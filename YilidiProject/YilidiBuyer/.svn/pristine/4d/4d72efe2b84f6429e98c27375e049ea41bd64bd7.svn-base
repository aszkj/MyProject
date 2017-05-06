//
//  DLTopQualityFruitSectionHeaderView.m
//  YilidiBuyer
//
//  Created by yld on 16/4/18.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLHomeSecondSectionHeaderView.h"
#import "DLHomeFloorModel.h"
#import "UIButton+Block.h"
#import "UIView+BlockGesture.h"
#import "DataManager+linkDataHandle.h"

@interface DLHomeSecondSectionHeaderView()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *adToTopConstraint;
@property (weak, nonatomic) IBOutlet UIView *floorHeaderView;

@end

@implementation DLHomeSecondSectionHeaderView

- (void)awakeFromNib {

    // Initialization code
}

- (void)_doNotShowFloorHeaderConfigure {
    self.adToTopConstraint.constant = 0;
    self.floorHeaderView.hidden = YES;
}

- (void)_floorHeaderAndAdNormalShowConfigure {
    self.adToTopConstraint.constant = 44;
    self.floorHeaderView.hidden = NO;
}

- (void)_configureUi {
    self.titleLabel.text = self.floorModel.floorBaseInfoModel.floorName;
    [self.titleImageView sd_SetImgWithUrlStr:self.floorModel.floorBaseInfoModel.floorIconImageUrl placeHolderImgName:nil];
    [self.sectionGoodsAdImgView sd_SetImgWithUrlStr:self.floorModel.floorAdInfoModel.floorAdImageUrl placeHolderImgName:nil];
    if (isEmpty(self.floorModel.floorBaseInfoModel)) {//只显示图片
        [self _doNotShowFloorHeaderConfigure];
    }else {
        if (self.floorModel.floorBaseInfoModel.floorProductList.count) {
            [self _floorHeaderAndAdNormalShowConfigure];
        }else {
            [self _doNotShowFloorHeaderConfigure];
        }
    }
    
    WEAK_SELF
    [self.moreGoodsButton addActionHandler:^(NSInteger tag) {
        [weak_self _dealClickFloorWithLinkCode:weak_self.floorModel.floorBaseInfoModel.floorLinkData linkTypeNumber:weak_self.floorModel.floorBaseInfoModel.floorLinkTypeNumber];
    }];
    
    self.sectionGoodsAdImgView.userInteractionEnabled = YES;
    [self.sectionGoodsAdImgView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        
        if (isEmpty([[DataManager sharedManager] canLinkCodeStrJump:weak_self.floorModel.floorAdInfoModel.floorAdLinkData linkTypeNumber:weak_self.floorModel.floorAdInfoModel.floorAdLinkTypeNumber])) {
            return ;
        }
        [weak_self _dealClickFloorAdWithLinkCode:weak_self.floorModel.floorAdInfoModel.floorAdLinkData linkTypeNumber:weak_self.floorModel.floorAdInfoModel.floorAdLinkTypeNumber];
    }];

}
- (void)_dealClickFloorAdWithLinkCode:(NSString *)linkCode linkTypeNumber:(NSNumber *)linkTypeNumber{
    NSDictionary *linkInfo = [[DataManager sharedManager] transferToDicWithLinkCodeStr:linkCode linkTypeNumber:linkTypeNumber];
    NSString *linkNotificationName = [[DataManager sharedManager] transferTolinkNotificationNameWithlinkTypeNumber:linkTypeNumber linkDataDic:linkInfo];
    if (isEmpty(linkNotificationName)) {
        return;
    }
    [kNotification postNotificationName:linkNotificationName object:linkInfo];
}

- (void)_dealClickFloorWithLinkCode:(NSString *)linkCode linkTypeNumber:(NSNumber *)linkTypeNumber{
    NSString *linkNotificationName = [[DataManager sharedManager] transferTolinkNotificationNameWithFloorlinkTypeNumber:linkTypeNumber];
    NSDictionary *linkInfo = [[DataManager sharedManager] transferToDicWithLinkCodeStr:linkCode linkTypeNumber:linkTypeNumber];
    if (isEmpty(linkNotificationName)) {
        return;
    }
    [kNotification postNotificationName:linkNotificationName object:linkInfo];
}



- (void)setFloorModel:(DLHomeFloorModel *)floorModel {
    _floorModel = floorModel;
    [self _configureUi];
}

@end
