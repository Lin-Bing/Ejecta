// The EJCanvas2D subclass that handles rendering to an offscreen texture.

#import "EJCanvasContext2D.h"

@interface EJCanvasContext2DTexture : EJCanvasContext2D {
	EJTexture *texture;
}
/* cp 离屏canvas，本质上就是一个纹理。
 创建离屏帧缓冲，食用纹理作为颜色附件，离屏canvas2d绘制到纹理上。 后续离屏canvas绘制到屏上canvas，本质上就是把纹理绘制到屏上canvas
 */
@property (readonly, nonatomic) EJTexture *texture;

@end
