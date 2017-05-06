//
//  userTestTableViewCell.h
//  jingGang
//
//  Created by yi jiehuang on 15/5/19.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDGoalBar.h"

@interface userTestTableViewCell : UITableViewCell
//cell1
@property (nonatomic, retain)IBOutlet UILabel     *_left_valuelab;
@property (nonatomic, retain)IBOutlet UILabel     *_midel_valuelab;
@property (nonatomic, retain)IBOutlet UILabel     *_right_valuelab;
@property (nonatomic, retain)IBOutlet UILabel     *_left_downlab;
@property (nonatomic, retain)IBOutlet UILabel     *_midel_downlab;
@property (nonatomic, retain)IBOutlet UILabel     *_right_downlab;
@property (nonatomic, retain)IBOutlet UILabel     *_left_linelab;
@property (nonatomic, retain)IBOutlet UILabel     *_reight_linelab;
@property (nonatomic, retain)IBOutlet UIImageView *_left1_img;
@property (nonatomic, retain)IBOutlet UIImageView *_midel1_img;
@property (nonatomic, retain)IBOutlet UIImageView *_reight1_img;
@property (retain, nonatomic) IBOutlet UIImageView *backGroundImage;
@property (weak, nonatomic) IBOutlet UIButton *zoujinBtn;
@property (weak, nonatomic) IBOutlet UIButton *expertBtn;


//cell2
@property (nonatomic, retain)IBOutlet UILabel     *_left_namelab;
@property (nonatomic, retain)IBOutlet UIImageView *_left2_Img;
@property (nonatomic, retain)IBOutlet UILabel     *_left_marklab;
@property (nonatomic, retain)IBOutlet UILabel     *_left_depictlab;
@property (nonatomic, retain)IBOutlet UIButton    *_left_Btn;
@property (nonatomic, retain)IBOutlet KDGoalBar   *_left_view;

@property (nonatomic, retain)IBOutlet UILabel     *_line_lab;

@property (nonatomic, retain)IBOutlet UILabel     *_right_namelab;
@property (nonatomic, retain)IBOutlet UIImageView *_right2_Img;
@property (nonatomic, retain)IBOutlet UILabel     *_right_marklab;
@property (nonatomic, retain)IBOutlet UILabel     *_right_depictlab;
@property (nonatomic, retain)IBOutlet UIButton    *_right_Btn;
@property (nonatomic, retain)IBOutlet KDGoalBar   *_right_view;


//cell3
@property (nonatomic, retain)IBOutlet UIImageView *_left_img;//左边图片
@property (nonatomic, retain)IBOutlet UILabel     *_name_lab;//标题
@property (nonatomic, retain)IBOutlet UILabel     *_desc_lab;//详情
@property (retain, nonatomic) IBOutlet UIImageView *perDayJinHuaBGImgView;
//响应事件的btn
@property (retain, nonatomic) IBOutlet UIButton *jinHuaBtn;

@end
