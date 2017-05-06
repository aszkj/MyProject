//
//  ApiManager.h
//  jingGang
//
//  Created by thinker on 15/8/12.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VApiManager.h"
#import "GlobeObject.h"

typedef void(^DataCenterBlock)(NSArray *responseData);
typedef void(^FailDataCenterBlock)(NSError *error);

@class APIManager;
@protocol APIManagerDelegate

- (void)apiManagerDidSuccess:(APIManager *)manager;
- (void)apiManagerDidFail:(APIManager *)manager;

@end

@protocol AddressReformerProtocol <NSObject>

- (NSDictionary *)getAddressfromData:(NSArray *)originData fromManager:(APIManager *)manager;
@end

@interface APIManager : NSObject

@property (nonatomic) VApiManager *vapiManager;
@property (nonatomic, weak    ) NSObject <APIManagerDelegate> *delegate;
@property (nonatomic, readonly) id                 successResponse;
@property (nonatomic, readonly) NSError            *error;
@property (nonatomic) NSString *name;

- (id)initWithDelegate:(NSObject <APIManagerDelegate> *)delegate;

/**
 *  获取用户云币
 */
- (void)getUsersIntegral;

/**
 *  发起申请退货请求
 *
 */
- (void)applyRetuanOrderID:(long)orderId
              returnReason:(NSString *)reason
                   goodsID:(long)goodsID
               goodsGspIds:(NSString *)gspIds;
/**
 *  获取商品退货记录列表
 *
 */
- (void)getReturnList:(NSInteger)pageNum;
/**
 *  订单退货取消
 */
- (void)cancelReturnOrderID:(long)orderID
                    goodsID:(long)goodsID
                goodsGspIds:(NSString *)gspIds;


- (void)getDefaultAddress;
- (void)getOrderList:(NSString *)orderStatus pageNum:(NSNumber *)number;
- (void)cancelOrder:(long)orderID stateInfo:(NSString *)cancelReason;
- (void)deleteOrder:(long)orderID;
- (void)confirmRecieve:(long)orderID;

- (void)confirmOrder:(NSString *)gcs;
- (void)buyNowWithGoodsId:(NSNumber *)goodsId
               goodsCount:(NSNumber *)goodsCount
                 goodsGsp:(NSString *)goodsGsp;
- (void)createOrder:(long)addrId
       transportIds:(NSDictionary *)transportDic
               msgs:(NSDictionary *)msgsDic
          couponIds:(NSDictionary *)couponDic
        integralIds:(NSString *)integralId
              gcIds:(NSString *)gcIds;

- (void)getPaymentView:(long)orderId;

- (void)getTransportCartIds:(NSString *)cartIds areaId:(NSNumber *)areaId;
/**
 *  获取个人线上订单列表
 */
- (void)getPersonalGroupOrderStatus:(NSInteger)orderStatus pageSize:(NSInteger)pageSize pageNum:(NSInteger)pageNum;

/**
 *  获取商品详情
 *
 *  @param goodsId 商品id
 */
- (void)getGoodsDetail:(NSNumber *)goodsId;
/**
 *  获取详细物流信息
 *
 *  @param expressCode 物流号
 *  @param expressID   物流公司id
 */
- (void)getWuliuExpressCode:(NSString *)expressCode expressID:(NSNumber *)expressID;
/**
 *  查找可用快递公司列表
 */
- (void)getWuliuCompanyList;
/**
 *  保存货物流信息
 *
 *  @param returnGoodsLogId 退货记录id
 *  @param expressId        物流公司id
 *  @param expressCode      物流单号
 */
- (void)returnShipSave:(long)returnGoodsLogId expressId:(long)expressId expressCode:(NSString *)expressCode;
/**
 *  关键字收索商户
 *
 *  @param keyword  关键字
 *  @param cityId   城市ID
 */
- (void)merchantFindKeyword:(NSString *)keyword cityID:(NSNumber *)cityId areaId:(NSNumber *)areaId distance:(NSNumber *)distance orderType:(NSNumber *)orderType storeLat:(double)storeLat storeLon:(double)storeLon pageSize:(NSInteger)pageSize pageNum:(NSInteger)pageNum;
/**
 *  寻找指定类型的商户
 *
 *  @param classId   分类ID
 *  @param cityId    城市ID
 *  @param areaId    地区ID
 *  @param distance  距离|米
 *  @param orderType 智能排序类型
 *  @param storeLat  纬度
 *  @param storeLon  经度
 *  @param pageSize  每页个数
 *  @param pageNum   页数
 */
- (void)merchantFindClassId:(NSNumber *)classId cityID:(NSNumber *)cityId areaId:(NSNumber *)areaId distance:(NSNumber *)distance orderType:(NSNumber *)orderType storeLat:(double)storeLat storeLon:(double)storeLon pageSize:(NSInteger)pageSize pageNum:(NSInteger)pageNum;
/**
 *  获取当前城市的子区
 *
 *  @param areaId 当前城市的ID
 */
- (void)GroupAreaList:(long)areaId;

/**
 *  获取收藏服务列表
 */
- (void)favServiceList:(NSInteger)pageSize pageNum:(NSInteger)pageNum;
/**
 *  取消线下服务订单
 *
 *  @param orderId 订单ID
 */
- (void)orderRefund:(NSNumber *)orderId;
/**
 *  订单支付需要的详情
 *
 *  @param orderId 订单ID
 */
- (void)personalPayView:(NSNumber *)orderId;
/**
 *  取消收藏的4商店5服务6商户
 *
 */
- (void)cancelPersonalCollection:(NSNumber *)fid type:(NSInteger)type;

- (void)requestO2ODataWithRet:(NSNumber *)ret withID:(NSNumber *)parentId;


- (NSDictionary *)fetchAddressDataWithReformer:(id<AddressReformerProtocol>)reformer withOrderListDic:(NSDictionary *)orderListDic;

/**
 *  将数组或是字典转换为Jason字符串
 *
 *  @param object 需要转换的字典或是数组
 *
 *  @return Jason字符串
 */
- (NSString *)DataTOjsonString:(id)object;
+ (NSString *)DataTOjsonString:(id)object;

@end
