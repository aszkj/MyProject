//
//  UIViewController+adLinkDataJumpHandler.m
//  YilidiBuyer
//
//  Created by mm on 16/12/3.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "UIViewController+adLinkDataJumpHandler.h"
#import "DLGoodsAllClassVC.h"
#import "DLSeckillActivityVC.h"
#import "DLRedPacketEntrancePageVC.h"
#import "DLGoodsdetailVC.h"
#import "DLClassificationZoneVC.h"
#import "DLVipAndPennyGoodsVC.h"
#import "DLInfoMationVC.h"
#import "DLShowFloorGoodsVC.h"
#import "ProjectRelativeKey.h"
#import "ProjectRelativeDefineNotification.h"
#import "CordovaH5UrlManager.h"
#import "DLCordovaH5VC.h"

@implementation UIViewController (adLinkDataJumpHandler)

- (void)registerLinkDataJumpNotification {
    [kNotification addObserver:self selector:@selector(observeToGoodsDetail:) name:KNotificationLookGoodsDetail object:nil];
    [kNotification addObserver:self selector:@selector(observeToH5Page:) name:KNotificationToH5Page object:nil];
    [kNotification addObserver:self selector:@selector(observeToGoodsClassPage:) name:KNotificationLookGoodsClassPage object:nil];
    [kNotification addObserver:self selector:@selector(observeToSpecialSubjectPage:) name:KNotificationLookSpecialSubjectGoods object:nil];
    [kNotification addObserver:self selector:@selector(observeToSeckillActivityPage:) name:KNotificationComeToSeckillActivityPage object:nil];
    [kNotification addObserver:self selector:@selector(observeToLookRedPacketPage:) name:KNotificationLookRedPacketPage object:nil];
    [kNotification addObserver:self selector:@selector(observeToInfoMationPage:) name:KNotificationComeToInfoMationPage object:nil];
}

#pragma mark ---------------------PageNavigate Method------------------------------
- (void)_enterGoodsClassPageWithClassCode:(NSDictionary *)infoDic {
    DLGoodsAllClassVC *allGoodsShowVC = [[DLGoodsAllClassVC alloc] init];
    allGoodsShowVC.infoDic = infoDic;
    [self.navigationController pushViewController:allGoodsShowVC animated:YES];
}

- (void)_enterSeckillActivityPage {
    DLSeckillActivityVC *seckillActivityVC = [[DLSeckillActivityVC alloc] init];
    [self.navigationController pushViewController:seckillActivityVC animated:YES];
}

- (void)_enterRedPacketEntrancePage {
    DLRedPacketEntrancePageVC *redPacketEntrancePage = [[DLRedPacketEntrancePageVC alloc] init];
    [self.navigationController pushViewController:redPacketEntrancePage animated:YES];
}

- (void)_enterGoodsDetailWithGoodsId:(NSString *)goodsId {
    DLGoodsdetailVC *goodsDetailVC = [[DLGoodsdetailVC alloc] init];
    goodsDetailVC.goodsId = goodsId;
    [self.navigationController pushViewController:goodsDetailVC animated:YES];
}

- (void)_enterSpecialSubjectPage:(NSDictionary *)infoDic {
    DLClassificationZoneVC *classSpecialVC = [[DLClassificationZoneVC alloc] init];
    classSpecialVC.infoDic = infoDic;
    [self.navigationController pushViewController:classSpecialVC animated:YES];
}

- (void)_enterH5Page:(NSDictionary *)infoDic {
//    DLVipAndPennyGoodsVC *perfectGoodsVC = [[DLVipAndPennyGoodsVC alloc] init];
//    perfectGoodsVC.infoDic = infoDic;
//    [self.navigationController pushViewController:perfectGoodsVC animated:YES];
    
    NSString *h5typeCode = infoDic[kLinkDataKeyH5Page];
    [[CordovaH5UrlManager sharedManager] getH5Url:^(NSString *h5Url) {
        DLCordovaH5VC *h5Page = [[DLCordovaH5VC alloc] init];
        h5Page.h5Url = h5Url;
        [self.navigationController pushViewController:h5Page animated:YES];
    } forh5Code:h5typeCode];

    

}

- (void)_enterInfoMationPage:(NSDictionary *)infoDic {
    DLInfoMationVC *infoMationVC = [[DLInfoMationVC alloc] init];
    infoMationVC.infoDic = infoDic;
    [self.navigationController pushViewController:infoMationVC animated:YES];
}


#pragma mark ---------------------Observe Method------------------------------
- (void)observeToGoodsDetail:(NSNotification *)info {
    [self _enterGoodsDetailWithGoodsId:info.object[kLinkDataKeyGoodsDetail]];
}

- (void)observeToH5Page:(NSNotification *)info {
    [self _enterH5Page:info.object];
}

- (void)observeToSeckillActivityPage:(NSNotification *)info {
    [self _enterSeckillActivityPage];
}

- (void)observeToLookRedPacketPage:(NSNotification *)info  {
    [self _enterRedPacketEntrancePage];
}

- (void)observeToSpecialSubjectPage:(NSNotification *)info {
    [self _enterSpecialSubjectPage:info.object];
}

- (void)observeToGoodsClassPage:(NSNotification *)info {
    [self _enterGoodsClassPageWithClassCode:info.object];
}

- (void)observeToInfoMationPage:(NSNotification *)info {
    [self _enterInfoMationPage:info.object];
}



@end
