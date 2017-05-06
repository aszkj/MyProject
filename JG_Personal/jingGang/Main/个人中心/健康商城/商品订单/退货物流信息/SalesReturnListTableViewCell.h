//
//  SalesReturnListTableViewCell.h
//  jingGang
//
//  Created by thinker on 15/8/10.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SalesReturnListTableViewCell : UITableViewCell

typedef NS_ENUM(NSInteger, TLSalesReturnStatus) {
    TLSalesReturnStatusUnkonwn   = -1,
    TLSalesReturnStatusWaitCheck = 0,
    TLSalesReturnStatusWaitWrite = 1,
    TLSalesReturnStatusCheckFail = 2,
    TLSalesReturnStatusWaitMoney = 3,
    TLSalesReturnStatusGetMoney  = 4,
    TLSalesReturnStatusTimeout   = 5,
};

typedef void(^ButtonPressBlock)(NSInteger operationType, NSIndexPath *indexPath);

@property (nonatomic) TLSalesReturnStatus salesReturnStatus;
@property (nonatomic) NSIndexPath *indexPath;

@property (weak, nonatomic) IBOutlet UILabel *goodsDetail;
@property (weak, nonatomic) IBOutlet UIImageView *goodsLogo;
@property (copy) ButtonPressBlock buttonPressBlock;

- (void)configWithReformedOrder:(NSDictionary *)returnData;


@end
