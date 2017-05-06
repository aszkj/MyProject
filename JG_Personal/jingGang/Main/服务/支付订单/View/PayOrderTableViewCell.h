//
//  PayOrderTableViewCell.h
//  jingGang
//
//  Created by thinker on 15/8/13.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChangePayBlock)(UIButton *selectedBtn);

@interface PayOrderTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *payImage;
@property (weak, nonatomic) IBOutlet UILabel *payTitle;
@property (weak, nonatomic) IBOutlet UILabel *payInform;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@property (copy) ChangePayBlock selectPayBlock;

@end
