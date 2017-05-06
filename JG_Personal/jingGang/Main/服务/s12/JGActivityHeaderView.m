//
//  JGActivityHeaderView.m
//  jingGang
//
//  Created by dengxf on 15/12/10.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "JGActivityHeaderView.h"
#import "UIImageView+WebCache.h"

@interface JGActivityHeaderView ()

@property (strong,nonatomic) UIImageView *headImageView;

@end

@implementation JGActivityHeaderView

- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        [self addSubview:_headImageView];
    }
    return _headImageView;
}


- (void)setHeadImgUrl:(NSString *)headImgUrl {
    _headImgUrl = headImgUrl;
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:_headImgUrl] placeholderImage:nil];
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _headImageView.x = 0;
    _headImageView.y = 0;
    _headImageView.width = ScreenWidth;
    _headImageView.height = 1000;
    
}

@end
