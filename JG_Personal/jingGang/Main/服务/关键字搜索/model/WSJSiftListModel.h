//
//  WSJSiftListModel.h
//  jingGang
//
//  Created by thinker on 15/8/6.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSJSiftListModel : NSObject


@property (nonatomic, copy) NSString *ID;

//是否选中该段
@property (nonatomic, assign) BOOL isSelectSection;
//该段数据源
@property (nonatomic, strong) NSMutableArray *data;
//每一段的标题
@property (nonatomic, copy)   NSString  *titleName;

//选中这一段中的某一行
@property (nonatomic, assign) NSInteger selectRow;


@end
