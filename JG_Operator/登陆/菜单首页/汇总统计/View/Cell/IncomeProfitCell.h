//
//  IncomeProfitCell.h
//  Operator_JingGang
//
//  Created by HanZhongchou on 15/11/10.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IncomeProfitCell : UITableViewCell
/**
 *  分润标题
 */
@property (weak, nonatomic) IBOutlet UILabel *labelIncome;
/**
 *  分润值
 */
@property (weak, nonatomic) IBOutlet UILabel *labelIncomePrice;

@end
