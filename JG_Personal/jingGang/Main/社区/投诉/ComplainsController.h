//
//  ComplainsController.h
//  jingGang
//
//  Created by dengxf on 15/10/30.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ComplainType) {
    InvitationType,     // 帖子类型
    InformationType     // 资讯类型
};

@interface ComplainsController : UIViewController

/**
 *  // targetId	Long	否	是	举报对象 id
 */
@property (copy , nonatomic) NSString *targetId;

/**
 *  举报的类型
 */
@property (assign, nonatomic) ComplainType complainType;



@end
