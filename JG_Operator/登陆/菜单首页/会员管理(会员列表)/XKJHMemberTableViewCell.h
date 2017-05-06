//
//  XKJHMemberTableViewCell.h
//  Merchants_JingGang
//
//  Created by thinker on 15/9/2.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKO_MembersManagerResponseInfo.h"

@interface XKJHMemberTableViewCell : UITableViewCell

/**
 *  所属会员信息
 *
 *  @param response <#response description#>
 */
- (void) willCustomCellWith:(XKO_MembersManagerResponseInfo *)response;
/**
 *  注册会员信息
 */
- (void) willCustomRegisterWith:(NSDictionary *)dict;

@end
