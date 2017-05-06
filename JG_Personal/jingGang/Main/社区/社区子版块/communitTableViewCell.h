//
//  communitTableViewCell.h
//  jingGang
//
//  Created by yi jiehuang on 15/5/21.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface communitTableViewCell : UITableViewCell

//cell1
@property (nonatomic, retain)IBOutlet UIImageView  *left_img;
@property (nonatomic, retain)IBOutlet UILabel      *name_lab;
@property (nonatomic, retain)IBOutlet UILabel      *dis_lab;
@property (nonatomic, retain)IBOutlet UIImageView  *bg_img;

//cell2
@property (nonatomic, retain)IBOutlet UIImageView  *head_img;
@property (nonatomic, retain)IBOutlet UILabel      *main_lab;
@property (nonatomic, retain)IBOutlet UILabel      *time_lab;
@property (nonatomic, retain)IBOutlet UIButton     *share_btn;
@property (nonatomic, retain)IBOutlet UIButton     *fallow_btn;
@property (nonatomic, retain)IBOutlet UIButton     *num_btn;
@property (nonatomic, retain)IBOutlet UIButton     *like_btn;
@property (nonatomic, retain)IBOutlet UILabel      *fallow_lab;
@property (nonatomic, retain)IBOutlet UILabel      *share_lab;
@property (nonatomic, retain)IBOutlet UILabel      *num_lab;
@property (nonatomic, retain)IBOutlet UILabel      *like_lab;

//@property (nonatomic, retain)IBOutlet UIImageView  *share_img;
//@property (nonatomic, retain)IBOutlet UIImageView  *fallow_img;
//@property (nonatomic, retain)IBOutlet UIImageView  *num_img;
//@property (nonatomic, retain)IBOutlet UIImageView  *like_img;


@property (retain, nonatomic) IBOutlet UIButton *fallowBT;
@property (retain, nonatomic) IBOutlet UIButton *shareBT;
@property (retain, nonatomic) IBOutlet UIButton *numBT;
@property (retain, nonatomic) IBOutlet UIButton *likeBT;

@end
