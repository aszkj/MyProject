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
    NSString *locationStr = @"错误信息";
    [[NSNotificationCenter defaultCenter] postNotificationName:@"haha" object:nil];
    [self.commandDelegate runInBackground:^{
        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:locationStr];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }];
    
    NSString *goodsBarCode = command.arguments.firstObject;
    emptyBlock(self.htmlAddFenToCartBlock,goodsBarCode);
}

- (void)addProductByBarCode:(CDVInvokedUrlCommand *)command {
    NSString *goodsBarCode = command.arguments.firstObject;
    emptyBlock(self.htmlAddVIPToCartBlock,goodsBarCode);
}


- (void)removeToCart:(CDVInvokedUrlCommand *)command {
    
    NSString *goodsId = command.arguments.firstObject;
    emptyBlock(self.htmlRemoveToCartBlock,goodsId);

}

@end
