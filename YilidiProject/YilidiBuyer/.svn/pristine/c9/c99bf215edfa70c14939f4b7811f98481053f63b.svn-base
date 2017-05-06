//
//  BrandDataManager.h
//  YilidiBuyer
//
//  Created by mm on 16/12/27.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^FetchBrandDataBlock)(NSMutableArray *brandDatas,NSArray *brandIndexs);

@interface BrandDataManager : NSObject

+ (instancetype)sharedManager;

- (void)startDownLoadBrandData;

- (void)fetchBrandData:(FetchBrandDataBlock)fetchBrandDataBlock;

@end
