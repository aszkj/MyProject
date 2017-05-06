//
//  DLNearChannelCell.h
//  YilidiBuyer
//
//  Created by yld on 16/5/9.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLNearChannelModel.h"

typedef void(^ChannelBlock)(NSString *type,NSString*url);
@interface DLNearChannelCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *seletedButton;

@property (weak, nonatomic) IBOutlet UILabel *channelLabel;
@property (nonatomic,copy)ChannelBlock channelBlock;

@end

@interface DLNearChannelCell (setSNearChannelModel)

-(void)setDLNearChannelCell:(DLNearChannelModel *)model;

@end


