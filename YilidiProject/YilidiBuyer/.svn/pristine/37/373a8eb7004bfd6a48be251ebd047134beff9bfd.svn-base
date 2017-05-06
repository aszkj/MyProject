//
//  AppLifeCycleLisner.m
//  YilidiBuyer
//
//  Created by mm on 16/12/28.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "AppLifeCycleLisner.h"

static AppLifeCycleLisner *_appLifeCycleLisner = nil;

@interface AppLifeCycleLisner()

@property (nonatomic, copy)AppLifeCycleListenCallBack appEnterForegroundCallBack;

@end

@implementation AppLifeCycleLisner


+ (instancetype)sharedManager{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _appLifeCycleLisner = [[AppLifeCycleLisner alloc] init];
        
    });
    return _appLifeCycleLisner;
}



- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _registerAppEnterForegroundNotification];
    }
    return self;
}

#pragma mark ---------------------Public Method------------------------------
- (void)listenAppEnterForeground:(AppLifeCycleListenCallBack)appEnterForegroundCallBack {

    self.appEnterForegroundCallBack = appEnterForegroundCallBack;
}

- (void)cancelListenAppEnterForeground {
    
  [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}


#pragma mark ---------------------Private Method------------------------------
- (void)_registerAppEnterForegroundNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self
                      selector:@selector(AL_appEnterForeGround:)
                          name:UIApplicationDidBecomeActiveNotification object:nil];
}

#pragma mark ---------------------Notication Method------------------------------
- (void)AL_appEnterForeGround:(NSNotification *)info {
    if (self.appEnterForegroundCallBack) {
        self.appEnterForegroundCallBack();
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
