//
//  DLTabbarItemView.m
//  YilidiBuyer
//
//  Created by yld on 16/4/18.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLUpDownTitleView.h"
#import "ProjectStandardUIDefineConst.h"
#import <Masonry/Masonry.h>

@interface DLUpDownTitleView()

@property (nonatomic,strong)UIView *bgView;
@property (nonatomic, strong)UIView *verticalSeperatedLineView;

@end

@implementation DLUpDownTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initInfo];
        [self _createUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        [self _initInfo];
        [self _createUI];
    }
    return self;
}

-(void)_initInfo {
    
    self.defaultTitleColor = KTextColor;
    self.selectedTitleColor = KDeepTextColor;
    self.titleFont = [UIFont systemFontOfSize:14.0f];
    self.defaultBackGroundColor = [UIColor whiteColor];
    self.selectedBackGroundColor = KCOLOR_PROJECT_RED;
//    self.selectedBackGroundColor = KSelectedBgColor;
    self.verticalLineBgColor = [UIColor groupTableViewBackgroundColor];
}

- (void)_createUI {
    
    
//    self.upButton = [UIButton new];
//    [self addSubview:self.upButton];
//    [self.upButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(2);
//        make.height.mas_equalTo(25);
//        make.left.right.mas_equalTo(self);
//    }];
//    self.upButton.titleLabel.font = self.titleFont;
//    [self.upButton setTitleColor:self.defaultTitleColor forState:UIControlStateNormal];
//    [self.upButton setTitleColor:self.selectedTitleColor forState:UIControlStateSelected];
//
    self.downButton = [UIButton new];
    self.downButton.backgroundColor = [UIColor clearColor];
    self.downButton.titleLabel.font = self.titleFont;
    [self addSubview:self.downButton];
    [self.downButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(0);
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(25);
        make.left.right.mas_equalTo(self);
    }];
    
    [self.downButton setTitleColor:self.defaultTitleColor forState:UIControlStateNormal];
    [self.downButton setTitleColor:self.selectedTitleColor forState:UIControlStateSelected];
    
    self.bgView = [UIView new];
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(5);
        make.right.mas_offset(-5);
        make.bottom.mas_offset(-1);
        make.height.mas_equalTo(3);
    }];
    self.bgView.backgroundColor = [UIColor whiteColor];

    
}

- (void)_configureUiWhenSelectedDeselected {
    self.upButton.selected = self.selected;
    self.downButton.selected = self.selected;
    self.bgView.backgroundColor = (self.selected ? self.selectedBackGroundColor:self.defaultBackGroundColor);
    if (self.needVerticalSeperatedLine) {
//        self.verticalSeperatedLineView.backgroundColor =  (self.selected ? self.selectedBackGroundColor:self.verticalLineBgColor);
    }

}

#pragma mark -------------------Setter/Getter Method----------------------
- (void)setSelected:(BOOL)selected {
    _selected = selected;
    [self _configureUiWhenSelectedDeselected];
}

- (void)setUpTitle:(NSString *)upTitle {
    _upTitle = upTitle;
    [self.upButton setTitle:upTitle forState:UIControlStateNormal];
}

- (void)setDownTitle:(NSString *)downTitle {
    _downTitle = downTitle;
    [self.downButton setTitle:downTitle forState:UIControlStateNormal];

}

- (void)setCanTouched:(BOOL)canTouched {
    _canTouched = canTouched;
    self.upButton.userInteractionEnabled = self.downButton.userInteractionEnabled = canTouched;
}

- (void)setNeedVerticalSeperatedLine:(BOOL)needVerticalSeperatedLine {
    _needVerticalSeperatedLine = needVerticalSeperatedLine;
//    self.verticalSeperatedLineView.hidden = !needVerticalSeperatedLine;
}

- (UIView *)verticalSeperatedLineView {
    
    if (!_verticalSeperatedLineView) {
        _verticalSeperatedLineView = [UIView new];
        [self addSubview:_verticalSeperatedLineView];
        _verticalSeperatedLineView.backgroundColor = self.verticalLineBgColor;
        [_verticalSeperatedLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(8);
            make.bottom.mas_equalTo(-8);
            make.width.mas_equalTo(1);
        }];
    }
    return _verticalSeperatedLineView;
    
}

@end
