//
//  ShopCartView.h
//  YilidiBuyer
//
//  Created by yld on 16/6/21.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GotoShopCartPageBlock)(void);

@interface ShopCartView : UIView

@property (nonatomic,assign)NSInteger shopCartBadgeNumber;

@property (nonatomic,copy)GotoShopCartPageBlock gotoShopCartPageBlock;

@property (nonatomic,assign)BOOL neetoShowYellowBg;

@property (nonatomic, strong)UILabel *messageLabel;

@property (nonatomic, strong)UIButton *shopCartButton;

@property (nonatomic, strong)UIView *bgView;


-(void)initShopCartGoods;

@end
