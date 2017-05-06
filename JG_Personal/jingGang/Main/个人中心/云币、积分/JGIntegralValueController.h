//
//  JGIntegralValueController.h
//  jingGang
//
//  Created by dengxf on 15/12/25.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef NS_ENUM(NSUInteger, ControllerValueType) {
    IntegralControllerType = 0,  // 积分类型
    CloudValueControllerType     // 云币类型
};

@protocol JGIntegralValueControllerDelegate <NSObject>

- (void)nofiticationCloudMoneyValueChange:(NSString *)cloudMoneyChangeStr;

@end


@interface JGIntegralValueController : UIViewController

@property (nonatomic,assign) id<JGIntegralValueControllerDelegate>delegate;

/**
 *  控制器入口   
    IntegralControllerType 为积分类型
    CloudValueControllerType 为云币类型
 */


- (instancetype)initWithControllerType:(ControllerValueType)valueType;

/**
 *  云币/积分
 */
@property (nonatomic,copy) NSString *strCloudVelues;

@end
