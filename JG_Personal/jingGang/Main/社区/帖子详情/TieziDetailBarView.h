//
//  TieziDetailBarView.h
//  jingGang
//
//  Created by thinker on 15/6/24.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "communitBtn.h"

@interface TieziDetailBarView : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *shareLB;
@property (retain, nonatomic) IBOutlet UILabel *fallowLB;
@property (retain, nonatomic) IBOutlet UILabel *numLB;
@property (retain, nonatomic) IBOutlet UILabel *favoLB;
@property (retain, nonatomic) IBOutlet communitBtn *shareBT;
@property (retain, nonatomic) IBOutlet communitBtn *fallowBT;
@property (retain, nonatomic) IBOutlet communitBtn *likeBT;
@property (retain, nonatomic) IBOutlet communitBtn *favoBT;

@property (retain, nonatomic) IBOutlet UIButton *shareTBT;
@property (retain, nonatomic) IBOutlet UIButton *fallowTBT;
@property (retain, nonatomic) IBOutlet UIButton *likeTBT;
@property (retain, nonatomic) IBOutlet UIButton *favoTBT;

@end
