#import "WEMEContent.h"

@implementation WEMEContent

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
  return [[JSONKeyMapper alloc] initWithDictionary:@{ @"code": @"code", @"content": @"content", @"description": @"_description", @"duration": @"duration", @"format": @"format", @"height": @"height", @"label": @"label", @"location_X": @"locationX", @"location_Y": @"locationY", @"mediaId": @"mediaId", @"msgtype": @"msgtype", @"picUrl": @"picUrl", @"recognition": @"recognition", @"scale": @"scale", @"thumbMediaId": @"thumbMediaId", @"title": @"title", @"url": @"url", @"width": @"width" }];
}

/**
 * Indicates whether the property with the given name is optional.
 * If `propertyName` is optional, then return `YES`, otherwise return `NO`.
 * This method is used by `JSONModel`.
 */
+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
  NSArray *optionalProperties = @[@"code", @"content", @"_description", @"duration", @"format", @"height", @"label", @"locationX", @"locationY", @"mediaId", @"msgtype", @"picUrl", @"recognition", @"scale", @"thumbMediaId", @"title", @"url", @"width"];

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
