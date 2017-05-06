//
//  VApiManager.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-13.
//  Copyright (c) 2014�?duocai. All rights reserved.
//

#import "AFNetworking.h"
#import "AccessToken.h"
//import auto create begin
#import "ComplaintsUsersListResponse.h"
#import "ComplaintsUsersListRequest.h"
#import "ComplaintsUsersDetailsResponse.h"
#import "ComplaintsUsersDetailsRequest.h"
#import "ComplaintsHandlerResponse.h"
#import "ComplaintsHandlerRequest.h"
#import "CloudBuyerCashSaveResponse.h"
#import "CloudBuyerCashSaveRequest.h"
#import "CloudBuyerMoneyPasswordResponse.h"
#import "CloudBuyerMoneyPasswordRequest.h"
#import "CloudBuyerPaymetResponse.h"
#import "CloudBuyerPaymetRequest.h"
#import "CloudBuyerStatusResponse.h"
#import "CloudBuyerStatusRequest.h"
#import "CloudBuyerQueryOnlyOneResponse.h"
#import "CloudBuyerQueryOnlyOneRequest.h"
#import "CloudBuyerPasswordIsNullResponse.h"
#import "CloudBuyerPasswordIsNullRequest.h"
#import "CloudBuyerMoneyPasswordSaveResponse.h"
#import "CloudBuyerMoneyPasswordSaveRequest.h"
#import "CloudBuyerMoneyPasswordValidateResponse.h"
#import "CloudBuyerMoneyPasswordValidateRequest.h"
#import "CloudBuyerMobileSmsResponse.h"
#import "CloudBuyerMobileSmsRequest.h"
#import "CodeSendResponse.h"
#import "CodeSendRequest.h"
#import "VerifyCodeSendResponse.h"
#import "VerifyCodeSendRequest.h"
#import "PasswordForgetUpdateResponse.h"
#import "PasswordForgetUpdateRequest.h"
#import "RegisterUsersCreateResponse.h"
#import "RegisterUsersCreateRequest.h"
#import "RegisterAccountExistsResponse.h"
#import "RegisterAccountExistsRequest.h"
#import "RegisterNicknameExistsResponse.h"
#import "RegisterNicknameExistsRequest.h"
#import "VerifyForgetcodeSendResponse.h"
#import "VerifyForgetcodeSendRequest.h"
#import "RegisterThirdCreateResponse.h"
#import "RegisterThirdCreateRequest.h"
#import "RegisterNvitationCodeExistsResponse.h"
#import "RegisterNvitationCodeExistsRequest.h"
#import "OperCodeSendResponse.h"
#import "OperCodeSendRequest.h"
#import "PasswordForgetOperatorUpdateResponse.h"
#import "PasswordForgetOperatorUpdateRequest.h"
#import "SnsIntegralGetResponse.h"
#import "SnsIntegralGetRequest.h"
#import "UsersCheckHistoryResponse.h"
#import "UsersCheckHistoryRequest.h"
#import "SnsCheckResultResponse.h"
#import "SnsCheckResultRequest.h"
#import "SnsRecommenGoodsAndStoreListResponse.h"
#import "SnsRecommenGoodsAndStoreListRequest.h"
#import "SnsCheckListResponse.h"
#import "SnsCheckListRequest.h"
#import "SnsHealthTaskSaveResponse.h"
#import "SnsHealthTaskSaveRequest.h"
#import "PaymetPasswordValidateResponse.h"
#import "PaymetPasswordValidateRequest.h"
#import "PersonalAllCityListResponse.h"
#import "PersonalAllCityListRequest.h"
#import "PersonalKeywordSearchResponse.h"
#import "PersonalKeywordSearchRequest.h"
#import "PersonalGoodsDetailsResponse.h"
#import "PersonalGoodsDetailsRequest.h"
#import "PersonalCommentSaveResponse.h"
#import "PersonalCommentSaveRequest.h"
#import "PersonalOrderRefundResponse.h"
#import "PersonalOrderRefundRequest.h"
#import "PersonalCouponRefundResponse.h"
#import "PersonalCouponRefundRequest.h"
#import "PersonalAwayStoreListResponse.h"
#import "PersonalAwayStoreListRequest.h"
#import "PersonalYoulikeStoreListResponse.h"
#import "PersonalYoulikeStoreListRequest.h"
#import "PersonalCancelResponse.h"
#import "PersonalCancelRequest.h"
#import "PersonalHotSearchResponse.h"
#import "PersonalHotSearchRequest.h"
#import "PersonalClassFindListResponse.h"
#import "PersonalClassFindListRequest.h"
#import "PersonalAreaParentListResponse.h"
#import "PersonalAreaParentListRequest.h"
#import "PersonalFavoritesListResponse.h"
#import "PersonalFavoritesListRequest.h"
#import "PersonalRecommStoreListResponse.h"
#import "PersonalRecommStoreListRequest.h"
#import "PersonalFavaGoodsListResponse.h"
#import "PersonalFavaGoodsListRequest.h"
#import "MerchStoreListResponse.h"
#import "MerchStoreListRequest.h"
#import "MerchStoreCommonInfoResponse.h"
#import "MerchStoreCommonInfoRequest.h"
#import "UsersConsultingListResponse.h"
#import "UsersConsultingListRequest.h"
#import "SnsConsultingDetailResponse.h"
#import "SnsConsultingDetailRequest.h"
#import "SnsConsultingRepayAddResponse.h"
#import "SnsConsultingRepayAddRequest.h"
#import "SnsConsultingAddResponse.h"
#import "SnsConsultingAddRequest.h"
#import "EquipDayQueryByDateResponse.h"
#import "EquipDayQueryByDateRequest.h"
#import "EquipQueryByRangeResponse.h"
#import "EquipQueryByRangeRequest.h"
#import "EquipQueryWeekByMonResponse.h"
#import "EquipQueryWeekByMonRequest.h"
#import "EquipQueryMonByYearResponse.h"
#import "EquipQueryMonByYearRequest.h"
#import "EquipWeekQueryResponse.h"
#import "EquipWeekQueryRequest.h"
#import "EquipSleepAddResponse.h"
#import "EquipSleepAddRequest.h"
#import "EquipSleepQueryByDateResponse.h"
#import "EquipSleepQueryByDateRequest.h"
#import "EquipSleepQueryResponse.h"
#import "EquipSleepQueryRequest.h"
#import "EquipSleepWeekResponse.h"
#import "EquipSleepWeekRequest.h"
#import "EquipSleepQueryByRangeResponse.h"
#import "EquipSleepQueryByRangeRequest.h"
#import "EquipSleepQueryWeekByMonResponse.h"
#import "EquipSleepQueryWeekByMonRequest.h"
#import "EquipAddResponse.h"
#import "EquipAddRequest.h"
#import "EquipDayQueryResponse.h"
#import "EquipDayQueryRequest.h"
#import "ShopExpressCompanyListResponse.h"
#import "ShopExpressCompanyListRequest.h"
#import "ShopExpressTransViewResponse.h"
#import "ShopExpressTransViewRequest.h"
#import "SalePromotionActivityAdMainInfoResponse.h"
#import "SalePromotionActivityAdMainInfoRequest.h"
#import "SalePromotionActivityAdGoodsInfoListResponse.h"
#import "SalePromotionActivityAdGoodsInfoListRequest.h"
#import "SalePromotionAdInfoResponse.h"
#import "SalePromotionAdInfoRequest.h"
#import "PhysicalSaveResponse.h"
#import "PhysicalSaveRequest.h"
#import "PhysicalQueryResponse.h"
#import "PhysicalQueryRequest.h"
#import "PhysicalListQueryResponse.h"
#import "PhysicalListQueryRequest.h"
#import "PhysicalListSelectCodeResponse.h"
#import "PhysicalListSelectCodeRequest.h"
#import "PhysicalDescriptionResponse.h"
#import "PhysicalDescriptionRequest.h"
#import "SnsInformationAllListResponse.h"
#import "SnsInformationAllListRequest.h"
#import "SnsInformationClassResponse.h"
#import "SnsInformationClassRequest.h"
#import "SnsInformationPageListResponse.h"
#import "SnsInformationPageListRequest.h"
#import "SnsBodyListResponse.h"
#import "SnsBodyListRequest.h"
#import "SelfOrderListResponse.h"
#import "SelfOrderListRequest.h"
#import "SelfGoodsConfirmResponse.h"
#import "SelfGoodsConfirmRequest.h"
#import "SelfDetailResponse.h"
#import "SelfDetailRequest.h"
#import "SelfFavaListResponse.h"
#import "SelfFavaListRequest.h"
#import "SelfFavaDeleteResponse.h"
#import "SelfFavaDeleteRequest.h"
#import "SelfOrderDeleteResponse.h"
#import "SelfOrderDeleteRequest.h"
#import "SelfOrderEvaluateSaveResponse.h"
#import "SelfOrderEvaluateSaveRequest.h"
#import "SelfEvaluateAddSaveResponse.h"
#import "SelfEvaluateAddSaveRequest.h"
#import "SelfEvaluateListResponse.h"
#import "SelfEvaluateListRequest.h"
#import "SelfOrderCancelResponse.h"
#import "SelfOrderCancelRequest.h"
#import "SysArticlePageArticleListResponse.h"
#import "SysArticlePageArticleListRequest.h"
#import "SysArticleAllArticleListResponse.h"
#import "SysArticleAllArticleListRequest.h"
#import "SysArticleArticleClassResponse.h"
#import "SysArticleArticleClassRequest.h"
#import "ShopTradePaymetViewResponse.h"
#import "ShopTradePaymetViewRequest.h"
#import "ShopTradeOrderCreateResponse.h"
#import "ShopTradeOrderCreateRequest.h"
#import "ShopTradePaymetResponse.h"
#import "ShopTradePaymetRequest.h"
#import "ShopTradeReturnCancelResponse.h"
#import "ShopTradeReturnCancelRequest.h"
#import "ShopTradeReturnApplyResponse.h"
#import "ShopTradeReturnApplyRequest.h"
#import "ShopTradeReturnListResponse.h"
#import "ShopTradeReturnListRequest.h"
#import "ShopTradeReturnViewResponse.h"
#import "ShopTradeReturnViewRequest.h"
#import "ShopTradeReturnShipSaveResponse.h"
#import "ShopTradeReturnShipSaveRequest.h"
#import "ShopOrderStatusGetResponse.h"
#import "ShopOrderStatusGetRequest.h"
#import "ShopCartRemoveResponse.h"
#import "ShopCartRemoveRequest.h"
#import "ShopCartAddResponse.h"
#import "ShopCartAddRequest.h"
#import "ShopFindUserCartQueryResponse.h"
#import "ShopFindUserCartQueryRequest.h"
#import "ShopTransportGetResponse.h"
#import "ShopTransportGetRequest.h"
#import "ShopCartSizeResponse.h"
#import "ShopCartSizeRequest.h"
#import "ShopBuyGoodsResponse.h"
#import "ShopBuyGoodsRequest.h"
#import "ShopGoodsCountAdjustResponse.h"
#import "ShopGoodsCountAdjustRequest.h"
#import "ShopGoodsTotalPriceResponse.h"
#import "ShopGoodsTotalPriceRequest.h"
#import "ShopCartAddressSaveResponse.h"
#import "ShopCartAddressSaveRequest.h"
#import "ShopCartGoodsDetailResponse.h"
#import "ShopCartGoodsDetailRequest.h"
#import "ShopUserAddressAllResponse.h"
#import "ShopUserAddressAllRequest.h"
#import "ShopDefaultAddressResponse.h"
#import "ShopDefaultAddressRequest.h"
#import "ShopDeleteAddressResponse.h"
#import "ShopDeleteAddressRequest.h"
#import "ShopAddresListResponse.h"
#import "ShopAddresListRequest.h"
#import "UsersExpertsPraiseResponse.h"
#import "UsersExpertsPraiseRequest.h"
#import "UsersExpertsUnpraiseResponse.h"
#import "UsersExpertsUnpraiseRequest.h"
#import "UsersExpertsListResponse.h"
#import "UsersExpertsListRequest.h"
#import "UsersExpertsDetailResponse.h"
#import "UsersExpertsDetailRequest.h"
#import "PersonalCityGetResponse.h"
#import "PersonalCityGetRequest.h"
#import "PersonalHotCityGetResponse.h"
#import "PersonalHotCityGetRequest.h"
#import "PersonalServiceBuyResponse.h"
#import "PersonalServiceBuyRequest.h"
#import "PersonalPayViewResponse.h"
#import "PersonalPayViewRequest.h"
#import "PersonalPayPageResponse.h"
#import "PersonalPayPageRequest.h"
#import "PersonalOrderPayResponse.h"
#import "PersonalOrderPayRequest.h"
#import "PersonalOrderPaymentResponse.h"
#import "PersonalOrderPaymentRequest.h"
#import "PersonalPromotionGoodsListResponse.h"
#import "PersonalPromotionGoodsListRequest.h"
#import "PersonalGroupGoodsLikeResponse.h"
#import "PersonalGroupGoodsLikeRequest.h"
#import "PersonalGroupOrderListResponse.h"
#import "PersonalGroupOrderListRequest.h"
#import "PersonalOrderLineListResponse.h"
#import "PersonalOrderLineListRequest.h"
#import "PersonalUnUsedorderDetailsResponse.h"
#import "PersonalUnUsedorderDetailsRequest.h"
#import "PersonalStoreInfoResponse.h"
#import "PersonalStoreInfoRequest.h"
#import "PersonalOrderDetailsResponse.h"
#import "PersonalOrderDetailsRequest.h"
#import "SnsRecommendListResponse.h"
#import "SnsRecommendListRequest.h"
#import "SnsCrcListResponse.h"
#import "SnsCrcListRequest.h"
#import "IntegralListResponse.h"
#import "IntegralListRequest.h"
#import "IntegralGoodCountGetResponse.h"
#import "IntegralGoodCountGetRequest.h"
#import "IntegralOrderListResponse.h"
#import "IntegralOrderListRequest.h"
#import "IntegralDetailsResponse.h"
#import "IntegralDetailsRequest.h"
#import "IntegralCancelResponse.h"
#import "IntegralCancelRequest.h"
#import "IntegralOrderCofirmResponse.h"
#import "IntegralOrderCofirmRequest.h"
#import "IntegralSaveOrderResponse.h"
#import "IntegralSaveOrderRequest.h"
#import "IntegralRePaymentResponse.h"
#import "IntegralRePaymentRequest.h"
#import "IntegralComputeOrderResponse.h"
#import "IntegralComputeOrderRequest.h"
#import "IntegralAddressListResponse.h"
#import "IntegralAddressListRequest.h"
#import "IntegralListByCriteriaResponse.h"
#import "IntegralListByCriteriaRequest.h"
#import "IntegralExchangeResponse.h"
#import "IntegralExchangeRequest.h"
#import "IntegralOrderDetailsResponse.h"
#import "IntegralOrderDetailsRequest.h"
#import "GroupAreaListResponse.h"
#import "GroupAreaListRequest.h"
#import "GroupCheckInSaveResponse.h"
#import "GroupCheckInSaveRequest.h"
#import "GroupOrderRefundSaveResponse.h"
#import "GroupOrderRefundSaveRequest.h"
#import "GroupStoreInfoGetResponse.h"
#import "GroupStoreInfoGetRequest.h"
#import "GroupOrderGetResponse.h"
#import "GroupOrderGetRequest.h"
#import "GroupConsumerSureMultiResponse.h"
#import "GroupConsumerSureMultiRequest.h"
#import "GroupConsumShareListResponse.h"
#import "GroupConsumShareListRequest.h"
#import "GroupRebateCountResponse.h"
#import "GroupRebateCountRequest.h"
#import "GroupShareDetailsResponse.h"
#import "GroupShareDetailsRequest.h"
#import "GroupOrderLineStatisticsResponse.h"
#import "GroupOrderLineStatisticsRequest.h"
#import "GroupOrderStatisticsResponse.h"
#import "GroupOrderStatisticsRequest.h"
#import "GroupOrderCountListResponse.h"
#import "GroupOrderCountListRequest.h"
#import "GroupOrderLineDetailsResponse.h"
#import "GroupOrderLineDetailsRequest.h"
#import "GroupOrderRevenueDetailsResponse.h"
#import "GroupOrderRevenueDetailsRequest.h"
#import "GroupStoreCustomerListResponse.h"
#import "GroupStoreCustomerListRequest.h"
#import "GroupPredepositListResponse.h"
#import "GroupPredepositListRequest.h"
#import "GroupGroupClassListResponse.h"
#import "GroupGroupClassListRequest.h"
#import "GroupGoodsRefundListResponse.h"
#import "GroupGoodsRefundListRequest.h"
#import "GroupOrderOnlineListResponse.h"
#import "GroupOrderOnlineListRequest.h"
#import "GroupQueryGoodsListResponse.h"
#import "GroupQueryGoodsListRequest.h"
#import "GroupQueryGoodsDetailsResponse.h"
#import "GroupQueryGoodsDetailsRequest.h"
#import "GroupQueryStoreStatusResponse.h"
#import "GroupQueryStoreStatusRequest.h"
#import "GroupVoucherDetailsResponse.h"
#import "GroupVoucherDetailsRequest.h"
#import "GroupOrderDetailsResponse.h"
#import "GroupOrderDetailsRequest.h"
#import "GroupMerchantInfoResponse.h"
#import "GroupMerchantInfoRequest.h"
#import "GroupConsumerSureResponse.h"
#import "GroupConsumerSureRequest.h"
#import "GroupOrderCartPayResponse.h"
#import "GroupOrderCartPayRequest.h"
#import "GroupEvaluateListResponse.h"
#import "GroupEvaluateListRequest.h"
#import "GroupEvaluateSaveResponse.h"
#import "GroupEvaluateSaveRequest.h"
#import "GroupOrderMonthListResponse.h"
#import "GroupOrderMonthListRequest.h"
#import "GroupStoreAlbunListResponse.h"
#import "GroupStoreAlbunListRequest.h"
#import "GroupGoodsShelvesResponse.h"
#import "GroupGoodsShelvesRequest.h"
#import "GroupMoneyCashResponse.h"
#import "GroupMoneyCashRequest.h"
#import "UsersIntegralGetResponse.h"
#import "UsersIntegralGetRequest.h"
#import "UsersBankInfoGetResponse.h"
#import "UsersBankInfoGetRequest.h"
#import "BindingMobileResponse.h"
#import "BindingMobileRequest.h"
#import "UsersSignLoginResponse.h"
#import "UsersSignLoginRequest.h"
#import "UsersFeedBackResponse.h"
#import "UsersFeedBackRequest.h"
#import "UsersSysHelpResponse.h"
#import "UsersSysHelpRequest.h"
#import "UsersNoticeResponse.h"
#import "UsersNoticeRequest.h"
#import "UsersArticMarkListResponse.h"
#import "UsersArticMarkListRequest.h"
#import "UsersInvitationCodeCheckExistsResponse.h"
#import "UsersInvitationCodeCheckExistsRequest.h"
#import "UsersRelationListResponse.h"
#import "UsersRelationListRequest.h"
#import "UsersIntegralDocResponse.h"
#import "UsersIntegralDocRequest.h"
#import "UserCustomerSavefirstResponse.h"
#import "UserCustomerSavefirstRequest.h"
#import "UserCustomerCouponResponse.h"
#import "UserCustomerCouponRequest.h"
#import "UsersIntegralResponse.h"
#import "UsersIntegralRequest.h"
#import "GroupAvailableBalanceGetResponse.h"
#import "GroupAvailableBalanceGetRequest.h"
#import "UsersCustomerSearchResponse.h"
#import "UsersCustomerSearchRequest.h"
#import "UsersCustomerUpdateResponse.h"
#import "UsersCustomerUpdateRequest.h"
#import "UsersCustomerUpdateImgResponse.h"
#import "UsersCustomerUpdateImgRequest.h"
#import "UsersPasswordUpdateResponse.h"
#import "UsersPasswordUpdateRequest.h"
#import "UsersPayPasswordUpdateResponse.h"
#import "UsersPayPasswordUpdateRequest.h"
#import "UsersIntegralGetByUidResponse.h"
#import "UsersIntegralGetByUidRequest.h"
#import "UsersOperaterMoneypassUpdateResponse.h"
#import "UsersOperaterMoneypassUpdateRequest.h"
#import "OpenIdBindingCheckResponse.h"
#import "OpenIdBindingCheckRequest.h"
#import "BindingListResponse.h"
#import "BindingListRequest.h"
#import "OpenIdBindingDeleteResponse.h"
#import "OpenIdBindingDeleteRequest.h"
#import "BindingRegisterResponse.h"
#import "BindingRegisterRequest.h"
#import "UsersOperatorNoticesResponse.h"
#import "UsersOperatorNoticesRequest.h"
#import "UsersSysNoticesDetailsResponse.h"
#import "UsersSysNoticesDetailsRequest.h"
#import "UsersNoticesDetailsResponse.h"
#import "UsersNoticesDetailsRequest.h"
#import "UsersArticleMarkDetailsResponse.h"
#import "UsersArticleMarkDetailsRequest.h"
#import "UsersInvitationCodeBindResponse.h"
#import "UsersInvitationCodeBindRequest.h"
#import "UsersShareInfoGetResponse.h"
#import "UsersShareInfoGetRequest.h"
#import "UsersRefererInfoResponse.h"
#import "UsersRefererInfoRequest.h"
#import "UsersShareInfoSaveResponse.h"
#import "UsersShareInfoSaveRequest.h"
#import "UsersIntegralListResponse.h"
#import "UsersIntegralListRequest.h"
#import "UsersYunMoneyListResponse.h"
#import "UsersYunMoneyListRequest.h"
#import "SearchClassGoodsResponse.h"
#import "SearchClassGoodsRequest.h"
#import "SearchGoodsKeywordResponse.h"
#import "SearchGoodsKeywordRequest.h"
#import "SearchGoodsHotKeywordResponse.h"
#import "SearchGoodsHotKeywordRequest.h"
#import "UsersFavoritesResponse.h"
#import "UsersFavoritesRequest.h"
#import "UsersFavoritesCancleResponse.h"
#import "UsersFavoritesCancleRequest.h"
#import "UsersExpertsCancleResponse.h"
#import "UsersExpertsCancleRequest.h"
#import "UsersInvitationQueryResponse.h"
#import "UsersInvitationQueryRequest.h"
#import "UsersExpertsQueryResponse.h"
#import "UsersExpertsQueryRequest.h"
#import "OperatorInfoGetResponse.h"
#import "OperatorInfoGetRequest.h"
#import "OperatorExpectProfitListResponse.h"
#import "OperatorExpectProfitListRequest.h"
#import "OperatorInvitationCodeGetResponse.h"
#import "OperatorInvitationCodeGetRequest.h"
#import "OperatorCashMoneyDetailsResponse.h"
#import "OperatorCashMoneyDetailsRequest.h"
#import "OperatorMemberListResponse.h"
#import "OperatorMemberListRequest.h"
#import "OperatorPasswordUpdateResponse.h"
#import "OperatorPasswordUpdateRequest.h"
#import "OperatorProfitListResponse.h"
#import "OperatorProfitListRequest.h"
#import "OperatorBusinessManagementListResponse.h"
#import "OperatorBusinessManagementListRequest.h"
#import "OperatorProfitStatisListResponse.h"
#import "OperatorProfitStatisListRequest.h"
#import "OperatorStatisRelationListResponse.h"
#import "OperatorStatisRelationListRequest.h"
#import "OperatorRegisterListResponse.h"
#import "OperatorRegisterListRequest.h"
#import "OperatorMoneyCashResponse.h"
#import "OperatorMoneyCashRequest.h"
#import "CaseListResponse.h"
#import "CaseListRequest.h"
#import "LikeGoodsListResponse.h"
#import "LikeGoodsListRequest.h"
#import "LikeYouGoodsListResponse.h"
#import "LikeYouGoodsListRequest.h"
#import "GoodsCaseListResponse.h"
#import "GoodsCaseListRequest.h"
#import "GoodsClassListResponse.h"
#import "GoodsClassListRequest.h"
#import "GoodsEvaluateResponse.h"
#import "GoodsEvaluateRequest.h"
#import "GoodsConsultListResponse.h"
#import "GoodsConsultListRequest.h"
#import "ShopGoodsConsultSaveResponse.h"
#import "ShopGoodsConsultSaveRequest.h"
#import "GoodsDetailsResponse.h"
#import "GoodsDetailsRequest.h"
#import "ShopStoreInfoGetResponse.h"
#import "ShopStoreInfoGetRequest.h"
#import "GoodsListResponse.h"
#import "GoodsListRequest.h"
#import "UsersCircleInvitationListResponse.h"
#import "UsersCircleInvitationListRequest.h"
#import "UsersMyselfInvitationListResponse.h"
#import "UsersMyselfInvitationListRequest.h"
#import "UsersCircleListResponse.h"
#import "UsersCircleListRequest.h"
#import "UsersCommentAddResponse.h"
#import "UsersCommentAddRequest.h"
#import "UsersRepylAddResponse.h"
#import "UsersRepylAddRequest.h"
#import "UsersInvitationAllListResponse.h"
#import "UsersInvitationAllListRequest.h"
#import "UsersInvitationSearchResponse.h"
#import "UsersInvitationSearchRequest.h"
#import "UsersCanclePraiseResponse.h"
#import "UsersCanclePraiseRequest.h"
#import "UsersInvitationDetailsResponse.h"
#import "UsersInvitationDetailsRequest.h"
#import "UsersInvitationExtendResponse.h"
#import "UsersInvitationExtendRequest.h"
#import "SnsFoodCaloriesListResponse.h"
#import "SnsFoodCaloriesListRequest.h"
#import "UsersPraiseResponse.h"
#import "UsersPraiseRequest.h"
#import "UsersInvitationAddResponse.h"
#import "UsersInvitationAddRequest.h"
#import "UsersCircleQueryResponse.h"
#import "UsersCircleQueryRequest.h"
#import "UsersReportListResponse.h"
#import "UsersReportListRequest.h"
#import "UsersReportSaveResponse.h"
#import "UsersReportSaveRequest.h"
#import "SnsFoodListResponse.h"
#import "SnsFoodListRequest.h"
#import "ReportSearchResponse.h"
#import "ReportSearchRequest.h"
#import "ReportRepDetailsResponse.h"
#import "ReportRepDetailsRequest.h"
#import "ReportAddResponse.h"
#import "ReportAddRequest.h"
#import "ReportResultClassListResponse.h"
#import "ReportResultClassListRequest.h"
#import "ReportCheckListResponse.h"
#import "ReportCheckListRequest.h"
#import "ReportResultDetailsSaveResponse.h"
#import "ReportResultDetailsSaveRequest.h"
#import "ReportResultDetailsUpdateResponse.h"
#import "ReportResultDetailsUpdateRequest.h"
#import "ReportResultDetailsResponse.h"
#import "ReportResultDetailsRequest.h"
#import "ReportItemResponse.h"
#import "ReportItemRequest.h"
#import "ReportDetailsResponse.h"
#import "ReportDetailsRequest.h"
//import auto create end

@interface VApiManager : AFHTTPRequestOperationManager

@property (readonly, nonatomic) NSString *clientId;
@property (readonly, nonatomic) NSString *secret;

+(instancetype) clientWithBaseURL:(NSURL *) url
                         clientId:(NSString *) clientId
                           sceret:(NSString *) secret;

-(id) initWithBaseURL:(NSURL *)url
             clientId:(NSString *)clientId
               secret:(NSString *)secret;

-(void) setAuthorizationHeaderWithCredential;

-(void) setAccessTokenHeader:(NSString *) token;

- (void)setUserAgent:(NSString *)userAgent;

-(void) authenticateUsingOAuthWithPath:(NSString *) path
                              username:(NSString *) username
                              password:(NSString *) password
                               success:(void (^)(AFHTTPRequestOperation *operation,AccessToken *credential))success
                               failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;

//method auto create begin
-(void) complaintsUsersList:(ComplaintsUsersListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,ComplaintsUsersListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) complaintsUsersDetails:(ComplaintsUsersDetailsRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,ComplaintsUsersDetailsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) complaintsHandler:(ComplaintsHandlerRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,ComplaintsHandlerResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) cloudBuyerCashSave:(CloudBuyerCashSaveRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,CloudBuyerCashSaveResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) cloudBuyerMoneyPassword:(CloudBuyerMoneyPasswordRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,CloudBuyerMoneyPasswordResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) cloudBuyerPaymet:(CloudBuyerPaymetRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,CloudBuyerPaymetResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) cloudBuyerStatus:(CloudBuyerStatusRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,CloudBuyerStatusResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) cloudBuyerQueryOnlyOne:(CloudBuyerQueryOnlyOneRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,CloudBuyerQueryOnlyOneResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) cloudBuyerPasswordIsNull:(CloudBuyerPasswordIsNullRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,CloudBuyerPasswordIsNullResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) cloudBuyerMoneyPasswordSave:(CloudBuyerMoneyPasswordSaveRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,CloudBuyerMoneyPasswordSaveResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) cloudBuyerMoneyPasswordValidate:(CloudBuyerMoneyPasswordValidateRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,CloudBuyerMoneyPasswordValidateResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) cloudBuyerMobileSms:(CloudBuyerMobileSmsRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,CloudBuyerMobileSmsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) codeSend:(CodeSendRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,CodeSendResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) verifyCodeSend:(VerifyCodeSendRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,VerifyCodeSendResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) passwordForgetUpdate:(PasswordForgetUpdateRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,PasswordForgetUpdateResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) registerUsersCreate:(RegisterUsersCreateRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,RegisterUsersCreateResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) registerAccountExists:(RegisterAccountExistsRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,RegisterAccountExistsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) registerNicknameExists:(RegisterNicknameExistsRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,RegisterNicknameExistsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) verifyForgetcodeSend:(VerifyForgetcodeSendRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,VerifyForgetcodeSendResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) registerThirdCreate:(RegisterThirdCreateRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,RegisterThirdCreateResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) registerNvitationCodeExists:(RegisterNvitationCodeExistsRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,RegisterNvitationCodeExistsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) operCodeSend:(OperCodeSendRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,OperCodeSendResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) passwordForgetOperatorUpdate:(PasswordForgetOperatorUpdateRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,PasswordForgetOperatorUpdateResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) snsIntegralGet:(SnsIntegralGetRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,SnsIntegralGetResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersCheckHistory:(UsersCheckHistoryRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersCheckHistoryResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) snsCheckResult:(SnsCheckResultRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,SnsCheckResultResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) snsRecommenGoodsAndStoreList:(SnsRecommenGoodsAndStoreListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,SnsRecommenGoodsAndStoreListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) snsCheckList:(SnsCheckListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,SnsCheckListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) snsHealthTaskSave:(SnsHealthTaskSaveRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,SnsHealthTaskSaveResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) paymetPasswordValidate:(PaymetPasswordValidateRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,PaymetPasswordValidateResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) personalAllCityList:(PersonalAllCityListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalAllCityListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) personalKeywordSearch:(PersonalKeywordSearchRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalKeywordSearchResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) personalGoodsDetails:(PersonalGoodsDetailsRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalGoodsDetailsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) personalCommentSave:(PersonalCommentSaveRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalCommentSaveResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) personalOrderRefund:(PersonalOrderRefundRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalOrderRefundResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) personalCouponRefund:(PersonalCouponRefundRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalCouponRefundResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) personalAwayStoreList:(PersonalAwayStoreListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalAwayStoreListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) personalYoulikeStoreList:(PersonalYoulikeStoreListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalYoulikeStoreListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) personalCancel:(PersonalCancelRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalCancelResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) personalHotSearch:(PersonalHotSearchRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalHotSearchResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) personalClassFindList:(PersonalClassFindListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalClassFindListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) personalAreaParentList:(PersonalAreaParentListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalAreaParentListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) personalFavoritesList:(PersonalFavoritesListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalFavoritesListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) personalRecommStoreList:(PersonalRecommStoreListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalRecommStoreListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) personalFavaGoodsList:(PersonalFavaGoodsListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalFavaGoodsListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) merchStoreList:(MerchStoreListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,MerchStoreListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) merchStoreCommonInfo:(MerchStoreCommonInfoRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,MerchStoreCommonInfoResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersConsultingList:(UsersConsultingListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersConsultingListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) snsConsultingDetail:(SnsConsultingDetailRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,SnsConsultingDetailResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) snsConsultingRepayAdd:(SnsConsultingRepayAddRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,SnsConsultingRepayAddResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) snsConsultingAdd:(SnsConsultingAddRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,SnsConsultingAddResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;

-(void) equipDayQueryByDate:(EquipDayQueryByDateRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,EquipDayQueryByDateResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) equipQueryByRange:(EquipQueryByRangeRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,EquipQueryByRangeResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) equipQueryWeekByMon:(EquipQueryWeekByMonRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,EquipQueryWeekByMonResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) equipQueryMonByYear:(EquipQueryMonByYearRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,EquipQueryMonByYearResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) equipWeekQuery:(EquipWeekQueryRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,EquipWeekQueryResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) equipSleepAdd:(EquipSleepAddRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,EquipSleepAddResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) equipSleepQueryByDate:(EquipSleepQueryByDateRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,EquipSleepQueryByDateResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) equipSleepQuery:(EquipSleepQueryRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,EquipSleepQueryResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) equipSleepWeek:(EquipSleepWeekRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,EquipSleepWeekResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) equipSleepQueryByRange:(EquipSleepQueryByRangeRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,EquipSleepQueryByRangeResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) equipSleepQueryWeekByMon:(EquipSleepQueryWeekByMonRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,EquipSleepQueryWeekByMonResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) equipAdd:(EquipAddRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,EquipAddResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) equipDayQuery:(EquipDayQueryRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,EquipDayQueryResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) shopExpressCompanyList:(ShopExpressCompanyListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopExpressCompanyListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) shopExpressTransView:(ShopExpressTransViewRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopExpressTransViewResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) salePromotionActivityAdMainInfo:(SalePromotionActivityAdMainInfoRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,SalePromotionActivityAdMainInfoResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) salePromotionActivityAdGoodsInfoList:(SalePromotionActivityAdGoodsInfoListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,SalePromotionActivityAdGoodsInfoListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) salePromotionAdInfo:(SalePromotionAdInfoRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,SalePromotionAdInfoResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) physicalSave:(PhysicalSaveRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,PhysicalSaveResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) physicalQuery:(PhysicalQueryRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,PhysicalQueryResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) physicalListQuery:(PhysicalListQueryRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,PhysicalListQueryResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;

-(void) physicalListSelectCode:(PhysicalListSelectCodeRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,PhysicalListSelectCodeResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) physicalDescription:(PhysicalDescriptionRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,PhysicalDescriptionResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) snsInformationAllList:(SnsInformationAllListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,SnsInformationAllListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) snsInformationClass:(SnsInformationClassRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,SnsInformationClassResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) snsInformationPageList:(SnsInformationPageListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,SnsInformationPageListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) snsBodyList:(SnsBodyListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,SnsBodyListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) selfOrderList:(SelfOrderListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,SelfOrderListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) selfGoodsConfirm:(SelfGoodsConfirmRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,SelfGoodsConfirmResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) selfDetail:(SelfDetailRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,SelfDetailResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) selfFavaList:(SelfFavaListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,SelfFavaListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) selfFavaDelete:(SelfFavaDeleteRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,SelfFavaDeleteResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) selfOrderDelete:(SelfOrderDeleteRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,SelfOrderDeleteResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) selfOrderEvaluateSave:(SelfOrderEvaluateSaveRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,SelfOrderEvaluateSaveResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) selfEvaluateAddSave:(SelfEvaluateAddSaveRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,SelfEvaluateAddSaveResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) selfEvaluateList:(SelfEvaluateListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,SelfEvaluateListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) selfOrderCancel:(SelfOrderCancelRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,SelfOrderCancelResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) sysArticlePageArticleList:(SysArticlePageArticleListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,SysArticlePageArticleListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) sysArticleAllArticleList:(SysArticleAllArticleListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,SysArticleAllArticleListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) sysArticleArticleClass:(SysArticleArticleClassRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,SysArticleArticleClassResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) shopTradePaymetView:(ShopTradePaymetViewRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopTradePaymetViewResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) shopTradeOrderCreate:(ShopTradeOrderCreateRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopTradeOrderCreateResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) shopTradePaymet:(ShopTradePaymetRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopTradePaymetResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) shopTradeReturnCancel:(ShopTradeReturnCancelRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopTradeReturnCancelResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) shopTradeReturnApply:(ShopTradeReturnApplyRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopTradeReturnApplyResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) shopTradeReturnList:(ShopTradeReturnListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopTradeReturnListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) shopTradeReturnView:(ShopTradeReturnViewRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopTradeReturnViewResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) shopTradeReturnShipSave:(ShopTradeReturnShipSaveRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopTradeReturnShipSaveResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) shopOrderStatusGet:(ShopOrderStatusGetRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopOrderStatusGetResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) shopCartRemove:(ShopCartRemoveRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopCartRemoveResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) shopCartAdd:(ShopCartAddRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopCartAddResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) shopFindUserCartQuery:(ShopFindUserCartQueryRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopFindUserCartQueryResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) shopTransportGet:(ShopTransportGetRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopTransportGetResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) shopCartSize:(ShopCartSizeRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopCartSizeResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) shopBuyGoods:(ShopBuyGoodsRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopBuyGoodsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) shopGoodsCountAdjust:(ShopGoodsCountAdjustRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopGoodsCountAdjustResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) shopGoodsTotalPrice:(ShopGoodsTotalPriceRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopGoodsTotalPriceResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) shopCartAddressSave:(ShopCartAddressSaveRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopCartAddressSaveResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) shopCartGoodsDetail:(ShopCartGoodsDetailRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopCartGoodsDetailResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) shopUserAddressAll:(ShopUserAddressAllRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopUserAddressAllResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) shopDefaultAddress:(ShopDefaultAddressRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopDefaultAddressResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) shopDeleteAddress:(ShopDeleteAddressRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopDeleteAddressResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) shopAddresList:(ShopAddresListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopAddresListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersExpertsPraise:(UsersExpertsPraiseRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersExpertsPraiseResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersExpertsUnpraise:(UsersExpertsUnpraiseRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersExpertsUnpraiseResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersExpertsList:(UsersExpertsListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersExpertsListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersExpertsDetail:(UsersExpertsDetailRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersExpertsDetailResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) personalCityGet:(PersonalCityGetRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalCityGetResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) personalHotCityGet:(PersonalHotCityGetRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalHotCityGetResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) personalServiceBuy:(PersonalServiceBuyRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalServiceBuyResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) personalPayView:(PersonalPayViewRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalPayViewResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) personalPayPage:(PersonalPayPageRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalPayPageResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) personalOrderPay:(PersonalOrderPayRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalOrderPayResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) personalOrderPayment:(PersonalOrderPaymentRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalOrderPaymentResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) personalPromotionGoodsList:(PersonalPromotionGoodsListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalPromotionGoodsListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) personalGroupGoodsLike:(PersonalGroupGoodsLikeRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalGroupGoodsLikeResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) personalGroupOrderList:(PersonalGroupOrderListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalGroupOrderListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) personalOrderLineList:(PersonalOrderLineListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalOrderLineListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) personalUnUsedorderDetails:(PersonalUnUsedorderDetailsRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalUnUsedorderDetailsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) personalStoreInfo:(PersonalStoreInfoRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalStoreInfoResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) personalOrderDetails:(PersonalOrderDetailsRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,PersonalOrderDetailsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) snsRecommendList:(SnsRecommendListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,SnsRecommendListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) snsCrcList:(SnsCrcListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,SnsCrcListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) integralList:(IntegralListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,IntegralListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) integralGoodCountGet:(IntegralGoodCountGetRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,IntegralGoodCountGetResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) integralOrderList:(IntegralOrderListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,IntegralOrderListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) integralDetails:(IntegralDetailsRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,IntegralDetailsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) integralCancel:(IntegralCancelRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,IntegralCancelResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) integralOrderCofirm:(IntegralOrderCofirmRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,IntegralOrderCofirmResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) integralSaveOrder:(IntegralSaveOrderRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,IntegralSaveOrderResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) integralRePayment:(IntegralRePaymentRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,IntegralRePaymentResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) integralComputeOrder:(IntegralComputeOrderRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,IntegralComputeOrderResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) integralAddressList:(IntegralAddressListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,IntegralAddressListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) integralListByCriteria:(IntegralListByCriteriaRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,IntegralListByCriteriaResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) integralExchange:(IntegralExchangeRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,IntegralExchangeResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) integralOrderDetails:(IntegralOrderDetailsRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,IntegralOrderDetailsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) groupAreaList:(GroupAreaListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupAreaListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) groupCheckInSave:(GroupCheckInSaveRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupCheckInSaveResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) groupOrderRefundSave:(GroupOrderRefundSaveRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupOrderRefundSaveResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) groupStoreInfoGet:(GroupStoreInfoGetRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupStoreInfoGetResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) groupOrderGet:(GroupOrderGetRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupOrderGetResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) groupConsumerSureMulti:(GroupConsumerSureMultiRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupConsumerSureMultiResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) groupConsumShareList:(GroupConsumShareListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupConsumShareListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) groupRebateCount:(GroupRebateCountRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupRebateCountResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) groupShareDetails:(GroupShareDetailsRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupShareDetailsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) groupOrderLineStatistics:(GroupOrderLineStatisticsRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupOrderLineStatisticsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) groupOrderStatistics:(GroupOrderStatisticsRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupOrderStatisticsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) groupOrderCountList:(GroupOrderCountListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupOrderCountListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) groupOrderLineDetails:(GroupOrderLineDetailsRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupOrderLineDetailsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) groupOrderRevenueDetails:(GroupOrderRevenueDetailsRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupOrderRevenueDetailsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) groupStoreCustomerList:(GroupStoreCustomerListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupStoreCustomerListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) groupPredepositList:(GroupPredepositListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupPredepositListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) groupGroupClassList:(GroupGroupClassListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupGroupClassListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) groupGoodsRefundList:(GroupGoodsRefundListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupGoodsRefundListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) groupOrderOnlineList:(GroupOrderOnlineListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupOrderOnlineListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) groupQueryGoodsList:(GroupQueryGoodsListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupQueryGoodsListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) groupQueryGoodsDetails:(GroupQueryGoodsDetailsRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupQueryGoodsDetailsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) groupQueryStoreStatus:(GroupQueryStoreStatusRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupQueryStoreStatusResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) groupVoucherDetails:(GroupVoucherDetailsRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupVoucherDetailsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) groupOrderDetails:(GroupOrderDetailsRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupOrderDetailsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) groupMerchantInfo:(GroupMerchantInfoRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupMerchantInfoResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) groupConsumerSure:(GroupConsumerSureRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupConsumerSureResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) groupOrderCartPay:(GroupOrderCartPayRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupOrderCartPayResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) groupEvaluateList:(GroupEvaluateListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupEvaluateListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) groupEvaluateSave:(GroupEvaluateSaveRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupEvaluateSaveResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) groupOrderMonthList:(GroupOrderMonthListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupOrderMonthListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) groupStoreAlbunList:(GroupStoreAlbunListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupStoreAlbunListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) groupGoodsShelves:(GroupGoodsShelvesRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupGoodsShelvesResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) groupMoneyCash:(GroupMoneyCashRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupMoneyCashResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersIntegralGet:(UsersIntegralGetRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersIntegralGetResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersBankInfoGet:(UsersBankInfoGetRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersBankInfoGetResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) bindingMobile:(BindingMobileRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,BindingMobileResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersSignLogin:(UsersSignLoginRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersSignLoginResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersFeedBack:(UsersFeedBackRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersFeedBackResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersSysHelp:(UsersSysHelpRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersSysHelpResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersNotice:(UsersNoticeRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersNoticeResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersArticMarkList:(UsersArticMarkListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersArticMarkListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersInvitationCodeCheckExists:(UsersInvitationCodeCheckExistsRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersInvitationCodeCheckExistsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersRelationList:(UsersRelationListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersRelationListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersIntegralDoc:(UsersIntegralDocRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersIntegralDocResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) userCustomerSavefirst:(UserCustomerSavefirstRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UserCustomerSavefirstResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) userCustomerCoupon:(UserCustomerCouponRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UserCustomerCouponResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersIntegral:(UsersIntegralRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersIntegralResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) groupAvailableBalanceGet:(GroupAvailableBalanceGetRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,GroupAvailableBalanceGetResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersCustomerSearch:(UsersCustomerSearchRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersCustomerSearchResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersCustomerUpdate:(UsersCustomerUpdateRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersCustomerUpdateResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersCustomerUpdateImg:(UsersCustomerUpdateImgRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersCustomerUpdateImgResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersPasswordUpdate:(UsersPasswordUpdateRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersPasswordUpdateResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersPayPasswordUpdate:(UsersPayPasswordUpdateRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersPayPasswordUpdateResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersIntegralGetByUid:(UsersIntegralGetByUidRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersIntegralGetByUidResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersOperaterMoneypassUpdate:(UsersOperaterMoneypassUpdateRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersOperaterMoneypassUpdateResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) openIdBindingCheck:(OpenIdBindingCheckRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,OpenIdBindingCheckResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) bindingList:(BindingListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,BindingListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) openIdBindingDelete:(OpenIdBindingDeleteRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,OpenIdBindingDeleteResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) bindingRegister:(BindingRegisterRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,BindingRegisterResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersOperatorNotices:(UsersOperatorNoticesRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersOperatorNoticesResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersSysNoticesDetails:(UsersSysNoticesDetailsRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersSysNoticesDetailsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersNoticesDetails:(UsersNoticesDetailsRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersNoticesDetailsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersArticleMarkDetails:(UsersArticleMarkDetailsRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersArticleMarkDetailsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersInvitationCodeBind:(UsersInvitationCodeBindRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersInvitationCodeBindResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersShareInfoGet:(UsersShareInfoGetRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersShareInfoGetResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersRefererInfo:(UsersRefererInfoRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersRefererInfoResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersShareInfoSave:(UsersShareInfoSaveRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersShareInfoSaveResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersIntegralList:(UsersIntegralListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersIntegralListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersYunMoneyList:(UsersYunMoneyListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersYunMoneyListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) searchClassGoods:(SearchClassGoodsRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,SearchClassGoodsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) searchGoodsKeyword:(SearchGoodsKeywordRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,SearchGoodsKeywordResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) searchGoodsHotKeyword:(SearchGoodsHotKeywordRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,SearchGoodsHotKeywordResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersFavorites:(UsersFavoritesRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersFavoritesResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersFavoritesCancle:(UsersFavoritesCancleRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersFavoritesCancleResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersExpertsCancle:(UsersExpertsCancleRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersExpertsCancleResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersInvitationQuery:(UsersInvitationQueryRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersInvitationQueryResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersExpertsQuery:(UsersExpertsQueryRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersExpertsQueryResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) operatorInfoGet:(OperatorInfoGetRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,OperatorInfoGetResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) operatorExpectProfitList:(OperatorExpectProfitListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,OperatorExpectProfitListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) operatorInvitationCodeGet:(OperatorInvitationCodeGetRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,OperatorInvitationCodeGetResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) operatorCashMoneyDetails:(OperatorCashMoneyDetailsRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,OperatorCashMoneyDetailsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) operatorMemberList:(OperatorMemberListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,OperatorMemberListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) operatorPasswordUpdate:(OperatorPasswordUpdateRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,OperatorPasswordUpdateResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) operatorProfitList:(OperatorProfitListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,OperatorProfitListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) operatorBusinessManagementList:(OperatorBusinessManagementListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,OperatorBusinessManagementListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) operatorProfitStatisList:(OperatorProfitStatisListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,OperatorProfitStatisListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) operatorStatisRelationList:(OperatorStatisRelationListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,OperatorStatisRelationListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) operatorRegisterList:(OperatorRegisterListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,OperatorRegisterListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) operatorMoneyCash:(OperatorMoneyCashRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,OperatorMoneyCashResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) caseList:(CaseListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,CaseListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) likeGoodsList:(LikeGoodsListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,LikeGoodsListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) likeYouGoodsList:(LikeYouGoodsListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,LikeYouGoodsListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) goodsCaseList:(GoodsCaseListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,GoodsCaseListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) goodsClassList:(GoodsClassListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,GoodsClassListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) goodsEvaluate:(GoodsEvaluateRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,GoodsEvaluateResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) goodsConsultList:(GoodsConsultListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,GoodsConsultListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) shopGoodsConsultSave:(ShopGoodsConsultSaveRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopGoodsConsultSaveResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) goodsDetails:(GoodsDetailsRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,GoodsDetailsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) shopStoreInfoGet:(ShopStoreInfoGetRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,ShopStoreInfoGetResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) goodsList:(GoodsListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,GoodsListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersCircleInvitationList:(UsersCircleInvitationListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersCircleInvitationListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersMyselfInvitationList:(UsersMyselfInvitationListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersMyselfInvitationListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersCircleList:(UsersCircleListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersCircleListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersCommentAdd:(UsersCommentAddRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersCommentAddResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersRepylAdd:(UsersRepylAddRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersRepylAddResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersInvitationAllList:(UsersInvitationAllListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersInvitationAllListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersInvitationSearch:(UsersInvitationSearchRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersInvitationSearchResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersCanclePraise:(UsersCanclePraiseRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersCanclePraiseResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersInvitationDetails:(UsersInvitationDetailsRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersInvitationDetailsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersInvitationExtend:(UsersInvitationExtendRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersInvitationExtendResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) snsFoodCaloriesList:(SnsFoodCaloriesListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,SnsFoodCaloriesListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersPraise:(UsersPraiseRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersPraiseResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersInvitationAdd:(UsersInvitationAddRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersInvitationAddResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersCircleQuery:(UsersCircleQueryRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersCircleQueryResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersReportList:(UsersReportListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersReportListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) usersReportSave:(UsersReportSaveRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,UsersReportSaveResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) snsFoodList:(SnsFoodListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,SnsFoodListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) reportSearch:(ReportSearchRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,ReportSearchResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) reportRepDetails:(ReportRepDetailsRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,ReportRepDetailsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) reportAdd:(ReportAddRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,ReportAddResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) reportResultClassList:(ReportResultClassListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,ReportResultClassListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) reportCheckList:(ReportCheckListRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,ReportCheckListResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) reportResultDetailsSave:(ReportResultDetailsSaveRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,ReportResultDetailsSaveResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) reportResultDetailsUpdate:(ReportResultDetailsUpdateRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,ReportResultDetailsUpdateResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) reportResultDetails:(ReportResultDetailsRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,ReportResultDetailsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) reportItem:(ReportItemRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,ReportItemResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
-(void) reportDetails:(ReportDetailsRequest *) req
                       success:(void (^)(AFHTTPRequestOperation *operation,ReportDetailsResponse *response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;
//method auto create end
@end
