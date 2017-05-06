//
//  PluginComponentTableViewCell.h
//  BaiYing_Thinker
//
//  Created by ray on 16/1/12.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PluginComponentController.h"
#import "SessonContentModel.h"

typedef void (^WebFinishLoadBlock)(NSString *,NSString *);

@interface PluginComponentTableViewCell : UITableViewCell

@property (nonatomic) UILabel *serverNameLabel;
@property (nonatomic) UILabel *sendTimeLabel;
@property (nonatomic) UIButton *serverStatusBtn;
@property (nonatomic,copy) WebFinishLoadBlock webFinishLoadBlock;

- (void)setMessage:(SessonContentModel *)message;


@end
