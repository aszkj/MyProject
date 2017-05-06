//
//  DLOrderDetaiFooterView.h
//  YilidiBuyer
//
//  Created by yld on 16/5/16.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLOrderDetaiFooterView : UIView


@property (weak, nonatomic) IBOutlet UILabel *totalAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *preferentialAmtLabel;
@property (weak, nonatomic) IBOutlet UILabel *transferFeeLabel;
@property (weak, nonatomic) IBOutlet UILabel *payableAmountLabel;

@property (strong, nonatomic) IBOutlet UILabel *totalNum;

@property (weak, nonatomic) IBOutlet UILabel *saleOrderNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *payTypeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *noteLabel;
@property (weak, nonatomic) IBOutlet UILabel *deliveryModeNameLabel;

@end
