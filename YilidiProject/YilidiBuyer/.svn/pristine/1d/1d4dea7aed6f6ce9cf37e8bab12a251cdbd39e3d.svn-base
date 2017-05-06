//
//  DLTabbarItemView.m
//  YilidiBuyer
//
//  Created by yld on 16/4/18.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLTabbarItemView.h"
#import "GlobleConst.h"
#import <Masonry/Masonry.h>

@implementation DLTabbarItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _createUI];
    }
    return self;
}

-(void)setIconImgName:(NSString *)iconImgName {
//    [self.itemIconButton setBackgroundImage:IMAGE(iconImgName) forState:UIControlStateNormal];
    [self.itemIconButton setImage:IMAGE(iconImgName) forState:UIControlStateNormal];
}

- (void)setSelectedIconImgName:(NSString *)selectedIconImgName {
//    [self.itemIconButton setBackgroundImage:IMAGE(selectedIconImgName) forState:UIControlStateSelected];
    [self.itemIconButton setImage:IMAGE(selectedIconImgName) forState:UIControlStateSelected];

}

- (void)setTitle:(NSString *)title {
    [self.itemTitleButton setTitle:title forState:UIControlStateNormal];
    [self.itemTitleButton setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    [self.itemTitleButton setTitleColor:KSelectedBgColor forState:UIControlStateSelected];
}

- (void)setSelected:(BOOL)selected {
    self.itemTitleButton.selected = selected;
    self.itemIconButton.selected = selected;
}

- (void)_createUI {
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
    lineView.backgroundColor = KLineColor;
    [self addSubview:lineView];
    
    self.itemIconButton = [UIButton new];
    [self addSubview:self.itemIconButton];
    
    [self.itemIconButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(8);
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(20, 19));
    }];
    
    self.itemTitleButton = [UIButton new];
    self.itemTitleButton.titleLabel.font = kSystemFontSize(12);
    [self addSubview:self.itemTitleButton];
    [self.itemTitleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-1);
        make.height.mas_equalTo(20);
        make.left.right.mas_equalTo(self);
    }];
}

@end
