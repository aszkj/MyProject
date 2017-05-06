//
//  DLOrderListCell.m
//  YilidiBuyer
//
//  Created by yld on 16/5/20.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLOrderListCell.h"
#import "MyCommonCollectionView.h"
#import "ProjectRelativeMaco.h"
#import "MerchantOrderListModel.h"
#import "Util.h"
#import "DateManager.h"

@interface DLOrderListCell()
@property (weak, nonatomic) IBOutlet UILabel *orderTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *customerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *customerPhoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *customerAdressLabel;

@property (weak, nonatomic) IBOutlet UILabel *orderGoodsReachTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderTotalAmountLabel;
@property (weak, nonatomic) IBOutlet UIButton *orderSequenceNumberButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *phoneNumberToLeftConstraint;

@property (strong, nonatomic) IBOutlet UIImageView *zitiImageView;

@property (strong, nonatomic) IBOutlet UILabel *doorLabel;

@end

@implementation DLOrderListCell
- (void)awakeFromNib {
    if (kScreenWidth == iPhone5_width) {
        self.orderGoodsReachTimeLabel.font = kSystemFontSize(10);
    }
    if (kScreenWidth == iPhone5_width) {
        self.phoneNumberToLeftConstraint.constant = 20;
    }
}

- (void)setOrderListModel:(MerchantOrderListModel *)orderListModel {
    _orderListModel = orderListModel;
    [self _configureCellByModel];
}
- (IBAction)enterOrderDetailAction:(id)sender {
    emptyBlock(self.enterOrderDetailBlock);
}

- (void)_configureCellByModel {
    //1送货上门 2自提
    if ([self.orderListModel.deliveryModeCode integerValue]==2) {
        self.zitiImageView.hidden=NO;
        self.doorLabel.hidden=NO;
        self.customerNameLabel.hidden=YES;
        self.customerPhoneNumberLabel.hidden=YES;
        self.customerAdressLabel.hidden=YES;
        self.distanceLabel.hidden=YES;
    }else{
        self.zitiImageView.hidden=YES;
        self.doorLabel.hidden=YES;
        self.customerNameLabel.hidden=NO;
        self.customerPhoneNumberLabel.hidden=NO;
        self.customerAdressLabel.hidden=NO;
        self.distanceLabel.hidden=NO;
        
    }

    
    [self.orderSequenceNumberButton setTitle:jFormat(@"%ld", self.orderListModel.modelAtIndexPath.row) forState:UIControlStateNormal];
    self.orderTimeLabel.text = self.orderListModel.orderCreateTime;
    self.customerNameLabel.text = self.orderListModel.takeOrderCustomerInfo.customerName;
    NSString *reachTime = [[DateManager sharedManager] afterAnHourTimeWithTheBasicTime:self.orderListModel.orderPayTime];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:reachTime];
    //要改为推后一小时送达
    NSTimeInterval time = 1 * 60 * 60;
    NSDate * lastYear = [date dateByAddingTimeInterval:time];
    NSString *currentDateStr = [dateFormatter stringFromDate: lastYear];
    NSLog(@"字符串转NSDate：%@",currentDateStr);
    if ([self.orderListModel.deliveryModeCode integerValue]==2) {
        self.orderGoodsReachTimeLabel.text = @"于营业结束前自提";
    }else{
        self.orderGoodsReachTimeLabel.text = jFormat(@"今日%@前送达",reachTime);
    }
    
    
   
    if (iPhone5) {
        self.orderTotalAmountLabel.font= [UIFont systemFontOfSize:12];
    }
    self.orderTotalAmountLabel.text = jFormat(@"订单金额：%.2f元",self.orderListModel.totalAmount.floatValue
);
    self.distanceLabel.text = jFormat(@"%.2fkm",self.orderListModel.takeOrderCustomerInfo.customerDistanceAwayFromYou.floatValue/1000);
    self.customerPhoneNumberLabel.text = self.orderListModel.takeOrderCustomerInfo.customerPhoneNumber;
    self.customerAdressLabel.text = self.orderListModel.takeOrderCustomerInfo.customerAdress;
}

- (IBAction)makeCallAction:(id)sender {
    if ([self.orderListModel.deliveryModeCode integerValue]==2) {
       
        [Util dialWithPhoneNumber:self.orderListModel.buyerMobile];
        
    }else{
    
        [Util dialWithPhoneNumber:self.orderListModel.takeOrderCustomerInfo.customerPhoneNumber];
    }
}


@end
