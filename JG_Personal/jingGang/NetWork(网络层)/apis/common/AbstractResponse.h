//
//  AbstractResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-19.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface AbstractResponse :  MTLModel <MTLJSONSerializing>
@property (nonatomic, readonly, copy) NSString *errorCode;
@property (nonatomic, readonly, copy) NSString *msg;
@property (nonatomic, readonly, copy) NSString *subCode;
@property (nonatomic, readonly, copy) NSString *subMsg;

@end
