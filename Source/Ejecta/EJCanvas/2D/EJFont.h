// This file contains the EJFontDescriptor, EJFontLayout and EJFont classes.

// EJFontDescriptor describes a font face and size and is used as a cache key
// into the EJFontCache. The Canvas2D implementation only holds an instance
// to a descriptor and leaves actual Font creation to the EJFontCache.

// EJFontLayout describes the layout of a string - i.e. the relative positon of
// each of a fonts glyph. This layout may get cached by EJFont internally, so it
// doesn't need to be recalculated when drawing the same string multiple times.

// EJFontLayout also hosts a EJTextMetrics struct that describes the text
// string's full widht, ascent and descent.

// EJFont finally is responsible for creating one or more glyph atlases,
// computing the layout for a string and pushing glyphs to CanvasContext2D.
// Glyphs are lazily rendered into an atlas. 

/* cp 文字绘制，绘制原理

 通过CoreText获取字符的属性信息：尺寸位置，上下偏移
 通过CoreGraphics获取字符的像素数据
 把每个字符保存到纹理上，通常是多个字符保存到同一个纹理上，然后通过缓冲保存一批顶点数据后，批量绘制文本
 批处理利用EJCanvasContext2D的pushTexturedRectX...
 
 
 
 例如：绘制文本 “Hello world”，文本长度11
 抓帧可以看到，会先在一个纹理上绘制所有字符，然后通过一个drawcall绘制66个顶点，即11个字符矩形，一次性把这段文本绘制出来
 
 #5 glDrawArrays(GL_TRIANGLES, 0, 66)
 */

#import "EJTexture.h"
#import <CoreText/CoreText.h>
#import <QuartzCore/QuartzCore.h>


#define EJ_FONT_TEXTURE_SIZE 1024
#define EJ_FONT_GLYPH_PADDING 2


typedef struct {
	float width;
	float ascent;
	float descent;
} EJTextMetrics;

typedef struct {
	float x, y, w, h; /* cp 字符的位置、尺寸 */
	unsigned short textureIndex;/* cp 字符对应的纹理id */
	float tx, ty, tw, th; /* cp 字符在纹理上的位置、尺寸 */
} EJFontGlyphInfo;

typedef struct {
	unsigned short textureIndex;  /* cp 纹理索引 */
	CGGlyph glyph;  /* cp 字型 */
	float xpos;
	EJFontGlyphInfo *info;
} EJFontGlyphLayout;


/* cp EJFontDescriptor
 字体描述
 作为缓存key受EJFontCache管理
 */
@interface EJFontDescriptor : NSObject {
	NSString *name; /* cp 字体 */
	float size; /* cp 大小 */
	NSUInteger hash;
}
+ (id)descriptorWithName:(NSString *)name size:(float)size;

@property (readonly, nonatomic) NSString *name;
@property (readonly, nonatomic) float size;

@end



@interface EJFontLayout : NSObject {
	NSData *glyphLayout;
	EJTextMetrics metrics;
	NSInteger glyphCount;
}

- (id)initWithGlyphLayout:(NSData *)layoutp glyphCount:(NSInteger)count metrics:(EJTextMetrics)metrics;
@property (readonly, nonatomic) EJFontGlyphLayout *layout;
@property (readonly, nonatomic) NSInteger glyphCount;
@property (readonly, nonatomic) EJTextMetrics metrics;

@end



int EJFontGlyphLayoutSortByTextureIndex(const void *a, const void *b);

@class EJCanvasContext2D;
@interface EJFont : NSObject {
	NSMutableArray *textures;
	float txLineX, txLineY, txLineH;
	BOOL useSingleGlyphTextures;
	
	// Font preferences
	float pointSize, ascent, descent, leading, contentScale, glyphPadding, xHeight;
	BOOL fill;
	float lineWidth;
	
	// Font references
	CTFontRef ctMainFont;
	
	// Core text variables for line layout
	CGGlyph *glyphsBuffer;
	CGPoint *positionsBuffer;
    
	/* cp 布局信息缓存 */
	NSCache *layoutCache;
}

- (id)initWithDescriptor:(EJFontDescriptor *)desc fill:(BOOL)fillp lineWidth:(float)lineWidthp contentScale:(float)contentScalep;
+ (void)loadFontAtPath:(NSString *)path;
- (void)drawString:(NSString *)string toContext:(EJCanvasContext2D *)context x:(float)x y:(float)y;
- (EJTextMetrics)measureString:(NSString *)string forContext:(EJCanvasContext2D *)context;

@end
