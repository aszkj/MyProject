//
//  DLOrderDetaiCell.m
//  YilidiBuyer
//
//  Created by yld on 16/5/16.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLOrderDetaiCell.h"
#import "DLInvitationOrdetailsModel.h"
#import "UIImageView+sd_SetImg.h"
@implementation DLOrderDetaiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(DLInvitationOrdetailsModel *)model {
    
        
        [_productImage sd_SetImgWithUrlStr:model.saleProductImageUrl placeHolderImgName:nil];
        _count.text = [NSString stringWithFormat:@"%d",model.allotCount];
        _productName.text = model.saleProductName;
        _addSubtractButton.maxResult = model.allotCount;
        _addSubtractButton.textField.text = _count.text;
        _addSubtractButton.callBack = ^(NSString *currentNum){
            
          
        };

    
}
@end
