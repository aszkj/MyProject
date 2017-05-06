//
//  DLNearChannelModel.h
//  YilidiBuyer
//
//  Created by yld on 16/5/9.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "BaseModel.h"

@interface DLNearChannelModel : BaseModel
@property (nonatomic,copy)NSString *selltype;
@property (nonatomic,copy)NSString *selltypeName;
@property (nonatomic,copy)NSNumber *shopId;
@property (nonatomic,copy)NSString *shopName;
@property (nonatomic,strong)NSString *shopImgUrl;
@property (nonatomic,strong)NSString *shopKey;
@property (nonatomic,strong)NSDictionary *dic;


@end
