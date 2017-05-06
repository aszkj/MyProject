//
//  ClockPikcerView.h
//  picker测试
//
//  Created by 张康健 on 15/6/12.
//  Copyright (c) 2015年 com.organazation. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectTimeBlock)(NSString *timeStr);


@interface ClockPikcerView : UIPickerView<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,strong)NSArray *data;

@property (nonatomic,copy)SelectTimeBlock selectTimeBlock;

@property (nonatomic,copy)NSString *selectedTimeStr;


@end
