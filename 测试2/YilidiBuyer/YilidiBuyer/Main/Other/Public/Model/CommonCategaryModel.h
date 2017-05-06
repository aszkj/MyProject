//
//  CommonCategaryModel.h
//  JCTagViewTest
//
//  Created by yld on 16/5/12.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface CommonCategaryModel : BaseModel

@property (nonatomic,copy)NSString *categaryName;

@property (nonatomic,copy)NSString *categaryId;

@end

@interface CommonCategaryModel (setGoodsCategary)

+ (CommonCategaryModel *)initWithGoodsCategaryDic:(NSDictionary *)goodsCategaryDic;

@end