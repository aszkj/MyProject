//
//  ComplainDetailCell.h
//  Operator_JingGang
//
//  Created by dengxf on 15/10/28.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComplainDetailModel.h"
typedef void (^ViewPhotoBlock)(void);

@interface ComplainDetailCell : UITableViewCell

@property (nonatomic,strong) ComplainDetailModel *model;

/**
 *  查看图片
 */
@property (copy , nonatomic) ViewPhotoBlock viewPhotoBlock;

@end
