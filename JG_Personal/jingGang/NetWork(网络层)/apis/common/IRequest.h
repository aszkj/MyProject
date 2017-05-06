//
//  IRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

typedef enum : NSUInteger {
    NetWork_Online,         //线上baseUrl
    NetWork_Inline,         //先下baseUrl
    NetWork_Develop,        //开发环境
}NetType;                   //网络环境

@interface AbstractRequest: NSObject
- (instancetype) init : (NSString *) token;
@property (nonatomic, readwrite, copy) NSString *accessToken;
@property (nonatomic, strong, readwrite) Class responseClazz;
@property (nonatomic, strong, readwrite) NSString *url;
@property (nonatomic, retain) NSMutableDictionary *headers;
@property (nonatomic, retain) NSMutableDictionary *queryParameters;
@property (nonatomic, retain) NSMutableDictionary *pathParameters;
//网络环境
@property (nonatomic, assign)NetType netType;
//baseUrl
@property (nonatomic, copy)NSString *baseUrl;

- (NSString *) getToken;
- (Class) getResponseClazz;
- (NSString *) getUrl;
- (NSString *) getApiUrl;
- (NSMutableDictionary *) getHeaders;
- (NSMutableDictionary *) getQueryParameters;
- (NSMutableDictionary *) getPathParameters;
- (NSString*)expandPath:(NSString*)path withURIVariablesArray:(NSArray*)URIVariables;
- (NSString*)expandPath:(NSString*)path withURIVariableDict:(NSDictionary*)URIVariables;


@end
