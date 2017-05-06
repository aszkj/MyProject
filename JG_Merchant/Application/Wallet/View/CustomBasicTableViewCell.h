//
//  CustomBasicTableViewCell.h
//  Merchants_JingGang
//
//  Created by thinker on 15/9/5.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomBasicTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *basicTitle;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;

@end
