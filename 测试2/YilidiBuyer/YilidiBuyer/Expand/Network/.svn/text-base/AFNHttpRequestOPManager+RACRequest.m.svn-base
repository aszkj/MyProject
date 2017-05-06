//
//  AFNHttpRequestOPManager+RACRequest.m
//  YilidiBuyer
//
//  Created by yld on 16/5/3.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "AFNHttpRequestOPManager+RACRequest.h"


@implementation AFNHttpRequestOPManager (RACRequest)

+ (RACSignal *)rac_GetInfoWithSubUrl:(NSString *)subUrl
                          parameters:(NSDictionary *)Parameters
                subScribeResultBlock:(SubScriberResultBlock)subScribeResultBlock;
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [[self class] getInfoWithSubUrl:subUrl parameters:Parameters block:^(id result, NSError *error) {
            if (subScribeResultBlock) {
                subScribeResultBlock(result,error,subscriber);
            }
        }];
        return nil;
    }];
}

+ (RACSignal *)rac_PostWithSubUrl:(NSString *)subUrl
                       parameters:(NSDictionary *)Parameters
             subScribeResultBlock:(SubScriberResultBlock)subScribeResultBlock;

{
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       [[self class] postWithParameters:Parameters subUrl:subUrl block:^(NSDictionary *resultDic, NSError *error) {
           if (subScribeResultBlock) {
               subScribeResultBlock(resultDic,error,subscriber);
           }
       }];
       return nil;
    }];


}


@end
