//
//  WSJAddresListViewController.h
//  jingGang
//
//  Created by thinker on 15/8/10.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSJAddresListViewController : UIViewController

//返回您所选中的地址,和地址的id
@property (nonatomic, copy) void (^returnAddress)(NSString * address,NSNumber *addressID);

@end
