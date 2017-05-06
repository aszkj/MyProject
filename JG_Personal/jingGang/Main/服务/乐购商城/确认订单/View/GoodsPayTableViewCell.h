//
//  GoodsPayTableViewCell.h
//  jingGang
//
//  Created by thinker on 15/8/11.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopManager.h"

typedef void(^TLActionBlock)(NSIndexPath *indexPath);
typedef void(^EditBlock)(NSIndexPath *indexPath,NSString *text);
typedef void(^SelectJifengBlock)();


@interface GoodsPayTableViewCell : UITableViewCell

@property (nonatomic) NSIndexPath *indexPath;
@property (nonatomic) NSNumber *totalPrice;
@property (copy) TLActionBlock selecTransport;
@property (copy) TLActionBlock selecYouhui;
@property (copy) EditBlock textEditend;
@property (copy) SelectJifengBlock selectJifengBlock;
@property (nonatomic) BOOL hasCouponInfoList;
@property (nonatomic) float goodsRealPrice;
@property (weak, nonatomic) IBOutlet UILabel *youhuiLB;
// 右侧优惠券使用
@property (strong,nonatomic) UILabel *useCouponLab;

- (void)configShopManager:(ShopManager *)shopManager;
- (void)configYouhuiList:(NSArray *)couponInfoArray;
- (void)setTransport:(NSString *)transport;
- (void)setYouhuiPrice:(double)youhuiPrice;
- (NSString *)feedMessage;
- (NSString *)transWay;
- (void)updateGoodTotalPrice;

@end
