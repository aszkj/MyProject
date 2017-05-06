//
//  WEMEFeedcontrollerApi+RACSignal.m
//  weimi
//
//  Created by ray on 16/1/19.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "WEMEFeedcontrollerApi+RACSignal.h"

@implementation WEMEFeedcontrollerApi (RACSignal)

+ (RACCompleteBlock)completeBlock:(RACSubject *)subject
{
    RACCompleteBlock completeBlock = ^(id output, NSError *error) {
        
        NSString *errorDescription = [output valueForKey:@"error"];
        if (error != nil ) {
            [subject sendError:error];
        } else if ( errorDescription != nil) {
            [subject sendError: [[NSError alloc] initWithDomain:@"10" code:110 userInfo:[NSDictionary dictionaryWithObject:errorDescription                                                                      forKey:NSLocalizedDescriptionKey]]];
        } else {
            [subject sendNext:output];
            [subject sendCompleted];
        }
    };
    
    return completeBlock;
}


@end
