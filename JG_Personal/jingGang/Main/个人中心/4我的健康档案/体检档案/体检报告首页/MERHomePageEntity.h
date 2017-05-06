//
//  MERHomePageEntity.h
//  jingGang
//
//  Created by ray on 15/10/21.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSInteger, ReportStatus) {
    ReportStatusUncommit = 1,
    ReportStatusCommit = 2,
    ReportStatusHandled = 3,
};

@interface MERHomePageEntity : NSObject

@property (nonatomic) NSNumber *apiId;
@property (nonatomic,copy) NSString *resultname;
@property (nonatomic,copy) NSAttributedString *reportTimeAttributedString;
@property (nonatomic,copy) NSString *createtime;
@property (nonatomic,copy) NSNumber *status;
@property (nonatomic,copy) NSString *createby;
@end
