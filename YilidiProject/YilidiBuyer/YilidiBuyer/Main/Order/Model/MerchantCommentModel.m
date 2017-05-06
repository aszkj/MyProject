//
//  MerchantCommentModel.m
//  YilidiBuyer
//
//  Created by mm on 17/2/10.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "MerchantCommentModel.h"
#import "GlobleConst.h"

@implementation MerchantCommentModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.merchantStoreId = kCommunityStoreId;
    }
    return self;
}

@end
