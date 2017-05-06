
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "KDGoalBarPercentLayer.h"


@interface KDGoalBar : UIView {
    UIImage * thumb;
    
    KDGoalBarPercentLayer *percentLayer;
    CALayer *thumbLayer;
          
}

@property (nonatomic, strong) UILabel *percentLabel;
@property (nonatomic, assign)float  witch;

- (void)setPercent:(float)percent witch:(NSInteger)witch animated:(BOOL)animated;


@end
