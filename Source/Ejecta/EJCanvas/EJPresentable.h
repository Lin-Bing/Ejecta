// The Presentable protocol is implemented Canvas Contexts that are directly
// rendered to the screen, instead of to an offscreen texture.

#import <Foundation/Foundation.h>

@protocol EJPresentable

/* cp 定时器，即每一帧执行一次，触发上屏
 */
- (void)present;
/* cp 定时器暂停时执行，避免退后台执行GL指令
 */
- (void)finish;

@property (nonatomic) CGRect style;
@property (nonatomic, readonly) UIView *view;

@end
