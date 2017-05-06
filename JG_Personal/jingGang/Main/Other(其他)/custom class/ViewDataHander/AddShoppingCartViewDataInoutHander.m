//
//  AddShoppingCartViewDataInoutHander.m
//  jingGang
//
//  Created by 张康健 on 15/8/12.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "AddShoppingCartViewDataInoutHander.h"
#import "GoodsSquModel.h"

@interface AddShoppingCartViewDataInoutHander()

//商品squ数组，属性选择完之后，会用到
@property (nonatomic,copy)NSArray *squArr;


@end

@implementation AddShoppingCartViewDataInoutHander

-(id)init{
    
    
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(id)initWithGoodsDetailModel:(GoodsDetailModel *)goodsDetailModel{
    
    self = [super init];
    if (self ) {
        _goodsDetailModel = goodsDetailModel;
        
#pragma 根据model生成需要的规格属性字典
        //赋值商品squ数组，
        _squArr = goodsDetailModel.detail;
        
        //规格数组
        if (!goodsDetailModel.cationList.count) {
            return self;
        }
        NSArray *goodsCationArr = goodsDetailModel.cationList;
        //商品规格以及其属性字典,以规格名字为key,每个规格的所有属性list为value
        _cationPropertyMutableDic = [NSMutableDictionary dictionaryWithCapacity:goodsCationArr.count];
        for (NSDictionary *dic in goodsCationArr) {
            NSString *cationNameKey = dic[@"name"];
            if (!_cationPropertyMutableDic[cationNameKey]) {//如果该key的value没有，创建
                NSMutableArray *propertyArr = [NSMutableArray arrayWithCapacity:0];
                [_cationPropertyMutableDic setObject:propertyArr forKey:cationNameKey];
            }
        }
        
        //处理商品属性列表，将其按规格进行归类
        if (!goodsDetailModel.ficPropertyList.count) {
            return self;
        }
        NSArray *propertyArr = goodsDetailModel.ficPropertyList;
        for (NSDictionary *propertyDic in propertyArr) {
            //拿出属性的规格名称
            NSString *propertyCationName = [propertyDic[@"spec"] objectForKey:@"name"];
            //遍历规格key数组，找到该属性对应的规格
            for (NSString *cationName in [_cationPropertyMutableDic allKeys]) {
                if ([propertyCationName isEqualToString:cationName]) {//找到了
                    NSMutableArray *propertyArr = _cationPropertyMutableDic[propertyCationName];
                    [propertyArr addObject:propertyDic];
                    break;
                }
                
            }
            
        }
        
    }
    return self;
}

-(void)setGoodsDetailModel:(GoodsDetailModel *)goodsDetailModel{
    _goodsDetailModel = goodsDetailModel;
}

#pragma mark - 设置属性数组 生成squ价格
-(void)setSelectedPropertyIdArr:(NSArray *)selectedPropertyIdArr{
    _selectedPropertyIdArr = selectedPropertyIdArr;
    
    //得到商品的squ价格
    _squPrice = [self _getGoodsPripriceWithSelectedPropertyIdArr:_selectedPropertyIdArr];
    
    //得到属性id字符串
    _selectedPropertyIdStr = [_selectedPropertyIdArr componentsJoinedByString:@","];
    
}


-(CGFloat )_getGoodsPripriceWithSelectedPropertyIdArr:(NSArray *)propertyIdArr{
    
    //先排序,从大到小
//    NSArray *sortedArr = [propertyIdArr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//        return [obj2 compare:obj1];
//    }];
//    
//    NSString *lineSortedStr = [sortedArr componentsJoinedByString:@"_"];
//    NSString *needStr = [NSString stringWithFormat:@"%@_",lineSortedStr];
    
    //从大到小生成
    NSString *needStr = [self getFromBigToSmallStrOfArr:propertyIdArr];
    //遍历squ数组，找到它对应的价格
    CGFloat price = 0.0;
    NSLog(@"need str ----%@",needStr);
    NSLog(@"squ -----%@",_squArr);
    BOOL finded = NO;
    for (NSDictionary *dicSu in _squArr) {
        if ([needStr isEqualToString:dicSu[@"id"]]) {
            _goodsSquModel = [[GoodsSquModel alloc] initWithJSONDic:dicSu];
            price = _goodsSquModel.actualPrice.floatValue;
            finded = YES;
            break;
        }
    }
    
    if (!finded) {
        //从小到大生成
        NSString *needStr = [self getFromSmallToBigStrOfArr:propertyIdArr];
        for (NSDictionary *dicSu in _squArr) {
            if ([needStr isEqualToString:dicSu[@"id"]]) {
                _goodsSquModel = [[GoodsSquModel alloc] initWithJSONDic:dicSu];
                price = _goodsSquModel.actualPrice.floatValue;
                break;
            }
        }
    }
    
    return price;
}


#pragma mark - 得到从大到小str
-(NSString *)getFromBigToSmallStrOfArr:(NSArray *)propertyIdArr {

    //先排序,从大到小
    NSArray *sortedArr = [propertyIdArr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj2 compare:obj1];
    }];
    
    NSString *lineSortedStr = [sortedArr componentsJoinedByString:@"_"];
    NSString *needStr = [NSString stringWithFormat:@"%@_",lineSortedStr];
    
    return needStr;
}


#pragma mark - 得到从小到大str
-(NSString *)getFromSmallToBigStrOfArr:(NSArray *)propertyIdArr {
    
    //先排序,从大到小
    NSArray *sortedArr = [propertyIdArr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
    
    NSString *lineSortedStr = [sortedArr componentsJoinedByString:@"_"];
    NSString *needStr = [NSString stringWithFormat:@"%@_",lineSortedStr];
    
    return needStr;
}





-(CGFloat)goodsActualPrice{
    
    //有积分兑换价
    if ([self.goodsDetailModel.hasExchangeIntegral integerValue]) {
        _goodsActualPrice = [self.goodsDetailModel.goodsIntegralPrice floatValue];
    }else if ([self.goodsDetailModel.hasMobilePrice integerValue]){//有手机专享价
        _goodsActualPrice = [self.goodsDetailModel.goodsMobilePrice floatValue];
        
    }else{
        _goodsActualPrice = self.goodsDetailModel.goodsCurrentPrice.floatValue;
    }
    
    return _goodsActualPrice;
}




@end
