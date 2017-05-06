//
//  devicesTableViewCell.h
//  jingGang
//
//  Created by yi jiehuang on 15/6/2.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDGoalBar.h"
#import "RMDownloadIndicator.h"


@interface devicesTableViewCell : UITableViewCell

//cell1
@property (nonatomic, retain)IBOutlet UIView       *_bgView;
@property (nonatomic, retain)IBOutlet KDGoalBar    *_kd_view;
@property (nonatomic, retain)IBOutlet UIImageView  *_midel_img;
//@property (retain, nonatomic) IBOutlet UILabel *progressLabel;
@property (retain, nonatomic) IBOutlet UIButton *freshButton;
@property (retain, nonatomic) IBOutlet UILabel *progressLabel;
@property (retain, nonatomic) IBOutlet RMDownloadIndicator *rmProgresser;
//@property (weak, nonatomic) IBOutlet UIButton *syncStateShowBtn;
@property (weak, nonatomic) IBOutlet UILabel *syncStateLabel;

//cell2
@property (nonatomic, retain)IBOutlet UIButton     *_left_btn;
@property (nonatomic, retain)IBOutlet UIButton     *_midel_btn;
@property (nonatomic, retain)IBOutlet UIButton     *_right_btn;
@property (nonatomic, retain)IBOutlet UILabel      *_left_name_lab;
@property (nonatomic, retain)IBOutlet UILabel      *_midel_name_lab;
@property (nonatomic, retain)IBOutlet UILabel      *_right_name_lab;
@property (nonatomic, retain)IBOutlet UILabel      *_left_lab;
@property (nonatomic, retain)IBOutlet UILabel      *_midel_lab;
@property (nonatomic, retain)IBOutlet UILabel      *_right_lab;
//@property (retain, nonatomic) IBOutlet UILabel *percentLabel;
//@property (retain, nonatomic) IBOutlet UILabel *percentLabel;
@property (retain, nonatomic) IBOutlet UILabel *peCentLabel;

//cell3
@property (nonatomic, retain)IBOutlet UIImageView  *_left_img;
@property (nonatomic, retain)IBOutlet UILabel      *_name_lab;
@end
