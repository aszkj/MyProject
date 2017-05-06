//
//  SearchCell.h
//  jingGang
//
//  Created by wangying on 15/6/6.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UIImageView *iconImg;
@property (retain, nonatomic) IBOutlet UILabel *titleText;
@property (retain, nonatomic) IBOutlet UILabel *nameText;
@property (retain, nonatomic) IBOutlet UILabel *timeText;
@property (retain, nonatomic) IBOutlet UIButton *share_btn;
@property (retain, nonatomic) IBOutlet UIButton *share_text;
@property (retain, nonatomic) IBOutlet UIButton *follow_btn;
@property (retain, nonatomic) IBOutlet UIButton *follow_text;
@property (retain, nonatomic) IBOutlet UIButton *zan_btn;
@property (retain, nonatomic) IBOutlet UILabel *zan_text;
@property (retain, nonatomic) IBOutlet UIButton *faviour;
@property (retain, nonatomic) IBOutlet UILabel *faiour_text;

@end
