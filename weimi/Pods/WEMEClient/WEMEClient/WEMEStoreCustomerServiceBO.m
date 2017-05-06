#import "WEMEStoreCustomerServiceBO.h"

@implementation WEMEStoreCustomerServiceBO

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
  return [[JSONKeyMapper alloc] initWithDictionary:@{ @"accountMobile": @"accountMobile", @"address": @"address", @"applyDate": @"applyDate", @"areaId": @"areaId", @"createDate": @"createDate", @"disableDate": @"disableDate", @"disableReason": @"disableReason", @"email": @"email", @"headImgPath": @"headImgPath", @"invitationDate": @"invitationDate", @"isDeleted": @"isDeleted", @"isExistMsg": @"isExistMsg", @"mobile": @"mobile", @"name": @"name", @"orderNumber": @"orderNumber", @"sellerId": @"sellerId", @"sellerName": @"sellerName", @"sex": @"sex", @"status": @"status", @"storeId": @"storeId", @"storeLogoPath": @"storeLogoPath", @"storeName": @"storeName", @"uid": @"uid", @"updateBy": @"updateBy", @"updateTime": @"updateTime" }];
}

/**
 * Indicates whether the property with the given name is optional.
 * If `propertyName` is optional, then return `YES`, otherwise return `NO`.
 * This method is used by `JSONModel`.
 */
+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
  NSArray *optionalProperties = @[@"accountMobile", @"address", @"applyDate", @"areaId", @"createDate", @"disableDate", @"disableReason", @"email", @"headImgPath", @"invitationDate", @"isDeleted", @"isExistMsg", @"mobile", @"name", @"orderNumber", @"sellerId", @"sellerName", @"sex", @"status", @"storeId", @"storeLogoPath", @"storeName", @"uid", @"updateBy", @"updateTime"];

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
