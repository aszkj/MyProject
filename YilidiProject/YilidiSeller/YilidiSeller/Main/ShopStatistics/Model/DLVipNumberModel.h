//
//  DLVipNumberModel.h
//  YilidiSeller
//
//  Created by yld on 16/6/1.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "BaseModel.h"

@interface DLVipNumberModel : BaseModel
@property (nonatomic,strong)NSString *date;//时间
@property (nonatomic,strong)NSNumber *registerNumber;//邀请数
@property (nonatomic,strong)NSNumber *vipNumber;//会员VIP数量

@end

@interface DLVipNumberModel (vipNumberModel)

+ (NSArray *)objectWithVipNumberModelArray:(NSArray *)array;

@end