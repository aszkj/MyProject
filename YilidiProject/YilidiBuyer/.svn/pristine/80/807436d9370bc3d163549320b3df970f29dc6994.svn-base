//
//  Operation.m
//  YilidiBuyer
//
//  Created by mm on 16/12/8.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "Operation.h"

@implementation Operation

- (void)backPressed:(CDVInvokedUrlCommand *)command {
    
    emptyBlock(self.htmlBackBlock);
}

- (void)redirectPage:(CDVInvokedUrlCommand *)command {
    emptyBlock(self.htmlRedirectBlock,command.arguments.firstObject);
}

- (void)toCartPage:(CDVInvokedUrlCommand *)command {
    emptyBlock(self.htmlToCartPageBlock);
}

- (void)toLoginPage:(CDVInvokedUrlCommand *)command {
    emptyBlock(self.htmlToLoginPageBlock);
}

- (void)toOrderListPage:(CDVInvokedUrlCommand *)command {
    emptyBlock(self.htmlToOrderlistPageBlock);
}

- (void)toOrderDetailPage:(CDVInvokedUrlCommand *)command {
    NSString *orderNo = command.arguments.firstObject;
    emptyBlock(self.htmlToOrderDetailPageBlock,orderNo);
}

- (void)toClassPage:(CDVInvokedUrlCommand *)command {
    emptyBlock(self.htmlToClassPageBlock);
}

- (void)toBrandPage:(CDVInvokedUrlCommand *)command {
    emptyBlock(self.htmlToBrandPageBlock);
}

@end
