#import "WEMEFeed.h"

@implementation WEMEFeed

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
  return [[JSONKeyMapper alloc] initWithDictionary:@{ @"broadcasted": @"broadcasted", @"content": @"content", @"id": @"_id", @"location": @"location", @"locationHumanText": @"locationHumanText", @"timestamp": @"timestamp", @"toFriendCircle": @"toFriendCircle", @"toLbs": @"toLbs", @"toService": @"toService", @"uid": @"uid" }];
}

/**
 * Indicates whether the property with the given name is optional.
 * If `propertyName` is optional, then return `YES`, otherwise return `NO`.
 * This method is used by `JSONModel`.
 */
+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
  NSArray *optionalProperties = @[@"broadcasted", @"content", @"_id", @"location", @"locationHumanText", @"timestamp", @"toFriendCircle", @"toLbs", @"toService", @"uid"];

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
