//
//  HorizonTableViewCell.h
//  Operator_JingGang
//
//  Created by ray on 15/9/20.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OAStackView/OAStackView.h>

@interface HorizonTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet OAStackView *stackView;
- (void)cleanSubView;
- (void)layoutStackView;
@end
