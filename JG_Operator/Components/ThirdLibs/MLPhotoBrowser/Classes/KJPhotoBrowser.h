//
//  KJPhotoBrowser.h
//  jingGang
//
//  Created by 张康健 on 15/8/24.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KJPhotoBrowser : NSObject

-(id)initWithImgUrls:(NSArray *)imgUrls imgViewArrs:(NSArray *)imgViewArr;

-(void)clickImgViewAtIndex:(NSInteger)index;

@end
