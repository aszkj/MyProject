//
//  DistributeContentView.h
//  weimi
//
//  Created by 张康健 on 16/1/20.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PersonDistributeContentModel;

@interface DistributeContentView : UIView

@property (nonatomic, copy)UILabel *distributeLabel;

@property (nonatomic, copy)UIImageView *distributeImageView;

@property (nonatomic, copy)PersonDistributeContentModel *distributeContentModel;


@end
