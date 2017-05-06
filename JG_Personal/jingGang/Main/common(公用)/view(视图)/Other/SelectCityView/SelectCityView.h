//
//  SelectCityView.h
//  jingGang
//
//  Created by 张康健 on 15/9/11.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectCityActionBlock)(void);

@interface SelectCityView : UIView

@property (nonatomic, copy)NSString *cityName;

@property (nonatomic, strong)NSNumber *cityID;

@property (nonatomic, copy)SelectCityActionBlock selectCityActionBlock;

@end
