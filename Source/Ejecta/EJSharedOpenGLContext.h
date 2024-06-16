// The Shared OpenGL Context provides compiled shaders and the main vertex
// buffer to all Canvas2D Contexts. With this, an offscreen Canvas2D does not
// have to recompile its own shaders or allocate its own buffer again. All
// Canvas2D contexts can also share the same underlying EAGLContext, which
// makes switching between canvases pretty fast.

// In contrast, WebGL Contexts do not use this class. Each WebGL Context will
// create its own EAGLContext so it can manage all the OpenGL state itself.

/* cp 共享上下文
 用于Canvas2D共享上下文，比如已编译完毕的着色器、顶点数据等
 WebGL不用这个类，而是创建自己的EAGLContext
 */
#import <Foundation/Foundation.h>
#import "EJGLProgram2D.h"
#import "EJGLProgram2DRadialGradient.h"

#define EJ_OPENGL_VERTEX_BUFFER_SIZE (32 * 1024) // 32kb

@interface EJSharedOpenGLContext : NSObject {
	EJGLProgram2D *programFlat;
	EJGLProgram2D *programTexture;
	EJGLProgram2D *programAlphaTexture;
	EJGLProgram2D *programPattern;
	EJGLProgram2DRadialGradient *programRadialGradient;
	
	EAGLContext *glContext2D;
	EAGLSharegroup *glSharegroup;
	NSMutableData *vertexBuffer;
}

+ (EJSharedOpenGLContext *)instance;

/* cp 着色器程序，vs都是EJShaderVertex，fs是根据名字
 Flat 只有颜色
 Texture 纹理 * 颜色
 AlphaTexture 纹理透明通道 * 颜色
 Pattern 平铺
 RadialGradient 径向渐变???
 */
@property (nonatomic, readonly) EJGLProgram2D *programFlat;
@property (nonatomic, readonly) EJGLProgram2D *programTexture;
@property (nonatomic, readonly) EJGLProgram2D *programAlphaTexture;
@property (nonatomic, readonly) EJGLProgram2D *programPattern;
@property (nonatomic, readonly) EJGLProgram2DRadialGradient *programRadialGradient;
/* cp OpenGL ES上下文
 */
@property (nonatomic, readonly) EAGLContext *glContext2D;
/* cp glContext2D对应的Sharegroup
 */
@property (nonatomic, readonly) EAGLSharegroup *glSharegroup;
@property (nonatomic, readonly) NSMutableData *vertexBuffer;

@end
