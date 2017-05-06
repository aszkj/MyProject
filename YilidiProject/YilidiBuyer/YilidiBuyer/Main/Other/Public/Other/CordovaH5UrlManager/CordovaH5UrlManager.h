//
//  CordovaH5UrlManager.h
//  YilidiBuyer
//
//  Created by mm on 16/12/19.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^GetH5UrlBlock)(NSString *h5Url);

@interface CordovaH5UrlManager : NSObject

+ (instancetype)sharedManager;

- (void)getH5Url:(GetH5UrlBlock)getH5UrlBlock forh5Code:(NSString *)h5Code;

- (void)beginDownLoadH5Url;

@end
