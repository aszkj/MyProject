//
//  AddressView.h
//  uipickerView
//
//  Created by wujianqiang on 15/12/28.
//  Copyright © 2015年 wujianqiang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddressView : UIView

- (instancetype)init;

@property (nonatomic,copy)NSDictionary *provinceDic;
@property (nonatomic,copy)NSDictionary *cityDic;
@property (nonatomic,copy)NSDictionary *areaDic;

@property (nonatomic, copy) NSString *province; // 省份
@property (nonatomic, copy) NSString *city;  // 城市
@property (nonatomic, copy) NSString *area;  // 地区

@end
