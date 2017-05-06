//
//  comsultationTableViewCell.h
//  jingGang
//
//  Created by yi jiehuang on 15/5/25.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define comsulationTableViewCellHeight 115;

@interface comsultationTableViewCell : UITableViewCell

@property(nonatomic, retain)IBOutlet UIButton  *_head_btn;
@property(nonatomic, retain)IBOutlet UILabel   *_name_lab;
@property(nonatomic, retain)IBOutlet UILabel   *_sex_lab;//
@property(nonatomic, retain)IBOutlet UILabel   *_dis_lab;//详情
@property(nonatomic, retain)IBOutlet UIImageView * bg_head_img;//头像背景

- (void)setEntity:(NSDictionary *)dic;

@end
