//
//  CityPikerView.h
//  uipickerView
//
//  Created by yld on 16/4/7.
//  Copyright © 2016年 wujianqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectRegionBlock)(NSDictionary *provinceDic, NSDictionary *cityDic, NSDictionary *townDic);

@interface CityPikerView : UIView

- (void)show;

@property (nonatomic,copy)SelectRegionBlock selectRegionBlock;


@end
