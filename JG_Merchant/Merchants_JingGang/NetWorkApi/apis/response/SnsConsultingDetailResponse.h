//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "ConsultingBO.h"

@interface SnsConsultingDetailResponse :  AbstractResponse
//提问对象
@property (nonatomic, readonly, copy) ConsultingBO *consultingBO;
@end
