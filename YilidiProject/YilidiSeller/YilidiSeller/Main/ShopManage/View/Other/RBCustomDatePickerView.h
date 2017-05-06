//  RBCustomDatePickerView.h
//  YilidiSeller
//
//  Created by yld on 16/6/14.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXSCycleScrollView.h"

typedef void(^TimePickerBlock)(NSString *);
@interface RBCustomDatePickerView : UIView <MXSCycleScrollViewDatasource,MXSCycleScrollViewDelegate>

@property (nonatomic,strong)TimePickerBlock timePickerBlock;
@end
