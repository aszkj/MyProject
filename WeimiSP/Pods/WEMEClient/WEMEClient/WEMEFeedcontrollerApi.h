#import <Foundation/Foundation.h>
#import "WEMEPageResponseOfFeed.h"
#import "WEMEPageResponseOfReply.h"
#import "WEMESingleObjectValueResponseOfFeed.h"
#import "WEMEFeedRequest.h"
#import "WEMEPageResponseOfMongoMessage.h"
#import "WEMEPageResponseOfSimpleFeed.h"
#import "WEMESimpleResponse.h"
#import "WEMEObject.h"
#import "WEMEApiClient.h"


/**
 * NOTE: This class is auto generated by the swagger code generator program. 
 * https://github.com/swagger-api/swagger-codegen 
 * Do not edit the class manually.
 */

@interface WEMEFeedcontrollerApi: NSObject

@property(nonatomic, assign)WEMEApiClient *apiClient;

-(instancetype) initWithApiClient:(WEMEApiClient *)apiClient;
-(void) addHeader:(NSString*)value forKey:(NSString*)key;
-(unsigned long) requestQueueSize;
+(WEMEFeedcontrollerApi*) apiWithHeader:(NSString*)headerValue key:(NSString*)key;
+(WEMEFeedcontrollerApi*) sharedAPI;
///
///
/// 本人发布的信息
/// 根据本地收到的最新的时间拉取更新信息.<br/> 用户级别
///
/// @param lastupdate lastupdate
/// @param page page
/// @param datesearch datesearch
/// 
///
/// @return WEMEPageResponseOfFeed*
-(NSNumber*) myFeedUsingGETWithCompletionBlock :(NSNumber*) lastupdate 
     page:(NSNumber*) page 
     datesearch:(NSNumber*) datesearch 
    
    completionHandler: (void (^)(WEMEPageResponseOfFeed* output, NSError* error))completionBlock;
    


///
///
/// 本人发布的信息
/// 根据本地收到的最新的时间拉取更新信息.<br/> 用户级别
///
/// @param fid fid
/// @param lastupdate lastupdate
/// @param page page
/// 
///
/// @return WEMEPageResponseOfReply*
-(NSNumber*) myFeedRepliesUsingGETWithCompletionBlock :(NSString*) fid 
     lastupdate:(NSNumber*) lastupdate 
     page:(NSNumber*) page 
    
    completionHandler: (void (^)(WEMEPageResponseOfReply* output, NSError* error))completionBlock;
    


///
///
/// 信息发布
/// 发布需求.<br/> 用户级别
///
/// @param req 发布结构
/// 
///
/// @return WEMESingleObjectValueResponseOfFeed*
-(NSNumber*) publishUsingPOSTWithCompletionBlock :(WEMEFeedRequest*) req 
    
    completionHandler: (void (^)(WEMESingleObjectValueResponseOfFeed* output, NSError* error))completionBlock;
    


///
///
/// 拉取我发布的feed的回复
/// 根据本地收到的最新的时间拉取更新信息.<br/> 用户级别
///
/// @param lastupdate lastupdate
/// @param page page
/// 
///
/// @return WEMEPageResponseOfReply*
-(NSNumber*) findUnPullMyFeedReplyUsingGETWithCompletionBlock :(NSNumber*) lastupdate 
     page:(NSNumber*) page 
    
    completionHandler: (void (^)(WEMEPageResponseOfReply* output, NSError* error))completionBlock;
    


///
///
/// 拉取我接收到的feed的回复
/// 根据本地收到的最新的时间拉取更新信息.<br/> 用户级别
///
/// @param lastupdate lastupdate
/// @param page page
/// 
///
/// @return WEMEPageResponseOfReply*
-(NSNumber*) findUnPullMyReplyUsingGETWithCompletionBlock :(NSNumber*) lastupdate 
     page:(NSNumber*) page 
    
    completionHandler: (void (^)(WEMEPageResponseOfReply* output, NSError* error))completionBlock;
    


///
///
/// 拉取信息
/// 根据本地收到的最新的时间拉取更新消息.<br/> 用户级别
///
/// @param channel channel
/// @param lastupdate lastupdate
/// @param page page
/// @param datesearch datesearch
/// 
///
/// @return WEMEPageResponseOfMongoMessage*
-(NSNumber*) pullmessageUsingGETWithCompletionBlock :(NSString*) channel 
     lastupdate:(NSNumber*) lastupdate 
     page:(NSNumber*) page 
     datesearch:(NSNumber*) datesearch 
    
    completionHandler: (void (^)(WEMEPageResponseOfMongoMessage* output, NSError* error))completionBlock;
    


///
///
/// 发现信息拉取
/// 根据本地收到的最新的时间拉取更新信息.<br/> 用户级别
///
/// @param lastupdate lastupdate
/// @param page page
/// @param datesearch datesearch
/// 
///
/// @return WEMEPageResponseOfSimpleFeed*
-(NSNumber*) reciveFeedUsingGETWithCompletionBlock :(NSNumber*) lastupdate 
     page:(NSNumber*) page 
     datesearch:(NSNumber*) datesearch 
    
    completionHandler: (void (^)(WEMEPageResponseOfSimpleFeed* output, NSError* error))completionBlock;
    


///
///
/// 更新最后查看时间
/// 在点击查看与消息接收界面进行调用.<br/> 用户级别
///
/// @param channel channel
/// 
///
/// @return WEMESimpleResponse*
-(NSNumber*) updateViewTimeUsingGETWithCompletionBlock :(NSString*) channel 
    
    completionHandler: (void (^)(WEMESimpleResponse* output, NSError* error))completionBlock;
    


///
///
/// 获取单条信息
/// 获取指定id的信息.<br/> 用户级别
///
/// @param _id id
/// 
///
/// @return WEMESingleObjectValueResponseOfFeed*
-(NSNumber*) getFeedUsingGETWithCompletionBlock :(NSString*) _id 
    
    completionHandler: (void (^)(WEMESingleObjectValueResponseOfFeed* output, NSError* error))completionBlock;
    



@end
