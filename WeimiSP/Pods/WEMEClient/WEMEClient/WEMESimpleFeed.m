#import "WEMESimpleFeed.h"

@implementation WEMESimpleFeed

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
  return [[JSONKeyMapper alloc] initWithDictionary:@{ @"channel": @"channel", @"content": @"content", @"id": @"_id", @"location": @"location", @"locationHumanText": @"locationHumanText", @"readed": @"readed", @"relationship": @"relationship", @"snapshot": @"snapshot", @"timestamp": @"timestamp", @"uid": @"uid" }];
}

/**
 * Indicates whether the property with the given name is optional.
 * If `propertyName` is optional, then return `YES`, otherwise return `NO`.
 * This method is used by `JSONModel`.
 */
+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
  NSArray *optionalProperties = @[@"channel", @"content", @"_id", @"location", @"locationHumanText", @"readed", @"relationship", @"snapshot", @"timestamp", @"uid"];

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
