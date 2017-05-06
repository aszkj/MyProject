//
//  CordovaH5UrlManager.m
//  YilidiBuyer
//
//  Created by mm on 16/12/19.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "CordovaH5UrlManager.h"
#import "NSString+Teshuzifu.h"
#import "GlobleConst.h"

static CordovaH5UrlManager *_cordovaH5UrlManager = nil;

@interface CordovaH5UrlManager()

@property (nonatomic,strong)NSMutableDictionary *cordovah5UrlDic;

@end

@implementation CordovaH5UrlManager

+ (instancetype)sharedManager{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _cordovaH5UrlManager = [[CordovaH5UrlManager alloc] init];
        
    });
    return _cordovaH5UrlManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)beginDownLoadH5Url {
    
       
    NSArray *h5Codes = @[H5PAGETYPE_ABOUT_US,
                         H5PAGETYPE_COMMON_QUESTION,
                       ];
    for (NSString *h5Code in h5Codes) {
        [self _requestH5Url:^(NSString *h5Url) {
            [self.cordovah5UrlDic setObject:h5Url forKey:h5Code];
        } forh5Code:h5Code];
    }
}

- (void)getH5Url:(GetH5UrlBlock)getH5UrlBlock forh5Code:(NSString *)h5Code {
    
    NSString *h5Url = [self.cordovah5UrlDic objectForKey:h5Code];
    if (h5Url) {
        getH5UrlBlock(h5Url);
    }else {
        [self _requestH5Url:^(NSString *h5Url) {
            [self.cordovah5UrlDic setObject:h5Url forKey:h5Code];
            getH5UrlBlock(h5Url);
        } forh5Code:h5Code];
    }
}


- (void)_requestH5Url:(GetH5UrlBlock)getH5UrlBlock forh5Code:(NSString *)h5Code{
    NSDictionary *parameters = @{@"type":@(h5Code.integerValue)};
    [AFNHttpRequestOPManager postWithParameters:parameters subUrl:kUrl_Setting block:^(NSDictionary *resultDic, NSError *error) {
        if (error.code!=1) {
            return;
        }else{
            NSString *urlStr = [NSString stringWithFormat:@"%@",resultDic[EntityKey][@"value"]];
            urlStr = [urlStr resolutionCordovaUrlStr];
            getH5UrlBlock(urlStr);
        }
    }];

}

@end
