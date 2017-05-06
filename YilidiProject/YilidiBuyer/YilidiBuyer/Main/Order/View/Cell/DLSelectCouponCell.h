//
//  DLSelectCouponCell.h
//  YilidiBuyer
//
//  Created by mm on 16/11/22.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectRelativEmerator.h"

typedef void(^SelectCouponBlock)(UIButton *);
#define kSelectCouponCellHeight 76

@class DLCouponModel;
@interface DLSelectCouponCell : UITableViewCell

@property (nonatomic,copy)SelectCouponBlock selectCouponBlock;

@end


@interface DLSelectCouponCell (setCellModel)

- (void)setCellModel:(DLCouponModel *)model;

- (void)setCellTicketType:(SelectTicketType)selectTicketType;


@end

