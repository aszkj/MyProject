//
//  JGActivityWebController.h
//  jingGang
//
//  Created by dengxf on 15/12/30.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PositionAdvertBO;
@class JGActivityHotSaleApiBO;
@interface JGActivityWebController : UIViewController

- (instancetype)initWithAdvertBO:(PositionAdvertBO *)AdvBO withHeaderRequest:(NSString *)headerRequest ApiBO:(id)apiBO isPushType:(BOOL)isPushType;

@end
