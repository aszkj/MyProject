//
//  DLMerchantServiceCommentFooterView.m
//  YilidiBuyer
//
//  Created by mm on 17/2/9.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "DLMerchantServiceCommentFooterView.h"
#import "CWStarRateView.h"
#import "ProjectRelativeDefineNotification.h"

@interface DLMerchantServiceCommentFooterView ()<CWStarRateViewDelegate>
@property (weak, nonatomic) IBOutlet CWStarRateView *merchantServiceCommentStart;
@property (weak, nonatomic) IBOutlet CWStarRateView *shipServiceCommentStart;

@end


@implementation DLMerchantServiceCommentFooterView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.merchantServiceCommentStart.delegate = self;
    self.shipServiceCommentStart.delegate = self;
}

- (void)setMerchantCommentModel:(MerchantCommentModel *)merchantCommentModel {
    _merchantCommentModel = merchantCommentModel;
//    [self _assignUi];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self _assignUi];
}

- (void)_assignUi {
    [self configureStartView:self.merchantServiceCommentStart];
    [self configureStartView:self.shipServiceCommentStart];
    self.merchantServiceCommentStart.scorePercent = self.merchantCommentModel.merchantServiceCommentScore;
    self.shipServiceCommentStart.scorePercent = self.merchantCommentModel.merchantShipServiceCommentScore;
}

- (void)configureStartView:(CWStarRateView *)startView {
    startView.frame = CGRectMake(87, (40-17)/2, 145, 17);
    startView.originalImgName = @"starMakeCommentNormal";
    startView.hilightedImgName = @"starMakeCommentHilight";
    startView.isCanbeTouch = YES;
}

#pragma mark ----------- StartViewdelegate
- (void)starRateView:(CWStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent
{
    if (starRateView.tag == 10) {//商家服务
        self.merchantCommentModel.merchantServiceCommentScore = newScorePercent;
    }else if (starRateView.tag == 11) {//配送服务
        self.merchantCommentModel.merchantShipServiceCommentScore = newScorePercent;
    }
    [kNotification postNotificationName:KNotificationHasCommentStarNotification object:nil];

}


@end
