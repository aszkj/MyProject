//
//  ComplainResultCell.h
//  Operator_JingGang
//
//  Created by dengxf on 15/10/28.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComplainDetailModel.h"
@protocol  ComplainResultCellDelegate<NSObject>

- (void)commitTextViewTextForVC:(NSString *)str;

@end

@interface ComplainResultCell : UITableViewCell

@property (nonatomic,strong) ComplainDetailModel *model;


@property (nonatomic,assign) id<ComplainResultCellDelegate>delaget;



@end
