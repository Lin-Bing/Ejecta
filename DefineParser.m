
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

static const char *_globalCompositeOperationEnumNames[] = {"source-over", "lighter", "lighten", "darker", "darken", "destination-out", "destination-over", "source-atop", "xor", "copy", "source-in", "destination-in", "source-out", "destination-atop"}; static JSValueRef _get_globalCompositeOperation( JSContextRef ctx, JSObjectRef object, JSStringRef propertyName, JSValueRef* exception ) { id instance = (id)JSObjectGetPrivate(object); return ((JSValueRef(*)(id, SEL, JSContextRef)) objc_msgSend)(instance, @selector(_get_globalCompositeOperation:), ctx); } + (void *)_ptr_to_get_globalCompositeOperation { return (void *)&_get_globalCompositeOperation; } - (JSValueRef)_get_globalCompositeOperation:(JSContextRef)ctx { JSStringRef src = JSStringCreateWithUTF8CString( _globalCompositeOperationEnumNames[renderingContext.globalCompositeOperation] ); JSValueRef ret = JSValueMakeString(ctx, src); JSStringRelease(src); return ret; } static _Bool _set_globalCompositeOperation( JSContextRef ctx, JSObjectRef object, JSStringRef propertyName, JSValueRef value, JSValueRef* exception ) { id instance = (id)JSObjectGetPrivate(object); ((void(*)(id, SEL, JSContextRef, JSValueRef)) objc_msgSend)(instance, @selector(_set_globalCompositeOperation:value:), ctx, value); return 1; } + (void *)_ptr_to_set_globalCompositeOperation { return (void *)&_set_globalCompositeOperation; } - (void)_set_globalCompositeOperation:(JSContextRef)ctx value:(JSValueRef)value { JSStringRef _str = JSValueToStringCopy(ctx, value, ((void*)0)); const JSChar *_strptr = JSStringGetCharactersPtr( _str ); size_t _length = JSStringGetLength(_str)-1; const char ** _names = _globalCompositeOperationEnumNames; int _target; if( _length == sizeof("source-over")-2 && JSStrIsEqualToStr( _strptr, _names[0], _length) ) { _target = 0; } else if( _length == sizeof("lighter")-2 && JSStrIsEqualToStr( _strptr, _names[0 +1], _length) ) { _target = 0 +1; } else if( _length == sizeof("lighten")-2 && JSStrIsEqualToStr( _strptr, _names[0 +1 +1], _length) ) { _target = 0 +1 +1; } else if( _length == sizeof("darker")-2 && JSStrIsEqualToStr( _strptr, _names[0 +1 +1 +1], _length) ) { _target = 0 +1 +1 +1; } else if( _length == sizeof("darken")-2 && JSStrIsEqualToStr( _strptr, _names[0 +1 +1 +1 +1], _length) ) { _target = 0 +1 +1 +1 +1; } else if( _length == sizeof("destination-out")-2 && JSStrIsEqualToStr( _strptr, _names[0 +1 +1 +1 +1 +1], _length) ) { _target = 0 +1 +1 +1 +1 +1; } else if( _length == sizeof("destination-over")-2 && JSStrIsEqualToStr( _strptr, _names[0 +1 +1 +1 +1 +1 +1], _length) ) { _target = 0 +1 +1 +1 +1 +1 +1; } else if( _length == sizeof("source-atop")-2 && JSStrIsEqualToStr( _strptr, _names[0 +1 +1 +1 +1 +1 +1 +1], _length) ) { _target = 0 +1 +1 +1 +1 +1 +1 +1; } else if( _length == sizeof("xor")-2 && JSStrIsEqualToStr( _strptr, _names[0 +1 +1 +1 +1 +1 +1 +1 +1], _length) ) { _target = 0 +1 +1 +1 +1 +1 +1 +1 +1; } else if( _length == sizeof("copy")-2 && JSStrIsEqualToStr( _strptr, _names[0 +1 +1 +1 +1 +1 +1 +1 +1 +1], _length) ) { _target = 0 +1 +1 +1 +1 +1 +1 +1 +1 +1; } else if( _length == sizeof("source-in")-2 && JSStrIsEqualToStr( _strptr, _names[0 +1 +1 +1 +1 +1 +1 +1 +1 +1 +1], _length) ) { _target = 0 +1 +1 +1 +1 +1 +1 +1 +1 +1 +1; } else if( _length == sizeof("destination-in")-2 && JSStrIsEqualToStr( _strptr, _names[0 +1 +1 +1 +1 +1 +1 +1 +1 +1 +1 +1], _length) ) { _target = 0 +1 +1 +1 +1 +1 +1 +1 +1 +1 +1 +1; } else if( _length == sizeof("source-out")-2 && JSStrIsEqualToStr( _strptr, _names[0 +1 +1 +1 +1 +1 +1 +1 +1 +1 +1 +1 +1], _length) ) { _target = 0 +1 +1 +1 +1 +1 +1 +1 +1 +1 +1 +1 +1; } else if( _length == sizeof("destination-atop")-2 && JSStrIsEqualToStr( _strptr, _names[0 +1 +1 +1 +1 +1 +1 +1 +1 +1 +1 +1 +1 +1], _length) ) { _target = 0 +1 +1 +1 +1 +1 +1 +1 +1 +1 +1 +1 +1 +1; } else { JSStringRelease( _str ); return; } renderingContext.globalCompositeOperation = _target; JSStringRelease( _str ); };




/*
EJ_BIND_GET(globalAlpha, ctx ) {
	return JSValueMakeNumber(ctx, renderingContext.state->globalAlpha );
}

EJ_BIND_SET(globalAlpha, ctx, value) {
	renderingContext.state->globalAlpha = MIN(1,MAX(JSValueToNumberFast(ctx, value),0));
}
*/
static JSValueRef _get_globalAlpha( JSContextRef ctx, JSObjectRef object, JSStringRef propertyName, JSValueRef* exception ) { id instance = (id)JSObjectGetPrivate(object); return ((JSValueRef(*)(id, SEL, JSContextRef)) objc_msgSend)(instance, @selector(_get_globalAlpha:), ctx); }
+ (void *)_ptr_to_get_globalAlpha { return (void *)&_get_globalAlpha; }
- (JSValueRef)_get_globalAlpha:(JSContextRef)ctx {
 return JSValueMakeNumber(ctx, renderingContext.state->globalAlpha );
}

static _Bool _set_globalAlpha( JSContextRef ctx, JSObjectRef object, JSStringRef propertyName, JSValueRef value, JSValueRef* exception ) { id instance = (id)JSObjectGetPrivate(object); ((void(*)(id, SEL, JSContextRef, JSValueRef)) objc_msgSend)(instance, @selector(_set_globalAlpha:value:), ctx, value); return 1; } 
+ (void *)_ptr_to_set_globalAlpha { return (void *)&_set_globalAlpha; } 
- (void)_set_globalAlpha:(JSContextRef)ctx value:(JSValueRef)value {
 renderingContext.state->globalAlpha = ((1) < (((JSValueToNumberFast(ctx, value)) > (0) ? (JSValueToNumberFast(ctx, value)) : (0))) ? (1) : (((JSValueToNumberFast(ctx, value)) > (0) ? (JSValueToNumberFast(ctx, value)) : (0))));
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

static JSValueRef _func_getImageData( JSContextRef ctx, JSObjectRef function, JSObjectRef object, size_t argc, const JSValueRef argv[], JSValueRef* exception ) { id instance = (id)JSObjectGetPrivate(object); JSValueRef ret = ((JSValueRef(*)(id, SEL, JSContextRef, size_t, const JSValueRef [])) objc_msgSend)(instance, @selector(_func_getImageData:argc:argv:), ctx, argc, argv); return ret ? ret : ((EJBindingBase *)instance)->scriptView->jsUndefined; } + (void *)_ptr_to_func_getImageData { return (void *)&_func_getImageData; }

- (JSValueRef)_func_getImageData:(JSContextRef)ctx argc:(size_t)argc argv:(const JSValueRef [])argv {
 if( argc < 4 +0 ) { return ((void*)0); } short sx = JSValueToNumberFast(ctx, argv[0]) ; short sy = JSValueToNumberFast(ctx, argv[0 +1]) ; short sw = JSValueToNumberFast(ctx, argv[0 +1 +1]) ; short sh = JSValueToNumberFast(ctx, argv[0 +1 +1 +1]);

 scriptView.currentRenderingContext = renderingContext;

 EJImageData *imageData = [renderingContext getImageDataSx:sx sy:sy sw:sw sh:sh];

 EJBindingImageData *binding = [[[EJBindingImageData alloc] initWithImageData:imageData] autorelease];
 return [EJBindingImageData createJSObjectWithContext:ctx scriptView:scriptView instance:binding];
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
    id instance = (id)JSObjectGetPrivate(object); return ((EJBindingBase *)instance)->scriptView->jsUndefined;
}
+ (void *)_ptr_to_func_isPointInPath { return (void *)&_func_isPointInPath; };
