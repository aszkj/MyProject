//
//  historyViewController.h
//  jingGang
//
//  Created by yi jiehuang on 15/6/2.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    StepHistory_Type,
    SleepHistory_Type,
}HistoyeType;

@interface historyViewController : UIViewController

@property (nonatomic, assign)HistoyeType histoyeType;

@end
