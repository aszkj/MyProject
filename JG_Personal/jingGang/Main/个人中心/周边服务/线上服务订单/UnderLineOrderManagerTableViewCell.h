//
//  UnderLineOrderManagerTableViewCell.h
//  jingGang
//
//  Created by thinker on 15/9/9.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ActionBlock)();

@interface UnderLineOrderManagerTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *serverImage;
@property (weak, nonatomic) IBOutlet UILabel *orderStatus;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UILabel *serverPriceAndNumber;
@property (weak, nonatomic) IBOutlet UIButton *actionButton;
@property (copy) ActionBlock commentBlock;
@property (copy) ActionBlock payBlock;
@property (copy) ActionBlock cancelBlock;

- (void)configWithObject:(id)object;
@end
