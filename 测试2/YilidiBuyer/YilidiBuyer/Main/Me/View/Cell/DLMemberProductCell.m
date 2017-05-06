//
//  DLMemberProductCell.m
//  YilidiBuyer
//
//  Created by yld on 16/6/12.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLMemberProductCell.h"
#import "UIImageView+sd_SetImg.h"
#import "DLMemberProductModel.h"
@implementation DLMemberProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(DLMemberProductModel *)model {


    [self.productImage sd_SetImgWithUrlStr:model.imageUrl placeHolderImgName:nil];
    self.productName.text = model.productName;
    self.productPrice.text = [NSString stringWithFormat:@"￥%@",[model.productPrice stringValue]];
    
    self.count.text = [NSString stringWithFormat:@"X%@",model.count];
}

@end
