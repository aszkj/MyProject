//
//  ComplainSelectedCell.m
//  jingGang
//
//  Created by dengxf on 15/10/31.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "ComplainSelectedCell.h"

@interface ComplainSelectedCell ()

/**
 *  被选中显示的标记UIImageView
 */
@property (strong,nonatomic) UIImageView *seletedImageView;

/**
 *  判断cell是否显示被选中标记
 */
@property (assign, nonatomic) BOOL showSelected;
@end

@implementation ComplainSelectedCell

- (UIImageView *)seletedImageView {
    if (!_seletedImageView) {
        _seletedImageView = [[UIImageView alloc] init];
        _seletedImageView.hidden = YES;
        _seletedImageView.backgroundColor = [UIColor clearColor];
        _seletedImageView.image = [UIImage imageNamed:@"XUANZHONG"];
        [self.contentView addSubview:_seletedImageView];
    }
    return _seletedImageView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat wHidth = 15.0f;
    CGFloat spacing = 16.0f;
    self.seletedImageView.width = wHidth;
    self.seletedImageView.height = wHidth;
    self.seletedImageView.x = self.contentView.width - spacing - wHidth;
    self.seletedImageView.y = (self.contentView.height - wHidth) / 2;
    self.seletedImageView.hidden = !self.showSelected;
}

- (void)stSelectedWithIndexPath:(NSIndexPath *)indexPath {
    
    if (self.seletedImageView.hidden) {
        // 已隐藏 设置为显示
        self.showSelected= YES;
        if ([self.delegate respondsToSelector:@selector(complainSelectedCell:didSelectedCells:)]) {
            [self.delegate complainSelectedCell:self didSelectedCells:indexPath];
        }
    }else {
        self.showSelected = NO;
        if ([self.delegate respondsToSelector:@selector(complainSelectedCell:didCancelSelectedCells:)]) {
            [self.delegate complainSelectedCell:self didCancelSelectedCells:indexPath];
        }
    }
    
    [self setNeedsLayout];
}

- (void)hiddenSelectedIndexPath {
    self.showSelected = NO;
    [self setNeedsLayout];
}
@end
