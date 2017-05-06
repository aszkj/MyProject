//
//  OrderDetailAddressCell.h
//  jingGang
//
//  Created by 鹏 朱 on 15/9/10.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^PhoneCallBlk)(void);

@interface OrderDetailAddressCell : UITableViewCell

@property (strong, nonatomic) UILabel *shopName;
@property (strong, nonatomic) UILabel *address;
@property (strong, nonatomic) UILabel *distance;
@property (copy, nonatomic) PhoneCallBlk phoneCallBlk;

@end
