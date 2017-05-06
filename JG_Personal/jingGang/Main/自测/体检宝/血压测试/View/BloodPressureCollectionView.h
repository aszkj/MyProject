//
//  BloodPressureCollectionView.h
//  jingGang
//
//  Created by 张康健 on 15/7/28.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMDownloadIndicator.h"
@interface BloodPressureCollectionView : UIView
@property (weak, nonatomic) IBOutlet RMDownloadIndicator  *rmBloodTestProgressView;
@property (weak, nonatomic) IBOutlet UILabel              *bloodPrssureValueLabel;
@property (weak, nonatomic) IBOutlet UILabel              *pressureLabel;

@end
