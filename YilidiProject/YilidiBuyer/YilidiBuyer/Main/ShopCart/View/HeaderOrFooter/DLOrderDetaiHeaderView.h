//
//  DLOrderDetaiHeaderView.h
//  YilidiBuyer
//
//  Created by yld on 16/5/16.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLOrderDetaiHeaderView : UIView
@property (strong, nonatomic) IBOutlet UILabel *goodsCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNumber;
@property (weak, nonatomic) IBOutlet UILabel *consigneeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end
