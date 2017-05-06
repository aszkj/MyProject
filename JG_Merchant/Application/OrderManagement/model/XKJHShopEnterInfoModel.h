//
//  XKJHShopEnterInfoModel.h
//  Merchants_JingGang
//
//  Created by thinker on 15/9/6.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKJHShopEnterInfoModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) CGFloat  titleWidth;
@property (nonatomic, copy  ) NSString *content;
@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) NSString *rightImageName;

@property (nonatomic, assign) CGFloat  rowHeight;
//保存图片数据
@property (nonatomic, strong) NSMutableArray *imageArray;
//保存图片的URL
@property (nonatomic, strong) NSMutableArray *imageURLArray;

@end
