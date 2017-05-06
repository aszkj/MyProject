//
//  WSJManagerAddressViewController.h
//  jingGang
//
//  Created by thinker on 15/8/10.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum :NSInteger{
    certainTrade,    //
    personalCenter  //个人中心地址管理
}addressType;

@interface WSJManagerAddressViewController : UIViewController

@property (nonatomic, assign) addressType type;

//删除addressID地址时回调方法
@property (nonatomic, copy) NSNumber *addressID;
@property (nonatomic, copy) void(^deleteAddress)(void);

//选中地址之后回调block
@property (nonatomic, copy) void(^selectAddress)(NSDictionary *dict);

@end
