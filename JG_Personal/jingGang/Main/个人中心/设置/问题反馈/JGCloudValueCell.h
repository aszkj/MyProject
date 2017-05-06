//
//  JGCloudValueCell.h
//  jingGang
//
//  Created by dengxf on 15/12/25.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CellValueType) {
    IntegralCellType = 0,  // 积分类型
    CloudValueCellType     // 云币类型
};

@class JGIntegralValueModel;
@interface JGCloudValueCell : UITableViewCell

@property (assign, nonatomic) CellValueType valueType;

/**
 *  积分model
 */
@property (nonatomic,strong) JGIntegralValueModel *integralModel;
/**
 *  云币model
 */
@property (nonatomic,strong) JGIntegralValueModel *cloudValuesModel;

@end
