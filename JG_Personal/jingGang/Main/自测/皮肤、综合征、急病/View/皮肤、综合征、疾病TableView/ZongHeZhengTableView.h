//
//  ZongHeZhengTableView.h
//  jingGang
//
//  Created by 张康健 on 15/6/4.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BeginTestBlock)(long groupID,NSString *groupTitle, NSString *groupContent, NSString *groupThumnail);
typedef void(^SelfTestDetailBlock)(long groupID, NSString *groupTitle, NSString *groupContent, NSString *groupThumnail);

@interface ZongHeZhengTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSArray *data;

@property (nonatomic,strong)NSArray *dataCellHeightArr;

@property (nonatomic,copy)BeginTestBlock beginTestBlock;

@property (nonatomic,copy)SelfTestDetailBlock selfTestDetailBlock;




@end
