//
//  JGCheckConsumeCell.h
//  Merchants_JingGang
//
//  Created by dengxf on 15/12/28.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedIndexPathBlock)(BOOL isSelected);

@interface JGCheckConsumeCell : UITableViewCell

@property (strong,nonatomic) UIButton *selectedButton;

@property (copy , nonatomic) SelectedIndexPathBlock selectedIndexPathBlock;

@property (assign, nonatomic) BOOL isSelected;
@end
