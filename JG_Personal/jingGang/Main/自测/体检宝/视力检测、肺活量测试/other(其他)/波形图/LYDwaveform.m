//
//  LYDwaveform.m
//  波形图
//
//  Created by Dong on 14-3-14.
//  Copyright (c) 2014年 CNTV. All rights reserved.
//

#import "LYDwaveform.h"
#import "UIView+ZXQuartz.h"
//Canvas

@implementation LYDwaveform

-(void)awakeFromNib
{
    i = 0;
    j = 0;
#if 0
    for (NSInteger k = 0 ;  k * 20 < self.frame.size.width ; k++)
    {
        UIView *v = [[UIView alloc]  initWithFrame:CGRectMake(k * 20, 0, 0.5, self.frame.size.height)];
        v.backgroundColor = [UIColor lightGrayColor];
        if (k % 5 == 0)
        {
//            v.frame = CGRectMake(k * 20, 0, 1, self.frame.size.height);
            v.backgroundColor = [UIColor blackColor];
        }
        
        [self addSubview:v];
    }
    
    for (NSInteger k = 0 ; k < 10 ; k ++)
    {
        UIView *v = [[UIView alloc]  initWithFrame:CGRectMake(0, k * self.frame.size.height / 10 , self.frame.size.width, 0.5)];
        v.backgroundColor = [UIColor lightGrayColor];
        if (k == 5)
        {
//            v.frame = CGRectMake(0, k * self.frame.size.height / 10 , self.frame.size.width, 1);
            v.backgroundColor = [UIColor blackColor];
            
        }
        
        [self addSubview:v];
    }
    
#endif
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
 
    }
    return self;
}

- (void)callDraw:(float)f
{
    if (f < 1) {
        swing = f;
    }else {
        swing = 1;
    }
    [self setNeedsDisplay];

}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [[NSRunLoop currentRunLoop]  runMode:UITrackingRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    
    //画横线
    CGFloat detaY = rect.size.height / 10;
    //    CGFloat x = rect.size.width ;
    [[UIColor lightGrayColor] setStroke];
    
    for (int k=1; k<=11; k++) {
        int y = detaY * (k-1);
        if (i==6) {
            
            [[UIColor darkGrayColor] setStroke];
            
        }else{
            
            [[UIColor lightGrayColor] setStroke];
        }
        [self drawLineFrom:CGPointMake(0, y) to:CGPointMake(rect.size.width, y)];
    }
    
    //画竖线
    CGFloat detaX = rect.size.width / 17;
    for (int k=1; k<=18; k++) {
        int x = detaX * (k - 1);
        if (k == 1 || k == 6 || k == 11 || k == 16 ) {
            [[UIColor darkGrayColor] setStroke];
        }else{
            [[UIColor lightGrayColor] setStroke];
        }
        [self drawLineFrom:CGPointMake(x, 0) to:CGPointMake(x, rect.size.height)];
    }

    
    
    
    
    if (self.height == 0)
    {
        self.height = self.frame.size.height / 2 - 10;
    }
    if (self.radian == 0)
    {
        self.radian = 1;
    }
    if (self.frequency == 0)
    {
        self.frequency = 1;
    }
    
    

    NSLog(@"isMainThread = %d",[NSThread isMainThread]);

//    dispatch_async(dispatch_get_main_queue(), ^{
    

    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextSetLineWidth(context, 1.0);
    
    float x = 0;
    float y = 40.0;
    CGContextMoveToPoint(context, x, y);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
    });
    for (float x = 0; x < rect.size.width; x ++)
    {
        float tem = (self.frequency - 20) / 19980.0 * 180;
        y = sin((x-i) * 2 * ((int)tem + 20)*3.14) * self.height + self.frame.size.height / 2;
        if (x != 0)
        {
            CGContextAddLineToPoint(context, x, y);
        }
        CGContextStrokePath(context);
        CGContextMoveToPoint(context, x, y);
    }
    i += 2;
//    });
}

- (void) ceshi
{
    //画横线
    CGFloat detaY = self.frame.size.height / 10;
    //    CGFloat x = rect.size.width ;
    [[UIColor lightGrayColor] setStroke];
    
    for (int k=1; k<=11; k++) {
        int y = detaY * (k-1);
        if (i==6) {
            
            [[UIColor darkGrayColor] setStroke];
            
        }else{
            
            [[UIColor lightGrayColor] setStroke];
        }
        [self drawLineFrom:CGPointMake(0, y) to:CGPointMake(self.frame.size.width, y)];
    }
    
    //画竖线
    CGFloat detaX = self.frame.size.width / 17;
    for (int k=1; k<=18; k++) {
        int x = detaX * (k - 1);
        if (k == 1 || k == 6 || k == 11 || k == 16 ) {
            [[UIColor darkGrayColor] setStroke];
        }else{
            [[UIColor lightGrayColor] setStroke];
        }
        [self drawLineFrom:CGPointMake(x, 0) to:CGPointMake(x, self.frame.size.height)];
    }
    
    
    
    
    
    if (self.height == 0)
    {
        self.height = self.frame.size.height / 2 - 10;
    }
    if (self.radian == 0)
    {
        self.radian = 1;
    }
    if (self.frequency == 0)
    {
        self.frequency = 1;
    }
    
    
    
    NSLog(@"isMainThread = %d",[NSThread isMainThread]);
    
    //    dispatch_async(dispatch_get_main_queue(), ^{
    
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextSetLineWidth(context, 1.0);
    
    float x = 0;
    float y = 40.0;
    CGContextMoveToPoint(context, x, y);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
    });
    for (float x = 0; x < self.frame.size.width; x ++)
    {
        float tem = (self.frequency - 20) / 19980.0 * 180;
        y = sin((x-i) * 2 * ((int)tem + 20)*3.14) * self.height + self.frame.size.height / 2;
        if (x != 0)
        {
            CGContextAddLineToPoint(context, x, y);
        }
        CGContextStrokePath(context);
        CGContextMoveToPoint(context, x, y);
    }
    i += 2;
}


@end
