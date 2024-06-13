#import "EJBindingCanvasContext2D.h"

#import "EJCanvasContext2DTexture.h"
#import "EJCanvasContext2DScreen.h"
#import "EJBindingImageData.h"
#import "EJBindingCanvasPattern.h"
#import "EJBindingCanvasGradient.h"
#import "EJBindingTextMetrics.h"
#import "EJFont.h"

#import "EJDrawable.h"
#import "EJConvertColorRGBA.h"


@implementation EJBindingCanvasContext2D

- (id)initWithRenderingContext:(EJCanvasContext2D *)renderingContextp {
	if( self = [super initWithContext:NULL argc:0 argv:NULL] ) {
		renderingContext = [renderingContextp retain];
	}
	return self;
}

- (void)dealloc {
	[renderingContext release];
	[super dealloc];
}

/*
EJ_BIND_ENUM(globalCompositeOperation, renderingContext.globalCompositeOperation,
	"source-over",		// kEJCompositeOperationSourceOver
	"lighter",			// kEJCompositeOperationLighter
	"lighten",			// kEJCompositeOperationLighten
	"darker",			// kEJCompositeOperationDarker
	"darken",			// kEJCompositeOperationDarken
	"destination-out",	// kEJCompositeOperationDestinationOut
	"destination-over",	// kEJCompositeOperationDestinationOver
	"source-atop",		// kEJCompositeOperationSourceAtop
	"xor",				// kEJCompositeOperationXOR
	"copy",				// kEJCompositeOperationCopy
	"source-in",		// kEJCompositeOperationSourceIn
	"destination-in",	// kEJCompositeOperationDestinationIn
	"source-out",		// kEJCompositeOperationSourceOut
	"destination-atop"	// kEJCompositeOperationDestinationAtop
);
*/

static const char *_globalCompositeOperationEnumNames[] = {
    "source-over", "lighter", "lighten", "darker", "darken", "destination-out", "destination-over", "source-atop", "xor", "copy", "source-in", "destination-in", "source-out", "destination-atop"
};
static JSValueRef _get_globalCompositeOperation( JSContextRef ctx, JSObjectRef object, JSStringRef propertyName, JSValueRef* exception ) {
    id instance = (id)JSObjectGetPrivate(object);
    return ((JSValueRef(*)(id, SEL, JSContextRef)) objc_msgSend)(instance, @selector(_get_globalCompositeOperation:), ctx);
}
+ (void *)_ptr_to_get_globalCompositeOperation {
    return (void *)&_get_globalCompositeOperation;
}
- (JSValueRef)_get_globalCompositeOperation:(JSContextRef)ctx {
    JSStringRef src = JSStringCreateWithUTF8CString( _globalCompositeOperationEnumNames[renderingContext.globalCompositeOperation] );
    JSValueRef ret = JSValueMakeString(ctx, src);
    JSStringRelease(src);
    return ret;
}
static _Bool _set_globalCompositeOperation( JSContextRef ctx, JSObjectRef object, JSStringRef propertyName, JSValueRef value, JSValueRef* exception ) {
    id instance = (id)JSObjectGetPrivate(object);
    ((void(*)(id, SEL, JSContextRef, JSValueRef)) objc_msgSend)(instance, @selector(_set_globalCompositeOperation:value:), ctx, value);
    return 1;
}
+ (void *)_ptr_to_set_globalCompositeOperation {
    return (void *)&_set_globalCompositeOperation;
}
- (void)_set_globalCompositeOperation:(JSContextRef)ctx value:(JSValueRef)value {
    JSStringRef _str = JSValueToStringCopy(ctx, value, ((void*)0));
    const JSChar *_strptr = JSStringGetCharactersPtr( _str );
    size_t _length = JSStringGetLength(_str)-1;
    const char ** _names = _globalCompositeOperationEnumNames;
    int _target;
    if( _length == sizeof("source-over")-2 && JSStrIsEqualToStr( _strptr, _names[0], _length) ) {
        _target = 0;
    } else if( _length == sizeof("lighter")-2 && JSStrIsEqualToStr( _strptr, _names[0 +1], _length) ) {
        _target = 0 +1;
    } else if( _length == sizeof("lighten")-2 && JSStrIsEqualToStr( _strptr, _names[0 +1 +1], _length) ) {
        _target = 0 +1 +1;
    } else if( _length == sizeof("darker")-2 && JSStrIsEqualToStr( _strptr, _names[0 +1 +1 +1], _length) ) {
        _target = 0 +1 +1 +1;
    } else if( _length == sizeof("darken")-2 && JSStrIsEqualToStr( _strptr, _names[0 +1 +1 +1 +1], _length) ) {
        _target = 0 +1 +1 +1 +1;
    } else if( _length == sizeof("destination-out")-2 && JSStrIsEqualToStr( _strptr, _names[0 +1 +1 +1 +1 +1], _length) ) {
        _target = 0 +1 +1 +1 +1 +1;
    } else if( _length == sizeof("destination-over")-2 && JSStrIsEqualToStr( _strptr, _names[0 +1 +1 +1 +1 +1 +1], _length) ) {
        _target = 0 +1 +1 +1 +1 +1 +1;
    } else if( _length == sizeof("source-atop")-2 && JSStrIsEqualToStr( _strptr, _names[0 +1 +1 +1 +1 +1 +1 +1], _length) ) {
        _target = 0 +1 +1 +1 +1 +1 +1 +1;
    } else if( _length == sizeof("xor")-2 && JSStrIsEqualToStr( _strptr, _names[0 +1 +1 +1 +1 +1 +1 +1 +1], _length) ) {
        _target = 0 +1 +1 +1 +1 +1 +1 +1 +1;
    } else if( _length == sizeof("copy")-2 && JSStrIsEqualToStr( _strptr, _names[0 +1 +1 +1 +1 +1 +1 +1 +1 +1], _length) ) {
        _target = 0 +1 +1 +1 +1 +1 +1 +1 +1 +1;
    } else if( _length == sizeof("source-in")-2 && JSStrIsEqualToStr( _strptr, _names[0 +1 +1 +1 +1 +1 +1 +1 +1 +1 +1], _length) ) {
        _target = 0 +1 +1 +1 +1 +1 +1 +1 +1 +1 +1;
    } else if( _length == sizeof("destination-in")-2 && JSStrIsEqualToStr( _strptr, _names[0 +1 +1 +1 +1 +1 +1 +1 +1 +1 +1 +1], _length) ) {
        _target = 0 +1 +1 +1 +1 +1 +1 +1 +1 +1 +1 +1;
    } else if( _length == sizeof("source-out")-2 && JSStrIsEqualToStr( _strptr, _names[0 +1 +1 +1 +1 +1 +1 +1 +1 +1 +1 +1 +1], _length) ) {
        _target = 0 +1 +1 +1 +1 +1 +1 +1 +1 +1 +1 +1 +1;
    } else if( _length == sizeof("destination-atop")-2 && JSStrIsEqualToStr( _strptr, _names[0 +1 +1 +1 +1 +1 +1 +1 +1 +1 +1 +1 +1 +1], _length) ) {
        _target = 0 +1 +1 +1 +1 +1 +1 +1 +1 +1 +1 +1 +1 +1;
    } else {
        JSStringRelease( _str );
        return;
    }
    renderingContext.globalCompositeOperation = _target; 
    JSStringRelease( _str );
};

EJ_BIND_ENUM(lineCap, renderingContext.state->lineCap,
	"butt",		// kEJLineCapButt
	"round",	// kEJLineCapRound
	"square"	// kEJLineCapSquare
);

EJ_BIND_ENUM(lineJoin, renderingContext.state->lineJoin,
	"miter",	// kEJLineJoinMiter
	"bevel",	// kEJLineJoinBevel
	"round"		// kEJLineJoinRound
);

EJ_BIND_ENUM(textAlign, renderingContext.state->textAlign,
	"start",	// kEJTextAlignStart
	"end",		// kEJTextAlignEnd
	"left",		// kEJTextAlignLeft
	"center",	// kEJTextAlignCenter
	"right"		// kEJTextAlignRight
);

EJ_BIND_ENUM(textBaseline, renderingContext.state->textBaseline,
	"alphabetic",	// kEJTextBaselineAlphabetic
	"middle",		// kEJTextBaselineMiddle
	"top",			// kEJTextBaselineTop
	"hanging",		// kEJTextBaselineHanging
	"bottom",		// kEJTextBaselineBottom
	"ideographic"	// kEJTextBaselineIdeographic
);

EJ_BIND_GET(fillStyle, ctx ) {
	if( renderingContext.fillObject ) {
		if( [renderingContext.fillObject isKindOfClass:EJCanvasPattern.class] ) {
			EJCanvasPattern *pattern = (EJCanvasPattern *)renderingContext.fillObject;
			return [EJBindingCanvasPattern createJSObjectWithContext:ctx scriptView:scriptView pattern:pattern];
		}
		else if( [renderingContext.fillObject isKindOfClass:EJCanvasGradient.class] ) {
			EJCanvasGradient *gradient = (EJCanvasGradient *)renderingContext.fillObject;
			return [EJBindingCanvasGradient createJSObjectWithContext:ctx scriptView:scriptView gradient:gradient];
		}
	}
	else {
		return ColorRGBAToJSValue(ctx, renderingContext.state->fillColor);
	}
	
	return NULL;
}

EJ_BIND_SET(fillStyle, ctx, value) {
	if( JSValueIsObject(ctx, value) ) {
		// Try CanvasPattern or CanvasGradient
		
		NSObject<EJFillable> *fillable;
		if( (fillable = [EJBindingCanvasPattern patternFromJSValue:value]) ) {
			renderingContext.fillObject = fillable;
		}
		else if( (fillable = [EJBindingCanvasGradient gradientFromJSValue:value]) ) {
			renderingContext.fillObject = fillable;
		}
	}
	else {
		// Should be a color string
		renderingContext.state->fillColor = JSValueToColorRGBA(ctx, value);
		renderingContext.fillObject = NULL;
	}
}

EJ_BIND_GET(strokeStyle, ctx ) {
	if( renderingContext.strokeObject ) {
		if( [renderingContext.strokeObject isKindOfClass:EJCanvasPattern.class] ) {
			EJCanvasPattern *pattern = (EJCanvasPattern *)renderingContext.strokeObject;
			return [EJBindingCanvasPattern createJSObjectWithContext:ctx scriptView:scriptView pattern:pattern];
		}
		else if( [renderingContext.strokeObject isKindOfClass:EJCanvasGradient.class] ) {
			EJCanvasGradient *gradient = (EJCanvasGradient *)renderingContext.strokeObject;
			return [EJBindingCanvasGradient createJSObjectWithContext:ctx scriptView:scriptView gradient:gradient];
		}
	}
	else {
		return ColorRGBAToJSValue(ctx, renderingContext.state->strokeColor);
	}
	
	return NULL;
}

EJ_BIND_SET(strokeStyle, ctx, value) {
	if( JSValueIsObject(ctx, value) ) {
		// Try CanvasPattern or CanvasGradient
		
		NSObject<EJFillable> *fillable;
		if( (fillable = [EJBindingCanvasPattern patternFromJSValue:value]) ) {
			renderingContext.strokeObject = fillable;
		}
		else if( (fillable = [EJBindingCanvasGradient gradientFromJSValue:value]) ) {
			renderingContext.strokeObject = fillable;
		}
	}
	else {
		// Should be a color string
		renderingContext.state->strokeColor = JSValueToColorRGBA(ctx, value);
		renderingContext.strokeObject = NULL;
	}
}

/*
EJ_BIND_GET(globalAlpha, ctx ) {
	return JSValueMakeNumber(ctx, renderingContext.state->globalAlpha );
}

EJ_BIND_SET(globalAlpha, ctx, value) {
	renderingContext.state->globalAlpha = MIN(1,MAX(JSValueToNumberFast(ctx, value),0));
}
*/
static JSValueRef _get_globalAlpha( JSContextRef ctx, JSObjectRef object, JSStringRef propertyName, JSValueRef* exception ) {
    id instance = (id)JSObjectGetPrivate(object); 
    return ((JSValueRef(*)(id, SEL, JSContextRef)) objc_msgSend)(instance, @selector(_get_globalAlpha:), ctx);
}
+ (void *)_ptr_to_get_globalAlpha { 
    return (void *)&_get_globalAlpha;
}
- (JSValueRef)_get_globalAlpha:(JSContextRef)ctx {
 return JSValueMakeNumber(ctx, renderingContext.state->globalAlpha );
}

static _Bool _set_globalAlpha( JSContextRef ctx, JSObjectRef object, JSStringRef propertyName, JSValueRef value, JSValueRef* exception ) {
    id instance = (id)JSObjectGetPrivate(object); 
    ((void(*)(id, SEL, JSContextRef, JSValueRef)) objc_msgSend)(instance, @selector(_set_globalAlpha:value:), ctx, value);
    return 1;
}
+ (void *)_ptr_to_set_globalAlpha { 
    return (void *)&_set_globalAlpha;
}
- (void)_set_globalAlpha:(JSContextRef)ctx value:(JSValueRef)value {
    renderingContext.state->globalAlpha = MIN(1,MAX(JSValueToNumberFast(ctx, value),0));
}

EJ_BIND_GET(lineWidth, ctx) {
	return JSValueMakeNumber(ctx, renderingContext.state->lineWidth);
}

EJ_BIND_SET(lineWidth, ctx, value) {
	renderingContext.state->lineWidth = JSValueToNumberFast(ctx, value);
}

EJ_BIND_GET(miterLimit, ctx) {
	return JSValueMakeNumber(ctx, renderingContext.state->miterLimit);
}

EJ_BIND_SET(miterLimit, ctx, value) {
	renderingContext.state->miterLimit = JSValueToNumberFast(ctx, value);
}

EJ_BIND_GET(font, ctx) {
	EJFontDescriptor *font = renderingContext.state->font;
	NSString *name = [NSString stringWithFormat:@"%dpx %@", (int)font.size, font.name];
	return NSStringToJSValue(ctx, name);
}

EJ_BIND_SET(font, ctx, value) {
	char string[64]; // Long font names are long
	JSStringRef jsString = JSValueToStringCopy( ctx, value, NULL );
	JSStringGetUTF8CString(jsString, string, 64);
	
	// Yeah, oldschool!
	float size = 0;
	char name[64];
	char ptx;
	char *start = string;
	while(*start != '\0' && !isdigit(*start)){ start++; } // skip to the first digit
	sscanf( start, "%fp%1[tx]%*[\"' ]%63[^\"']", &size, &ptx, name); // matches: 10.5p[tx] 'some font'
	
	if( ptx == 't' ) { // pt or px?
		size = ceilf(size*4.0/3.0);
	}
	
	EJFontDescriptor *font = [EJFontDescriptor descriptorWithName:@(name) size:size];
	if( font ) {
		renderingContext.font = font;
	}
	else if( size ) {
		// Font name not found, but we have a size? Use the current font and just change the size
		renderingContext.font = [EJFontDescriptor descriptorWithName:renderingContext.font.name size:size];
	}
	
	JSStringRelease(jsString);
}

EJ_BIND_SET(imageSmoothingEnabled, ctx, value) {
	scriptView.currentRenderingContext = renderingContext;
	renderingContext.imageSmoothingEnabled = JSValueToBoolean(ctx, value);
}

EJ_BIND_GET(imageSmoothingEnabled, ctx) {
	return JSValueMakeBoolean(ctx, renderingContext.imageSmoothingEnabled);
}

EJ_BIND_FUNCTION(save, ctx, argc, argv) {
	[renderingContext save];
	return NULL;
}

EJ_BIND_FUNCTION(restore, ctx, argc, argv) {
	[renderingContext restore];
	return NULL;
}

EJ_BIND_FUNCTION(rotate, ctx, argc, argv) {
	EJ_UNPACK_ARGV(float angle);
	[renderingContext rotate:angle];
	return NULL;
}

EJ_BIND_FUNCTION(translate, ctx, argc, argv) {
	EJ_UNPACK_ARGV(float x, float y);
	[renderingContext translateX:x y:y];
	return NULL;
}

EJ_BIND_FUNCTION(scale, ctx, argc, argv) {
	EJ_UNPACK_ARGV(float x, float y);
	[renderingContext scaleX:x y:y];
	return NULL;
}

EJ_BIND_FUNCTION(transform, ctx, argc, argv) {
	EJ_UNPACK_ARGV(float m11, float m12, float m21, float m22, float dx, float dy);
	[renderingContext transformM11:m11 m12:m12 m21:m21 m22:m22 dx:dx dy:dy];
	return NULL;
}

EJ_BIND_FUNCTION(setTransform, ctx, argc, argv) {
	EJ_UNPACK_ARGV(float m11, float m12, float m21, float m22, float dx, float dy);
	[renderingContext setTransformM11:m11 m12:m12 m21:m21 m22:m22 dx:dx dy:dy];
	return NULL;
}

EJ_BIND_FUNCTION(drawImage, ctx, argc, argv) {
	if( argc < 3 ) { return NULL; }
	
	// Set the currentRenderingContext before getting the texture, so we can
	// correctly treat the case where the currentRenderingContext is the same
	// as the image being drawn; i.e. a texture canvas drawing into itself.
	scriptView.currentRenderingContext = renderingContext;
	
	NSObject<EJDrawable> *drawable = (NSObject<EJDrawable> *)JSValueGetPrivate(argv[0]);
	EJTexture *image = drawable.texture;
	
	if( !image.textureId ) { return NULL; }
	
	short sx = 0, sy = 0, sw, sh;
	float dx, dy, dw, dh;
	
	if( argc == 3 ) {
		// drawImage(image, dx, dy)
		EJ_UNPACK_ARGV_OFFSET(1, dx, dy);
		sw = image.width;
		sh = image.height;
		dw = sw;
		dh = sh;
	}
	else if( argc == 5 ) {
		// drawImage(image, dx, dy, dw, dh)
		EJ_UNPACK_ARGV_OFFSET(1, dx, dy, dw, dh);
		sw = image.width;
		sh = image.height;
	}
	else if( argc >= 9 ) {
		// drawImage(image, sx, sy, sw, sh, dx, dy, dw, dh)
		EJ_UNPACK_ARGV_OFFSET(1, sx, sy, sw, sh, dx, dy, dw, dh);
	}
	else {
		return NULL;
	}
	
	[renderingContext drawImage:image sx:sx sy:sy sw:sw sh:sh dx:dx dy:dy dw:dw dh:dh];
	return NULL;
}

EJ_BIND_FUNCTION(fillRect, ctx, argc, argv) {
	EJ_UNPACK_ARGV(float dx, float dy, float w, float h);
			
	scriptView.currentRenderingContext = renderingContext;
	[renderingContext fillRectX:dx y:dy w:w h:h];
	return NULL;
}

EJ_BIND_FUNCTION(strokeRect, ctx, argc, argv) {
	EJ_UNPACK_ARGV(float dx, float dy, float w, float h);
	
	scriptView.currentRenderingContext = renderingContext;
	[renderingContext strokeRectX:dx y:dy w:w h:h];
	return NULL;
}

EJ_BIND_FUNCTION(clearRect, ctx, argc, argv) {
	EJ_UNPACK_ARGV(float dx, float dy, float w, float h);
	
	scriptView.currentRenderingContext = renderingContext;
	[renderingContext clearRectX:dx y:dy w:w h:h];
	return NULL;
}

/*
EJ_BIND_FUNCTION(getImageData, ctx, argc, argv) {
	EJ_UNPACK_ARGV(short sx, short sy, short sw, short sh);
	
	scriptView.currentRenderingContext = renderingContext;
	
	EJImageData *imageData = [renderingContext getImageDataSx:sx sy:sy sw:sw sh:sh];
	
	EJBindingImageData *binding = [[[EJBindingImageData alloc] initWithImageData:imageData] autorelease];
	return [EJBindingImageData createJSObjectWithContext:ctx scriptView:scriptView instance:binding];
}
*/

static JSValueRef _func_getImageData( JSContextRef ctx, JSObjectRef function, JSObjectRef object, size_t argc, const JSValueRef argv[], JSValueRef* exception ) {
    id instance = (id)JSObjectGetPrivate(object);
    JSValueRef ret = ((JSValueRef(*)(id, SEL, JSContextRef, size_t, const JSValueRef [])) objc_msgSend)(instance, @selector(_func_getImageData:argc:argv:), ctx, argc, argv);
    return ret ? ret : ((EJBindingBase *)instance)->scriptView->jsUndefined;
}
+ (void *)_ptr_to_func_getImageData {
    return (void *)&_func_getImageData;
}

- (JSValueRef)_func_getImageData:(JSContextRef)ctx argc:(size_t)argc argv:(const JSValueRef [])argv {
    if( argc < 4 +0 ) { return ((void*)0); } 
    
    short sx = JSValueToNumberFast(ctx, argv[0]) ;
    short sy = JSValueToNumberFast(ctx, argv[0 +1]) ;
    short sw = JSValueToNumberFast(ctx, argv[0 +1 +1]) ; 
    short sh = JSValueToNumberFast(ctx, argv[0 +1 +1 +1]);
    scriptView.currentRenderingContext = renderingContext;
    EJImageData *imageData = [renderingContext getImageDataSx:sx sy:sy sw:sw sh:sh];
    EJBindingImageData *binding = [[[EJBindingImageData alloc] initWithImageData:imageData] autorelease];
    return [EJBindingImageData createJSObjectWithContext:ctx scriptView:scriptView instance:binding];
}

EJ_BIND_FUNCTION(createImageData, ctx, argc, argv) {
	EJ_UNPACK_ARGV(short sw, short sh);
		
	NSMutableData *pixels = [NSMutableData dataWithLength:sw * sh * 4];
	EJImageData *imageData = [[[EJImageData alloc] initWithWidth:sw height:sh pixels:pixels] autorelease];
	
	EJBindingImageData *binding = [[[EJBindingImageData alloc] initWithImageData:imageData] autorelease];
	return [EJBindingImageData createJSObjectWithContext:ctx scriptView:scriptView instance:binding];
}

EJ_BIND_FUNCTION(putImageData, ctx, argc, argv) {
	EJ_UNPACK_ARGV_OFFSET(1, float dx, float dy);
	EJBindingImageData *jsImageData = (EJBindingImageData *)JSValueGetPrivate(argv[0]);
	
	scriptView.currentRenderingContext = renderingContext;
	[renderingContext putImageData:jsImageData.imageData dx:dx dy:dy];
	return NULL;
}

EJ_BIND_FUNCTION(createLinearGradient, ctx, argc, argv) {
	EJVector2 p1, p2;
	EJ_UNPACK_ARGV(p1.x, p1.y, p2.x, p2.y);
	
	EJCanvasGradient *gradient = [[[EJCanvasGradient alloc] initLinearGradientWithP1:p1 p2:p2] autorelease];
	return [EJBindingCanvasGradient createJSObjectWithContext:ctx scriptView:scriptView gradient:gradient];
}

EJ_BIND_FUNCTION(createRadialGradient, ctx, argc, argv) {
	EJVector2 p1, p2;
	float r1, r2;
	EJ_UNPACK_ARGV(p1.x, p1.y, r1, p2.x, p2.y, r2);
	
	EJCanvasGradient *gradient = [[[EJCanvasGradient alloc] initRadialGradientWithP1:p1 r1:r1 p2:p2 r2:r2] autorelease];
	return [EJBindingCanvasGradient createJSObjectWithContext:ctx scriptView:scriptView gradient:gradient];
}

EJ_BIND_FUNCTION(createPattern, ctx, argc, argv) {
	if( argc < 1 ) { return NULL; }
	NSObject<EJDrawable> *drawable = (NSObject<EJDrawable> *)JSValueGetPrivate(argv[0]);
	EJTexture *image = drawable.texture;
	
	if( !image ) { return NULL; }
	
	EJCanvasPatternRepeat repeat = kEJCanvasPatternRepeat;
	if( argc > 1 ) {
		NSString *repeatString = JSValueToNSString(ctx, argv[1]);
		if( [repeatString isEqualToString:@"repeat-x"] ) {
			repeat = kEJCanvasPatternRepeatX;
		}
		else if( [repeatString isEqualToString:@"repeat-y"] ) {
			repeat = kEJCanvasPatternRepeatY;
		}
		else if( [repeatString isEqualToString:@"no-repeat"] ) {
			repeat = kEJCanvasPatternNoRepeat;
		}
	}
	EJCanvasPattern *pattern = [[[EJCanvasPattern alloc] initWithTexture:image repeat:repeat] autorelease];
	return [EJBindingCanvasPattern createJSObjectWithContext:ctx scriptView:scriptView pattern:pattern];
}

EJ_BIND_FUNCTION(beginPath, ctx, argc, argv) {
	[renderingContext beginPath];
	return NULL;
}

EJ_BIND_FUNCTION(closePath, ctx, argc, argv) {
	[renderingContext closePath];
	return NULL;
}

EJ_BIND_FUNCTION(fill, ctx, argc, argv) {
	EJPathFillRule fillRule = (argc > 0 && [JSValueToNSString(ctx, argv[0]) isEqualToString:@"evenodd"])
		? kEJPathFillRuleEvenOdd
		: kEJPathFillRuleNonZero;
	
	scriptView.currentRenderingContext = renderingContext;
	[renderingContext fill:fillRule];
	return NULL;
}

EJ_BIND_FUNCTION(stroke, ctx, argc, argv) {
	scriptView.currentRenderingContext = renderingContext;
	[renderingContext stroke];
	return NULL;
}

EJ_BIND_FUNCTION(moveTo, ctx, argc, argv) {
	EJ_UNPACK_ARGV(float x, float y);
	[renderingContext moveToX:x y:y];
	
	return NULL;
}

EJ_BIND_FUNCTION(lineTo, ctx, argc, argv) {
	EJ_UNPACK_ARGV(float x, float y);
	[renderingContext lineToX:x y:y];
	return NULL;
}

EJ_BIND_FUNCTION(rect, ctx, argc, argv) {
	EJ_UNPACK_ARGV(float x, float y, float w, float h);
	[renderingContext rectX:x y:y w:w h:h];
	return NULL;
}

EJ_BIND_FUNCTION(bezierCurveTo, ctx, argc, argv) {
	EJ_UNPACK_ARGV(float cpx1, float cpy1, float cpx2, float cpy2, float x, float y);
	[renderingContext bezierCurveToCpx1:cpx1 cpy1:cpy1 cpx2:cpx2 cpy2:cpy2 x:x y:y];
	return NULL;
}

EJ_BIND_FUNCTION(quadraticCurveTo, ctx, argc, argv) {
	EJ_UNPACK_ARGV(float cpx, float cpy, float x, float y);
	[renderingContext quadraticCurveToCpx:cpx cpy:cpy x:x y:y];
	return NULL;
}

EJ_BIND_FUNCTION(arcTo, ctx, argc, argv) {
	EJ_UNPACK_ARGV(float x1, float y1, float x2, float y2, float radius);
	[renderingContext arcToX1:x1 y1:y1 x2:x2 y2:y2 radius:radius];
	return NULL;
}

EJ_BIND_FUNCTION(arc, ctx, argc, argv) {
	EJ_UNPACK_ARGV(float x, float y, float radius, float startAngle, float endAngle);
	BOOL antiClockwise = (argc > 5 ? JSValueToNumberFast(ctx, argv[5]) : NO);
	
	[renderingContext arcX:x y:y radius:radius startAngle:startAngle endAngle:endAngle antiClockwise:antiClockwise];
	return NULL;
}

EJ_BIND_FUNCTION(measureText, ctx, argc, argv) {
	if( argc < 1 ) { return NULL; }
	
	NSString *string = JSValueToNSString(ctx, argv[0]);
	EJTextMetrics metrics = [renderingContext measureText:string];
	
	return [EJBindingTextMetrics createJSObjectWithContext:ctx scriptView:scriptView metrics:metrics];
}

EJ_BIND_FUNCTION(fillText, ctx, argc, argv) {
	EJ_UNPACK_ARGV_OFFSET(1, float x, float y);
	NSString *string = JSValueToNSString(ctx, argv[0]);
	
	scriptView.currentRenderingContext = renderingContext;
	[renderingContext fillText:string x:x y:y];
	return NULL;
}

EJ_BIND_FUNCTION(strokeText, ctx, argc, argv) {
	EJ_UNPACK_ARGV_OFFSET(1, float x, float y);
	NSString *string = JSValueToNSString(ctx, argv[0]);
	
	scriptView.currentRenderingContext = renderingContext;
	[renderingContext strokeText:string x:x y:y];
	return NULL;
}

EJ_BIND_FUNCTION(clip, ctx, argc, argv) {
	EJPathFillRule fillRule = (argc > 0 && [JSValueToNSString(ctx, argv[0]) isEqualToString:@"evenodd"])
		? kEJPathFillRuleEvenOdd
		: kEJPathFillRuleNonZero;
		
	scriptView.currentRenderingContext = renderingContext;
	[renderingContext clip:fillRule];
	return NULL;
}

EJ_BIND_FUNCTION(resetClip, ctx, argc, argv) {
	scriptView.currentRenderingContext = renderingContext;
	[renderingContext resetClip];
	return NULL;
}

/*
EJ_BIND_FUNCTION_NOT_IMPLEMENTED( isPointInPath );
*/

static JSValueRef _func_isPointInPath( JSContextRef ctx, JSObjectRef function, JSObjectRef object, size_t argc, const JSValueRef argv[], JSValueRef* exception ) {
    static _Bool didShowWarning;
    if( !didShowWarning ) {
        NSLog(@"Warning: method " @ "isPointInPath" @" is not yet implemented!");
        didShowWarning = 1;
    }
    id instance = (id)JSObjectGetPrivate(object); 
    return ((EJBindingBase *)instance)->scriptView->jsUndefined;
}
+ (void *)_ptr_to_func_isPointInPath {
    return (void *)&_func_isPointInPath;
};

@end
