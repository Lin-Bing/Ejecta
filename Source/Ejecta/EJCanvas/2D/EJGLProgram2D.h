// A wrapper class around OpenGL's shader compilation, used for compiling
// shaders for Canvas2D.

#import <Foundation/Foundation.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

#import "EJCanvas2DTypes.h"

/* cp 顶点着色器索引 */
enum {
	kEJGLProgram2DAttributePos,
	kEJGLProgram2DAttributeUV,
	kEJGLProgram2DAttributeColor,
};

/* cp context2D 着色器程序 */
@interface EJGLProgram2D : NSObject {
	GLuint program;
	GLuint screen; /* cp uniform位置 */
}

- (id)initWithVertexShader:(const char *)vertexShaderSource fragmentShader:(const char *)fragmentShaderSource;
- (void)bindAttributeLocations;
- (void)getUniforms;

/* cp 编译着色器 */
+ (GLint)compileShaderSource:(const char *)source type:(GLenum)type;
/* cp 链接 */
+ (void)linkProgram:(GLuint)program;

@property (nonatomic, readonly) GLuint program;
@property (nonatomic, readonly) GLuint screen;

@end
