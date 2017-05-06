//
// Created by 邹俊 on 2016/8/10.
// Copyright (c) 2016 尚娱网络. All rights reserved.
//

#import "JJMenuItemCell.h"


@interface JJMenuItemCell()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation JJMenuItemCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}


- (void)commonInit {
    _normalFontColor = _selectedFontColor = [UIColor blackColor];
    _normalFontSize = _selectedFontSize = 4;

    _titleLabel = [[UILabel alloc] init];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = _normalFontColor;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:_normalFontSize];
    [self.contentView addSubview:_titleLabel];

    [self.contentView addConstraints:
            [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_titleLabel]|"
                                                    options:0
                                                    metrics:nil
                                                      views:NSDictionaryOfVariableBindings(_titleLabel)]];[self.contentView addConstraints:
            [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_titleLabel]|"
                                                    options:0
                                                    metrics:nil
                                                      views:NSDictionaryOfVariableBindings(_titleLabel)]];
}



- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];

    if (selected) {
        _titleLabel.textColor = _selectedFontColor;
//        _titleLabel.font = [UIFont systemFontOfSize:_selectedFontSize];
//        _titleLabel.transform = CGAffineTransformScale(_titleLabel.transform, _normalFontSize / (float)_selectedFontSize, _normalFontSize / (float)_selectedFontSize);
        [UIView animateWithDuration:0.2 animations:^{
//            _titleLabel.transform = CGAffineTransformScale(_titleLabel.transform, _selectedFontSize / (float)_normalFontSize, _selectedFontSize / (float)_normalFontSize);
        } completion:^(BOOL finished) {
//            _titleLabel.transform = CGAffineTransformScale(_titleLabel.transform, 1, 1);
        }];
    } else {
        _titleLabel.textColor = _normalFontColor;
//        _titleLabel.font = [UIFont systemFontOfSize:_normalFontSize];
    }
}



- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = _title;
}

- (void)setNormalFontColor:(UIColor *)normalFontColor {
    _normalFontColor = normalFontColor;
    _titleLabel.textColor = _normalFontColor;
}

- (void)setNormalFontSize:(int)normalFontSize {
    _normalFontSize = normalFontSize;
    _titleLabel.font = [UIFont systemFontOfSize:_normalFontSize];
}




@end
