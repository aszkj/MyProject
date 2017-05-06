//
//  ZongHeZhengCell.h
//  jingGang
//
//  Created by 张康健 on 15/6/4.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CheckGroup;
@interface ZongHeZhengCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIView *btView;
@property (retain, nonatomic) IBOutlet UILabel *selfTest_Title;
@property (retain, nonatomic) IBOutlet UIImageView *self_test_Img;
@property (retain, nonatomic) IBOutlet UITextView *summary_TextView;
@property (nonatomic,strong)CheckGroup *checkGroup;
@property (retain, nonatomic) IBOutlet UIButton *beginTestBtn;
@property (retain, nonatomic) IBOutlet UIButton *lookDetailBtn;

@end
