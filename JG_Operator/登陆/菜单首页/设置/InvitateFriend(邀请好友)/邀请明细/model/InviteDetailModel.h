//
//  InviteDetailModel.h
//  jingGang
//
//  Created by HanZhongchou on 15/12/21.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InviteDetailModel : NSObject

/**
 *  头像UrlString
 */
@property (nonatomic,copy) NSString *headImgPath;
/**
 *  用户名称
 */
@property (nonatomic,copy) NSString *nickname;
/**
 *  注册手机号
 */
@property (nonatomic,copy) NSString *mobile;
/**
 *  注册日期
 */
@property (nonatomic,copy) NSString *registerTime;



@end
