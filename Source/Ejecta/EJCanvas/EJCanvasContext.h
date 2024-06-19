// The base class each Canvas Context (2D or WebGL) is derived from, so it can
// be hosted by a Canvas.

#import <Foundation/Foundation.h>

/* cp canvas context基类，存放公用属性
 */
@class EAGLContext;
@interface EJCanvasContext : NSObject {
    // canvas带过来的，像素尺寸
	short width, height;
	
    /* cp 创建context时js端传入的入参
     */
	BOOL preserveDrawingBuffer;/* cp canvas2d默认ture */
	BOOL msaaEnabled;
    int msaaSamples;
	BOOL alphaShouldLock;
	BOOL needsPresenting;
    /* cp 上下文 */
	EAGLContext *glContext;
}

- (void)create;
- (void)flushBuffers;
- (void)prepare;

@property (nonatomic) BOOL preserveDrawingBuffer;
@property (nonatomic) BOOL msaaEnabled;
@property (nonatomic) BOOL alphaShouldLock;
@property (nonatomic) int msaaSamples;
@property (nonatomic) short width;
@property (nonatomic) short height;

/* cp OpenGL ES上下文 */
@property (nonatomic, readonly) EAGLContext *glContext;

@end
