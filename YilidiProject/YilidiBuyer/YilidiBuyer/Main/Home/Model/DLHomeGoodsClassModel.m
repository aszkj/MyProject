//
//  DLHomeGoodsClassModel.m
//  YilidiBuyer
//
//  Created by yld on 16/5/24.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLHomeGoodsClassModel.h"
#import "GoodsModel.h"

@implementation DLHomeGoodsClassModel

-(instancetype)initWithDefaultDataDic:(NSDictionary *)dic {
    
    self = [super initWithDefaultDataDic:dic];
    if (self) {

    }
    return self;
}

- (void)setClassMoreCode:(NSString *)classMoreCode {
    _classMoreCode = [self subCodeFromLinkData:classMoreCode];
}

-(NSString *)subCodeFromLinkData:(NSString *)linkData {
    NSString *subStr = nil;
    NSRange range =  [linkData rangeOfString:@"="];
    if (range.length > 0) {
        subStr = [linkData substringFromIndex:range.location+1];
    }
    return subStr;
}

@end
