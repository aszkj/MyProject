#import "WEMETaskBO.h"

@implementation WEMETaskBO

- (instancetype)init {
  self = [super init];

  if (self) {
    // initalise property's default value, if any
    
  }

  return self;
}

/**
 * Maps json key to property name.
 * This method is used by `JSONModel`.
 */
+ (JSONKeyMapper *)keyMapper
{
  return [[JSONKeyMapper alloc] initWithDictionary:@{ @"address": @"address", @"channelId": @"channelId", @"createBy": @"createBy", @"createTime": @"createTime", @"id": @"_id", @"invalidTime": @"invalidTime", @"isDeleted": @"isDeleted", @"lastStartWaitDistance": @"lastStartWaitDistance", @"lastStartWaitStore": @"lastStartWaitStore", @"lastStartWaitTime": @"lastStartWaitTime", @"lat": @"lat", @"lon": @"lon", @"member": @"member", @"messageViewBeginTime": @"messageViewBeginTime", @"mid": @"mid", @"platformCompleteTime": @"platformCompleteTime", @"platformServiceName": @"platformServiceName", @"price": @"price", @"sellerName": @"sellerName", @"serviceClassId": @"serviceClassId", @"serviceClassName": @"serviceClassName", @"status": @"status", @"storeCompleteTime": @"storeCompleteTime", @"storeServiceMobile": @"storeServiceMobile", @"storeServiceName": @"storeServiceName", @"subject": @"subject", @"taskDescription": @"taskDescription", @"userMobile": @"userMobile", @"userName": @"userName", @"waitSecond": @"waitSecond" }];
}

/**
 * Indicates whether the property with the given name is optional.
 * If `propertyName` is optional, then return `YES`, otherwise return `NO`.
 * This method is used by `JSONModel`.
 */
+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
  NSArray *optionalProperties = @[@"address", @"channelId", @"createBy", @"createTime", @"_id", @"invalidTime", @"isDeleted", @"lastStartWaitDistance", @"lastStartWaitStore", @"lastStartWaitTime", @"lat", @"lon", @"member", @"messageViewBeginTime", @"mid", @"platformCompleteTime", @"platformServiceName", @"price", @"sellerName", @"serviceClassId", @"serviceClassName", @"status", @"storeCompleteTime", @"storeServiceMobile", @"storeServiceName", @"subject", @"taskDescription", @"userMobile", @"userName", @"waitSecond"];

  if ([optionalProperties containsObject:propertyName]) {
    return YES;
  }
  else {
    return NO;
  }
}

/**
 * Gets the string presentation of the object.
 * This method will be called when logging model object using `NSLog`.
 */
- (NSString *)description {
    return [[self toDictionary] description];
}

@end
