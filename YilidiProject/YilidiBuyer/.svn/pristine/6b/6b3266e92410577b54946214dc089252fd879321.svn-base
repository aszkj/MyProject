//
//  DLOrderStatusCell.m
//  YilidiBuyer
//
//  Created by yld on 16/5/30.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLOrderStatusCell.h"
#import "DLInvoiceStatusModel.h"
#import "ProjectStandardUIDefineConst.h"
@implementation DLOrderStatusCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(DLInvoiceStatusModel *)model {
    
    self.orderStatus.text = model.statusCodeName;
    self.orderTime.text = model.statusTime;


}




@end
