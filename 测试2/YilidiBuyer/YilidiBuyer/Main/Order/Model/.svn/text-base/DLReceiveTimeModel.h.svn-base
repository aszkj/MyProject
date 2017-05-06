//
//  DLReceiveTimeModel.h
//  YilidiBuyer
//
//  Created by yld on 16/5/18.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "BaseModel.h"

@interface DLReceiveTimeModel : BaseModel

@property (nonatomic,strong)NSNumber *receiveTimeId;

@property (nonatomic,copy)NSString *startTime;

@property (nonatomic,copy)NSString *endTime;

/**
 *  0 - 今天 1 － 明天  2 － 后天
 */
@property (nonatomic,strong)NSNumber *receiveDate;


@end
@interface DLReceiveTimeModel (objectGoodsModel)

+ (NSArray *)objectGoodsModelWithGoodsArr:(NSArray *)goodsArr;

- (NSString*)shipTimeStr;

- (NSInteger)timeIntegerHourWithTimeStr:(NSString *)timeStr;

- (NSInteger)timeIntegerMinuteWithTimeStr:(NSString *)timeStr;


@end
