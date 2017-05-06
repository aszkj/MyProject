//
//  DLBrandModel.h
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/12/12.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "BaseModel.h"

@interface DLBrandModel : BaseModel
@property (nonatomic,strong)NSString *brandUrl;
@property (nonatomic,strong)NSString *brandName;
@property (nonatomic,strong)NSString *brandCode;


@end

@interface DLBrandModel(setBrandModel)

+ (NSArray*)objectBrandModelWithArr:(NSArray*)array;

@end
