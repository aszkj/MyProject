//
//  DLAnimatePerformer+business.m
//  YilidiBuyer
//
//  Created by mm on 17/3/2.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "DLAnimatePerformer+business.h"
#import "ProjectRelativeDefineNotification.h"
#import "GlobleConst.h"


@implementation DLAnimatePerformer (business)

+ (void)excuteAddShopCartAnimationUsingAnimateImageView:(UIImageView *)animateImageView
                                        contentListView:(id)contentListView
                                      shopCartViewPoint:(CGPoint)shopCartViewPoint
                                          isAddShopCart:(BOOL)isAddShopCart
{
    UIScrollView *contentListScrollView = (UIScrollView *)contentListView;

    if (!isAddShopCart) {
        [kNotification postNotificationName:KNotificationShopCartBadgeValueNeedChange object:@(isAddShopCart)];
        return;
    }
    contentListScrollView.scrollEnabled = NO;
    BLOCK_OBJ(contentListScrollView)
    DLAnimatePerformer *animatePerformer = [[DLAnimatePerformer alloc] init];

    [animatePerformer performProjectDefaultAddShopCartAnimationForAnimationGoodsImgView:animateImageView animateEndPoint: shopCartViewPoint animateDidEndBlock:^{
        block_contentListScrollView.scrollEnabled = YES;
        [kNotification postNotificationName:KNotificationShopCartBadgeValueNeedChange object:@(isAddShopCart)];
    }];


}

@end
