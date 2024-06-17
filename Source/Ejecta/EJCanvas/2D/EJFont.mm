#import "EJFont.h"
#import "EJCanvasContext2D.h"
#include <malloc/malloc.h>
#include <unordered_map>


@implementation EJFontDescriptor
@synthesize name, size;

+ (id)descriptorWithName:(NSString *)name size:(float)size {
	// Check if the font exists
	if( !name.length || ![UIFont fontWithName:name size:size] ) {
		return NULL;
	}
	
	EJFontDescriptor *descriptor = [EJFontDescriptor new];
	descriptor->name = [name retain];
	descriptor->size = size;
	descriptor->hash = [name hash] + (size * 383); // 383 is a 'random' prime, chosen by fair dice roll
	return [descriptor autorelease];
}

- (NSUInteger)hash {
	return hash;
}

- (BOOL)isEqual:(id)anObject {
	if( ![anObject isKindOfClass:[EJFontDescriptor class]] ) {
		return NO;
	}
	
	EJFontDescriptor *otherDescriptor = (EJFontDescriptor *)anObject;
	return (otherDescriptor->size == size && [otherDescriptor->name isEqualToString:name]);
}

- (void)dealloc {
	[name release];
	[super dealloc];
}

@end



@implementation EJFontLayout
@synthesize metrics, glyphCount;

- (id)initWithGlyphLayout:(NSData *)layout glyphCount:(NSInteger)count metrics:(EJTextMetrics)metricsp {
	if( self = [super init] ) {
		glyphLayout = [layout retain];
		glyphCount = count;
		metrics = metricsp;
	}
	return self;
}

- (void)dealloc {
	[glyphLayout release];
	[super dealloc];
}

- (EJFontGlyphLayout *)glyphLayout {
	return (EJFontGlyphLayout *)glyphLayout.bytes;
}

@end



int EJFontGlyphLayoutSortByTextureIndex(const void *a, const void *b) {
	return ( ((EJFontGlyphLayout*)a)->textureIndex - ((EJFontGlyphLayout*)b)->textureIndex );
}


@interface EJFont () {
	// Glyph information
	std::unordered_map<int, EJFontGlyphInfo> glyphInfoMap;
}
@end


@implementation EJFont

- (id)initWithDescriptor:(EJFontDescriptor *)desc fill:(BOOL)fillp lineWidth:(float)lineWidthp contentScale:(float)contentScalep {
	self = [super init];
	if(self) {
		positionsBuffer = NULL;
		glyphsBuffer = NULL;
		
		contentScale = contentScalep;
		fill = fillp;
		lineWidth = lineWidthp;
		glyphPadding = EJ_FONT_GLYPH_PADDING + (fill ? 0 : lineWidth);
		
        /* cp 根据字体，大小，创建CT字体对象 */
		ctMainFont = CTFontCreateWithName((CFStringRef)desc.name, desc.size, NULL);
		
		if( ctMainFont ) {
			pointSize = desc.size;
			leading	= CTFontGetLeading(ctMainFont);
			ascent = CTFontGetAscent(ctMainFont);
			descent = CTFontGetDescent(ctMainFont);
			xHeight = CTFontGetXHeight(ctMainFont);
			
			// If we can't fit at least two rows of glyphs into EJ_FONT_TEXTURE_SIZE, create
			// a new texture for each glyph. Otherwise we're wasting a lot of space.
			// This of course comes at the expense of a bit of performance, because we have
			// to bind a few more textures when drawing.
			if( (ascent + descent) * contentScale > EJ_FONT_TEXTURE_SIZE/2 ) {
				useSingleGlyphTextures = true;
			}
			
			textures = [[NSMutableArray alloc] initWithCapacity:1];
			layoutCache = [NSCache new];
			layoutCache.countLimit = 128;
		}
	}
	return self;
}

+ (void)loadFontAtPath:(NSString*)path{
	NSData *inData = [[NSFileManager defaultManager] contentsAtPath:path];
	if(inData == nil){
		NSLog(@"Failed to load font. Data at path is null");
		return;
	}
	CFErrorRef error;
	CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)inData);
	CGFontRef font = CGFontCreateWithDataProvider(provider);
	
	if( CTFontManagerRegisterGraphicsFont(font, &error) ){
		CFStringRef name = CGFontCopyPostScriptName(font);
		NSLog(@"Loaded Font: %@", (NSString *)name);
		CFRelease(name);
	}
	else {
		CFStringRef errorDescription = CFErrorCopyDescription(error);
		NSLog(@"Failed to load font: %@", errorDescription);
		CFRelease(errorDescription);
	}
	CFRelease(font);
	CFRelease(provider);
}

- (void)dealloc {
	CFRelease(ctMainFont);
	
	[textures release];
	[layoutCache release];
	
	free(glyphsBuffer);
	free(positionsBuffer);
	
	[super dealloc];
}
/* cp 创建特定字体的字符对应的纹理
 通常是多个字符共用一个纹理， 分配一个1024* 1024的纹理，绘制文字
 */
- (unsigned short)createGlyph:(CGGlyph)glyph withFont:(CTFontRef)font {
	// Get glyph information
	EJFontGlyphInfo *glyphInfo = &glyphInfoMap[glyph];
	
	CGRect bbRect;
	CTFontGetBoundingRectsForGlyphs(font, kCTFontOrientationDefault, &glyph, &bbRect, 1);
	
	// Add some padding around the glyphs
	glyphInfo->y = floorf(bbRect.origin.y) - glyphPadding;
	glyphInfo->x = floorf(bbRect.origin.x) - glyphPadding;
	glyphInfo->w = bbRect.size.width + glyphPadding * 2;
	glyphInfo->h = bbRect.size.height + glyphPadding * 2;
	
	// Size needed for this glyph in pixels; must be a multiple of 8 for CG
	int pxWidth = floorf((glyphInfo->w * contentScale) / 8 + 1) * 8;
	int pxHeight = floorf((glyphInfo->h * contentScale) / 8 + 1) * 8;
		
	// Do we need to create a new texture to hold this glyph?
	BOOL createNewTexture = (textures.count == 0 || useSingleGlyphTextures);
	
	if( txLineX + pxWidth > EJ_FONT_TEXTURE_SIZE ) {
		// New line
		txLineX = 0.0f;
		txLineY += txLineH;
		txLineH = 0.0f;
		
		// Line exceeds texture height? -> new texture
		if( txLineY + pxHeight > EJ_FONT_TEXTURE_SIZE) {
			createNewTexture = YES;
		}
	}
	
	EJTexture *texture;
	int textureWidth = EJ_FONT_TEXTURE_SIZE,
		textureHeight = EJ_FONT_TEXTURE_SIZE;
    /* cp 按需创建纹理 */
	if( createNewTexture ) {
		txLineX = txLineY = txLineH = 0;
		
		// In single glyph mode, create a new texture for each glyph in the glyph's size
		if( useSingleGlyphTextures ) {
			textureWidth = pxWidth;
			textureHeight = pxHeight;
		}
		
		texture = [[EJTexture alloc] initWithWidth:textureWidth height:textureHeight format:GL_ALPHA];
		[textures addObject:texture];
		[texture release];	
	}
	else {
		texture = textures.lastObject;
	}
	
	glyphInfo->textureIndex = textures.count; // 0 is reserved, index starts at 1
	glyphInfo->tx = ((txLineX+1) / textureWidth);
	glyphInfo->ty = ((txLineY+1) / textureHeight);
	glyphInfo->tw = (glyphInfo->w / textureWidth) * contentScale,
	glyphInfo->th = (glyphInfo->h / textureHeight) * contentScale;
    
    /* cp 使用CoreGraphics，绘制文字，获取文字对应的像素数据 */
	NSMutableData *pixels = [NSMutableData dataWithLength:pxWidth * pxHeight];
	
	CGContextRef context = CGBitmapContextCreate(pixels.mutableBytes, pxWidth, pxHeight, 8, pxWidth, NULL, kCGImageAlphaOnly);
	
	CGContextSetFontSize(context, pointSize);
	CGContextTranslateCTM(context, 0.0, pxHeight);
	CGContextScaleCTM(context, contentScale, -1.0*contentScale);
	
	// Fill or stroke?
	if( fill ) {
		CGContextSetTextDrawingMode(context, kCGTextFill);
		CGContextSetGrayFillColor(context, 1.0, 1.0);
	}
	else {
		CGContextSetTextDrawingMode(context, kCGTextStroke);
		CGContextSetGrayStrokeColor(context, 1.0, 1.0);
		CGContextSetLineWidth(context, lineWidth);
	}
	
	// Render glyph and update the texture
	CGPoint p = CGPointMake(-glyphInfo->x, -glyphInfo->y);
	CTFontDrawGlyphs(font, &glyph, &p, 1, context);
	[texture updateWithPixels:pixels atX:txLineX y:txLineY width:pxWidth height:pxHeight];
	
	// Update texture coordinates
	txLineX += pxWidth;
	txLineH = MAX( txLineH, pxHeight );
	
	CGContextRelease(context);
	
	return glyphInfo->textureIndex;
}

void processLine(CTLineRef line) {
    // 获取该行中的所有字形运行（CTRun）
    CFArrayRef runs = CTLineGetGlyphRuns(line);
    NSInteger runCount = CFArrayGetCount(runs);

    NSLog(@"Number of runs: %ld", (long)runCount);

    // 遍历每个CTRun：每种字形的属性，以及对应的字符数量
    for (NSInteger i = 0; i < runCount; i++) {
        CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runs, i);
        
        // 获取字形运行的属性
        NSDictionary *attributes = (__bridge NSDictionary *)CTRunGetAttributes(run);
        NSLog(@"Attributes: %@", attributes);
        
        // 获取字形运行中的字形数量
        CFIndex glyphCount = CTRunGetGlyphCount(run);
        NSLog(@"Number of glyphs in run %ld: %ld", (long)i, (long)glyphCount);
    }
}

- (EJFontLayout *)getLayoutForString:(NSString *)string {

	// Try Cache first
	EJFontLayout *cached = [layoutCache objectForKey:string];
	if( cached ) {
		return cached;
	}

	/* cp 根据字体、文本，创建一行文本CTLineRef
     */
	// Create attributed line
	NSAttributedString *attributes = [[NSAttributedString alloc]
		initWithString:string
		attributes:@{ (id)kCTFontAttributeName: (id)ctMainFont }];
	
	CTLineRef line = CTLineCreateWithAttributedString((CFAttributedStringRef)attributes);
	[attributes release];
    
	/* cp 获取宽度，上下间距获取不准，后续再通过glyphs获取 */
	// Get line metrics; sadly, ascent and descent are broken: 'ascent' equals
	// the total height (i.e. what should be ascent + descent) and 'descent'
	// is always the maximum descent of the font - no matter if you have
	// descending characters or not.
	// So, we have to collect those infos ourselfs from the glyphs.
	EJTextMetrics metrics = {
		.width = CTLineGetTypographicBounds(line, NULL, NULL, NULL),
		.ascent = 0,
		.descent = 0,
	};
	
	/* cp 获取一行文本的字形数量，创建EJFontGlyphLayout缓冲 */
	// Create a layout buffer large enough to hold all glyphs for this line
	NSInteger lineGlyphCount = CTLineGetGlyphCount(line);
	size_t layoutBufferSize = sizeof(EJFontGlyphLayout) * lineGlyphCount;
	NSMutableData *layoutData = [NSMutableData dataWithLength:layoutBufferSize];
	EJFontGlyphLayout *layoutBuffer = (EJFontGlyphLayout *)layoutData.mutableBytes;
		
    processLine(line);

	/* cp 获取CTRun数量，如果这行文本属性一直，则值为1
     
     CTLine 表示一行字符，可以包含保存多个字形（字符图形）
     CTRun 表示属性相同的一组字符，可以包含多种字形
     CGGlyph 表示字形
     https://yangchao0033.github.io/blog/2016/01/26/coretextji-chu/
     */
	// Go through all runs for this line
	CFArrayRef runs = CTLineGetGlyphRuns(line);
	NSInteger runCount = CFArrayGetCount(runs);
	
	int layoutIndex = 0;
	for( int i = 0; i < runCount; i++ ) {
		CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runs, i);
		NSInteger runGlyphCount = CTRunGetGlyphCount(run);/* cp 获取字符数量 */
		CTFontRef runFont = (CTFontRef)CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);
	
		// Fetch glyphs buffer
		const CGGlyph *glyphs = CTRunGetGlyphsPtr(run);
		if( !glyphs ) {
			size_t glyphsBufferSize = sizeof(CGGlyph) * runGlyphCount;
			if( malloc_size(glyphsBuffer) < glyphsBufferSize ) {
				glyphsBuffer = (CGGlyph *)realloc(glyphsBuffer, glyphsBufferSize);
			}
			CTRunGetGlyphs(run, CFRangeMake(0, 0), glyphsBuffer);
			glyphs = glyphsBuffer;
		}
		
		// Fetch Positions buffer
		CGPoint *positions = (CGPoint*)CTRunGetPositionsPtr(run);
		if( !positions ) {
			size_t positionsBufferSize = sizeof(CGPoint) * runGlyphCount;
			if( malloc_size(positionsBuffer) < positionsBufferSize ) {
				positionsBuffer = (CGPoint *)realloc(positionsBuffer, positionsBufferSize);
			}
			CTRunGetPositions(run, CFRangeMake(0, 0), positionsBuffer);
			positions = positionsBuffer;
		}
		
		/* cp 针对每个字符，生成对应的纹理，通常多个字符绘制到同一个大纹理上 */
		// Go through all glyphs for this run, create the textures and collect the glyph
		// info and positions as well as the max ascent and descent
		for( int g = 0; g < runGlyphCount; g++ ) {
			EJFontGlyphLayout *gl = &layoutBuffer[layoutIndex];
			gl->glyph = glyphs[g];
			gl->xpos = positions[g].x;
			gl->info = &glyphInfoMap[gl->glyph];
			
			gl->textureIndex = gl->info->textureIndex;
			if( !gl->textureIndex ) {
				gl->textureIndex = [self createGlyph:gl->glyph withFont:runFont];
			}
			
			metrics.ascent = MAX(metrics.ascent, gl->info->h + gl->info->y - glyphPadding);
			metrics.descent = MAX(metrics.descent, -gl->info->y - glyphPadding);
			layoutIndex++;
		}		
	}	
	
	// Sort glyphs by texture index. This way we can loop through the all glyphs while
	// minimizing the amount of texture binds needed. Skip this if we only have
	// one texture anyway
	if( textures.count > 1 ) {
		qsort( layoutBuffer, lineGlyphCount, sizeof(EJFontGlyphLayout), EJFontGlyphLayoutSortByTextureIndex);
	}
	
	/* cp 根据这行文本生成的字符信息（包含纹理、尺寸等），生成布局信息 */
	// Create the layout object and add it to the cache
	EJFontLayout *layout = [[EJFontLayout alloc] initWithGlyphLayout:layoutData
		glyphCount:lineGlyphCount metrics:metrics];
		
	[layoutCache setObject:layout forKey:string];
	
	CFRelease(line);
	
	return [layout autorelease];
}

- (float)getYOffsetForBaseline:(EJTextBaseline)baseline {
	// Figure out the y position with the given textBaseline
	switch( baseline ) {
		case kEJTextBaselineAlphabetic:
		case kEJTextBaselineIdeographic:
			return 0;
		case kEJTextBaselineTop:
		case kEJTextBaselineHanging:
			return ascent;
		case kEJTextBaselineMiddle:
			return xHeight/2;
		case kEJTextBaselineBottom:
			return -descent;
	}
	return 0;
}

- (void)drawString:(NSString *)string toContext:(EJCanvasContext2D *)context x:(float)x y:(float)y {
	if( string.length == 0 ) { return; }
	
    /* cp 获取字符串布局信息 */
	EJFontLayout *layout = [self getLayoutForString:string];
	
	// Figure out the x position with the current textAlign.
	if(context.state->textAlign != kEJTextAlignLeft) {
		if( context.state->textAlign == kEJTextAlignRight || context.state->textAlign == kEJTextAlignEnd ) {
			x -= layout.metrics.width;
		}
		else if( context.state->textAlign == kEJTextAlignCenter ) {
			x -= layout.metrics.width/2.0f;
		}
	}

	y += [self getYOffsetForBaseline:context.state->textBaseline];
	
	x = roundf(x);
	y = roundf(y);
	
	
	// Fill or stroke color?
	EJCanvasState *state = context.state;
	EJColorRGBA color = fill
		? EJCanvasBlendFillColor(state)
		: EJCanvasBlendStrokeColor(state);
	
    /* cp 逐个绘制字符，其实也不是绘制，而是先绑定纹理，缓存顶点数据，然后批量绘制 */
	// Go through all glyphs - bind textures as needed - and draw
	EJFontGlyphLayout *layoutBuffer = layout.glyphLayout;
	NSInteger glyphCount = layout.glyphCount;
	NSInteger i = 0;
	while( i < glyphCount ) {
		int textureIndex = layoutBuffer[i].textureIndex;/* cp 绑定纹理 */
		[context setTexture:textures[textureIndex-1]];
		/* cp 如果字符在同一个纹理上，则继续push，不用重复绑定 */
		// Go through glyphs while the texture stays the same
		while( i < glyphCount && textureIndex == layoutBuffer[i].textureIndex ) {
			EJFontGlyphInfo *glyphInfo = layoutBuffer[i].info;
			
			float gx = x + layoutBuffer[i].xpos + glyphInfo->x;
			float gy = y - (glyphInfo->h + glyphInfo->y);
			
			[context pushTexturedRectX:gx y:gy w:glyphInfo->w h:glyphInfo->h
				tx:glyphInfo->tx ty:glyphInfo->ty+glyphInfo->th tw:glyphInfo->tw th:-glyphInfo->th
				color:color withTransform:state->transform];
			
			i++;
		}
	}
}

- (EJTextMetrics)measureString:(NSString*)string forContext:(EJCanvasContext2D *)context {
	if( string.length == 0 ) { return {0}; }
	
	float yOffset = [self getYOffsetForBaseline:context.state->textBaseline];
	EJTextMetrics metrics = [self getLayoutForString:string].metrics;
	
	metrics.width = metrics.width;
	metrics.ascent += yOffset;
	metrics.descent += yOffset;
	
	return metrics;
}

@end
