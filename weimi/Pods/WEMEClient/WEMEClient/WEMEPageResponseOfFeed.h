#import <Foundation/Foundation.h>
#import "WEMEObject.h"

/**
 * NOTE: This class is auto generated by the swagger code generator program.
 * https://github.com/swagger-api/swagger-codegen
 * Do not edit the class manually.
 */

#import "WEMEPageOfFeed.h"


@protocol WEMEPageResponseOfFeed
@end

@interface WEMEPageResponseOfFeed : WEMEObject


@property(nonatomic) NSString* error;

@property(nonatomic) NSString* errorDescription;

@property(nonatomic) WEMEPageOfFeed* page;

@property(nonatomic) NSNumber* success;

@end