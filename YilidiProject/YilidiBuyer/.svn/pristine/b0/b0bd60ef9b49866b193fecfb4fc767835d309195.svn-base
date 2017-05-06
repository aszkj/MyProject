//
//  DLGrabRedPacketResultCell.m
//  YilidiBuyer
//
//  Created by yld on 16/10/19.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLGrabRedPacketResultCell.h"
#import "NSArray+dealUI.h"
#import "NSLayoutConstraint+changeConstraintValue.h"
#import "DLCouponModel.h"


@interface DLGrabRedPacketResultCell()
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *allLabels;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *quanLabelToLeftConstraint;

@property (weak, nonatomic) IBOutlet UILabel *couponUseRangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *couponUseConditionLabel;
@property (weak, nonatomic) IBOutlet UILabel *couponUseInPayWayLabel;
@property (weak, nonatomic) IBOutlet UILabel *couponUseTimeRangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *couponAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *couponTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *couponStatusLabel;

@end

@implementation DLGrabRedPacketResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    if (iPhone5 || iPhone4) {
        [self.allLabels changeFontSizeInUIArrForDetaFontNumber:-2];
        [self.quanLabelToLeftConstraint changeConstraintValueOfDetaValue:-7];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

@implementation DLGrabRedPacketResultCell (setCellModel)

- (void)setCellModel:(DLCouponModel *)model {
    
    if (isEmpty(model.userCope)) {
        model.userCope = @"全场";
    }
    self.couponUseRangeLabel.text = jFormat(@"%@",model.userCope);
    self.couponUseConditionLabel.text = model.ticketDescription;
    self.couponUseTimeRangeLabel.text = jFormat(@"%@到%@",model.beginTime,model.endTime);
    self.couponAmountLabel.text = jFormat(@"%ld",model.ticketAmount);
    self.couponTypeLabel.text = jFormat(@"%@",model.ticketTypeName);
    self.couponStatusLabel.text = jFormat(@"%@",model.ticketStatusName);

}

@end
