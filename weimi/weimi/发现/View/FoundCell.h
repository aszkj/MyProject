//
//  FoundCell.h
//  weimi
//
//  Created by 张康健 on 16/1/20.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DistributeContentView.h"
#import "LatesteMessageRepyView.h"
#import "FoundModel.h"

@interface FoundCell : UITableViewCell

@property (nonatomic,strong)UIImageView *avartImgView;
@property (nonatomic,strong)UILabel *nickNameLabel;
@property (nonatomic,strong)UILabel *timeLabel;

//红点label
@property (nonatomic,strong)UILabel *redNoteLabel;

//发布话题视图
@property (nonatomic, strong)DistributeContentView *distributeContentView;

//最新消息视图
@property (nonatomic, strong)LatesteMessageRepyView *latesteMessageRepyView;


//来自哪里，朋友圈，附近
@property (nonatomic,strong)UIButton *fromWhereButton;

@property (nonatomic, strong)FoundModel *foundModel;




@end
