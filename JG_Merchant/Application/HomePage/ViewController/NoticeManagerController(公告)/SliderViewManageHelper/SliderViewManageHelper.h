//
//  SliderViewManageHelper.h
//  Merchants_JingGang
//
//  Created by dengxf on 15/10/29.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SliderViewManageHelper : NSObject

- (instancetype)initWithController:(UIViewController *)controller
                itemTitles:(NSArray *)itemTitles
             selectedIndex:(NSInteger)selectedIndex;

@end
