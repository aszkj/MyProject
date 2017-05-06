//
//  XKJHBaseNavigationBar.m
//  Merchants_JingGang
//
//  Created by 鹏 朱 on 15/9/5.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHBaseNavigationBar.h"
#import "UIColor+UIImage.h"

@implementation XKJHBaseNavigationBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    int  fontSize = 16;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        fontSize = 18;
    }
    self.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],
//                                 NSShadowAttributeName:[NSValue valueWithUIOffset:UIOffsetMake(0, 0)],
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:fontSize]};
    self.tintColor = [UIColor whiteColor];
    self.barTintColor = status_color;
    self.translucent = NO;

    UIImageView *shadowView  = [UIImageView new];
    shadowView.backgroundColor = [UIColor colorFromHexRGB:@"59C4F0"];
    [shadowView setFrame:CGRectMake(0,-20, kScreenWidth, 20)];
    [self addSubview:shadowView];

    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    UIImage *backgroundImage = [[UIColor colorFromHexRGB:@"59C4F0"] translateIntoImage];
    [backgroundImage drawInRect:CGRectMake(0, 0, rect.size.width,rect.size.height)];
    
    backgroundImage = [kGetColor(178, 178, 178) translateIntoImage];
    [backgroundImage drawInRect:CGRectMake(0, rect.size.height-0.5, rect.size.width,0.5)];
}

@end
