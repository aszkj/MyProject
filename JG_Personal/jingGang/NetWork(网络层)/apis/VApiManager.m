//
//  VApiManager.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-13.
//  Copyright (c) 2014�?duocai. All rights reserved.
//

#import "VApiManager.h"
#import "Sculptor.h"

NSString * const kOAuthGrantType = @"password";

@interface VApiManager ()
@property (readwrite, nonatomic) NSString *clientId;
@property (readwrite, nonatomic) NSString *secret;
@end


@implementation VApiManager
#pragma mark Properties
+(instancetype) clientWithBaseURL:(NSURL *) url
                         clientId:(NSString *) clientId
                           sceret:(NSString *) secret
{
    return [[self alloc] initWithBaseURL:url clientId:clientId secret:secret];
}

-(id) initWithBaseURL:(NSURL *)url
             clientId:(NSString *)clientId
               secret:(NSString *)secret
{
    NSParameterAssert(clientId);
    self = [super initWithBaseURL:url];
    if(!self){
        return nil;
    }
    self.clientId = clientId;
    self.secret = secret;
    return self;
}

-(void) setAuthorizationHeaderWithCredential
{
    NSString *strSecret = [NSString stringWithFormat:@"%@:%@",self.clientId,self.secret] ;
    NSData *secretData = [[strSecret dataUsingEncoding:NSUTF8StringEncoding] base64EncodedDataWithOptions:0];
    NSString * base64 = [[NSString alloc] initWithData:secretData encoding:NSUTF8StringEncoding];
    [self.requestSerializer setValue: [NSString stringWithFormat:@"Basic %@", base64]forHTTPHeaderField:@"Authorization"];
    [self.requestSerializer setValue: @"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type" ];
}


-(void) setAccessTokenHeader:(NSString *) token{
    if (token) {
        [self.requestSerializer setValue: [NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];    [self.requestSerializer setValue: @"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type" ];
    }
}

- (void)setUserAgent:(NSString *)userAgent
{
    [self.requestSerializer setValue:userAgent forHTTPHeaderField:@"User-Agent"];
}

-(void) authenticateUsingOAuthWithPath:(NSString *) path
                              username:(NSString *) username
                              password:(NSString *) password
                              success:(void (^)(AFHTTPRequestOperation *operation,AccessToken *credential))success
                              failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    NSMutableDictionary *mutableParameters = [NSMutableDictionary dictionary];
    [mutableParameters setObject:kOAuthGrantType forKey:@"grant_type"];
    [mutableParameters setValue:username forKey:@"username"];
    [mutableParameters setValue:password forKey:@"password"];
    NSDictionary *parameters = [NSDictionary dictionaryWithDictionary:mutableParameters];
    
    [self setAuthorizationHeaderWithCredential];
   
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:AccessToken.class];
    [self POST:path parameters:parameters success:success failure:failure];
    
}

//method auto create begin
-(void) complaintsUsersList:(ComplaintsUsersListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,ComplaintsUsersListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) complaintsUsersDetails:(ComplaintsUsersDetailsRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,ComplaintsUsersDetailsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) complaintsHandler:(ComplaintsHandlerRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,ComplaintsHandlerResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) cloudBuyerCashSave:(CloudBuyerCashSaveRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,CloudBuyerCashSaveResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) cloudBuyerMoneyPassword:(CloudBuyerMoneyPasswordRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,CloudBuyerMoneyPasswordResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) cloudBuyerPaymet:(CloudBuyerPaymetRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,CloudBuyerPaymetResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) cloudBuyerStatus:(CloudBuyerStatusRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,CloudBuyerStatusResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) cloudBuyerQueryOnlyOne:(CloudBuyerQueryOnlyOneRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,CloudBuyerQueryOnlyOneResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) cloudBuyerPasswordIsNull:(CloudBuyerPasswordIsNullRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,CloudBuyerPasswordIsNullResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) cloudBuyerMoneyPasswordSave:(CloudBuyerMoneyPasswordSaveRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,CloudBuyerMoneyPasswordSaveResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) cloudBuyerMoneyPasswordValidate:(CloudBuyerMoneyPasswordValidateRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,CloudBuyerMoneyPasswordValidateResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) cloudBuyerMobileSms:(CloudBuyerMobileSmsRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,CloudBuyerMobileSmsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) codeSend:(CodeSendRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,CodeSendResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) verifyCodeSend:(VerifyCodeSendRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,VerifyCodeSendResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) passwordForgetUpdate:(PasswordForgetUpdateRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,PasswordForgetUpdateResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) registerUsersCreate:(RegisterUsersCreateRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,RegisterUsersCreateResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) registerAccountExists:(RegisterAccountExistsRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,RegisterAccountExistsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) registerNicknameExists:(RegisterNicknameExistsRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,RegisterNicknameExistsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) verifyForgetcodeSend:(VerifyForgetcodeSendRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,VerifyForgetcodeSendResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) registerThirdCreate:(RegisterThirdCreateRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,RegisterThirdCreateResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) registerNvitationCodeExists:(RegisterNvitationCodeExistsRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,RegisterNvitationCodeExistsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) operCodeSend:(OperCodeSendRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,OperCodeSendResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) passwordForgetOperatorUpdate:(PasswordForgetOperatorUpdateRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,PasswordForgetOperatorUpdateResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) snsIntegralGet:(SnsIntegralGetRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,SnsIntegralGetResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersCheckHistory:(UsersCheckHistoryRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersCheckHistoryResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) snsCheckResult:(SnsCheckResultRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,SnsCheckResultResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) snsRecommenGoodsAndStoreList:(SnsRecommenGoodsAndStoreListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,SnsRecommenGoodsAndStoreListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) snsCheckList:(SnsCheckListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,SnsCheckListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) snsHealthTaskSave:(SnsHealthTaskSaveRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,SnsHealthTaskSaveResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) paymetPasswordValidate:(PaymetPasswordValidateRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,PaymetPasswordValidateResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) personalAllCityList:(PersonalAllCityListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalAllCityListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) personalKeywordSearch:(PersonalKeywordSearchRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalKeywordSearchResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) personalGoodsDetails:(PersonalGoodsDetailsRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalGoodsDetailsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) personalCommentSave:(PersonalCommentSaveRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalCommentSaveResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) personalOrderRefund:(PersonalOrderRefundRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalOrderRefundResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) personalCouponRefund:(PersonalCouponRefundRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalCouponRefundResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) personalAwayStoreList:(PersonalAwayStoreListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalAwayStoreListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) personalYoulikeStoreList:(PersonalYoulikeStoreListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalYoulikeStoreListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) personalCancel:(PersonalCancelRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalCancelResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) personalHotSearch:(PersonalHotSearchRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalHotSearchResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) personalClassFindList:(PersonalClassFindListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalClassFindListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) personalAreaParentList:(PersonalAreaParentListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalAreaParentListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) personalFavoritesList:(PersonalFavoritesListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalFavoritesListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) personalRecommStoreList:(PersonalRecommStoreListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalRecommStoreListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) personalFavaGoodsList:(PersonalFavaGoodsListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalFavaGoodsListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) merchStoreList:(MerchStoreListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,MerchStoreListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) merchStoreCommonInfo:(MerchStoreCommonInfoRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,MerchStoreCommonInfoResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersConsultingList:(UsersConsultingListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersConsultingListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) snsConsultingDetail:(SnsConsultingDetailRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,SnsConsultingDetailResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) snsConsultingRepayAdd:(SnsConsultingRepayAddRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,SnsConsultingRepayAddResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) snsConsultingAdd:(SnsConsultingAddRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,SnsConsultingAddResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}

-(void) equipDayQueryByDate:(EquipDayQueryByDateRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,EquipDayQueryByDateResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) equipQueryByRange:(EquipQueryByRangeRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,EquipQueryByRangeResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) equipQueryWeekByMon:(EquipQueryWeekByMonRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,EquipQueryWeekByMonResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) equipQueryMonByYear:(EquipQueryMonByYearRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,EquipQueryMonByYearResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) equipWeekQuery:(EquipWeekQueryRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,EquipWeekQueryResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) equipSleepAdd:(EquipSleepAddRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,EquipSleepAddResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) equipSleepQueryByDate:(EquipSleepQueryByDateRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,EquipSleepQueryByDateResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) equipSleepQuery:(EquipSleepQueryRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,EquipSleepQueryResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) equipSleepWeek:(EquipSleepWeekRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,EquipSleepWeekResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) equipSleepQueryByRange:(EquipSleepQueryByRangeRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,EquipSleepQueryByRangeResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) equipSleepQueryWeekByMon:(EquipSleepQueryWeekByMonRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,EquipSleepQueryWeekByMonResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) equipAdd:(EquipAddRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,EquipAddResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) equipDayQuery:(EquipDayQueryRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,EquipDayQueryResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) shopExpressCompanyList:(ShopExpressCompanyListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopExpressCompanyListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) shopExpressTransView:(ShopExpressTransViewRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopExpressTransViewResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) salePromotionActivityAdMainInfo:(SalePromotionActivityAdMainInfoRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,SalePromotionActivityAdMainInfoResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self GET:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) salePromotionActivityAdGoodsInfoList:(SalePromotionActivityAdGoodsInfoListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,SalePromotionActivityAdGoodsInfoListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) salePromotionAdInfo:(SalePromotionAdInfoRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,SalePromotionAdInfoResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) physicalSave:(PhysicalSaveRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,PhysicalSaveResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) physicalQuery:(PhysicalQueryRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,PhysicalQueryResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) physicalListQuery:(PhysicalListQueryRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,PhysicalListQueryResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) physicalListSelectCode:(PhysicalListSelectCodeRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,PhysicalListSelectCodeResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) physicalDescription:(PhysicalDescriptionRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,PhysicalDescriptionResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) snsInformationAllList:(SnsInformationAllListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,SnsInformationAllListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) snsInformationClass:(SnsInformationClassRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,SnsInformationClassResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) snsInformationPageList:(SnsInformationPageListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,SnsInformationPageListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) snsBodyList:(SnsBodyListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,SnsBodyListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) selfOrderList:(SelfOrderListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,SelfOrderListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) selfGoodsConfirm:(SelfGoodsConfirmRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,SelfGoodsConfirmResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) selfDetail:(SelfDetailRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,SelfDetailResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) selfFavaList:(SelfFavaListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,SelfFavaListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) selfFavaDelete:(SelfFavaDeleteRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,SelfFavaDeleteResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) selfOrderDelete:(SelfOrderDeleteRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,SelfOrderDeleteResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) selfOrderEvaluateSave:(SelfOrderEvaluateSaveRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,SelfOrderEvaluateSaveResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) selfEvaluateAddSave:(SelfEvaluateAddSaveRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,SelfEvaluateAddSaveResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) selfEvaluateList:(SelfEvaluateListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,SelfEvaluateListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) selfOrderCancel:(SelfOrderCancelRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,SelfOrderCancelResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) sysArticlePageArticleList:(SysArticlePageArticleListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,SysArticlePageArticleListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) sysArticleAllArticleList:(SysArticleAllArticleListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,SysArticleAllArticleListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) sysArticleArticleClass:(SysArticleArticleClassRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,SysArticleArticleClassResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) shopTradePaymetView:(ShopTradePaymetViewRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopTradePaymetViewResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) shopTradeOrderCreate:(ShopTradeOrderCreateRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopTradeOrderCreateResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) shopTradePaymet:(ShopTradePaymetRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopTradePaymetResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) shopTradeReturnCancel:(ShopTradeReturnCancelRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopTradeReturnCancelResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) shopTradeReturnApply:(ShopTradeReturnApplyRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopTradeReturnApplyResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) shopTradeReturnList:(ShopTradeReturnListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopTradeReturnListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) shopTradeReturnView:(ShopTradeReturnViewRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopTradeReturnViewResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) shopTradeReturnShipSave:(ShopTradeReturnShipSaveRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopTradeReturnShipSaveResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) shopOrderStatusGet:(ShopOrderStatusGetRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopOrderStatusGetResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) shopCartRemove:(ShopCartRemoveRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopCartRemoveResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) shopCartAdd:(ShopCartAddRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopCartAddResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) shopFindUserCartQuery:(ShopFindUserCartQueryRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopFindUserCartQueryResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) shopTransportGet:(ShopTransportGetRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopTransportGetResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) shopCartSize:(ShopCartSizeRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopCartSizeResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) shopBuyGoods:(ShopBuyGoodsRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopBuyGoodsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) shopGoodsCountAdjust:(ShopGoodsCountAdjustRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopGoodsCountAdjustResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) shopGoodsTotalPrice:(ShopGoodsTotalPriceRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopGoodsTotalPriceResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) shopCartAddressSave:(ShopCartAddressSaveRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopCartAddressSaveResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) shopCartGoodsDetail:(ShopCartGoodsDetailRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopCartGoodsDetailResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) shopUserAddressAll:(ShopUserAddressAllRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopUserAddressAllResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) shopDefaultAddress:(ShopDefaultAddressRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopDefaultAddressResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) shopDeleteAddress:(ShopDeleteAddressRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopDeleteAddressResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) shopAddresList:(ShopAddresListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopAddresListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersExpertsPraise:(UsersExpertsPraiseRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersExpertsPraiseResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersExpertsUnpraise:(UsersExpertsUnpraiseRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersExpertsUnpraiseResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersExpertsList:(UsersExpertsListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersExpertsListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersExpertsDetail:(UsersExpertsDetailRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersExpertsDetailResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) personalCityGet:(PersonalCityGetRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalCityGetResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) personalHotCityGet:(PersonalHotCityGetRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalHotCityGetResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) personalServiceBuy:(PersonalServiceBuyRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalServiceBuyResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) personalPayView:(PersonalPayViewRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalPayViewResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) personalPayPage:(PersonalPayPageRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalPayPageResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) personalOrderPay:(PersonalOrderPayRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalOrderPayResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) personalOrderPayment:(PersonalOrderPaymentRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalOrderPaymentResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) personalPromotionGoodsList:(PersonalPromotionGoodsListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalPromotionGoodsListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) personalGroupGoodsLike:(PersonalGroupGoodsLikeRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalGroupGoodsLikeResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) personalGroupOrderList:(PersonalGroupOrderListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalGroupOrderListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) personalOrderLineList:(PersonalOrderLineListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalOrderLineListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) personalUnUsedorderDetails:(PersonalUnUsedorderDetailsRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalUnUsedorderDetailsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) personalStoreInfo:(PersonalStoreInfoRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalStoreInfoResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) personalOrderDetails:(PersonalOrderDetailsRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalOrderDetailsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) snsRecommendList:(SnsRecommendListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,SnsRecommendListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) snsCrcList:(SnsCrcListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,SnsCrcListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) integralList:(IntegralListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,IntegralListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) integralGoodCountGet:(IntegralGoodCountGetRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,IntegralGoodCountGetResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) integralOrderList:(IntegralOrderListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,IntegralOrderListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) integralDetails:(IntegralDetailsRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,IntegralDetailsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) integralCancel:(IntegralCancelRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,IntegralCancelResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) integralOrderCofirm:(IntegralOrderCofirmRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,IntegralOrderCofirmResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) integralSaveOrder:(IntegralSaveOrderRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,IntegralSaveOrderResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) integralRePayment:(IntegralRePaymentRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,IntegralRePaymentResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) integralComputeOrder:(IntegralComputeOrderRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,IntegralComputeOrderResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) integralAddressList:(IntegralAddressListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,IntegralAddressListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) integralListByCriteria:(IntegralListByCriteriaRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,IntegralListByCriteriaResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) integralExchange:(IntegralExchangeRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,IntegralExchangeResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) integralOrderDetails:(IntegralOrderDetailsRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,IntegralOrderDetailsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) groupAreaList:(GroupAreaListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupAreaListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) groupCheckInSave:(GroupCheckInSaveRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupCheckInSaveResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) groupOrderRefundSave:(GroupOrderRefundSaveRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupOrderRefundSaveResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) groupStoreInfoGet:(GroupStoreInfoGetRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupStoreInfoGetResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) groupOrderGet:(GroupOrderGetRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupOrderGetResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) groupConsumerSureMulti:(GroupConsumerSureMultiRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupConsumerSureMultiResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) groupConsumShareList:(GroupConsumShareListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupConsumShareListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) groupRebateCount:(GroupRebateCountRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupRebateCountResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) groupShareDetails:(GroupShareDetailsRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupShareDetailsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) groupOrderLineStatistics:(GroupOrderLineStatisticsRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupOrderLineStatisticsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) groupOrderStatistics:(GroupOrderStatisticsRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupOrderStatisticsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) groupOrderCountList:(GroupOrderCountListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupOrderCountListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) groupOrderLineDetails:(GroupOrderLineDetailsRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupOrderLineDetailsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) groupOrderRevenueDetails:(GroupOrderRevenueDetailsRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupOrderRevenueDetailsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) groupStoreCustomerList:(GroupStoreCustomerListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupStoreCustomerListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) groupPredepositList:(GroupPredepositListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupPredepositListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) groupGroupClassList:(GroupGroupClassListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupGroupClassListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) groupGoodsRefundList:(GroupGoodsRefundListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupGoodsRefundListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) groupOrderOnlineList:(GroupOrderOnlineListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupOrderOnlineListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) groupQueryGoodsList:(GroupQueryGoodsListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupQueryGoodsListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) groupQueryGoodsDetails:(GroupQueryGoodsDetailsRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupQueryGoodsDetailsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) groupQueryStoreStatus:(GroupQueryStoreStatusRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupQueryStoreStatusResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) groupVoucherDetails:(GroupVoucherDetailsRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupVoucherDetailsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) groupOrderDetails:(GroupOrderDetailsRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupOrderDetailsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) groupMerchantInfo:(GroupMerchantInfoRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupMerchantInfoResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) groupConsumerSure:(GroupConsumerSureRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupConsumerSureResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) groupOrderCartPay:(GroupOrderCartPayRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupOrderCartPayResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) groupEvaluateList:(GroupEvaluateListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupEvaluateListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) groupEvaluateSave:(GroupEvaluateSaveRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupEvaluateSaveResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) groupOrderMonthList:(GroupOrderMonthListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupOrderMonthListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) groupStoreAlbunList:(GroupStoreAlbunListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupStoreAlbunListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) groupGoodsShelves:(GroupGoodsShelvesRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupGoodsShelvesResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) groupMoneyCash:(GroupMoneyCashRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupMoneyCashResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersIntegralGet:(UsersIntegralGetRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersIntegralGetResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersBankInfoGet:(UsersBankInfoGetRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersBankInfoGetResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) bindingMobile:(BindingMobileRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,BindingMobileResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersSignLogin:(UsersSignLoginRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersSignLoginResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersFeedBack:(UsersFeedBackRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersFeedBackResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersSysHelp:(UsersSysHelpRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersSysHelpResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersNotice:(UsersNoticeRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersNoticeResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersArticMarkList:(UsersArticMarkListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersArticMarkListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersInvitationCodeCheckExists:(UsersInvitationCodeCheckExistsRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersInvitationCodeCheckExistsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersRelationList:(UsersRelationListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersRelationListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersIntegralDoc:(UsersIntegralDocRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersIntegralDocResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self GET:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) userCustomerSavefirst:(UserCustomerSavefirstRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UserCustomerSavefirstResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) userCustomerCoupon:(UserCustomerCouponRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UserCustomerCouponResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersIntegral:(UsersIntegralRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersIntegralResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) groupAvailableBalanceGet:(GroupAvailableBalanceGetRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupAvailableBalanceGetResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersCustomerSearch:(UsersCustomerSearchRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersCustomerSearchResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersCustomerUpdate:(UsersCustomerUpdateRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersCustomerUpdateResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersCustomerUpdateImg:(UsersCustomerUpdateImgRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersCustomerUpdateImgResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersPasswordUpdate:(UsersPasswordUpdateRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersPasswordUpdateResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersPayPasswordUpdate:(UsersPayPasswordUpdateRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersPayPasswordUpdateResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersIntegralGetByUid:(UsersIntegralGetByUidRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersIntegralGetByUidResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersOperaterMoneypassUpdate:(UsersOperaterMoneypassUpdateRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersOperaterMoneypassUpdateResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) openIdBindingCheck:(OpenIdBindingCheckRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,OpenIdBindingCheckResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) bindingList:(BindingListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,BindingListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) openIdBindingDelete:(OpenIdBindingDeleteRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,OpenIdBindingDeleteResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) bindingRegister:(BindingRegisterRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,BindingRegisterResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersOperatorNotices:(UsersOperatorNoticesRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersOperatorNoticesResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersSysNoticesDetails:(UsersSysNoticesDetailsRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersSysNoticesDetailsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersNoticesDetails:(UsersNoticesDetailsRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersNoticesDetailsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersArticleMarkDetails:(UsersArticleMarkDetailsRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersArticleMarkDetailsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersInvitationCodeBind:(UsersInvitationCodeBindRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersInvitationCodeBindResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersShareInfoGet:(UsersShareInfoGetRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersShareInfoGetResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self GET:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersRefererInfo:(UsersRefererInfoRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersRefererInfoResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self GET:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersShareInfoSave:(UsersShareInfoSaveRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersShareInfoSaveResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersIntegralList:(UsersIntegralListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersIntegralListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self GET:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersYunMoneyList:(UsersYunMoneyListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersYunMoneyListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self GET:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) searchClassGoods:(SearchClassGoodsRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,SearchClassGoodsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) searchGoodsKeyword:(SearchGoodsKeywordRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,SearchGoodsKeywordResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) searchGoodsHotKeyword:(SearchGoodsHotKeywordRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,SearchGoodsHotKeywordResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersFavorites:(UsersFavoritesRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersFavoritesResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersFavoritesCancle:(UsersFavoritesCancleRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersFavoritesCancleResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersExpertsCancle:(UsersExpertsCancleRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersExpertsCancleResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersInvitationQuery:(UsersInvitationQueryRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersInvitationQueryResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersExpertsQuery:(UsersExpertsQueryRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersExpertsQueryResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) operatorInfoGet:(OperatorInfoGetRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,OperatorInfoGetResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) operatorExpectProfitList:(OperatorExpectProfitListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,OperatorExpectProfitListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) operatorInvitationCodeGet:(OperatorInvitationCodeGetRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,OperatorInvitationCodeGetResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) operatorCashMoneyDetails:(OperatorCashMoneyDetailsRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,OperatorCashMoneyDetailsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) operatorMemberList:(OperatorMemberListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,OperatorMemberListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) operatorPasswordUpdate:(OperatorPasswordUpdateRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,OperatorPasswordUpdateResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) operatorProfitList:(OperatorProfitListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,OperatorProfitListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) operatorBusinessManagementList:(OperatorBusinessManagementListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,OperatorBusinessManagementListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) operatorProfitStatisList:(OperatorProfitStatisListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,OperatorProfitStatisListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) operatorStatisRelationList:(OperatorStatisRelationListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,OperatorStatisRelationListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) operatorRegisterList:(OperatorRegisterListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,OperatorRegisterListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) operatorMoneyCash:(OperatorMoneyCashRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,OperatorMoneyCashResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) caseList:(CaseListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,CaseListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) likeGoodsList:(LikeGoodsListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,LikeGoodsListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) likeYouGoodsList:(LikeYouGoodsListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,LikeYouGoodsListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) goodsCaseList:(GoodsCaseListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,GoodsCaseListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) goodsClassList:(GoodsClassListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,GoodsClassListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) goodsEvaluate:(GoodsEvaluateRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,GoodsEvaluateResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) goodsConsultList:(GoodsConsultListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,GoodsConsultListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) shopGoodsConsultSave:(ShopGoodsConsultSaveRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopGoodsConsultSaveResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) goodsDetails:(GoodsDetailsRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,GoodsDetailsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) shopStoreInfoGet:(ShopStoreInfoGetRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopStoreInfoGetResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) goodsList:(GoodsListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,GoodsListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersCircleInvitationList:(UsersCircleInvitationListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersCircleInvitationListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersMyselfInvitationList:(UsersMyselfInvitationListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersMyselfInvitationListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersCircleList:(UsersCircleListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersCircleListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersCommentAdd:(UsersCommentAddRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersCommentAddResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersRepylAdd:(UsersRepylAddRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersRepylAddResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersInvitationAllList:(UsersInvitationAllListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersInvitationAllListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersInvitationSearch:(UsersInvitationSearchRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersInvitationSearchResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersCanclePraise:(UsersCanclePraiseRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersCanclePraiseResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersInvitationDetails:(UsersInvitationDetailsRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersInvitationDetailsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersInvitationExtend:(UsersInvitationExtendRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersInvitationExtendResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) snsFoodCaloriesList:(SnsFoodCaloriesListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,SnsFoodCaloriesListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersPraise:(UsersPraiseRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersPraiseResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersInvitationAdd:(UsersInvitationAddRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersInvitationAddResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersCircleQuery:(UsersCircleQueryRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersCircleQueryResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersReportList:(UsersReportListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersReportListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) usersReportSave:(UsersReportSaveRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersReportSaveResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) snsFoodList:(SnsFoodListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,SnsFoodListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) reportSearch:(ReportSearchRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,ReportSearchResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) reportRepDetails:(ReportRepDetailsRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,ReportRepDetailsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) reportAdd:(ReportAddRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,ReportAddResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) reportResultClassList:(ReportResultClassListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,ReportResultClassListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) reportCheckList:(ReportCheckListRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,ReportCheckListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) reportResultDetailsSave:(ReportResultDetailsSaveRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,ReportResultDetailsSaveResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) reportResultDetailsUpdate:(ReportResultDetailsUpdateRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,ReportResultDetailsUpdateResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) reportResultDetails:(ReportResultDetailsRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,ReportResultDetailsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) reportItem:(ReportItemRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,ReportItemResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
-(void) reportDetails:(ReportDetailsRequest *) request
                       success:(void (^)(AFHTTPRequestOperation *operation,ReportDetailsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self setAccessTokenHeader: request.accessToken];
    self.responseSerializer = [SCLMantleResponseSerializer serializerForModelClass:request.responseClazz];
    [self POST:request.getUrl parameters:request.getQueryParameters success:success failure:failure];
}
//method auto create end

@end
