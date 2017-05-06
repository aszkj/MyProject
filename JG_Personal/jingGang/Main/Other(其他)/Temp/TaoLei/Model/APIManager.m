//
//  ApiManager.m
//  jingGang
//
//  Created by thinker on 15/8/12.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "APIManager.h"
#import "NSObject+MJExtension.h"

@interface APIManager ()

@end

@implementation APIManager

- (VApiManager *)vapiManager {
    if (_vapiManager == nil) {
        _vapiManager = [[VApiManager alloc] init];
    }
    return _vapiManager;
}

- (void)personalPayView:(NSNumber *)orderId {
    PersonalPayViewRequest *request = [[PersonalPayViewRequest alloc] init:GetToken];
    request.api_orderId = orderId;
    
    [self.vapiManager personalPayView:request success:^(AFHTTPRequestOperation *operation, PersonalPayViewResponse *response) {
        _successResponse = response;
        [self delegateResponseSuccess];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _error = error;
        [self delefateResponseFail];
    }];
}

- (void)orderRefund:(NSNumber *)orderId {
    PersonalOrderRefundRequest *request = [[PersonalOrderRefundRequest alloc] init:GetToken];
    request.api_orderId = orderId;
    
    [self.vapiManager personalOrderRefund:request success:^(AFHTTPRequestOperation *operation, PersonalOrderRefundResponse *response) {
        _successResponse = response;
        [self delegateResponseSuccess];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _error = error;
        [self delefateResponseFail];
    }];
}

- (void)merchantFindKeyword:(NSString *)keyword cityID:(NSNumber *)cityId areaId:(NSNumber *)areaId distance:(NSNumber *)distance orderType:(NSNumber *)orderType storeLat:(double)storeLat storeLon:(double)storeLon pageSize:(NSInteger)pageSize pageNum:(NSInteger)pageNum
{
    PersonalKeywordSearchRequest *request = [[PersonalKeywordSearchRequest alloc] init:GetToken];
    request.api_cityId = cityId;
    request.api_keyWord = keyword.copy;
    request.api_areaId = areaId;
    request.api_distance = distance;
    request.api_orderType = orderType;
    request.api_areaId = areaId;
    request.api_storeLat = @(storeLat);
    request.api_storeLon = @(storeLon);
    request.api_pageNum = @(pageNum);
    request.api_pageSize = @(pageSize);
    
    [self.vapiManager personalKeywordSearch:request success:^(AFHTTPRequestOperation *operation, PersonalKeywordSearchResponse *response) {
        _successResponse = response;
        [self delegateResponseSuccess];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _error = error;
        [self delefateResponseFail];
    }];
}

- (void)merchantFindClassId:(NSNumber *)classId cityID:(NSNumber *)cityId areaId:(NSNumber *)areaId distance:(NSNumber *)distance orderType:(NSNumber *)orderType storeLat:(double)storeLat storeLon:(double)storeLon pageSize:(NSInteger)pageSize pageNum:(NSInteger)pageNum {
    PersonalClassFindListRequest *request = [[PersonalClassFindListRequest alloc] init:GetToken];
    request.api_classId = classId;
    request.api_cityId = cityId;
    request.api_distance = distance;
    request.api_areaId = areaId;
    request.api_orderType = orderType;
    request.api_storeLat = @(storeLat);
    request.api_storeLon = @(storeLon);
    request.api_pageNum = @(pageNum);
    request.api_pageSize = @(pageSize);
    
    [self.vapiManager personalClassFindList:request success:^(AFHTTPRequestOperation *operation, PersonalClassFindListResponse *response) {
        _successResponse = response;
        [self delegateResponseSuccess];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _error = error;
        [self delefateResponseFail];
    }];
}

- (void)cancelPersonalCollection:(NSNumber *)fid type:(NSInteger)type {
    PersonalCancelRequest *request = [[PersonalCancelRequest alloc] init:GetToken];
    request.api_fid = fid;
    request.api_type = @(type);
    
    [self.vapiManager personalCancel:request success:^(AFHTTPRequestOperation *operation, PersonalCancelResponse *response) {
        _successResponse = response;
        [self delegateResponseSuccess];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _error = error;
        [self delefateResponseFail];
    }];
}

- (void)favServiceList:(NSInteger)pageSize pageNum:(NSInteger)pageNum {
    PersonalFavaGoodsListRequest *request = [[PersonalFavaGoodsListRequest alloc] init:GetToken];
    request.api_pageNum = @(pageNum);
    request.api_pageSize = @(pageSize);
    
    [self.vapiManager personalFavaGoodsList:request success:^(AFHTTPRequestOperation *operation, PersonalFavaGoodsListResponse *response) {
        _successResponse = response;
        [self delegateResponseSuccess];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _error = error;
        [self delefateResponseFail];
    }];
}

- (void)GroupAreaList:(long)areaId {
    PersonalAreaParentListRequest *request = [[PersonalAreaParentListRequest alloc] init:GetToken];
    request.api_areaId = @(areaId);
    
    [self.vapiManager personalAreaParentList:request success:^(AFHTTPRequestOperation *operation, PersonalAreaParentListResponse *response) {
        _successResponse = response;
        [self delegateResponseSuccess];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _error = error;
        [self delefateResponseFail];
    }];
}

- (void)requestO2ODataWithRet:(NSNumber *)ret withID:(NSNumber *)parentId
{
    GroupGroupClassListRequest *groupListRequest = [[GroupGroupClassListRequest alloc] init:GetToken];
    groupListRequest.api_ret = ret;
    groupListRequest.api_parentId = parentId;
    
    [self.vapiManager groupGroupClassList:groupListRequest success:^(AFHTTPRequestOperation *operation, GroupGroupClassListResponse *response) {
        _successResponse = response;
        [self delegateResponseSuccess];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _error = error;
        [self delefateResponseFail];
    }];
}

- (void)getPersonalGroupOrderStatus:(NSInteger)orderStatus pageSize:(NSInteger)pageSize pageNum:(NSInteger)pageNum {
    PersonalGroupOrderListRequest *request = [[PersonalGroupOrderListRequest alloc] init:GetToken];
    request.api_status = @(orderStatus);
    request.api_pageSize = @(pageSize);
    request.api_pageNum = @(pageNum);
    
    [self.vapiManager personalGroupOrderList:request success:^(AFHTTPRequestOperation *operation, PersonalGroupOrderListResponse *response) {
        _successResponse = response;
        [self delegateResponseSuccess];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _error = error;
        [self delefateResponseFail];
    }];
}

- (void)getGoodsDetail:(NSNumber *)goodsId
{
    GoodsDetailsRequest *request = [[GoodsDetailsRequest alloc] init:GetToken];
    request.api_goodsId = goodsId;
    
    [self.vapiManager goodsDetails:request success:^(AFHTTPRequestOperation *operation, GoodsDetailsResponse *response) {
        _successResponse = response;
        [self delegateResponseSuccess];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _error = error;
        [self delefateResponseFail];
    }];
}

- (void)getUsersIntegral
{
    UsersIntegralRequest *request = [[UsersIntegralRequest alloc] init:GetToken];
    
    [self.vapiManager usersIntegral:request success:^(AFHTTPRequestOperation *operation, UsersIntegralResponse *response) {
        _successResponse = response;
        [self delegateResponseSuccess];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _error = error;
        [self delefateResponseFail];
    }];
}

- (void)getPaymentView:(long)orderId
{
    ShopTradePaymetViewRequest *request = [[ShopTradePaymetViewRequest alloc] init:GetToken];
    request.api_id = @(orderId);
    
    [self.vapiManager shopTradePaymetView:request success:^(AFHTTPRequestOperation *operation, ShopTradePaymetViewResponse *response) {
        _successResponse = response;
        [self delegateResponseSuccess];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _error = error;
        [self delefateResponseFail];
    }];
}

- (void)getTransportCartIds:(NSString *)cartIds areaId:(NSNumber *)areaId
{
    ShopTransportGetRequest *request = [[ShopTransportGetRequest alloc] init:GetToken];
    request.api_areaId = areaId;
    request.api_cartIds = cartIds;
    
    [self.vapiManager shopTransportGet:request success:^(AFHTTPRequestOperation *operation, ShopTransportGetResponse *response) {
        _successResponse = response;
        [self delegateResponseSuccess];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _error = error;
        [self delefateResponseFail];
    }];
}

- (void)createOrder:(long)addrId transportIds:(NSDictionary *)transportDic msgs:(NSDictionary *)msgsDic
          couponIds:(NSDictionary *)couponDic integralIds:(NSString *)integralId gcIds:(NSString *)gcIds
{
    
    ShopTradeOrderCreateRequest *request = [[ShopTradeOrderCreateRequest alloc] init:GetToken];
    request.api_addrId = @(addrId);
    request.api_transportIds = [self DataTOjsonString:transportDic];
    request.api_msgs = [self DataTOjsonString:msgsDic];
    request.api_couponIds = [self DataTOjsonString:couponDic];
    request.api_integralIds = integralId;
    request.api_gcIds = gcIds;
    [self.vapiManager shopTradeOrderCreate:request success:^(AFHTTPRequestOperation *operation, ShopTradeOrderCreateResponse *response) {
        _successResponse = response;
        [self delegateResponseSuccess];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _error = error;
        [self delefateResponseFail];
    }];
}

- (void)confirmOrder:(NSString *)gcs {
    
    ShopCartGoodsDetailRequest *request = [[ShopCartGoodsDetailRequest alloc] init:GetToken];
    request.api_gcs = gcs;
    [self.vapiManager shopCartGoodsDetail:request success:^(AFHTTPRequestOperation *operation, ShopCartGoodsDetailResponse *response) {
        _successResponse = response;
        [self delegateResponseSuccess];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _error = error;
        [self delefateResponseFail];
    }];
    
}


- (void)buyNowWithGoodsId:(NSNumber *)goodsId
               goodsCount:(NSNumber *)goodsCount
                 goodsGsp:(NSString *)goodsGsp
{
    ShopBuyGoodsRequest *request = [[ShopBuyGoodsRequest alloc] init:GetToken];
    request.api_goodsId = goodsId;
    if (goodsGsp) {
        request.api_gsp = goodsGsp;
    }
    request.api_count = goodsCount;
    [self.vapiManager shopBuyGoods:request success:^(AFHTTPRequestOperation *operation, ShopBuyGoodsResponse *response) {
        _successResponse = response;
        [self delegateResponseSuccess];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _error = error;
        [self delefateResponseFail];
    }];
}

- (void)getOrderList:(NSString *)orderStatus pageNum:(NSNumber *)number
{
    
    
    SelfOrderListRequest *request = [[SelfOrderListRequest alloc] init:GetToken];
    request.api_orderStatus = orderStatus;
    request.api_pageSize = @(10);
    request.api_pageNum = number;
    [self.vapiManager selfOrderList:request success:^(AFHTTPRequestOperation *operation, SelfOrderListResponse *response) {
        _successResponse = response;
        [self delegateResponseSuccess];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _error = error;
        [self delefateResponseFail];
    }];
    
}

- (void)cancelOrder:(long)orderID stateInfo:(NSString *)cancelReason
{
    
    SelfOrderCancelRequest *request = [[SelfOrderCancelRequest alloc] init:GetToken];
    request.api_orderId = @(orderID);
    request.api_stateInfo = cancelReason;
    [self.vapiManager selfOrderCancel:request success:^(AFHTTPRequestOperation *operation, SelfOrderCancelResponse *response) {
        _successResponse = response;
        [self delegateResponseSuccess];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _error = error;
        [self delefateResponseFail];
    }];
}

- (void)confirmRecieve:(long)orderID
{
    SelfGoodsConfirmRequest *request = [[SelfGoodsConfirmRequest alloc] init:GetToken];
    request.api_orderId = @(orderID);
    
    [self.vapiManager selfGoodsConfirm:request success:^(AFHTTPRequestOperation *operation, SelfGoodsConfirmResponse *response) {
        _successResponse = response;
        [self delegateResponseSuccess];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _error = error;
        [self delefateResponseFail];
    }];
}

- (void)deleteOrder:(long)orderID
{
    SelfOrderDeleteRequest *request = [[SelfOrderDeleteRequest alloc] init:GetToken];
    request.api_orderId = @(orderID);
    
    [self.vapiManager selfOrderDelete:request success:^(AFHTTPRequestOperation *operation, SelfOrderDeleteResponse *response) {
        _successResponse = response;
        [self delegateResponseSuccess];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _error = error;
        [self delefateResponseFail];
    }];
}

- (void)getWuliuExpressCode:(NSString *)expressCode expressID:(NSNumber *)expressID
{
    ShopExpressTransViewRequest *request = [[ShopExpressTransViewRequest alloc] init:GetToken];
    request.api_expressCode = expressCode;
    request.api_expressCompanyId = expressID;
    
    [self.vapiManager shopExpressTransView:request success:^(AFHTTPRequestOperation *operation, ShopExpressTransViewResponse *response) {
        _successResponse = response;
        [self delegateResponseSuccess];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _error = error;
        [self delefateResponseFail];
    }];
}

- (void)getWuliuCompanyList
{
    ShopExpressCompanyListRequest *request = [[ShopExpressCompanyListRequest alloc] init:GetToken];
    
    [self.vapiManager shopExpressCompanyList:request success:^(AFHTTPRequestOperation *operation, ShopExpressCompanyListResponse *response) {
        _successResponse = response;
        [self delegateResponseSuccess];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _error = error;
        [self delefateResponseFail];
    }];
}

- (void)returnShipSave:(long)returnGoodsLogId expressId:(long)expressId expressCode:(NSString *)expressCode
{
    ShopTradeReturnShipSaveRequest *request = [[ShopTradeReturnShipSaveRequest alloc] init:GetToken];
    request.api_expressId = @(expressId);
    request.api_expressCode = expressCode;
    request.api_returnGoodsLogId = @(returnGoodsLogId);
    
    [self.vapiManager shopTradeReturnShipSave:request success:^(AFHTTPRequestOperation *operation, ShopTradeReturnShipSaveResponse *response) {
        _successResponse = response;
        [self delegateResponseSuccess];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _error = error;
        [self delefateResponseFail];
    }];
}

- (void)applyRetuanOrderID:(long)orderId returnReason:(NSString *)reason goodsID:(long)goodsID goodsGspIds:(NSString *)gspIds
{
    ShopTradeReturnApplyRequest *request = [[ShopTradeReturnApplyRequest alloc] init:GetToken];
    request.api_orderId = @(orderId);
    request.api_returnGoodsContent = reason;
    request.api_goodsId = @(goodsID);
    request.api_goodsGspIds = gspIds;
    
    [self.vapiManager shopTradeReturnApply:request success:^(AFHTTPRequestOperation *operation, ShopTradeReturnApplyResponse *response) {
        _successResponse = response;
        [self delegateResponseSuccess];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _error = error;
        [self delefateResponseFail];
    }];
}
- (void)getReturnList:(NSInteger)pageNum
{
    ShopTradeReturnListRequest *request = [[ShopTradeReturnListRequest alloc] init:GetToken];
    request.api_pageNum = @(pageNum);
    request.api_pageSize = @(10);
    
    [self.vapiManager shopTradeReturnList:request success:^(AFHTTPRequestOperation *operation, ShopTradeReturnListResponse *response) {
        _successResponse = response;
        [self delegateResponseSuccess];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _error = error;
        [self delefateResponseFail];
    }];
}

- (void)cancelReturnOrderID:(long)orderID goodsID:(long)goodsID goodsGspIds:(NSString *)gspIds
{
    ShopTradeReturnCancelRequest *request = [[ShopTradeReturnCancelRequest alloc] init:GetToken];
    request.api_orderId = @(orderID);
    request.api_goodsId = @(goodsID);
    request.api_goodsGspIds = gspIds;
    
    [self.vapiManager shopTradeReturnCancel:request success:^(AFHTTPRequestOperation *operation, ShopTradeReturnCancelResponse *response) {
        _successResponse = response;
        [self delegateResponseSuccess];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _error = error;
        [self delefateResponseFail];
    }];
}


- (void)getDefaultAddress {
    ShopUserAddressAllRequest *request = [[ShopUserAddressAllRequest alloc] init:GetToken];
    request.api_def = [NSNumber numberWithBool:NO];
    
    [self.vapiManager shopUserAddressAll:request success:^(AFHTTPRequestOperation *operation, ShopUserAddressAllResponse *response) {
        
        for (NSInteger i = 0; i < response.userAddressAll.count; i++) {
            NSDictionary *dict = response.userAddressAll[i];
            if ([[dict objectForKey:@"defaultVal"] boolValue] == YES) {
                _successResponse = dict;
            }
        }
        if (self.successResponse == nil) {
            _successResponse = response.userAddressAll.firstObject;
        }

        if ([self.delegate respondsToSelector:@selector(apiManagerDidSuccess:)]) {
            [self.delegate apiManagerDidSuccess:self];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _error = error;
        if ([self.delegate respondsToSelector:@selector(apiManagerDidFail:)]) {
            [self.delegate apiManagerDidFail:self];
        }
    }];

}


- (void)getShopUserAddressAll:(BOOL)needAddressAll {
    
    ShopUserAddressAllRequest *request = [[ShopUserAddressAllRequest alloc] init:GetToken];
    request.api_def = [NSNumber numberWithBool:needAddressAll];
    
    [self.vapiManager shopUserAddressAll:request success:^(AFHTTPRequestOperation *operation, ShopUserAddressAllResponse *response) {
        
        _successResponse = response.userAddressAll;
        
        if ([self.delegate respondsToSelector:@selector(apiManagerDidSuccess:)]) {
            [self.delegate apiManagerDidSuccess:self];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _error = error;
        if ([self.delegate respondsToSelector:@selector(apiManagerDidFail:)]) {
            [self.delegate apiManagerDidFail:self];
        }
        
        NSLog(@"cheshi --error-- %@",error);
        if (-1009 == [error code]) {
            NSLog(@"网络连接断开");
        }
    }];
    
    
}


- (void)delegateResponseSuccess {
    if ([self.delegate respondsToSelector:@selector(apiManagerDidSuccess:)]) {
        [self.delegate apiManagerDidSuccess:self];
    }
}

- (void)delefateResponseFail {
    if ([self.delegate respondsToSelector:@selector(apiManagerDidFail:)]) {
        [self.delegate apiManagerDidFail:self];
    }
}

- (NSDictionary *)fetchAddressDataWithReformer:(id<AddressReformerProtocol>)reformer withOrderListDic:(NSDictionary *)orderListDic{
    if (reformer == nil) {
        return self.successResponse;
    } else {
//        ShopCartGoodsDetailResponse *response = self.successResponse;
//        NSDictionary *orderListDic = ((NSDictionary *)response.orderList);
        if (orderListDic[@"shopUserAddress"] == nil) {
            return nil;
        }
        return [reformer getAddressfromData:orderListDic[@"shopUserAddress"] fromManager:self];
    }
}


+ (NSString *)DataTOjsonString:(id)object {
    NSString *jsonString = nil;
    NSError *error;
    if (object == nil) {
        return jsonString;
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

- (NSString *)DataTOjsonString:(id)object
{
    return [[self class] DataTOjsonString:object];
}

- (id)initWithDelegate:(NSObject <APIManagerDelegate> *)delegate
{
    if (self = [super init]) {
        self.delegate = delegate;
    }
    
    return self;
}

@end
