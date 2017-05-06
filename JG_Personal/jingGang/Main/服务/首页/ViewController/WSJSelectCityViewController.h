//
//  WSJSelectCityViewController.h
//  jingGang
//
//  Created by thinker on 15/9/17.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CityBlock)(NSString *city,NSNumber *cityID);

@interface WSJSelectCityViewController : UIViewController

/**
 *  选中城市，通过block返回城市名称(city城市名称，cityID城市id)
 */
@property (nonatomic, copy) CityBlock city;

@end
