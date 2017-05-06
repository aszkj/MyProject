//
//  WMERResultViewController.h
//  jingGang
//
//  Created by thinker on 15/10/22.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XK_ViewController.h"

@interface WMERResultViewController : XK_ViewController
/**
 *  创建时间
 */
@property (nonatomic, readwrite, copy) NSString *createTime;

@property (nonatomic,copy) NSNumber *apiId; //体检报告ID
@end
