//
//  HaleyPlugin.m
//  HelloCordova
//
//  Created by Harvey on 16/9/28.
//
//


#import "ProductCart.h"

@implementation ProductCart

- (void)addToCart:(CDVInvokedUrlCommand *)command
{
    NSString *locationStr = @"错误信息";
    self.jsTransValueBlock();
    [[NSNotificationCenter defaultCenter] postNotificationName:@"haha" object:nil];
    [self.commandDelegate runInBackground:^{
        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:locationStr];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }];
    
    NSDictionary *goodsDic = command.arguments.firstObject;
    emptyBlock(self.htmlAddToCartBlock,goodsDic);
}

- (void)removeToCart:(CDVInvokedUrlCommand *)command {
    
    NSString *goodsId = command.arguments.firstObject;
    emptyBlock(self.htmlRemoveToCartBlock,goodsId);

}

@end
