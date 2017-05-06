#import "WEMEMessagecontrollerApi.h"
#import "WEMEQueryParamCollection.h"
#import "WEMEPageResponseOfMongoMessage.h"


@interface WEMEMessagecontrollerApi ()
    @property (readwrite, nonatomic, strong) NSMutableDictionary *defaultHeaders;
@end

@implementation WEMEMessagecontrollerApi

static WEMEMessagecontrollerApi* singletonAPI = nil;

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

+(WEMEMessagecontrollerApi*) apiWithHeader:(NSString*)headerValue key:(NSString*)key {

    if (singletonAPI == nil) {
        singletonAPI = [[WEMEMessagecontrollerApi alloc] init];
        [singletonAPI addHeader:headerValue forKey:key];
    }
    return singletonAPI;
}

+(WEMEMessagecontrollerApi*) sharedAPI {

    if (singletonAPI == nil) {
        singletonAPI = [[WEMEMessagecontrollerApi alloc] init];
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
/// 拉取信息
/// 根据本地收到的最新的时间拉取更新消息.<br/> 用户级别
///  @param lastupdate lastupdate
///
///  @param page page
///
///  @param datesearch datesearch
///
///  @returns WEMEPageResponseOfMongoMessage*
///
-(NSNumber*) getmessageUsingGET1WithCompletionBlock: (NSNumber*) lastupdate
         page: (NSNumber*) page
         datesearch: (NSNumber*) datesearch
        
        completionHandler: (void (^)(WEMEPageResponseOfMongoMessage* output, NSError* error))completionBlock { 
        

    
    // verify the required parameter 'lastupdate' is set
    if (lastupdate == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `lastupdate` when calling `getmessageUsingGET1`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/api/message/getmessage"];

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
                                         responseType: @"WEMEPageResponseOfMongoMessage*"
                                      completionBlock: ^(id data, NSError *error) {
                  
                  completionBlock((WEMEPageResponseOfMongoMessage*)data, error);
              }
          ];
}

///
/// 拉取信息
/// 获取某一channel的所有消息.<br/> 用户级别
///  @param cid cid
///
///  @param lastupdate lastupdate
///
///  @param page page
///
///  @param datesearch datesearch
///
///  @returns WEMEPageResponseOfMongoMessage*
///
-(NSNumber*) getmessageUsingGETWithCompletionBlock: (NSNumber*) cid
         lastupdate: (NSNumber*) lastupdate
         page: (NSNumber*) page
         datesearch: (NSNumber*) datesearch
        
        completionHandler: (void (^)(WEMEPageResponseOfMongoMessage* output, NSError* error))completionBlock { 
        

    
    // verify the required parameter 'cid' is set
    if (cid == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `cid` when calling `getmessageUsingGET`"];
    }
    
    // verify the required parameter 'lastupdate' is set
    if (lastupdate == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `lastupdate` when calling `getmessageUsingGET`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/api/message/getmessage/{cid}"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    if (cid != nil) {
        pathParams[@"cid"] = cid;
    }
    

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
                                         responseType: @"WEMEPageResponseOfMongoMessage*"
                                      completionBlock: ^(id data, NSError *error) {
                  
                  completionBlock((WEMEPageResponseOfMongoMessage*)data, error);
              }
          ];
}



@end
