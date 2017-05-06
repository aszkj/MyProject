

#import "KDGoalBarPercentLayer.h"
#import "userDefaultManager.h"

#define toRadians(x) ((x)*M_PI / 180.0)
#define toDegrees(x) ((x)*180.0 / M_PI)
//#define innerRadius    20
//#define outerRadius    25

@implementation KDGoalBarPercentLayer
@synthesize percent,percent2;

-(void)drawInContext:(CGContextRef)ctx {
    self.innerRadius = [[userDefaultManager GetLocalDataString:@"innerRadius"] floatValue];
    if (self.innerRadius == 0) {
        self.innerRadius = 58;
        self.outerRadius = 78;
    }else{
        self.innerRadius = [[userDefaultManager GetLocalDataString:@"innerRadius"] floatValue];
        self.outerRadius = [[userDefaultManager GetLocalDataString:@"outerRadius"] floatValue];
    }
    self.innerRadius = 20;
    self.outerRadius = 25;
    [self DrawRight:ctx];
    [self DrawLeft:ctx];
}
-(void)DrawRight:(CGContextRef)ctx {
    CGPoint center = CGPointMake(self.frame.size.width / (2), self.frame.size.height / (2));
    
    CGFloat delta = -toRadians(360 * percent);
    
    UIColor * left_color1 = [UIColor colorWithRed:115.f/255.0f green:196.f/255.0f blue:115.f/255.0f alpha:1.0f];
    UIColor * left_color2 = [UIColor colorWithRed:143.f/255.0f green:110.f/255.0f blue:225.f/255.0f alpha:1.0f];
    UIColor * left_color3 = [UIColor colorWithRed:86.f/255.0f green:150.f/255.0f blue:238.f/255.0f alpha:1.0f];
    
    UIColor * left_color4 = [UIColor colorWithRed:72.f/255.0f green:199.f/255.0f blue:245.f/255.0f alpha:1.0f];
    UIColor * left_color5 = [UIColor colorWithRed:231.f/255.0f green:82.f/255.0f blue:129.f/255.0f alpha:1.0f];
    UIColor * left_color6 = [UIColor colorWithRed:245.f/255.0f green:176.f/255.0f blue:78.f/255.0f alpha:1.0f];
    UIColor * left_color7 = [UIColor colorWithRed:222.f/255.0f green:222.f/255.0f blue:222.f/255.0f alpha:1.0f];
    UIColor * left_color8 = [UIColor colorWithRed:222.f/255.0f green:222.f/255.0f blue:222.f/255.0f alpha:1.0f];
    CGColorRef left_color = nil;
    if (_witch == 0) {
        left_color = left_color1.CGColor;
    }else if (_witch == 2){
        left_color = left_color2.CGColor;
    }else if (_witch == 4){
        left_color = left_color3.CGColor;
    }else if (_witch == 1){
        left_color = left_color4.CGColor;
    }else if (_witch == 3){
        left_color = left_color5.CGColor;
    }else if (_witch == 5){
        left_color = left_color6.CGColor;
    }else if (self.witch == 100) {
        left_color = left_color7.CGColor;
    }else if (self.witch == 200){
        left_color = left_color8.CGColor;
    }
    
    CGContextSetFillColorWithColor(ctx, left_color);
    
    CGContextSetLineWidth(ctx, 1);
    
    CGContextSetLineCap(ctx, kCGLineCapRound);
    
    CGContextSetAllowsAntialiasing(ctx, YES);
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathAddRelativeArc(path, NULL, center.x, center.y, _innerRadius, -(M_PI / 2), delta);
    CGPathAddRelativeArc(path, NULL, center.x, center.y, _outerRadius, delta - (M_PI / 2), -delta);
    CGPathAddLineToPoint(path, NULL, center.x, center.y-_innerRadius);
    
    CGContextAddPath(ctx, path);
    CGContextFillPath(ctx);
    
    CFRelease(path);
}

-(void)DrawLeft:(CGContextRef)ctx {
    CGPoint center = CGPointMake(self.frame.size.width / (2), self.frame.size.height / (2));
    
    CGFloat delta = toRadians(360 * (1-percent));
    
    UIColor * right_color1 = [UIColor colorWithRed:203.f/255.0f green:234.f/255.0f blue:203.f/255.0f alpha:1.0f];
    UIColor * right_color2 = [UIColor colorWithRed:206.f/255.0f green:195.f/255.0f blue:242.f/255.0f alpha:1.0f];
    UIColor * right_color3 = [UIColor colorWithRed:179.f/255.0f green:212.f/255.0f blue:248.f/255.0f alpha:1.0f];
    
    UIColor * right_color4 = [UIColor colorWithRed:163.f/255.0f green:231.f/251.0f blue:251.f/255.0f alpha:1.0f];
    UIColor * right_color5 = [UIColor colorWithRed:242.f/255.0f green:179.f/255.0f blue:200.f/255.0f alpha:1.0f];
    UIColor * right_color6 = [UIColor colorWithRed:250.f/255.0f green:219.f/255.0f blue:176.f/255.0f alpha:1.0f];
    UIColor * right_color7 = [UIColor colorWithRed:77.f/255.0f green:208.f/255.0f blue:200.f/255.0f alpha:1.0f];
    UIColor * right_color8 = [UIColor colorWithRed:255.f/255.0f green:207.f/255.0f blue:151.f/255.0f alpha:1.0f];
    CGColorRef right_color = nil;
    if (_witch == 0) {
        right_color = right_color1.CGColor;
    }else if (_witch == 2){
        right_color = right_color2.CGColor;
    }else if (_witch == 4){
        right_color = right_color3.CGColor;
    }else if (_witch == 1){
        right_color = right_color4.CGColor;
    }else if (_witch == 3){
        right_color = right_color5.CGColor;
    }else if (_witch == 5){
        right_color = right_color6.CGColor;
    }else if (self.witch == 100) {
        right_color = right_color7.CGColor;
    }else if (self.witch == 200){
        right_color = right_color8.CGColor;
    }
    CGContextSetFillColorWithColor(ctx, right_color);
    
    CGContextSetLineWidth(ctx, 1);
    
    CGContextSetLineCap(ctx, kCGLineCapRound);
    
    CGContextSetAllowsAntialiasing(ctx, YES);
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathAddRelativeArc(path, NULL, center.x, center.y, _innerRadius, -(M_PI / 2), delta);
    CGPathAddRelativeArc(path, NULL, center.x, center.y, _outerRadius, delta - (M_PI / 2), -delta);
    CGPathAddLineToPoint(path, NULL, center.x, center.y-_innerRadius);
    
    CGContextAddPath(ctx, path);
    CGContextFillPath(ctx);
    
    CFRelease(path);
}

@end
