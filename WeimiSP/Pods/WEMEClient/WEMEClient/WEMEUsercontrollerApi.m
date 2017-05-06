#import "WEMEUsercontrollerApi.h"
#import "WEMEQueryParamCollection.h"
#import "WEMESimpleResponse.h"
#import "WEMEApnRequest.h"
#import "WEMEPoint.h"
#import "WEMESingleObjectValueResponseOfSimpleUser.h"


@interface WEMEUsercontrollerApi ()
    @property (readwrite, nonatomic, strong) NSMutableDictionary *defaultHeaders;
@end

@implementation WEMEUsercontrollerApi

static WEMEUsercontrollerApi* singletonAPI = nil;

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

+(WEMEUsercontrollerApi*) apiWithHeader:(NSString*)headerValue key:(NSString*)key {

    if (singletonAPI == nil) {
        singletonAPI = [[WEMEUsercontrollerApi alloc] init];
        [singletonAPI addHeader:headerValue forKey:key];
    }
    return singletonAPI;
}

+(WEMEUsercontrollerApi*) sharedAPI {

    if (singletonAPI == nil) {
        singletonAPI = [[WEMEUsercontrollerApi alloc] init];
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
/// 上传用户地理信息
/// 
///  @param includes includes
///
///  @returns WEMESimpleResponse*
///
-(NSNumber*) addressbookUsingPOSTWithCompletionBlock: (NSArray* /* NSString */) includes
        
        completionHandler: (void (^)(WEMESimpleResponse* output, NSError* error))completionBlock { 
        

    
    // verify the required parameter 'includes' is set
    if (includes == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `includes` when calling `addressbookUsingPOST`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/api/addressbook"];

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
    
    bodyParam = includes;
    

    
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
                                         responseType: @"WEMESimpleResponse*"
                                      completionBlock: ^(id data, NSError *error) {
                  
                  completionBlock((WEMESimpleResponse*)data, error);
              }
          ];
}

///
/// 上传用户apn token
/// 
///  @param apn apn
///
///  @returns WEMESimpleResponse*
///
-(NSNumber*) apnUsingPOSTWithCompletionBlock: (WEMEApnRequest*) apn
        
        completionHandler: (void (^)(WEMESimpleResponse* output, NSError* error))completionBlock { 
        

    
    // verify the required parameter 'apn' is set
    if (apn == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `apn` when calling `apnUsingPOST`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/api/apn"];

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
    
    bodyParam = apn;
    

    
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
                                         responseType: @"WEMESimpleResponse*"
                                      completionBlock: ^(id data, NSError *error) {
                  
                  completionBlock((WEMESimpleResponse*)data, error);
              }
          ];
}

///
/// 修改密码
/// 修改密码.<br/> 用户级别
///  @param oldPassword 老密码
///
///  @param password 新密码
///
///  @returns WEMESimpleResponse*
///
-(NSNumber*) changepasswordUsingGETWithCompletionBlock: (NSString*) oldPassword
         password: (NSString*) password
        
        completionHandler: (void (^)(WEMESimpleResponse* output, NSError* error))completionBlock { 
        

    
    // verify the required parameter 'oldPassword' is set
    if (oldPassword == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `oldPassword` when calling `changepasswordUsingGET`"];
    }
    
    // verify the required parameter 'password' is set
    if (password == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `password` when calling `changepasswordUsingGET`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/api/changepassword"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if (oldPassword != nil) {
        
        queryParams[@"oldPassword"] = oldPassword;
    }
    if (password != nil) {
        
        queryParams[@"password"] = password;
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
/// 修改手机号码
/// 修改手机号码.<br/> 用户级别
///  @param phone 新手机号码
///
///  @param code 短信验证码
///
///  @returns WEMESimpleResponse*
///
-(NSNumber*) changephoneUsingGETWithCompletionBlock: (NSString*) phone
         code: (NSString*) code
        
        completionHandler: (void (^)(WEMESimpleResponse* output, NSError* error))completionBlock { 
        

    
    // verify the required parameter 'phone' is set
    if (phone == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `phone` when calling `changephoneUsingGET`"];
    }
    
    // verify the required parameter 'code' is set
    if (code == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `code` when calling `changephoneUsingGET`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/api/changephone"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if (phone != nil) {
        
        queryParams[@"phone"] = phone;
    }
    if (code != nil) {
        
        queryParams[@"code"] = code;
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
/// 找回密码发送短信验证码
/// 找回密码发送短信验证码.<br/> App级别
///  @param phone 新手机号码
///
///  @returns WEMESimpleResponse*
///
-(NSNumber*) changePhoneverifycodeUsingGETWithCompletionBlock: (NSString*) phone
        
        completionHandler: (void (^)(WEMESimpleResponse* output, NSError* error))completionBlock { 
        

    
    // verify the required parameter 'phone' is set
    if (phone == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `phone` when calling `changePhoneverifycodeUsingGET`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/api/changephone_verifycode"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if (phone != nil) {
        
        queryParams[@"phone"] = phone;
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
/// 找回密码
/// 找回密码.<br/> App级别
///  @param phone 手机号码
///
///  @param password 密码
///
///  @param idcode 短信验证码
///
///  @returns WEMESimpleResponse*
///
-(NSNumber*) forgetPasswordUsingPOSTWithCompletionBlock: (NSString*) phone
         password: (NSString*) password
         idcode: (NSString*) idcode
        
        completionHandler: (void (^)(WEMESimpleResponse* output, NSError* error))completionBlock { 
        

    
    // verify the required parameter 'phone' is set
    if (phone == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `phone` when calling `forgetPasswordUsingPOST`"];
    }
    
    // verify the required parameter 'password' is set
    if (password == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `password` when calling `forgetPasswordUsingPOST`"];
    }
    
    // verify the required parameter 'idcode' is set
    if (idcode == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `idcode` when calling `forgetPasswordUsingPOST`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/api/forgetpassword"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if (phone != nil) {
        
        queryParams[@"phone"] = phone;
    }
    if (password != nil) {
        
        queryParams[@"password"] = password;
    }
    if (idcode != nil) {
        
        queryParams[@"idcode"] = idcode;
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
                                         responseType: @"WEMESimpleResponse*"
                                      completionBlock: ^(id data, NSError *error) {
                  
                  completionBlock((WEMESimpleResponse*)data, error);
              }
          ];
}

///
/// 找回密码发送短信验证码
/// 找回密码发送短信验证码.<br/> App级别
///  @param phoneNumber 手机号码
///
///  @returns WEMESimpleResponse*
///
-(NSNumber*) forgetpasswordverifycodeUsingGETWithCompletionBlock: (NSString*) phoneNumber
        
        completionHandler: (void (^)(WEMESimpleResponse* output, NSError* error))completionBlock { 
        

    
    // verify the required parameter 'phoneNumber' is set
    if (phoneNumber == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `phoneNumber` when calling `forgetpasswordverifycodeUsingGET`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/api/forgetpassword_verifycode"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if (phoneNumber != nil) {
        
        queryParams[@"phone_number"] = phoneNumber;
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
/// 上传用户地理信息
/// 
///  @param point point
///
///  @returns WEMESimpleResponse*
///
-(NSNumber*) geoUsingPOSTWithCompletionBlock: (WEMEPoint*) point
        
        completionHandler: (void (^)(WEMESimpleResponse* output, NSError* error))completionBlock { 
        

    
    // verify the required parameter 'point' is set
    if (point == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `point` when calling `geoUsingPOST`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/api/geo"];

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
    
    bodyParam = point;
    

    
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
                                         responseType: @"WEMESimpleResponse*"
                                      completionBlock: ^(id data, NSError *error) {
                  
                  completionBlock((WEMESimpleResponse*)data, error);
              }
          ];
}

///
/// 用户注册
/// 使用手机号码进行注册.<br/> App级别
///  @param username 手机号码
///
///  @param password 密码
///
///  @param nickname 昵称
///
///  @param idcode 短信验证码
///
///  @returns WEMESimpleResponse*
///
-(NSNumber*) regsiterUsingPOSTWithCompletionBlock: (NSString*) username
         password: (NSString*) password
         nickname: (NSString*) nickname
         idcode: (NSString*) idcode
        
        completionHandler: (void (^)(WEMESimpleResponse* output, NSError* error))completionBlock { 
        

    
    // verify the required parameter 'username' is set
    if (username == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `username` when calling `regsiterUsingPOST`"];
    }
    
    // verify the required parameter 'password' is set
    if (password == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `password` when calling `regsiterUsingPOST`"];
    }
    
    // verify the required parameter 'nickname' is set
    if (nickname == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `nickname` when calling `regsiterUsingPOST`"];
    }
    
    // verify the required parameter 'idcode' is set
    if (idcode == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `idcode` when calling `regsiterUsingPOST`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/api/register"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if (username != nil) {
        
        queryParams[@"username"] = username;
    }
    if (password != nil) {
        
        queryParams[@"password"] = password;
    }
    if (nickname != nil) {
        
        queryParams[@"nickname"] = nickname;
    }
    if (idcode != nil) {
        
        queryParams[@"idcode"] = idcode;
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
                                         responseType: @"WEMESimpleResponse*"
                                      completionBlock: ^(id data, NSError *error) {
                  
                  completionBlock((WEMESimpleResponse*)data, error);
              }
          ];
}

///
/// 用户注销
/// 注销用户.<br/> 用户级别
///  @returns NSNumber*
///
-(NSNumber*) sigoutUsingGETWithCompletionBlock: 
        (void (^)(NSNumber* output, NSError* error))completionBlock { 
        

    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/api/sigout"];

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
                                         responseType: @"NSNumber*"
                                      completionBlock: ^(id data, NSError *error) {
                  
                  completionBlock((NSNumber*)data, error);
              }
          ];
}

///
/// 修改头像
/// 
///  @param avatar 头像图片地址
///
///  @returns WEMESimpleResponse*
///
-(NSNumber*) updateAvatarUsingPOST1WithCompletionBlock: (NSString*) avatar
        
        completionHandler: (void (^)(WEMESimpleResponse* output, NSError* error))completionBlock { 
        

    
    // verify the required parameter 'avatar' is set
    if (avatar == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `avatar` when calling `updateAvatarUsingPOST1`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/api/update_avatar"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if (avatar != nil) {
        
        queryParams[@"avatar"] = avatar;
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
                                         responseType: @"WEMESimpleResponse*"
                                      completionBlock: ^(id data, NSError *error) {
                  
                  completionBlock((WEMESimpleResponse*)data, error);
              }
          ];
}

///
/// 修改昵称
/// 
///  @param nickName 昵称
///
///  @returns WEMESimpleResponse*
///
-(NSNumber*) updateNickNameUsingPOST1WithCompletionBlock: (NSString*) nickName
        
        completionHandler: (void (^)(WEMESimpleResponse* output, NSError* error))completionBlock { 
        

    
    // verify the required parameter 'nickName' is set
    if (nickName == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `nickName` when calling `updateNickNameUsingPOST1`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/api/update_nickname"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if (nickName != nil) {
        
        queryParams[@"nickName"] = nickName;
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
                                         responseType: @"WEMESimpleResponse*"
                                      completionBlock: ^(id data, NSError *error) {
                  
                  completionBlock((WEMESimpleResponse*)data, error);
              }
          ];
}

///
/// 获取本人信息
/// 获取指定id的信息.<br/> 用户级别
///  @returns WEMESingleObjectValueResponseOfSimpleUser*
///
-(NSNumber*) getMyProfileUsingGETWithCompletionBlock: 
        (void (^)(WEMESingleObjectValueResponseOfSimpleUser* output, NSError* error))completionBlock { 
        

    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/api/userprofile"];

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
                                         responseType: @"WEMESingleObjectValueResponseOfSimpleUser*"
                                      completionBlock: ^(id data, NSError *error) {
                  
                  completionBlock((WEMESingleObjectValueResponseOfSimpleUser*)data, error);
              }
          ];
}

///
/// 获取用户信息
/// 获取指定id的信息.<br/> 用户级别
///  @param _id id
///
///  @returns WEMESingleObjectValueResponseOfSimpleUser*
///
-(NSNumber*) getUserProfileUsingGETWithCompletionBlock: (NSNumber*) _id
        
        completionHandler: (void (^)(WEMESingleObjectValueResponseOfSimpleUser* output, NSError* error))completionBlock { 
        

    
    // verify the required parameter '_id' is set
    if (_id == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `_id` when calling `getUserProfileUsingGET`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/api/userprofile/{id}"];

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
                                         responseType: @"WEMESingleObjectValueResponseOfSimpleUser*"
                                      completionBlock: ^(id data, NSError *error) {
                  
                  completionBlock((WEMESingleObjectValueResponseOfSimpleUser*)data, error);
              }
          ];
}

///
/// 注册发送短信验证码
/// 服务发送短信验证码.<br/> App级别
///  @param phoneNumber 手机号码
///
///  @returns WEMESimpleResponse*
///
-(NSNumber*) verifycodeUsingGETWithCompletionBlock: (NSString*) phoneNumber
        
        completionHandler: (void (^)(WEMESimpleResponse* output, NSError* error))completionBlock { 
        

    
    // verify the required parameter 'phoneNumber' is set
    if (phoneNumber == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `phoneNumber` when calling `verifycodeUsingGET`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/api/verifycode"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if (phoneNumber != nil) {
        
        queryParams[@"phone_number"] = phoneNumber;
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



@end
