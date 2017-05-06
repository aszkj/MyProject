//
//  NodataLogicModule.h
//  YilidiBuyer
//
//  Created by mm on 16/12/16.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NodataLogicModule : NSObject

@property (nonatomic,copy)NSString *nodataAlertTitle;

@property (nonatomic,copy)NSString *nodataAlertImage;

@property (nonatomic,copy)UIColor *nodataBgColor;

@property (nonatomic,assign)BOOL needDealNodataCondition;


@end
