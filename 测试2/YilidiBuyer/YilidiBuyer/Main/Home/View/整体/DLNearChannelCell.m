//
//  DLNearChannelCell.m
//  YilidiBuyer
//
//  Created by yld on 16/5/9.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLNearChannelCell.h"



@implementation DLNearChannelCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

@implementation DLNearChannelCell (setShopCartCellModel)

-(void)setDLNearChannelCell:(DLNearChannelModel *)model{


    _channelLabel.text = model.shopName;
//    self.channelBlock(model.selltype,model.shopImgUrl);
    
}
@end

