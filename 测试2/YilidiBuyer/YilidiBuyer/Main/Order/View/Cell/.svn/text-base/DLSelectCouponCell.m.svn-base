//
//  DLSelectCouponCell.m
//  YilidiBuyer
//
//  Created by mm on 16/11/22.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLSelectCouponCell.h"
#import "DLCouponModel.h"

@interface DLSelectCouponCell()

@property (weak, nonatomic) IBOutlet UILabel *couponValueLabel;
@property (weak, nonatomic) IBOutlet UIButton *couponSelectedButton;
@property (weak, nonatomic) IBOutlet UIImageView *ticketAmountBgImgView;
@property (weak, nonatomic) IBOutlet UILabel *ticketUseRangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *ticketDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *ticketAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *ticketAmountRMBLabel;

@end

@implementation DLSelectCouponCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (IBAction)clickBgButton:(id)sender {
    [self selectDeselectSelectAction:self.couponSelectedButton];
}

- (IBAction)selectDeselectSelectAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
    emptyBlock(self.selectCouponBlock,button);
}

@end

@implementation DLSelectCouponCell (setCellModel)

- (void)setCellModel:(DLCouponModel *)model {
  
    self.couponValueLabel.text = model.ticketTypeName;
    self.couponSelectedButton.selected = model.selected;
    self.ticketAmountLabel.text = jFormat(@"%ld",model.ticketAmount);
    self.ticketUseRangeLabel.text = [NSString stringWithFormat:@"%@",model.userCope];
    self.ticketDescriptionLabel.text = model.ticketDescription;
}

- (void)setCellTicketType:(SelectTicketType)selectTicketType {
    NSString *ticketAmountBgImgName = nil;
    NSString *selecteTicketButtonSelectedImgName = nil;
    UIColor  *ticketAmountLabelColor = nil;
    if (selectTicketType == CouponTicket) {
        ticketAmountBgImgName = @"couponRedBg";
        selecteTicketButtonSelectedImgName = @"couponSelectedRed";
        ticketAmountLabelColor = UIColorFromRGB(0xFF3A30);
    }else if (selectTicketType == PledgeTicket) {
        ticketAmountBgImgName = @"pledgeTicketBlue";
        selecteTicketButtonSelectedImgName = @"couponSelectedBlue";
        ticketAmountLabelColor = UIColorFromRGB(0x299ef1);
    }
    self.ticketAmountBgImgView.image = IMAGE(ticketAmountBgImgName);
    [self.couponSelectedButton setBackgroundImage:IMAGE(selecteTicketButtonSelectedImgName) forState:UIControlStateSelected];
    self.ticketAmountLabel.textColor = self.ticketAmountRMBLabel.textColor = ticketAmountLabelColor;

}


@end
