#import "WEMEFeedcontrollerApi.h"
#import "WEMEQueryParamCollection.h"
#import "WEMEPageResponseOfFeed.h"
#import "WEMEPageResponseOfReply.h"
#import "WEMESingleObjectValueResponseOfFeed.h"
#import "WEMEFeedRequest.h"
#import "WEMEPageResponseOfMongoMessage.h"
#import "WEMEPageResponseOfSimpleFeed.h"
#import "WEMESimpleResponse.h"


@interface WEMEFeedcontrollerApi ()
    @property (readwrite, nonatomic, strong) NSMutableDictionary *defaultHeaders;
@end

@implementation WEMEFeedcontrollerApi

static WEMEFeedcontrollerApi* singletonAPI = nil;

#pragma mark - Initialize methods

- (id) init {
    self = [super init];
    if (self) {
        WEMEConfiguration *config = [WEMEConfiguration sharedConfig];
        if (config.apiClient == nil) {
            config.apiClient = [[WEMEApiClient alloc] init];
        }
        self.apiClient = config.apiClient;
        self.defaultHeaders = [NSMutableDictionary dictionary];
    }
    return self;
}

- (id) initWithApiClient:(WEMEApiClient *)apiClient {
    self = [super init];
    if (self) {
        self.apiClient = apiClient;
        self.defaultHeaders = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark -

+(WEMEFeedcontrollerApi*) apiWithHeader:(NSString*)headerValue key:(NSString*)key {

    if (singletonAPI == nil) {
        singletonAPI = [[WEMEFeedcontrollerApi alloc] init];
        [singletonAPI addHeader:headerValue forKey:key];
    }
    return singletonAPI;
}

+(WEMEFeedcontrollerApi*) sharedAPI {

    if (singletonAPI == nil) {
        singletonAPI = [[WEMEFeedcontrollerApi alloc] init];
    }
    return singletonAPI;
}

-(void) addHeader:(NSString*)value forKey:(NSString*)key {
    [self.defaultHeaders setValue:value forKey:key];
}

-(void) setHeaderValue:(NSString*) value
           forKey:(NSString*)key {
    [self.defaultHeaders setValue:value forKey:key];
}

-(unsigned long) requestQueueSize {
    return [WEMEApiClient requestQueueSize];
}

#pragma mark - Api Methods

///
/// 本人发布的信息
/// 根据本地收到的最新的时间拉取更新信息.<br/> 用户级别
///  @param lastupdate lastupdate
///
///  @param page page
///
///  @param datesearch datesearch
///
///  @returns WEMEPageResponseOfFeed*
///
-(NSNumber*) myFeedUsingGETWithCompletionBlock: (NSNumber*) lastupdate
         page: (NSNumber*) page
         datesearch: (NSNumber*) datesearch
        
        completionHandler: (void (^)(WEMEPageResponseOfFeed* output, NSError* error))completionBlock { 
        

    
    // verify the required parameter 'lastupdate' is set
    if (lastupdate == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `lastupdate` when calling `myFeedUsingGET`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/api/feed/myFeed"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if (lastupdate != nil) {
        
        queryParams[@"lastupdate"] = lastupdate;
    }
    if (page != nil) {
        
        queryParams[@"page"] = page;
    }
    if (datesearch != nil) {
        
        queryParams[@"datesearch"] = datesearch;
    }
    
    NSMutableDictionary* headerParams = [NSMutableDictionary dictionaryWithDictionary:self.defaultHeaders];

    

    // HTTP header `Accept`
    headerParams[@"Accept"] = [WEMEApiClient selectHeaderAccept:@[@"application/json"]];
    if ([headerParams[@"Accept"] length] == 0) {
        [headerParams removeObjectForKey:@"Accept"];
    }

    // response content type
    NSString *responseContentType;
    if ([headerParams objectForKey:@"Accept"]) {
        responseContentType = [headerParams[@"Accept"] componentsSeparatedByString:@", "][0];
    }
    else {
        responseContentType = @"";
    }

    // request content type
    NSString *requestContentType = [WEMEApiClient selectHeaderContentType:@[@"application/json"]];

    // Authentication setting
    NSArray *authSettings = @[@"oauth2-clientcredentials"];

    id bodyParam = nil;
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *files = [[NSMutableDictionary alloc] init];
    
    
    

    
    return [self.apiClient requestWithCompletionBlock: resourcePath
                                               method: @"GET"
                                           pathParams: pathParams
                                          queryParams: queryParams
                                           formParams: formParams
                                                files: files
                                                 body: bodyParam
                                         headerParams: headerParams
                                         authSettings: authSettings
                                   requestContentType: requestContentType
                                  responseContentType: responseContentType
                                         responseType: @"WEMEPageResponseOfFeed*"
                                      completionBlock: ^(id data, NSError *error) {
                  
                  completionBlock((WEMEPageResponseOfFeed*)data, error);
              }
          ];
}

///
/// 本人发布的信息
/// 根据本地收到的最新的时间拉取更新信息.<br/> 用户级别
///  @param fid fid
///
///  @param lastupdate lastupdate
///
///  @param page page
///
///  @returns WEMEPageResponseOfReply*
///
-(NSNumber*) myFeedRepliesUsingGETWithCompletionBlock: (NSString*) fid
         lastupdate: (NSNumber*) lastupdate
         page: (NSNumber*) page
        
        completionHandler: (void (^)(WEMEPageResponseOfReply* output, NSError* error))completionBlock { 
        

    
    // verify the required parameter 'fid' is set
    if (fid == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `fid` when calling `myFeedRepliesUsingGET`"];
    }
    
    // verify the required parameter 'lastupdate' is set
    if (lastupdate == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `lastupdate` when calling `myFeedRepliesUsingGET`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/api/feed/myFeedReply"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if (fid != nil) {
        
        queryParams[@"fid"] = fid;
    }
    if (lastupdate != nil) {
        
        queryParams[@"lastupdate"] = lastupdate;
    }
    if (page != nil) {
        
        queryParams[@"page"] = page;
    }
    
    NSMutableDictionary* headerParams = [NSMutableDictionary dictionaryWithDictionary:self.defaultHeaders];

    

    // HTTP header `Accept`
    headerParams[@"Accept"] = [WEMEApiClient selectHeaderAccept:@[@"application/json"]];
    if ([headerParams[@"Accept"] length] == 0) {
        [headerParams removeObjectForKey:@"Accept"];
    }

    // response content type
    NSString *responseContentType;
    if ([headerParams objectForKey:@"Accept"]) {
        responseContentType = [headerParams[@"Accept"] componentsSeparatedByString:@", "][0];
    }
    else {
        responseContentType = @"";
    }

    // request content type
    NSString *requestContentType = [WEMEApiClient selectHeaderContentType:@[@"application/json"]];

    // Authentication setting
    NSArray *authSettings = @[@"oauth2-clientcredentials"];

    id bodyParam = nil;
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *files = [[NSMutableDictionary alloc] init];
    
    
    

    
    return [self.apiClient requestWithCompletionBlock: resourcePath
                                               method: @"GET"
                                           pathParams: pathParams
                                          queryParams: queryParams
                                           formParams: formParams
                                                files: files
                                                 body: bodyParam
                                         headerParams: headerParams
                                         authSettings: authSettings
                                   requestContentType: requestContentType
                                  responseContentType: responseContentType
                                         responseType: @"WEMEPageResponseOfReply*"
                                      completionBlock: ^(id data, NSError *error) {
                  
                  completionBlock((WEMEPageResponseOfReply*)data, error);
              }
          ];
}

///
/// 信息发布
/// 发布需求.<br/> 用户级别
///  @param req 发布结构
///
///  @returns WEMESingleObjectValueResponseOfFeed*
///
-(NSNumber*) publishUsingPOSTWithCompletionBlock: (WEMEFeedRequest*) req
        
        completionHandler: (void (^)(WEMESingleObjectValueResponseOfFeed* output, NSError* error))completionBlock { 
        

    
    // verify the required parameter 'req' is set
    if (req == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `req` when calling `publishUsingPOST`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/api/feed/publish"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    
    NSMutableDictionary* headerParams = [NSMutableDictionary dictionaryWithDictionary:self.defaultHeaders];

    

    // HTTP header `Accept`
    headerParams[@"Accept"] = [WEMEApiClient selectHeaderAccept:@[@"application/json"]];
    if ([headerParams[@"Accept"] length] == 0) {
        [headerParams removeObjectForKey:@"Accept"];
    }

    // response content type
    NSString *responseContentType;
    if ([headerParams objectForKey:@"Accept"]) {
        responseContentType = [headerParams[@"Accept"] componentsSeparatedByString:@", "][0];
    }
    else {
        responseContentType = @"";
    }

    // request content type
    NSString *requestContentType = [WEMEApiClient selectHeaderContentType:@[@"application/json"]];

    // Authentication setting
    NSArray *authSettings = @[@"oauth2-clientcredentials"];

    id bodyParam = nil;
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *files = [[NSMutableDictionary alloc] init];
    
    bodyParam = req;
    

    
    return [self.apiClient requestWithCompletionBlock: resourcePath
                                               method: @"POST"
                                           pathParams: pathParams
                                          queryParams: queryParams
                                           formParams: formParams
                                                files: files
                                                 body: bodyParam
                                         headerParams: headerParams
                                         authSettings: authSettings
                                   requestContentType: requestContentType
                                  responseContentType: responseContentType
                                         responseType: @"WEMESingleObjectValueResponseOfFeed*"
                                      completionBlock: ^(id data, NSError *error) {
                  
                  completionBlock((WEMESingleObjectValueResponseOfFeed*)data, error);
              }
          ];
}

///
/// 拉取我发布的feed的回复
/// 根据本地收到的最新的时间拉取更新信息.<br/> 用户级别
///  @param lastupdate lastupdate
///
///  @param page page
///
///  @returns WEMEPageResponseOfReply*
///
-(NSNumber*) findUnPullMyFeedReplyUsingGETWithCompletionBlock: (NSNumber*) lastupdate
         page: (NSNumber*) page
        
        completionHandler: (void (^)(WEMEPageResponseOfReply* output, NSError* error))completionBlock { 
        

    
    // verify the required parameter 'lastupdate' is set
    if (lastupdate == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `lastupdate` when calling `findUnPullMyFeedReplyUsingGET`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/api/feed/pullMyFeedReply"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if (lastupdate != nil) {
        
        queryParams[@"lastupdate"] = lastupdate;
    }
    if (page != nil) {
        
        queryParams[@"page"] = page;
    }
    
    NSMutableDictionary* headerParams = [NSMutableDictionary dictionaryWithDictionary:self.defaultHeaders];

    

    // HTTP header `Accept`
    headerParams[@"Accept"] = [WEMEApiClient selectHeaderAccept:@[@"application/json"]];
    if ([headerParams[@"Accept"] length] == 0) {
        [headerParams removeObjectForKey:@"Accept"];
    }

    // response content type
    NSString *responseContentType;
    if ([headerParams objectForKey:@"Accept"]) {
        responseContentType = [headerParams[@"Accept"] componentsSeparatedByString:@", "][0];
    }
    else {
        responseContentType = @"";
    }

    // request content type
    NSString *requestContentType = [WEMEApiClient selectHeaderContentType:@[@"application/json"]];

    // Authentication setting
    NSArray *authSettings = @[@"oauth2-clientcredentials"];

    id bodyParam = nil;
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *files = [[NSMutableDictionary alloc] init];
    
    
    

    
    return [self.apiClient requestWithCompletionBlock: resourcePath
                                               method: @"GET"
                                           pathParams: pathParams
                                          queryParams: queryParams
                                           formParams: formParams
                                                files: files
                                                 body: bodyParam
                                         headerParams: headerParams
                                         authSettings: authSettings
                                   requestContentType: requestContentType
                                  responseContentType: responseContentType
                                         responseType: @"WEMEPageResponseOfReply*"
                                      completionBlock: ^(id data, NSError *error) {
                  
                  completionBlock((WEMEPageResponseOfReply*)data, error);
              }
          ];
}

///
/// 拉取我接收到的feed的回复
/// 根据本地收到的最新的时间拉取更新信息.<br/> 用户级别
///  @param lastupdate lastupdate
///
///  @param page page
///
///  @returns WEMEPageResponseOfReply*
///
-(NSNumber*) findUnPullMyReplyUsingGETWithCompletionBlock: (NSNumber*) lastupdate
         page: (NSNumber*) page
        
        completionHandler: (void (^)(WEMEPageResponseOfReply* output, NSError* error))completionBlock { 
        

    
    // verify the required parameter 'lastupdate' is set
    if (lastupdate == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `lastupdate` when calling `findUnPullMyReplyUsingGET`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/api/feed/pullMyReply"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if (lastupdate != nil) {
        
        queryParams[@"lastupdate"] = lastupdate;
    }
    if (page != nil) {
        
        queryParams[@"page"] = page;
    }
    
    NSMutableDictionary* headerParams = [NSMutableDictionary dictionaryWithDictionary:self.defaultHeaders];

    

    // HTTP header `Accept`
    headerParams[@"Accept"] = [WEMEApiClient selectHeaderAccept:@[@"application/json"]];
    if ([headerParams[@"Accept"] length] == 0) {
        [headerParams removeObjectForKey:@"Accept"];
    }

    // response content type
    NSString *responseContentType;
    if ([headerParams objectForKey:@"Accept"]) {
        responseContentType = [headerParams[@"Accept"] componentsSeparatedByString:@", "][0];
    }
    else {
        responseContentType = @"";
    }

    // request content type
    NSString *requestContentType = [WEMEApiClient selectHeaderContentType:@[@"application/json"]];

    // Authentication setting
    NSArray *authSettings = @[@"oauth2-clientcredentials"];

    id bodyParam = nil;
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *files = [[NSMutableDictionary alloc] init];
    
    
    

    
    return [self.apiClient requestWithCompletionBlock: resourcePath
                                               method: @"GET"
                                           pathParams: pathParams
                                          queryParams: queryParams
                                           formParams: formParams
                                                files: files
                                                 body: bodyParam
                                         headerParams: headerParams
                                         authSettings: authSettings
                                   requestContentType: requestContentType
                                  responseContentType: responseContentType
                                         responseType: @"WEMEPageResponseOfReply*"
                                      completionBlock: ^(id data, NSError *error) {
                  
                  completionBlock((WEMEPageResponseOfReply*)data, error);
              }
          ];
}

///
/// 拉取信息
/// 根据本地收到的最新的时间拉取更新消息.<br/> 用户级别
///  @param channel channel
///
///  @param lastupdate lastupdate
///
///  @param page page
///
///  @param datesearch datesearch
///
///  @returns WEMEPageResponseOfMongoMessage*
///
-(NSNumber*) pullmessageUsingGETWithCompletionBlock: (NSString*) channel
         lastupdate: (NSNumber*) lastupdate
         page: (NSNumber*) page
         datesearch: (NSNumber*) datesearch
        
        completionHandler: (void (^)(WEMEPageResponseOfMongoMessage* output, NSError* error))completionBlock { 
        

    
    // verify the required parameter 'channel' is set
    if (channel == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `channel` when calling `pullmessageUsingGET`"];
    }
    
    // verify the required parameter 'lastupdate' is set
    if (lastupdate == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `lastupdate` when calling `pullmessageUsingGET`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/api/feed/pullmessage"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if (channel != nil) {
        
        queryParams[@"channel"] = channel;
    }
    if (lastupdate != nil) {
        
        queryParams[@"lastupdate"] = lastupdate;
    }
    if (page != nil) {
        
        queryParams[@"page"] = page;
    }
    if (datesearch != nil) {
        
        queryParams[@"datesearch"] = datesearch;
    }
    
    NSMutableDictionary* headerParams = [NSMutableDictionary dictionaryWithDictionary:self.defaultHeaders];

    

    // HTTP header `Accept`
    headerParams[@"Accept"] = [WEMEApiClient selectHeaderAccept:@[@"application/json"]];
    if ([headerParams[@"Accept"] length] == 0) {
        [headerParams removeObjectForKey:@"Accept"];
    }

    // response content type
    NSString *responseContentType;
    if ([headerParams objectForKey:@"Accept"]) {
        responseContentType = [headerParams[@"Accept"] componentsSeparatedByString:@", "][0];
    }
    else {
        responseContentType = @"";
    }

    // request content type
    NSString *requestContentType = [WEMEApiClient selectHeaderContentType:@[@"application/json"]];

    // Authentication setting
    NSArray *authSettings = @[@"oauth2-clientcredentials"];

    id bodyParam = nil;
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *files = [[NSMutableDictionary alloc] init];
    
    
    

    
    return [self.apiClient requestWithCompletionBlock: resourcePath
                                               method: @"GET"
                                           pathParams: pathParams
                                          queryParams: queryParams
                                           formParams: formParams
                                                files: files
                                                 body: bodyParam
                                         headerParams: headerParams
                                         authSettings: authSettings
                                   requestContentType: requestContentType
                                  responseContentType: responseContentType
                                         responseType: @"WEMEPageResponseOfMongoMessage*"
                                      completionBlock: ^(id data, NSError *error) {
                  
                  completionBlock((WEMEPageResponseOfMongoMessage*)data, error);
              }
          ];
}

///
/// 发现信息拉取
/// 根据本地收到的最新的时间拉取更新信息.<br/> 用户级别
///  @param lastupdate lastupdate
///
///  @param page page
///
///  @param datesearch datesearch
///
///  @returns WEMEPageResponseOfSimpleFeed*
///
-(NSNumber*) reciveFeedUsingGETWithCompletionBlock: (NSNumber*) lastupdate
         page: (NSNumber*) page
         datesearch: (NSNumber*) datesearch
        
        completionHandler: (void (^)(WEMEPageResponseOfSimpleFeed* output, NSError* error))completionBlock { 
        

    
    // verify the required parameter 'lastupdate' is set
    if (lastupdate == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `lastupdate` when calling `reciveFeedUsingGET`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/api/feed/reciveFeed"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if (lastupdate != nil) {
        
        queryParams[@"lastupdate"] = lastupdate;
    }
    if (page != nil) {
        
        queryParams[@"page"] = page;
    }
    if (datesearch != nil) {
        
        queryParams[@"datesearch"] = datesearch;
    }
    
    NSMutableDictionary* headerParams = [NSMutableDictionary dictionaryWithDictionary:self.defaultHeaders];

    

    // HTTP header `Accept`
    headerParams[@"Accept"] = [WEMEApiClient selectHeaderAccept:@[@"application/json"]];
    if ([headerParams[@"Accept"] length] == 0) {
        [headerParams removeObjectForKey:@"Accept"];
    }

    // response content type
    NSString *responseContentType;
    if ([headerParams objectForKey:@"Accept"]) {
        responseContentType = [headerParams[@"Accept"] componentsSeparatedByString:@", "][0];
    }
    else {
        responseContentType = @"";
    }

    // request content type
    NSString *requestContentType = [WEMEApiClient selectHeaderContentType:@[@"application/json"]];

    // Authentication setting
    NSArray *authSettings = @[@"oauth2-clientcredentials"];

    id bodyParam = nil;
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *files = [[NSMutableDictionary alloc] init];
    
    
    

    
    return [self.apiClient requestWithCompletionBlock: resourcePath
                                               method: @"GET"
                                           pathParams: pathParams
                                          queryParams: queryParams
                                           formParams: formParams
                                                files: files
                                                 body: bodyParam
                                         headerParams: headerParams
                                         authSettings: authSettings
                                   requestContentType: requestContentType
                                  responseContentType: responseContentType
                                         responseType: @"WEMEPageResponseOfSimpleFeed*"
                                      completionBlock: ^(id data, NSError *error) {
                  
                  completionBlock((WEMEPageResponseOfSimpleFeed*)data, error);
              }
          ];
}

///
/// 更新最后查看时间
/// 在点击查看与消息接收界面进行调用.<br/> 用户级别
///  @param channel channel
///
///  @returns WEMESimpleResponse*
///
-(NSNumber*) updateViewTimeUsingGETWithCompletionBlock: (NSString*) channel
        
        completionHandler: (void (^)(WEMESimpleResponse* output, NSError* error))completionBlock { 
        

    
    // verify the required parameter 'channel' is set
    if (channel == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `channel` when calling `updateViewTimeUsingGET`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/api/feed/update_view_time"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if (channel != nil) {
        
        queryParams[@"channel"] = channel;
    }
    
    NSMutableDictionary* headerParams = [NSMutableDictionary dictionaryWithDictionary:self.defaultHeaders];

    

    // HTTP header `Accept`
    headerParams[@"Accept"] = [WEMEApiClient selectHeaderAccept:@[@"application/json"]];
    if ([headerParams[@"Accept"] length] == 0) {
        [headerParams removeObjectForKey:@"Accept"];
    }

    // response content type
    NSString *responseContentType;
    if ([headerParams objectForKey:@"Accept"]) {
        responseContentType = [headerParams[@"Accept"] componentsSeparatedByString:@", "][0];
    }
    else {
        responseContentType = @"";
    }

    // request content type
    NSString *requestContentType = [WEMEApiClient selectHeaderContentType:@[@"application/json"]];

    // Authentication setting
    NSArray *authSettings = @[@"oauth2-clientcredentials"];

    id bodyParam = nil;
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *files = [[NSMutableDictionary alloc] init];
    
    
    

    
    return [self.apiClient requestWithCompletionBlock: resourcePath
                                               method: @"GET"
                                           pathParams: pathParams
                                          queryParams: queryParams
                                           formParams: formParams
                                                files: files
                                                 body: bodyParam
                                         headerParams: headerParams
                                         authSettings: authSettings
                                   requestContentType: requestContentType
                                  responseContentType: responseContentType
                                         responseType: @"WEMESimpleResponse*"
                                      completionBlock: ^(id data, NSError *error) {
                  
                  completionBlock((WEMESimpleResponse*)data, error);
              }
          ];
}

///
/// 获取单条信息
/// 获取指定id的信息.<br/> 用户级别
///  @param _id id
///
///  @returns WEMESingleObjectValueResponseOfFeed*
///
-(NSNumber*) getFeedUsingGETWithCompletionBlock: (NSString*) _id
        
        completionHandler: (void (^)(WEMESingleObjectValueResponseOfFeed* output, NSError* error))completionBlock { 
        

    
    // verify the required parameter '_id' is set
    if (_id == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `_id` when calling `getFeedUsingGET`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/api/feed/{id}"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    if (_id != nil) {
        pathParams[@"id"] = _id;
    }
    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    
    NSMutableDictionary* headerParams = [NSMutableDictionary dictionaryWithDictionary:self.defaultHeaders];

    

    // HTTP header `Accept`
    headerParams[@"Accept"] = [WEMEApiClient selectHeaderAccept:@[@"application/json"]];
    if ([headerParams[@"Accept"] length] == 0) {
        [headerParams removeObjectForKey:@"Accept"];
    }

    // response content type
    NSString *responseContentType;
    if ([headerParams objectForKey:@"Accept"]) {
        responseContentType = [headerParams[@"Accept"] componentsSeparatedByString:@", "][0];
    }
    else {
        responseContentType = @"";
    }

    // request content type
    NSString *requestContentType = [WEMEApiClient selectHeaderContentType:@[@"application/json"]];

    // Authentication setting
    NSArray *authSettings = @[@"oauth2-clientcredentials"];

    id bodyParam = nil;
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *files = [[NSMutableDictionary alloc] init];
    
    
    

    
    return [self.apiClient requestWithCompletionBlock: resourcePath
                                               method: @"GET"
                                           pathParams: pathParams
                                          queryParams: queryParams
                                           formParams: formParams
                                                files: files
                                                 body: bodyParam
                                         headerParams: headerParams
                                         authSettings: authSettings
                                   requestContentType: requestContentType
                                  responseContentType: responseContentType
                                         responseType: @"WEMESingleObjectValueResponseOfFeed*"
                                      completionBlock: ^(id data, NSError *error) {
                  
                  completionBlock((WEMESingleObjectValueResponseOfFeed*)data, error);
              }
          ];
}



@end
