//
//  DLInvoiceCell.m
//  YilidiSeller
//
//  Created by yld on 16/5/31.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLInvoiceCell.h"
#import "DLInvoiceListModel.h"
#import "GlobleConst.h"
@implementation DLInvoiceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setModel:(DLInvoiceListModel *)model invoiceStatus:(NSInteger)status {

//    self.countLabel.text = [NSString stringWithFormat:@"%ld",model.modelAtIndexPath.row+1];
    self.invoiceCode.text = model.allotOrderNo;
    NSString *statusName;
    switch (model.statusCode) {
        case SubmitStatus:
            statusName=@"已提交";
            break;
        case AuditStatus:
            statusName=@"已审核";
            break;
        case AuditNotThroughStatus:
            statusName=@"审核不通过";
            break;
        case DeliveryStatus:
            statusName=@"已发货";
            break;
        case InspectionStatus:
            statusName=@"验货中";
            break;
        case InspectionCompleteStatus:
            statusName=@"验货完毕";
            break;
        case GoodsFinishStatus:
            statusName=@"调货完成";
            break;
        case ControversyStatus:
            statusName=@"调拨争议";
            break;
        case CustomerServiceStatus:
            statusName=@"平台客服已介入";
            break;
            
        default:
            statusName=model.statusCodeName;
            break;
    }

    
    self.invoiceStutas.text = statusName;
    self.address.text = model.consAddress;
    
    if (status==0) {
        self.invoiceCount.text = [NSString stringWithFormat:@"+%@件",[model.allotTotalCount stringValue]];
        self.invoicePrice.text = [NSString stringWithFormat:@"￥%.2f",[model.allotTotalAmount floatValue]/1000];
    }else{
        if (isEmpty(model.realAllotTotalCount)) {
            
             self.invoiceCount.text = @"+0件";
            
        }else{
        
            self.invoiceCount.text = [NSString stringWithFormat:@"+%@件",[model.realAllotTotalCount stringValue]];
            }
            self.invoicePrice.text = [NSString stringWithFormat:@"￥%.2f",[model.realAllotTotalAmount floatValue]/1000];
        
    }
   
    self.invoiceTime.text = model.createTime;
    
    
}

@end
