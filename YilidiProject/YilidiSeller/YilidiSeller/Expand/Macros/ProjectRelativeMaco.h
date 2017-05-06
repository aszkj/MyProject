//
//  ProjectRelativeMaco.h
//  YilidiSeller
//
//  Created by yld on 16/3/26.
//  Copyright © 2016年 Dellidc. All rights reserved.
//
//放项目相关宏
#pragma mark - 工程中用的宏

#ifndef ProjectRelativeMaco_h
#define ProjectRelativeMaco_h

#import "Util.h"
//保留两位小数,不带元
#define kNumberToStrRemain2Point(number) [NSString stringWithFormat:@"%.2f",number.doubleValue]
//带元
#define kNumberToStrRemain2PointRMB(number) [NSString stringWithFormat:@"价格：¥%@",kNumberToStrRemain2Point(number)]
#define kNumberToStrRemain2PointRMBWithOutPrice(number) [NSString stringWithFormat:@"¥%@",kNumberToStrRemain2Point(number)]
#define kPriceFloatValueToRMB(price)  [Util toRMBValueOfFloatValue:price]

#define kBuyGoodsNumber(goodsNumber) [NSString stringWithFormat:@"x%ld",goodsNumber.integerValue]
#define kStockNumber(stockNumber)    [NSString stringWithFormat:@"库存：X%ld",stockNumber.integerValue]

#define UrlWithStr(urlStr) [NSURL URLWithString:urlStr]

#define regionFilePath [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/region.plist"]
#define rootController  [UIApplication sharedApplication].keyWindow.rootViewController
#define MakeUIEdgeInset(top,left,bottom,right) UIEdgeInsetsMake(top, left, bottom, right)


#define kRMBPriceStrWithPrice(price,rmbFontSize,priceFontSize) [Util toAttributeRMBfOfValue:price RMBTextFont:[UIFont systemFontOfSize:rmbFontSize] zhengshuPartFont:[UIFont systemFontOfSize:priceFontSize]]
#define kDefaultRMBStrWithPrice(price) kRMBPriceStrWithPrice(price,12,14)



#endif /* ProjectRelativeMaco_h */
