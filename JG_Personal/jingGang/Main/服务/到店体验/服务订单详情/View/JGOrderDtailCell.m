//
//  JGOrderDtailCell.m
//  jingGang
//
//  Created by dengxf on 15/12/26.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "JGOrderDtailCell.h"

@implementation JGOrderDtailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
    }
    
    return self;
}


- (NSString *)orderDetailStatus:(NSInteger)status {
    NSString *resultOrderState;
    switch (status) {
        case 0:
            resultOrderState = @"未消费";
            break;
        case 1:
            resultOrderState = @"已消费";
            break;
        case -1:
            resultOrderState = @"已过期";
            break;
        case 3:
            resultOrderState = @"审核中";
            break;
        case 5:
            resultOrderState = @"审核通过";
            break;
        case 6:
            resultOrderState = @"审核不通过";
            break;
        case 7:
            resultOrderState = @"退款完成";
            break;
        default:
            break;
    }
    return resultOrderState;
}


- (void)setDetailModel:(JGOrderDetailModel *)detailModel {
    _detailModel = detailModel;
    self.orderStatusLab.text = [self orderDetailStatus:[_detailModel.status integerValue]];
    
    if ([@"1" isEqualToString:TNSString(_detailModel.status)]) {
        self.qrcodeButton.hidden = YES;
    }else
    {
        self.qrcodeButton.hidden = NO;
    }
    self.consumeCodeLab.text = detailModel.groupSn;
    
}

- (void)awakeFromNib {
}

@end
