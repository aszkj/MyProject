//
//  DLVouchersModel.h
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/10/24.
//  Copyright © 2016年 yld. All rights reserved.
//


#import "DLOrdertailsModel.h"

@interface DLVouchersModel : DLOrdertailsModel
@property (nonatomic,strong)NSNumber *ticketAmount;
@property (nonatomic,strong)NSString *useScope;
@property (nonatomic,strong)NSString *ticketDescription;
@property (nonatomic,strong)NSString *ticketStatusName;
@property (nonatomic,strong)NSString *limit;
@property (nonatomic,strong)NSString *isValidity;
@property (nonatomic,strong)NSString *couponType;
@property (nonatomic,strong)NSNumber *ticketType;
@end

@interface DLVouchersModel (setVouchersModel)
+ (NSArray*)objectVouchersModelWithArr:(NSArray*)array  isValidity:(NSString*)validity;

@end
