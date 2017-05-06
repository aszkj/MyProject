//
//  NLSwipeResult.h
//  MTypeSDK
//
//  Created by su on 13-6-30.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NLSwipeResultType.h"
#import "NLAccount.h"
/*!
 @class
 @abstract 刷卡器刷卡结果
 @discussion
 */
@interface NLSwipeResult : NSObject
@property (nonatomic, readonly) NLSwipeResultType rsltType;
@property (nonatomic, strong, readonly) NLAccount *account;
@property (nonatomic, strong, readonly) NSArray *readModels;
@property (nonatomic, copy, readonly) NSData *firstTrackData;
@property (nonatomic, copy, readonly) NSData *secondTrackData;
@property (nonatomic, copy, readonly) NSData *thirdTrackData;
@property (nonatomic, copy, readonly) NSData *trackDatas;
@property (nonatomic, copy, readonly) NSString *validDate;
@property (nonatomic, copy, readonly) NSString *serviceCode;
@property (nonatomic, copy, readonly) NSData *ksn;
@property (nonatomic, copy, readonly) NSData *extInfo;

/*!
 @method
 @abstract 构造一个刷卡失败的事件
 @discussion
 */
- (id)initWithRsltType:(NLSwipeResultType)rsltType;
/*!
 @method
 @abstract 构造一个刷卡成功的事件
 @discussion
 */
- (id)initWithAccount:(NLAccount*)account
           readModels:(NSArray*)readModels
       firstTrackData:(NSData*)firstTrackData
      secondTrackData:(NSData*)secondTrackData
       thirdTrackData:(NSData*)thirdTrackData;

- (id)initWithAccount:(NLAccount*)account
           readModels:(NSArray*)readModels
       firstTrackData:(NSData*)firstTrackData
      secondTrackData:(NSData*)secondTrackData
       thirdTrackData:(NSData*)thirdTrackData
           trackDatas:(NSData*)trackDatas;

- (id)initWithAccount:(NLAccount*)account
           readModels:(NSArray*)readModels
       firstTrackData:(NSData*)firstTrackData
      secondTrackData:(NSData*)secondTrackData
       thirdTrackData:(NSData*)thirdTrackData
           trackDatas:(NSData*)trackDatas
            validDate:(NSString*)validDate
          serviceCode:(NSString*)serviceCode
                  ksn:(NSData*)ksn
              extInfo:(NSData*)extInfo;

@end