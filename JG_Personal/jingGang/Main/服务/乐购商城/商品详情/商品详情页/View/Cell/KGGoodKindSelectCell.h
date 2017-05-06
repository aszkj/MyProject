//
//  KGGoodKindSelectCell.h
//  jingGang
//
//  Created by 张康健 on 15/8/9.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "welfareView.h"

@interface KGGoodKindSelectCell : UITableViewCell

//选择的种类，，颜色，尺码等
@property (nonatomic, strong)UILabel *typeLabel;

//各个种类view
@property (nonatomic, strong)welfareView *typeView;


@property (nonatomic, copy)NSString *typeTitle;
@property (nonatomic, copy)NSArray *typeArr;

//属性数组
@property (nonatomic, copy)NSArray *properArr;

@end
