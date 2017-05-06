//
//  DLHomeHeaderLoopModel.m
//  YilidiBuyer
//
//  Created by yld on 16/4/19.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLHomeHeaderLoopModel.h"

@implementation DLHomeHeaderLoopModel

-(instancetype)initWithDefaultDataDic:(NSDictionary *)dic {
    
    self = [super initWithDefaultDataDic:dic];
    if (self) {
        self.imgUrl = dic[@"imageUrl"];
        self.title = dic[@"titleName"];
        self.linkTypeNumber = dic[@"linkType"];
        self.linkData = dic[@"linkData"];
    }
    return self;
}

//- (void)setLinkData:(NSString *)linkData {
//    _linkData = [self subCodeFromLinkData:linkData];
//}
//
//-(NSString *)subCodeFromLinkData:(NSString *)linkData {
//    NSString *subStr = nil;
//    if (isEmpty(linkData)) {
//        return nil;
//    }
//    NSRange range =  [linkData rangeOfString:@"="];
//    if (range.length > 0) {
//        subStr = [linkData substringFromIndex:range.location+1];
//    }
//    return subStr;
//}


@end
