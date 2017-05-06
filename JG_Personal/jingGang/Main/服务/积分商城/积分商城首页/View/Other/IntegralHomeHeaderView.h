//
//  IntegralHomeHeaderView.h
//  jingGang
//
//  Created by 张康健 on 15/11/22.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
@interface IntegralHomeHeaderView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet SDCycleScrollView *headerView;


- (void)headerRequestData;

@end
