//
//  NLAbstractMenu.h
//  MTypeSDK
//
//  Created by wlx on 14-2-17.
//  Copyright (c) 2014年 wanglx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NLMenu.h"
@interface NLAbstractMenu : NSObject<NLMenu>
@property (nonatomic, strong) NSMutableArray* children;
@property (nonatomic, strong) NSString* eCodeStr;
@property (nonatomic, strong) NSString* name;
@property (nonatomic) BOOL bLeaf;
@property (nonatomic) BOOL bRoot;
-(id)initWithECode:(NSString *)eCode andName:(NSString *)name andIsLeaf:(BOOL)isLeaf;
@end
