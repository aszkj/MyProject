//
//  DarlingCommentModel.m
//  jingGang
//
//  Created by 张康健 on 15/8/18.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "DarlingCommentModel.h"

@implementation DarlingCommentModel

-(id)init{
    
    self = [super init];
    if (self) {
        _commentTextContent = @"";
        _commentImgArr = [NSMutableArray arrayWithCapacity:0];
        _commentImgUrlArr = [NSMutableArray arrayWithCapacity:0];
        _descriptionStars = 0;
        _serviceAltitudeStars = 0;
        _deliveryServiceStars = 0;
        _commentLevel = 0;
        
    }
    return self;
}

-(NSString *)joinedImgUrlStr{
    if (_commentImgUrlArr.count == 0) {
        return @"";
    }
    return [_commentImgUrlArr componentsJoinedByString:@";"];
    
}

@end
