#import "WEMEMemberBO.h"

@implementation WEMEMemberBO

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
  return [[JSONKeyMapper alloc] initWithDictionary:@{ @"birthdate": @"birthdate", @"createBy": @"createBy", @"createTime": @"createTime", @"email": @"email", @"headImgPath": @"headImgPath", @"height": @"height", @"isDeleted": @"isDeleted", @"mobile": @"mobile", @"name": @"name", @"nickname": @"nickname", @"sex": @"sex", @"status": @"status", @"uid": @"uid", @"updateBy": @"updateBy", @"updateTime": @"updateTime", @"weight": @"weight" }];
}

/**
 * Indicates whether the property with the given name is optional.
 * If `propertyName` is optional, then return `YES`, otherwise return `NO`.
 * This method is used by `JSONModel`.
 */
+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
  NSArray *optionalProperties = @[@"birthdate", @"createBy", @"createTime", @"email", @"headImgPath", @"height", @"isDeleted", @"mobile", @"name", @"nickname", @"sex", @"status", @"uid", @"updateBy", @"updateTime", @"weight"];

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
