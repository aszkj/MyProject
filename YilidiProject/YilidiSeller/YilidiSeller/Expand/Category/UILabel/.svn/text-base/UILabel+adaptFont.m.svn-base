//
//  UILabel+adaptFont.m
//  YilidiSeller
//
//  Created by yld on 16/7/1.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "UILabel+adaptFont.h"
#import <objc/runtime.h>

//#define SizeScale ((IPHONE_HEIGHT > 568) ? IPHONE_HEIGHT/568 : 1)
#define SizeScale   kScreenWidth / iPhone6_width

@implementation UILabel (adaptFont)

+ (void)load{
    
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
    
}

- (id)myInitWithCoder:(NSCoder*)aDecode{
    [self myInitWithCoder:aDecode];
    if (self) {
        //部分不像改变字体的 把tag值设置成333跳过
//        if(self.tag != 333){
            CGFloat fontSize = self.font.pointSize;
//        if (kScreenWidth == iPhone5_width) {
//            fontSize = fontSize - 1;
//        }
//        self.font = [UIFont systemFontOfSize:fontSize];
//        }
    }
    return self;
}


@end
