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


@end
