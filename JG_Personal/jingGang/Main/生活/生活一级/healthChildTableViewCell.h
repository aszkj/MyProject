//
//  healthChildTableViewCell.h
//  jingGang
//
//  Created by yi jiehuang on 15/5/27.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface healthChildTableViewCell : UITableViewCell

//cell1
@property (nonatomic, retain)IBOutlet UILabel      *left_lab;
@property (nonatomic, retain)IBOutlet UIImageView  *left_img;
@property (nonatomic, retain)IBOutlet UILabel      *name_lab;
@property (nonatomic, retain)IBOutlet UILabel      *dis_lab;

//cell2
@property (nonatomic, retain)IBOutlet UILabel      *right_lab;
@property (nonatomic, retain)IBOutlet UIImageView  *right_img;
@property (nonatomic, retain)IBOutlet UILabel      *name_lab2;
@property (nonatomic, retain)IBOutlet UILabel      *dis_lab2;

@end
