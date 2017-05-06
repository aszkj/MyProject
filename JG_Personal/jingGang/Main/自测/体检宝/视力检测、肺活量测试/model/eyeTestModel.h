//
//  eyeTestModel.h
//  jingGang
//
//  Created by thinker on 15/7/22.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface eyeTestModel : NSObject

@property (nonatomic, strong) NSString * leftLabel;  //左边视力数
@property (nonatomic, strong) NSString * rightLabel; //右边视力数
@property (nonatomic, assign) float width;     //中间图片的大小

@end
