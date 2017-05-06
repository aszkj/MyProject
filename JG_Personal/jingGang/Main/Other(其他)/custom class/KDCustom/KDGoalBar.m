
#import "KDGoalBar.h"

@implementation KDGoalBar
@synthesize    percentLabel;

#define Label_Selected_Color            [UIColor colorWithRed:70.f/255.0f green:203.f/255.0f blue:179.f/255.0f alpha:1.0f]
#define color_no                        [UIColor colorWithRed:200.f/255.0f green:235.f/255.0f blue:202.f/255.0f alpha:1.0f]

#pragma Init & Setup
- (id)init
{
    if ((self = [super init]))
    {
        [self setup];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
    {
        [self setup];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        [self setup];
    }
    
    return self;
}


-(void)layoutSubviews {
    CGRect frame = self.frame;
    int percent = percentLayer.percent * 100;
    [percentLabel setText:[NSString stringWithFormat:@"%i%%", percent]];
    
    
    CGRect labelFrame = percentLabel.frame;
    labelFrame.origin.x = frame.size.width / 2 - percentLabel.frame.size.width / 2;
    labelFrame.origin.y = frame.size.height / 2 - percentLabel.frame.size.height / 2;
    percentLabel.frame = labelFrame;
    
    [super layoutSubviews];
}

-(void)setup {
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = NO;
    
    
    //    percentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 75, 75)];
    //    [percentLabel setFont:[UIFont systemFontOfSize:30]];
    //    [percentLabel setTextColor:[UIColor colorWithRed:89/255.0 green:89/255.0 blue:89/255.0 alpha:1.0]];
    //    [percentLabel setTextAlignment:NSTextAlignmentCenter];
    //    [percentLabel setBackgroundColor:[UIColor clearColor]];
    //    percentLabel.adjustsFontSizeToFitWidth = YES;
    //    percentLabel.minimumFontSize = 10;
    //    [self addSubview:percentLabel];
    
    thumbLayer = [CALayer layer];
    thumbLayer.contentsScale = [UIScreen mainScreen].scale;
    thumbLayer.contents = (id) thumb.CGImage;
    thumbLayer.frame = CGRectMake(self.frame.size.width / 2 - thumb.size.width/2, 0, thumb.size.width, thumb.size.height);
    thumbLayer.hidden = YES;
    
    
    percentLayer = [KDGoalBarPercentLayer layer];
    percentLayer.contentsScale = [UIScreen mainScreen].scale;
    percentLayer.percent = 0;
    percentLayer.percent2 = self.witch;
    percentLayer.frame = self.bounds;
    percentLayer.masksToBounds = NO;
    [percentLayer setNeedsDisplay];
    
    [self.layer addSublayer:percentLayer];
        [self.layer addSublayer:thumbLayer];
    
    
}


#pragma mark - Touch Events
- (void)moveThumbToPosition:(CGFloat)angle {
    CGRect rect = thumbLayer.frame;
    NSLog(@"%@",NSStringFromCGRect(rect));
    CGPoint center = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0f);
    angle -= (M_PI/2);
    NSLog(@"%f",angle);
    
    rect.origin.x = center.x + 75 * cosf(angle) - (rect.size.width/2);
    rect.origin.y = center.y + 75 * sinf(angle) - (rect.size.height/2);
    
    NSLog(@"%@",NSStringFromCGRect(rect));
    
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    
    thumbLayer.frame = rect;
    
    [CATransaction commit];
}
#pragma mark - Custom Getters/Setters
- (void)setPercent:(float)percent witch:(NSInteger)witch animated:(BOOL)animated {
    
    CGFloat floatPercent = percent / 100.0;
    floatPercent = MIN(1, MAX(0, floatPercent));
    
    percentLayer.percent = floatPercent;
    percentLayer.witch = witch;
    [self setNeedsLayout];
    [percentLayer setNeedsDisplay];
    
    [self moveThumbToPosition:floatPercent * (2 * M_PI) - (M_PI/2)];
    
}


@end
