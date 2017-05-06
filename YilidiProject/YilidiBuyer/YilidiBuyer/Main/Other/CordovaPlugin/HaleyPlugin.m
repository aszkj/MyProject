//
//  HaleyPlugin.m
//  HelloCordova
//
//  Created by Harvey on 16/9/28.
//
//


#import "HaleyPlugin.h"

@implementation HaleyPlugin


- (void)location:(CDVInvokedUrlCommand *)command
{
     NSString *locationStr = @"错误信息";
//    NSString *jsStr = [NSString stringWithFormat:@"setLocation('%@')",locationStr];
//    [self.commandDelegate evalJs:jsStr];
    self.jsTransValueBlock();
    [[NSNotificationCenter defaultCenter] postNotificationName:@"haha" object:nil];
    [self.commandDelegate runInBackground:^{
        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:locationStr];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }];
}

@end
