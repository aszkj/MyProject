//
//  Canvas.m
//  demo
//
//  Created by 张 玺 on 13-3-29.
//  Copyright (c) 2013年 me.zhangxi. All rights reserved.
//

#import "Canvas.h"
#import "UIView+ZXQuartz.h"

@implementation Canvas

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }

    return self;
}


- (void)drawRect:(CGRect)rect
{
//    UIColor *blue = [UIColor colorWithRed:80.f/255.f
//                                    green:150.f/255.f
//                                     blue:225.f/255.f
//                                    alpha:1];
//    
//    UIColor *white = [UIColor colorWithRed:1
//                                     green:1
//                                      blue:1
//                                     alpha:1];
//    UIColor *green = [UIColor colorWithRed:41.f/255.f
//                                     green:199.f/255.f
//                                      blue:165.f/255.f
//                                     alpha:1];
//    [blue setStroke];//设置线条颜色
//    [white setFill]; //设置填充颜色
//    
//    //画背景矩形框
//    [self drawRectangle:CGRectMake(10, 10, 300, 300)];
//    
//    //画圆角矩形
//    [self drawRectangle:CGRectMake(15, 15, 290, 290) withRadius:10];
//    
//    //画多边形
//    [green setFill];
//    NSArray *points= @[[NSValue valueWithCGPoint:CGPointMake(70, 30)],
//                       [NSValue valueWithCGPoint:CGPointMake(80, 70)],
//                       [NSValue valueWithCGPoint:CGPointMake(120, 80)],
//                       [NSValue valueWithCGPoint:CGPointMake(80, 90)],
//                       [NSValue valueWithCGPoint:CGPointMake(70, 130)],
//                       [NSValue valueWithCGPoint:CGPointMake(60, 90)],
//                       [NSValue valueWithCGPoint:CGPointMake(20, 80)],
//                       [NSValue valueWithCGPoint:CGPointMake(60, 70)],
//                       [NSValue valueWithCGPoint:CGPointMake(70, 30)]];
//    [self drawPolygon:points];
//    [white setFill];
//    
//    //画波浪线
//    [self drawCurveFrom:CGPointMake(120, 50)
//                     to:CGPointMake(200, 50)
//          controlPoint1:CGPointMake(130, 0)
//          controlPoint2:CGPointMake(190, 100)];
//    
//    //画大圆
//    [self drawCircleWithCenter:CGPointMake(160, 160)
//                        radius:50];
//    
//    [blue setFill];//设置蓝色填充
//    
//    //画眼睛
//    [self drawCircleWithCenter:CGPointMake(135, 145)
//                        radius:6];
//    [self drawCircleWithCenter:CGPointMake(185, 145)
//                        radius:6];
//
//    [white setFill];//切换回白色填充
//    
//    //画嘴巴
//    [self drawArcFromCenter:CGPointMake(160, 160)
//                     radius:30
//                 startAngle:0
//                   endAngle:3.14
//                  clockwise:YES];
//
//    //画三道直线
//    [self drawLineFrom:CGPointMake(110, 260)
//                    to:CGPointMake(210, 260)];
//    [self drawLineFrom:CGPointMake(120, 265)
//                    to:CGPointMake(200, 265)];
//    [self drawLineFrom:CGPointMake(130, 270)
//                    to:CGPointMake(190, 270)];
    

    //画横线
    CGFloat detaY = rect.size.height / 10;
//    CGFloat x = rect.size.width ;
    [[UIColor lightGrayColor] setStroke];
    
    for (int i=1; i<=11; i++) {
        int y = detaY * (i-1);
        if (i==6) {
            
            [[UIColor darkGrayColor] setStroke];
            
        }else{
            
            [[UIColor lightGrayColor] setStroke];
        }
        [self drawLineFrom:CGPointMake(0, y) to:CGPointMake(rect.size.width, y)];
    }
    
    //画竖线
    CGFloat detaX = rect.size.width / 17;
    for (int i=1; i<=18; i++) {
        int x = detaX * (i - 1);
        if (i == 1 || i == 6 || i == 11 || i == 16 ) {
            [[UIColor darkGrayColor] setStroke];
        }else{
            [[UIColor lightGrayColor] setStroke];
        }
        [self drawLineFrom:CGPointMake(x, 0) to:CGPointMake(x, rect.size.height)];
    }
    
    
    
//    [self drawLineFrom:CGPointMake(30, detaY) to:CGPointMake(x, detaY)];
//    [self drawLineFrom:CGPointMake(30, detaY*2) to:CGPointMake(x, detaY*2)];
//    [self drawLineFrom:CGPointMake(30, detaY*3) to:CGPointMake(x, detaY*3)];
//    [self drawLineFrom:CGPointMake(30, detaY*4) to:CGPointMake(x, detaY*4)];
//    [self drawLineFrom:CGPointMake(30, detaY*5) to:CGPointMake(x, detaY*5)];
//    
//    [[UIColor darkGrayColor] setStroke];
//    [self drawLineFrom:CGPointMake(30, detaY*6) to:CGPointMake(x, detaY*6)];
//    [[UIColor lightGrayColor] setStroke];
//    [self drawLineFrom:CGPointMake(30, detaY*7) to:CGPointMake(x, detaY*7)];
//    [self drawLineFrom:CGPointMake(30, detaY*8) to:CGPointMake(x, detaY*8)];
//    [self drawLineFrom:CGPointMake(30, detaY*9) to:CGPointMake(x, detaY*9)];
//    [self drawLineFrom:CGPointMake(30, detaY*10) to:CGPointMake(x, detaY*10)];
//    [self drawLineFrom:CGPointMake(30, detaY*11) to:CGPointMake(x, detaY*11)];
//
    
//    //画扇形
//    [[UIColor grayColor] setStroke];
//    [white setFill];
//    [self drawSectorFromCenter:CGPointMake(60, 400)
//                        radius:30
//                    startAngle:-3.14/2
//                      endAngle:0
//                     clockwise:YES];
//    [blue setFill];
//    [self drawSectorFromCenter:CGPointMake(60, 400)
//                        radius:30
//                    startAngle:0
//                      endAngle:3.14/2
//                     clockwise:YES];
//    [white setFill];
//    [self drawSectorFromCenter:CGPointMake(60, 400)
//                        radius:30
//                    startAngle:3.14/2
//                      endAngle:3.14
//                     clockwise:YES];
//    [blue setFill];
//    [self drawSectorFromCenter:CGPointMake(60, 400)
//                        radius:30
//                    startAngle:3.14
//                      endAngle:-3.14/2
//                     clockwise:YES];
//    [blue setStroke];
//    //画折线
//    NSArray *lines = @[[NSValue valueWithCGPoint:CGPointMake(200, 400)],
//                       [NSValue valueWithCGPoint:CGPointMake(220, 380)],
//                       [NSValue valueWithCGPoint:CGPointMake(240, 410)],
//                       [NSValue valueWithCGPoint:CGPointMake(260, 350)],
//                       [NSValue valueWithCGPoint:CGPointMake(280, 410)],
//                       [NSValue valueWithCGPoint:CGPointMake(300, 390)]];
//    [self drawLines:lines];
}


@end
