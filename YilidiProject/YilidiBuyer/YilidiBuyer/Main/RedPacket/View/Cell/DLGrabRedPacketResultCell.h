//
//  DLGrabRedPacketResultCell.h
//  YilidiBuyer
//
//  Created by yld on 16/10/19.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DLCouponModel;
#define DLGrabRedPacketResultCellHeight 102
@interface DLGrabRedPacketResultCell : UITableViewCell

@end


@interface DLGrabRedPacketResultCell (setCellModel)

- (void)setCellModel:(DLCouponModel *)model;

@end
