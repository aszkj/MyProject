//
//  DLInvoiceDetaiCell.m
//  YilidiBuyer
//
//  Created by yld on 16/5/16.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLInvoiceDetaiCell.h"
#import "UIImageView+sd_SetImg.h"
@implementation DLInvoiceDetaiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (void)setModel:(DLInvitationOrdetailsModel *)model {
    
    
//    self.userInteractionEnabled = model.selected;
//    self.contentView.userInteractionEnabled = model.selected;
    
    if (model.selected==YES) {
        
         _closedCount.hidden=YES;
        _addSubtractButton.hidden=NO;
    }else {
        _closedCount.hidden=NO;
        _receivingCount.hidden=NO;
        _closedCount.text = [NSString stringWithFormat:@"%d",(int)model.allotCount];
        _addSubtractButton.hidden=YES;
        
    }
    
    if (model.isReceiveHidden==YES) {
        _closedCount.hidden=YES;
        _receivingCount.hidden=YES;
    }
    
    
    [_productImage sd_SetImgWithUrlStr:model.saleProductImageUrl placeHolderImgName:@"default"];
    _count.text = [NSString stringWithFormat:@"%d",(int)model.allotCount];
    _closedCount.text = [NSString stringWithFormat:@"%d",(int)model.realAllotCount];
    _productName.text = model.saleProductName;
    _addSubtractButton.maxResult = (int)model.allotCount;
    _addSubtractButton.textField.text = _count.text;
    WEAK_SELF
    _addSubtractButton.callBack = ^(NSString *currentNum){
        
        model.allotCount = [currentNum integerValue];
        weak_self.invitationBlock(model);
    };
    
}
@end
