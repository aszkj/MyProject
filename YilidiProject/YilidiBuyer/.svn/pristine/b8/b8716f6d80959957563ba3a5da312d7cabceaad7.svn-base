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
    /*
     //关于我们
     #define H5PAGETYPE_ABOUT_US @"H5PAGETYPE_ABOUT_US"
     //常见问题
     #define H5PAGETYPE_COMMON_QUESTION @"H5PAGETYPE_COMMON_QUESTION"
     //合伙人加盟
     #define H5PAGETYPE_PARTNER_JOIN @"H5PAGETYPE_PARTNER_JOIN"
     //新人专享
     #define H5PAGETYPE_FRESHMAN_EXCLUSIVE @"H5PAGETYPE_FRESHMAN_EXCLUSIVE"
     //注册有礼
     #define H5PAGETYPE_REGISTER_GIFT @"H5PAGETYPE_REGISTER_GIFT"
     //牛奶促销
     #define H5PAGETYPE_MILK_PROMOTION  @"H5PAGETYPE_MILK_PROMOTION"
     //升级VIP
     #define H5PAGETYPE_UPGRADE_VIP @"H5PAGETYPE_UPGRADE_VIP_NEW"
     //分享有礼
     #define H5PAGETYPE_SHARE_PAGE  @"H5PAGETYPE_SHARE_PAGE"
     */
    NSArray *h5Codes = @[H5PAGETYPE_ABOUT_US,
                         H5PAGETYPE_COMMON_QUESTION,
                         H5PAGETYPE_PARTNER_JOIN,
                         H5PAGETYPE_FRESHMAN_EXCLUSIVE,
                         H5PAGETYPE_REGISTER_GIFT,
                         H5PAGETYPE_MILK_PROMOTION,
                         H5PAGETYPE_UPGRADE_VIP,
                         H5PAGETYPE_SHARE_PAGE];
    self.cordovah5UrlDic = [NSMutableDictionary dictionaryWithCapacity:h5Codes.count];
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
    NSDictionary *parameters = @{@"typeCode":h5Code};
    [AFNHttpRequestOPManager postWithParameters:parameters subUrl:kUrl_GetTypeUrl block:^(NSDictionary *resultDic, NSError *error) {
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
