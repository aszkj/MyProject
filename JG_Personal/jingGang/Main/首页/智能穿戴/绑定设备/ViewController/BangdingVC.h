//
//  BangdingVC.h
//  jingGang
//
//  Created by 张康健 on 15/6/10.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JGBlueToothManager.h"
#import "devicesChildViewController.h"

typedef void(^BackBlcok)(void);
@interface BangdingVC : UIViewController

@property (nonatomic,strong)CBPeripheral *needBandePerial;

@property (nonatomic,strong)devicesChildViewController *bangdedSuceessBackVC;


@property (nonatomic,strong)BackBlcok backBlock;

@end
