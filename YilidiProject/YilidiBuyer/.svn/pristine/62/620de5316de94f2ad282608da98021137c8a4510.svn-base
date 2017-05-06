//
//  ShopCartSectionHeaderView.h
//  YilidiBuyer
//
//  Created by yld on 16/8/1.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectRelativEmerator.h"

typedef void(^EnterAdressPageBlock)(void);
#define KShopCartSectionHeaderViewHeight 132

@class StoreModel;
@class AdressModel;
@interface ShopCartSectionHeaderView : UIView

@property (nonatomic,assign)SelectShipWay selectShipWay;
@property (weak, nonatomic) IBOutlet UILabel *reciepeTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (nonatomic,copy)EnterAdressPageBlock enterAdressPageBlock;
@property (weak, nonatomic) IBOutlet UILabel *deliveryTimeWayLabel;
@property (weak, nonatomic) IBOutlet UILabel *freeShipLabel;

@property (nonatomic,strong)StoreModel *storeModel;
@property (nonatomic,strong)AdressModel *adressModel;


@end
