//
//  HaleyPlugin.h
//  HelloCordova
//
//  Created by Harvey on 16/9/28.
//
//

#import <Cordova/CDVPlugin.h>

typedef void(^JsTransValueBlock)(void);
@interface HaleyPlugin : CDVPlugin

- (void)location:(CDVInvokedUrlCommand *)command;

@property (nonatomic,copy)JsTransValueBlock jsTransValueBlock;

@end
