//
//  FaviousCell.h
//  jingGang
//
//  Created by wangying on 15/6/1.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FaviousCell : UITableViewCell
//cell 1
@property (retain, nonatomic) IBOutlet UIImageView *icon_img;
@property (retain, nonatomic) IBOutlet UILabel *title_l;
@property (retain, nonatomic) IBOutlet UILabel *place_l;

@property (retain, nonatomic) IBOutlet UILabel *time_l;
//shareicon
@property (retain, nonatomic) IBOutlet UIImageView *share_img;
@property (retain, nonatomic) IBOutlet UIImageView *gen_btn;
@property (retain, nonatomic) IBOutlet UIButton *gen_btnt;
@property (retain, nonatomic) IBOutlet UIImageView *zan_img;

@property (retain, nonatomic) IBOutlet UIButton *zan_btn;
@property (retain, nonatomic) IBOutlet UIImageView *star_img;
@property (retain, nonatomic) IBOutlet UIButton *star_text;
//cell2
//@property (retain, nonatomic) IBOutlet UIImageView *icon_simg;
//@property (retain, nonatomic) IBOutlet UILabel *title_sl;
//@property (retain, nonatomic) IBOutlet UILabel *neme_sl;
//@property (retain, nonatomic) IBOutlet UILabel *time_sl;
//@property (retain, nonatomic) IBOutlet UIButton *share_simg;
//@property (retain, nonatomic) IBOutlet UIButton *gen_sl;
//@property (retain, nonatomic) IBOutlet UIButton *zan_simg;
//@property (retain, nonatomic) IBOutlet UIButton *an_sl;
//@property (retain, nonatomic) IBOutlet UIButton *star_simg;
//@property (retain, nonatomic) IBOutlet UIButton *star_sl;
//
////cell3
//@property (retain, nonatomic) IBOutlet UIImageView *icon_timg;
//@property (retain, nonatomic) IBOutlet UILabel *name_tl;
//@property (retain, nonatomic) IBOutlet UILabel *medic_3l;
//@property (retain, nonatomic) IBOutlet UILabel *school_tl;

@end
