// The EJCanvas2D subclass that handles rendering to an offscreen texture.

#import "EJCanvasContext2D.h"

@interface EJCanvasContext2DTexture : EJCanvasContext2D {
	EJTexture *texture;
}
/* cp 离屏canvas，本质上就是一个纹理
 */
@property (readonly, nonatomic) EJTexture *texture;

@end
