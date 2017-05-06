//
//  JGMainClickView.h
//  jingGang
//
//  Created by Ai song on 16/1/18.
//  Copyright © 2016年 Dengxf_Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JGMainClickViewDelegate <NSObject>
/*
 **点击button跳转
 */
- (void)SelectButtonClick:(NSInteger)tag;
/*
 **
 */
- (void)push;
@end

@interface JGMainClickView : UIView
@property (nonatomic,strong)UIButton *kmButton;
@property (nonatomic,strong)UIButton *calButton;
@property (nonatomic,strong)UILabel *numberlabel;
//健康自测
@property (nonatomic,weak)id<JGMainClickViewDelegate>delegate;
@end
