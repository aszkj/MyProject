//
//  AFNHttpRequestOPManager+RACRequest.h
//  YilidiBuyer
//
//  Created by yld on 16/5/3.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "AFNHttpRequestOPManager.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
typedef RACDisposable *(^SubScriberResultBlock)(id result, NSError *error,id<RACSubscriber> subscriber);

@interface AFNHttpRequestOPManager (RACRequest)

+ (RACSignal *)rac_GetInfoWithSubUrl:(NSString *)subUrl
                        parameters:(NSDictionary *)Parameters
                subScribeResultBlock:(SubScriberResultBlock)subScribeResultBlock;

+ (RACSignal *)rac_PostWithSubUrl:(NSString *)subUrl
                          parameters:(NSDictionary *)Parameters
             subScribeResultBlock:(SubScriberResultBlock)subScribeResultBlock;

@end
