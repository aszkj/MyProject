//
//  someTestTableViewCell.h
//  jingGang
//
//  Created by yi jiehuang on 15/6/6.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface someTestTableViewCell : UITableViewCell

@property (nonatomic, retain)IBOutlet  UIImageView   *_left_img;
@property (nonatomic, retain)IBOutlet  UILabel       *_name_lab;
@property (retain, nonatomic) IBOutlet UIButton *clickButton;
@property (retain, nonatomic) IBOutlet UIButton *haveCompletedimgView;

@end
