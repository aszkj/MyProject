//
//  ComplainCell.h
//  Operator_JingGang
//
//  Created by dengxf on 15/10/27.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ComplainModel;

@interface ComplainCell : UITableViewCell

/**
 *  投诉管理模型
 */
@property (strong,nonatomic) ComplainModel *compModel;

/**
 *  投诉状态
 */
@property (nonatomic,assign) BOOL isHandled;

@end
