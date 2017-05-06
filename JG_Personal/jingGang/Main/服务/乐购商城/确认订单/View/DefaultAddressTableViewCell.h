//
//  DefaultAddressTableViewCell.h
//  jingGang
//
//  Created by thinker on 15/8/11.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopUserAddress.h"

@interface DefaultAddressTableViewCell : UITableViewCell

- (void)changeAddress:(NSDictionary *)addressDic;
- (void)changeShopUserAddress:(ShopUserAddress *)address;


@end
