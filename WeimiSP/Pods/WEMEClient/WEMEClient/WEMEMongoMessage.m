#import "WEMEMongoMessage.h"

@implementation WEMEMongoMessage

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
  return [[JSONKeyMapper alloc] initWithDictionary:@{ @"channel": @"channel", @"content": @"content", @"id": @"_id", @"localId": @"localId", @"model": @"model", @"msgType": @"msgType", @"ownerId": @"ownerId", @"session": @"session", @"timestamp": @"timestamp", @"uid": @"uid", @"userInfo": @"userInfo" }];
}

/**
 * Indicates whether the property with the given name is optional.
 * If `propertyName` is optional, then return `YES`, otherwise return `NO`.
 * This method is used by `JSONModel`.
 */
+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
  NSArray *optionalProperties = @[@"channel", @"content", @"_id", @"localId", @"model", @"msgType", @"ownerId", @"session", @"timestamp", @"uid", @"userInfo"];

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
