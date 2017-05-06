//
//  DLNeartyAdressModel.h
//  YilidiBuyer
//
//  Created by yld on 16/4/28.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "BaseModel.h"

@interface DLNeartyAdressModel : BaseModel

@property (nonatomic,copy)NSString *mainAdress;

@property (nonatomic,copy)NSString *detailAdress;

@property (nonatomic,copy)NSString *regionPath;

@property (nonatomic,strong)NSNumber *distance;

@end
