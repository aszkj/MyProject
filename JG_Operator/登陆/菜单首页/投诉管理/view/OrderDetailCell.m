//
//  OrderDetailCell.m
//  Operator_JingGang
//
//  Created by dengxf on 15/10/28.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "OrderDetailCell.h"

@interface OrderDetailCell ()

/**
 *  订单编号label
 */
@property (weak, nonatomic) IBOutlet UILabel *labelOrderNum;
/**
 *  下单时间label
 */
@property (weak, nonatomic) IBOutlet UILabel *labelPayTime;
/**
 *  订单总额label
 */
@property (weak, nonatomic) IBOutlet UILabel *labelOrderTotal;
/**
 *  订单状态label
 */
@property (weak, nonatomic) IBOutlet UILabel *labelOrderStatus;

@end

@implementation OrderDetailCell



- (void)setModel:(ComplainDetailModel *)model
{
    _model = model;
    //订单支付时间
    self.labelPayTime.text = [NSString stringWithFormat:@"%@",_model.payTime];
    
    self.labelPayTime.text = [NSString stringDiseposeNullWithStr:self.labelPayTime.text];
    
    //订单号
    self.labelOrderNum.text = [NSString stringWithFormat:@"%@",_model.orderId];
    self.labelOrderNum.text = [NSString stringDiseposeNullWithStr:self.labelOrderNum.text];

    //订单金额
    
    if (_model.price == nil) {
        self.labelOrderTotal.text = @"";
    }else{
        self.labelOrderTotal.text = [NSString stringWithFormat:@"￥%@",_model.price];
    }

    
    NSString *strDisposeStatus = [NSString stringWithFormat:@"%@",_model.status];
    
    if ([strDisposeStatus isEqualToString:@"1"]) {
        self.labelOrderStatus.text = @"处理中";

    }else{
        self.labelOrderStatus.text = @"已完成";
    }
}



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
