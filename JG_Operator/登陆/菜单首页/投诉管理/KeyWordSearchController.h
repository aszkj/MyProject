//
//  KeyWordSearchController.h
//  Operator_JingGang
//
//  Created by dengxf on 15/10/30.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKO_BaseViewController.h"

@interface KeyWordSearchController : XKO_BaseViewController

/**
 *  需要搜索的列表的状态 1处理中  3已完成
 */
@property (nonatomic,assign) NSInteger complainStatus;

@end
