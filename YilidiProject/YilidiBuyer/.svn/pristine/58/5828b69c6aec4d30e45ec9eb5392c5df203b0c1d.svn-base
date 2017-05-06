//
// Created by Joon on 16/8/11.
// Copyright (c) 2016 ___Joon___. All rights reserved.
//

#import "JJContentItemCell.h"


@interface JJContentItemCell()



@end

@implementation JJContentItemCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}


- (void)commonInit {

}


- (void)setContentItemView:(UIView *)contentItemView {
    _contentItemView = contentItemView;
    [self.contentView addSubview:_contentItemView];
}


- (void)layoutSubviews {
    _contentItemView.frame = self.bounds;
}


@end