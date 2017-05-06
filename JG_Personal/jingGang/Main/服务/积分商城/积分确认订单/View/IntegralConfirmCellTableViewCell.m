//
//  IntegralConfirmCellTableViewCell.m
//  jingGang
//
//  Created by ray on 15/11/3.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "IntegralConfirmCellTableViewCell.h"
#import "PublicInfo.h"
#import "Masonry.h"

@implementation IntegralConfirmCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setEntity:(NSArray<__kindof IntegralGoodsDetails *> *)array {
    UIView *superview = self.contentView;
    [superview.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [array enumerateObjectsUsingBlock:^(IntegralGoodsDetails * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *goodsView = [self goodsView:obj.igGoodsName count:obj.igExchangeCount totalIntegral:@(obj.igGoodsIntegral.doubleValue * obj.igExchangeCount.doubleValue)];
        [superview addSubview:goodsView];
    }];
    [superview.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull goodsView, NSUInteger idx, BOOL * _Nonnull stop) {
        [goodsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superview);
            make.right.equalTo(superview);
            if (idx == 0) {
                make.top.equalTo(superview).with.offset(16);
            } else {
                UIView *preView = superview.subviews[(idx-1)];
                make.top.equalTo(preView.mas_bottom).with.offset(3);
            }
            if (idx == array.count-1) {
                make.bottom.equalTo(superview).with.offset(-16);
            }
        }];
    }];
}

- (UIView *)goodsView:(NSString *)goodsName count:(NSNumber *)count totalIntegral:(NSNumber *)totalIntegral {
    UIView *goodsView = [[UIView alloc] initWithFrame:CGRectZero];
    UILabel *nameLabel = [self labelWithText:goodsName];
    UILabel *countLabel = [self labelWithText:[@"X" stringByAppendingString:count.stringValue]];
    UILabel *integralLabel = [self labelWithText:[@"积分：" stringByAppendingString:totalIntegral.stringValue]];
    [goodsView addSubview:nameLabel];
    [goodsView addSubview:countLabel];
    [goodsView addSubview:integralLabel];
    UIView *superview = goodsView;
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@[countLabel,integralLabel]);
        make.left.equalTo(superview);
        make.right.equalTo(countLabel.mas_left);
        make.top.equalTo(@[superview,countLabel,integralLabel]);
        make.bottom.equalTo(@[superview,countLabel,integralLabel]);
    }];
    [countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(integralLabel.mas_left);
    }];
    [integralLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(superview);
    }];
    
    return goodsView;
}

- (UILabel *)labelWithText:(NSString *)text {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = UIColorFromRGB(0x666666);
    label.numberOfLines = 2;
    label.text = text;
    label.font = [UIFont systemFontOfSize:13];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

@end
