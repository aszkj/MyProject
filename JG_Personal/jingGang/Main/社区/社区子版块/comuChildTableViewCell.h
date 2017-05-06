//
//  comuChildTableViewCell.h
//  jingGang
//
//  Created by yi jiehuang on 15/5/26.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface comuChildTableViewCell : UITableViewCell

@property (nonatomic, retain)IBOutlet UIImageView  *head;
@property (nonatomic, retain)IBOutlet UILabel      *main;
@property (nonatomic, retain)IBOutlet UILabel      *time;
@property (nonatomic, retain)IBOutlet UIButton     *sharebtn;
@property (nonatomic, retain)IBOutlet UIButton     *fallowbtn;
@property (nonatomic, retain)IBOutlet UIButton     *numbtn;
@property (nonatomic, retain)IBOutlet UIButton     *likebtn;
@property (nonatomic, retain)IBOutlet UILabel      *fallowlab;
@property (nonatomic, retain)IBOutlet UILabel      *sharelab;
@property (nonatomic, retain)IBOutlet UILabel      *numlab;
@property (nonatomic, retain)IBOutlet UILabel      *likelab;

@property (retain, nonatomic) IBOutlet UIButton *shareBT;
@property (retain, nonatomic) IBOutlet UIButton *fallowBT;
@property (retain, nonatomic) IBOutlet UIButton *numBT;
@property (retain, nonatomic) IBOutlet UIButton *likeBT;

@end
