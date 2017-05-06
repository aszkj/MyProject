//
//  JGWeatherView.h
//  jingGang
//
//  Created by Ai song on 16/1/20.
//  Copyright © 2016年 Dengxf_Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JGWeatherView : UIView
- (instancetype)initWithFrame:(CGRect)frame andSuperView:(UIView *)superView;
@property (nonatomic,strong)UIImageView *weatherimageView;
@property (nonatomic,assign)BOOL isOpen;
- (void)showInSuperView;
- (void)hideInSuperView;
@end
