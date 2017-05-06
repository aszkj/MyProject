//
//  ProjectRelativeKey.h
//  YilidiSeller
//
//  Created by yld on 16/4/15.
//  Copyright © 2016年 yld. All rights reserved.
//

#ifndef ProjectRelativeKey_h
#define ProjectRelativeKey_h
#pragma mark - 工程中用的key


#define kaddShopCartGoodsModelKey @"addShopCartGoodsModel"
#define kwillAnimateGoodsViewKey  @"willAnimateGoodsView"

#define KCellTitleMyOrder @"我的订单"
#define KCellTitleMyRecipeAdress @"收货地址"
#define KCellTitleContactShopKeeper @"联系店主"
#define KCellTitleShopApply @"店铺申请"
#define KCellTitleReturenGoodsReturnMoneny @"退货/退款"
#define KCellTitleMyComment @"我的评价"
#define KCellTitleIdeaFeedBack @"意见反馈"
#define KCellTitleNormalProblem @"常见问题"
#define KCellTitleAboutUs @"关于我们"
#define KCellTitleCheckUpdate @"检查更新"
#define KCellTitleMore @"更多"
#define KCellTitleClearCache @"清理缓存"
#define KCellTitleServiceItems @"服务条款"
#define KCellTitleAboutYilidi @"关于一里递"

#define KLightingShipping     @"闪电配送"
#define KNotificationNamePrefix  @"KNotificationName"
#define KGoodsIdNotificationNameWithGoodsId(_goodsId) [NSString stringWithFormat:@"%@_%@",KNotificationNamePrefix,_goodsId]
#define KGoodsChangeGoodsNumberKey  @"KGoodsChangeGoodsNumberKey"
#define KGoodsChangeIsAddKey        @"KGoodsChangeIsAddKey"

#define kGoodsCountChangeNotificationName @"kGoodsCountChangeNotificationName"

#define kGoodsOnOffShelfNumberKey  @"kGoodsOnOffShelfNumberKey"
#define kGoodsClassJoinedStrKey    @"kGoodsClassJoinedStrKey"

#endif /* ProjectRelativeKey_h */
