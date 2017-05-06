//
//  JGIntegarlCloudController.h
//  jingGang
//
//  Created by HanZhongchou on 15/12/30.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "XK_ViewController.h"

typedef NS_ENUM(NSUInteger, RuleValueType) {
    IntegralRuleType = 0,  // 积分规则类型
    CloudValueRuleType     // 云币规则类型
};


@interface JGIntegarlCloudController : XK_ViewController

@property (assign, nonatomic) RuleValueType RuleValueType;



@end
