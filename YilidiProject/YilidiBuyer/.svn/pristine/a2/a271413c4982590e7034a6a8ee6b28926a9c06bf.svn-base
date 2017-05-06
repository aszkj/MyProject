//
//  HaleyPlugin.m
//  HelloCordova
//
//  Created by Harvey on 16/9/28.
//
//


#import "ProductCart.h"

@implementation ProductCart

- (void)addProductByFen:(CDVInvokedUrlCommand *)command
{
    NSString *goodsBarCode = command.arguments.firstObject;
    emptyBlock(self.htmlAddFenToCartBlock,goodsBarCode);
}

- (void)addProductByBarCode:(CDVInvokedUrlCommand *)command {
    NSString *goodsBarCode = command.arguments.firstObject;
    emptyBlock(self.htmlAddVIPToCartBlock,goodsBarCode);
}


- (void)addToCart:(CDVInvokedUrlCommand *)command {
    NSDictionary *goodsDic = command.arguments.firstObject;
    emptyBlock(self.htmlAddToCartBlock,goodsDic);
}

- (void)removeToCart:(CDVInvokedUrlCommand *)command {
    NSDictionary *goodsDic = command.arguments.firstObject;
    emptyBlock(self.htmlRemoveToCartBlock,goodsDic);
}

- (void)buyAtOnce:(CDVInvokedUrlCommand *)command {
    NSDictionary *goodsDic = command.arguments.firstObject;
    emptyBlock(self.htmlBuyAtOneceBlock,goodsDic);
}

- (void)clearCart:(CDVInvokedUrlCommand *)command {
    emptyBlock(self.htmlClearShopCartBlock);
}



@end
