//
//  HaleyPlugin.h
//  HelloCordova
//
//  Created by Harvey on 16/9/28.
//
//

#import <Cordova/CDVPlugin.h>
typedef void(^JsTransValueBlock)(void);
typedef void(^HtmlAddToCartBlock)(NSDictionary *goodsDic);
typedef void(^HtmlRemoveToCartBlock)(NSString *goodsId);

@interface ProductCart : CDVPlugin

- (void)addToCart:(CDVInvokedUrlCommand *)command;

- (void)removeToCart:(CDVInvokedUrlCommand *)command;

@property (nonatomic,copy)HtmlAddToCartBlock htmlAddToCartBlock;

@property (nonatomic,copy)HtmlRemoveToCartBlock htmlRemoveToCartBlock;

@property (nonatomic,copy)JsTransValueBlock jsTransValueBlock;

@end
