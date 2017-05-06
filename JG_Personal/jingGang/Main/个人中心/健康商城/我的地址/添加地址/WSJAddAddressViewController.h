//
//  WSJAddAddressViewController.h
//  jingGang
//
//  Created by thinker on 15/8/10.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSJAddAddressViewController : UIViewController

//该地址是否为默认地址
@property (nonatomic, assign) BOOL isDefault;
//编辑地址----内容
@property (nonatomic, copy) NSDictionary *dict;

//点击确认回传数据
@property (nonatomic, copy) void (^addAddress)(NSDictionary *dict,BOOL defualt);

@end
