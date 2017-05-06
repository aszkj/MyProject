//
//  WEMEFeedcontrollerApi+RACSignal.h
//  weimi
//
//  Created by ray on 16/1/19.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <WEMEClient/WEMEFeedcontrollerApi.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface WEMEFeedcontrollerApi (RACSignal)


typedef void (^RACCompleteBlock)(id output, NSError *error);

+ (RACCompleteBlock)completeBlock:(RACSubject *)subject;

@end
