//
//  MyOrderSectionHeaderView.h
//  YilidiBuyer
//
//  Created by yld on 16/5/6.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderSectionHeaderView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UILabel *orderTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *orderStatusLabel;
@end
