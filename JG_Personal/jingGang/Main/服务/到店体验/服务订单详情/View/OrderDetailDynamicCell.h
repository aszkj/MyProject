//
//  OrderDetailDynamicCell.h
//  jingGang
//
//  Created by 鹏 朱 on 15/9/10.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RefundBlk)(void);

@interface OrderDetailDynamicCell : UITableViewCell

@property (strong, nonatomic) UIImageView *shopImg;

@property (strong, nonatomic) UILabel *shopName;
@property (strong, nonatomic) UILabel *price;
@property (strong, nonatomic) UIButton *refundBtn;
@property (strong, nonatomic) UILabel *consumeCode;
@property (strong, nonatomic) UILabel *consumeState;
@property (copy, nonatomic) RefundBlk refundBlk;
//@property (copy, nonatomic) RefundBlk evaluationBlk;

@end
