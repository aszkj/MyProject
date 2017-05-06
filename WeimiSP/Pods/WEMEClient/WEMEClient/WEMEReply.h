#import <Foundation/Foundation.h>
#import "WEMEObject.h"

/**
 * NOTE: This class is auto generated by the swagger code generator program.
 * https://github.com/swagger-api/swagger-codegen
 * Do not edit the class manually.
 */

#import "WEMEFeed.h"
#import "WEMEPoint.h"
#import "WEMEMessageSnapshot.h"
#import "WEMEBroadcast.h"


@protocol WEMEReply
@end

@interface WEMEReply : WEMEObject


@property(nonatomic) WEMEBroadcast* broadcast;

@property(nonatomic) WEMEFeed* feed;

@property(nonatomic) NSString* fid;

@property(nonatomic) NSString* fuid;

@property(nonatomic) NSString* _id;

@property(nonatomic) NSNumber* lastUpdate;

@property(nonatomic) WEMEPoint* location;

@property(nonatomic) NSString* locationHumanText;

@property(nonatomic) NSNumber* readed;

@property(nonatomic) WEMEMessageSnapshot* snapshot;

@property(nonatomic) NSNumber* timestamp;

@property(nonatomic) NSString* uid;

@end
