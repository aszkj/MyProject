//
//  MerchantManageCell.m
//  Operator_JingGang
//
//  Created by 张康健 on 15/9/19.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "MerchantManageCell.h"
#import "NSString+BlankString.h"

@interface MerchantManageCell()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewRangeSuperViewLength;

@end
@implementation MerchantManageCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    if ([self.strStatus isEqualToString:@"IncomeStatisticsViewController"]) {
        self.viewRangeSuperViewLength.constant = 10.0;
        self.labelItemTitle.text = [NSString stringWithFormat:@"%@",self.dicItemName[@"incomeTitle"]];
        self.labelOneItem.text = [NSString stringWithFormat:@"%@",self.dicItemName[@"oneItem"]];
        self.labelTwoItem.text = [NSString stringWithFormat:@"%@",self.dicItemName[@"twoItem"]];
        self.labelThreeItem.text = [NSString stringWithFormat:@"%@",self.dicItemName[@"threeItem"]];
    }else{
        self.storeNameLabel.text = self.operatorManageModel.storeName;
        
        self.tradeTotalValueLabel.text = kNumberToStr(self.operatorManageModel.tradingTotal);
        
        self.consumeBackPromitLabel.text = kNumberToStr(self.operatorManageModel.rebateConsumeAmount);
        
        self.commissionBackPromitLabel.text = kNumberToStr(self.operatorManageModel.rebateFeeAmount);
        
        self.totalBackPromitLabel.text = kNumberToStr(self.operatorManageModel.rebateTotal);
    }

}

- (void)setModel:(IncomeStatisticsModel *)model
{
    _model = model;
    
    
//    返润收益     注册返润收益|辖区返润收益|隶属返润收益|支付手续收益
    self.tradeTotalValueLabel.text = [NSString stringWithFormat:@"%@",_model.profitAmount];
//    one Itme  数据  推荐运营商|本辖本消|本隶本消|隶属支付
    self.consumeBackPromitLabel.text = [NSString stringWithFormat:@"%@",_model.recommedAmount];
//    two Item  数据  推荐商户|本辖外销|本隶外消|辖区支付
    self.commissionBackPromitLabel.text = [NSString stringWithFormat:@"%@",_model.storeAmount];
//    three Item 数据 推荐会员|外辖本消|外隶本消|推荐收益
    self.totalBackPromitLabel.text = [NSString stringWithFormat:@"%@",_model.userAmount];
    
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}


- (IBAction)makeCallAction:(id)sender {
    
    if (self.operatorManageModel.storeTelephone) {
        [Util dialWithPhoneNumber:self.operatorManageModel.storeTelephone];
    }
}


@end
