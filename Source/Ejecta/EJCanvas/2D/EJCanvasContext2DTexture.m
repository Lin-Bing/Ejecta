#import "EJCanvasContext2DTexture.h"
#import "EJJavaScriptView.h"

@implementation EJCanvasContext2DTexture

- (void)dealloc {
	[texture release];
	[super dealloc];
}

- (void)resizeToWidth:(short)newWidth height:(short)newHeight {
	[self flushBuffers];
	
	bufferWidth = width = newWidth;
	bufferHeight = height = newHeight;
	
	NSLog(
		@"Creating Offscreen Canvas (2D): "
			@"size: %dx%d, "
			@"antialias: %@",
		width, height,
		(msaaEnabled ? [NSString stringWithFormat:@"yes (%d samples)", msaaSamples] : @"no")
	);
	/* cp 创建纹理，作为离屏画布的渲染表面，即离屏帧缓冲的颜色附件，因为后面需要采样，因此食用纹理 */
	// Release previous texture if any, create the new texture and set it as
	// the rendering target for this framebuffer
	[texture release];
	texture = [[EJTexture alloc] initAsRenderTargetWithWidth:newWidth height:newHeight
		fbo:viewFrameBuffer];
	
	glBindFramebuffer(GL_FRAMEBUFFER, viewFrameBuffer);
	glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, texture.textureId, 0);
	
	[self resetFramebuffer];
}
/* cp 离屏canvas，渲染到屏上canvas时，取出当前帧缓冲的纹理附件 */
- (EJTexture *)texture {
	// If this texture Canvas uses MSAA, we need to resolve the MSAA first,
	// before we can use the texture for drawing.
	if( msaaEnabled && needsPresenting ) {
		GLint boundFrameBuffer;
		glGetIntegerv( GL_FRAMEBUFFER_BINDING, &boundFrameBuffer );
		
		//Bind the MSAA and View frameBuffers and resolve
		glBindFramebuffer(GL_READ_FRAMEBUFFER_APPLE, msaaFrameBuffer);
		glBindFramebuffer(GL_DRAW_FRAMEBUFFER_APPLE, viewFrameBuffer);
		glResolveMultisampleFramebufferAPPLE();
		
		glBindFramebuffer(GL_FRAMEBUFFER, boundFrameBuffer);
		needsPresenting = NO;
	}
	
	// Special case where this canvas is drawn into itself - we have to use glReadPixels to get a texture
	if( scriptView.currentRenderingContext == self ) {
		return [self getImageDataSx:0 sy:0 sw:width sh:height].texture;
	}
	/* cp 普通情况，直接返回纹理附件 */
	// Just use the framebuffer texture directly
	else {
		return texture;
	}
}

@end
