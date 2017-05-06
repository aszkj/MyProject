//
//  HaleyPlugin.h
//  HelloCordova
//
//  Created by Harvey on 16/9/28.
//
//

#import "CDV.h"

typedef void(^JsTransValueBlock)(void);
typedef void(^HtmlAddFenToCartBlock)(NSString *goodsBarCode);
typedef void(^HtmlAddVIPToCartBlock)(NSString *goodsBarCode);
typedef void(^HtmlRemoveToCartBlock)(NSString *goodsId);

@interface ProductCart : CDVPlugin

//一分钱
- (void)addProductByFen:(CDVInvokedUrlCommand *)command;

//vip商品
- (void)addProductByBarCode:(CDVInvokedUrlCommand *)command;

- (void)removeToCart:(CDVInvokedUrlCommand *)command;

@property (nonatomic,copy)HtmlAddFenToCartBlock htmlAddFenToCartBlock;
@property (nonatomic,copy)HtmlAddVIPToCartBlock htmlAddVIPToCartBlock;

@property (nonatomic,copy)HtmlRemoveToCartBlock htmlRemoveToCartBlock;

@property (nonatomic,copy)JsTransValueBlock jsTransValueBlock;

@end
