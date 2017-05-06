//
//  TitleSelectorView.m
//  jingGang
//
//  Created by thinker on 15/8/5.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "TLTitleSelectorView.h"
#import "Masonry.h"

@interface TLTitleSelectorView ()

@property (nonatomic, readonly) NSArray *titles;
@property (nonatomic          ) NSArray *buttons;
@property (nonatomic          ) UIView  *bottomView;
@property (nonatomic          ) UIColor *bottomColor;
@property (nonatomic          ) UIButton *seletedButton;

@end


@implementation TLTitleSelectorView

@synthesize titleColor = _titleColor,selectedColor = _selectedColor;

- (instancetype)initWithFrame:(CGRect)frame          // default initializer
{
    if (self = [super initWithFrame:frame]) {
    
    }
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (id)initWithTitles:(NSString *)firstTitle, ... NS_REQUIRES_NIL_TERMINATION
{
    if (self = [super init]) {
        [self setSelectorTitles:firstTitle, nil];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

}


- (void)setSelectorTitles:(NSString *)firstTitle, ... NS_REQUIRES_NIL_TERMINATION
{
    if (self.titles != nil) {
        return;
    } else {
        NSMutableArray *argsArray = [[NSMutableArray alloc] init];
        id arg;
        va_list argList;
        if(firstTitle)
        {
            va_start(argList,firstTitle);
            [argsArray addObject:firstTitle];
            while ((arg = va_arg(argList,id)))
            {
                [argsArray addObject:arg];
            }
            va_end(argList);
        }
        
        _titles = argsArray.copy;
        
        for (int i = 0; i < self.buttons.count; i++) {
            UIButton *button = self.buttons[i];
            [self addSubview:button];
        }
        [self setNeedsDisplay];
        [self setViewsMASConstraint];
    }
    
}

- (void)pressButton:(UIButton *)button
{
    if (self.seletedButton == button) {
        return;
    } else {
        [self setBottomViewConstraint:button];
        [UIView animateWithDuration:0.3 animations:^{
            
            [self.bottomView layoutIfNeeded];
        } completion:^(BOOL finished) {
            self.seletedButton = button;
        }];
        
        if (self.buttonPressBlock) {
            self.buttonPressBlock(button.tag);
        }
    }
}


- (UIColor *)bottomColor {
    if (_bottomColor == nil) {
        _bottomColor = status_color;
    }
    
    return _bottomColor;
}

- (UIView *)bottomView {
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomView.backgroundColor = self.bottomColor;
        [self addSubview:_bottomView];
    }

    return _bottomView;
}

- (NSArray *)buttons {
    if (_buttons == nil) {
        
        NSAssert(self.titles != nil, @"Titles must be set");
        NSMutableArray *argsArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < self.titles.count; i++) {
            UIButton *button = [[UIButton alloc] init];
            [button setTitle:self.titles[i] forState:UIControlStateNormal];
            [button setTitleColor:self.titleColor forState:UIControlStateNormal];
            
            [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
            button.titleLabel.adjustsFontSizeToFitWidth = YES;
            [argsArray addObject:button];
            button.tag = i;
            [button addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
        }
        _buttons = [argsArray copy];
    }
    
    return _buttons;
}

- (void)setSeletedButton:(UIButton *)seletedButton {
    if (_seletedButton != nil) {
        [_seletedButton setTitleColor:self.titleColor forState:UIControlStateNormal];
    }
    _seletedButton = seletedButton;
    [seletedButton setTitleColor:self.selectedColor forState:UIControlStateNormal];
}

- (void)setSelectedColor:(UIColor *)selectedColor {
    _selectedColor = selectedColor;
    if (self.seletedButton) {
        [self.seletedButton setTitleColor:selectedColor forState:UIControlStateNormal];
    }
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    for (int i = 0; i < self.buttons.count; i++) {
        UIButton *button = self.buttons[i];
        if (button != self.seletedButton) {
            [button setTitleColor:_titleColor forState:UIControlStateNormal];
        }
    }
}

- (UIColor *)titleColor {
    if (_titleColor == nil) {
        _titleColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.9];
    }
    
    return _titleColor;
}

- (UIColor *)selectedColor {
    if (_selectedColor == nil) {
        _selectedColor = [UIColor colorWithRed:74.0/255 green:182.0/255 blue:236.0/255 alpha:1];
    }
    return _selectedColor;
}

- (void)setBottomViewConstraint:(UIButton *)selectedButton{
    [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@4);
        make.width.equalTo(selectedButton.titleLabel);
        make.bottom.equalTo(selectedButton);
        make.centerX.equalTo(selectedButton);
    }];
}

- (void)setViewsMASConstraint
{
    NSInteger count = self.buttons.count;
    for (int i = 0; i < count; i++) {
        UIButton *button = self.buttons[i];
        
        UIView *superView = self;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(superView);
            make.bottom.equalTo(superView);
            make.width.equalTo(superView).multipliedBy(1.0/count);
            if (0 == i) {
                make.left.equalTo(superView);
            } else if (count - 1 == i) {
                make.right.equalTo(superView);
            } else {
                UIButton *nextButton = self.buttons[i+1];
                make.right.equalTo(nextButton.mas_left);
            }
        }];
        
        [button.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(button);
            make.width.lessThanOrEqualTo(button).with.offset(-20);
        }];
    }

     self.seletedButton = self.buttons.firstObject;
    [self setBottomViewConstraint:self.seletedButton];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
