//
//  WSJAddresListViewController.h
//  jingGang
//
//  Created by thinker on 15/8/10.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum :NSInteger{
    shopDetailsAddress,//详细地址
    bankAddress  //开户行地址
}AddressType;

@interface WSJAddresListViewController : UIViewController

@property (nonatomic, assign) AddressType addressType;

//返回您所选中的地址,和地址的id
@property (nonatomic, copy) void (^returnAddress)(NSString * address,NSNumber *addressID);

@end
