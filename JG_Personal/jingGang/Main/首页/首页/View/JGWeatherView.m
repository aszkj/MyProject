//
//  JGWeatherView.m
//  jingGang
//
//  Created by Ai song on 16/1/20.
//  Copyright © 2016年 Dengxf_Dev. All rights reserved.
//

#import "JGWeatherView.h"

@interface JGWeatherView ()
#define height  [[UIScreen mainScreen] bounds].size.height
#define width  [[UIScreen mainScreen] bounds].size.width
@property (nonatomic,strong)UIView *supView;
@end
@implementation JGWeatherView
- (instancetype)initWithFrame:(CGRect)frame andSuperView:(UIView *)superView{
    self = [super initWithFrame:frame];
    self.supView = superView;
    if(self){
        self.isOpen = NO;
        
        [self initView];
    }
    return  self;
}
- (void)initView{
    self.weatherimageView = [[UIImageView alloc] init];
    
    if (height == 480) {
        self.weatherimageView.frame = CGRectMake(0, 0, width, height/3-10);
    }else{
        self.weatherimageView.frame = CGRectMake(0, 0, width, height/4+20);
    }
    [self addSubview:self.weatherimageView];
}
- (void)showInSuperView{
    if(self.isOpen){
        
        return;
    }
    else{
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = self.supView.frame;
        }];
        
    }
}
- (void)hideInSuperView{
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = CGRectMake(0, -height, width,height);
    }];
}
@end
