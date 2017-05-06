//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ComplaintsHandlerResponse.h"

@implementation ComplaintsHandlerResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"totalCount":@"totalCount",
			@"groupComplaintBOs":@"groupComplaintBOs",
			@"groupComplaintsBO":@"groupComplaintsBO",
			@"totalPage":@"totalPage"
             };
}

+(NSValueTransformer *) groupComplaintBOsTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GroupComplaint class]];
}
+(NSValueTransformer *) groupComplaintsBOTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GroupComplaint class]];
}
@end
