//
//  foodViewController.h
//  jingGang
//
//  Created by yi jiehuang on 15/5/30.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TiZhongDengJi) {
    TiZhongDengJiPianShou,//默认从0开始 偏瘦
    TiZhongDengJiZhengChang,//正常
    TiZhongDengJiPianPang,//偏胖
    TiZhongDengJiQingDuFeiPang,//轻度肥胖
    TiZhongDengJiZhongDuFeiPang,//重度配胖
};

@interface foodViewController : UIViewController

@end
