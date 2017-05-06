//
//  KJAddShoppingCarView.h
//  jingGang
//
//  Created by 张康健 on 15/8/9.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KJGoodKindSelectTableView.h"
#import "AddShoppingCartViewDataInoutHander.h"


//确定block
typedef void(^MakeSureBlock)(NSNumber *num, NSArray *propertyIdArr,NSString *selectedPropertyIdStr,CGFloat squPrice);
//立即购买，加入购物车block
typedef void(^AddShopingCartOrBuyNowBlock)(NSNumber *num, NSArray *propertyIdArr, BOOL isbuyNow);

@interface KJAddShoppingCarView : UIView
@property (weak, nonatomic) IBOutlet KJGoodKindSelectTableView *goodsKindSelectTableView;
//加入购物车视图高度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shoppingCarViewToBottonContraint;
//加入购物车视图距离底部的距离
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addShoppingCarViewHeightConstraint;

//商品本身的规格与属性字典
@property (nonatomic, copy)NSDictionary *goodsCationPropertyDic;

@property (weak, nonatomic) IBOutlet UILabel *displaySelectedPropertyLabel;

//已选择的属性字符串
@property (nonatomic, copy)NSString *selectedPropertyStr;

//选择商品一系列属性后生成的字典
@property (nonatomic, copy)NSMutableDictionary *selectGoodsCationPropertyDic;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;
@property (weak, nonatomic) IBOutlet UIButton *addShoppingCartButton;
@property (weak, nonatomic) IBOutlet UIButton *buyNowButton;

@property (nonatomic, copy)MakeSureBlock makeSureBlock;

@property (nonatomic, copy)AddShopingCartOrBuyNowBlock AddShopingCartOrBuyNowBlock;

//是否是由点击选择商品属性所呈现
@property (nonatomic, assign)BOOL ispresentedBySelectedGoodsCation;
@property (weak, nonatomic) IBOutlet UILabel *goodsStockLabel;

//购买数量
@property NSInteger buyCount;

//处理数据逻辑的对象
@property (nonatomic, strong)AddShoppingCartViewDataInoutHander* dataHander;

+(id)showCartViewInContentView:(UIView *)contentView;
-(void)startShow;
-(void)endShowAfterSeconds:(NSInteger)seconds;

-(void)beginAnimation;
-(void)endAnimation;

@end
