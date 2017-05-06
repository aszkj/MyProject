//
//  DLReceiveTimeModel.m
//  YilidiBuyer
//
//  Created by yld on 16/5/18.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLReceiveTimeModel.h"

@implementation DLReceiveTimeModel

- (instancetype)initWithDefaultDataDic:(NSDictionary *)dic {
    
    self = [super initWithDefaultDataDic:dic];
    if (self) {
        self.receiveTimeId = dic[@"receiveTimeId"];
        self.startTime = dic[@"startDate"];
        self.endTime = dic[@"endDate"];
        self.receiveDate = dic[@"receiveDate"];
    }
    return self;
}

@end
@implementation DLReceiveTimeModel (objectGoodsModel)

+ (NSArray *)objectGoodsModelWithGoodsArr:(NSArray *)goodsArr
{
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:goodsArr.count];
    for (NSDictionary *dic in goodsArr) {
        DLReceiveTimeModel *model = [[DLReceiveTimeModel alloc] initWithDefaultDataDic:dic];
        [tempArr addObject:model];
    }
    
    return [tempArr copy];
}

- (NSString*)shipTimeStr {
    NSString *dateStr = nil;
    if (self.receiveDate.integerValue == 0) {
        dateStr = @"";
    }else if (self.receiveDate.integerValue == 1){
        dateStr = @"明天";
    }else{
        dateStr = @"后天";
    }

    return [NSString stringWithFormat:@"%@%@-%@",dateStr,self.startTime,self.endTime];

}
- (NSInteger)timeIntegerHourWithTimeStr:(NSString *)timeStr {
    NSString *tempStr = @"--";
    if (timeStr.length > 2) {
       tempStr = [timeStr substringToIndex:2];
    }
    return [tempStr integerValue];
}

- (NSInteger)timeIntegerMinuteWithTimeStr:(NSString *)timeStr {
    NSString *tempStr = @"--";
    if (timeStr.length > 2) {
        tempStr = [timeStr substringFromIndex:tempStr.length-2];
    }
    return [tempStr integerValue];


}



@end
