//
//  PropertyListReformerKeys.h
//  jingGang
//
//  Created by thinker on 15/8/4.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#ifndef jingGang_PropertyListReformerKeys_h
#define jingGang_PropertyListReformerKeys_h

extern NSString * const shopDataKeyName;
extern NSString * const shopDataKeyLogo;
extern NSString * const shopDataKeyType;

/**
 *  收货的地址的相关键值
 */
extern NSString * const addressKeyUsrName;
extern NSString * const addressKeyUsrPhone;
extern NSString * const addressKeyAddressDetail;
extern NSString * const addressKeyAddressID;

/**
 *  订单的相关键值
 */
extern NSString * const orderKeyID;
extern NSString * const orderKeyOrderID;
extern NSString * const orderKeyStatus;
extern NSString * const orderKeyGoodsCount;
extern NSString * const orderKeyTotalPrice;
extern NSString * const orderKeyTransPrice;
extern NSString * const orderKeyReceiverName;
extern NSString * const orderKeyGoodsImageUrlArray;

/**
 *  物流的相关键值
 */
extern NSString * const transKeyCompanyID;
extern NSString * const transKeyShipCodeID;

/**
 *  退货相关键值
 */
extern NSString * const returnGoodsKeyGoodsName;
extern NSString * const returnGoodsKeyStatus;
extern NSString * const returnGoodsKeyImagePath;
extern NSString * const returnGoodsKeyOrderId;
extern NSString * const returnGoodsKeyGoodsId;
extern NSString * const returnGoodsKeyGoodsGspIds;
extern NSString * const returnGoodsKeyReason;
extern NSString * const returnGoodsKeyselfAddress;
extern NSString * const returnGoodsKeyLogId;

#endif
