//
//  WInputXingViewController.h
//  jingGang
//
//  Created by thinker on 15/10/23.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XK_ViewController.h"
#import "PhysicalReportDetailModel.h"

@interface WInputXingViewController : XK_ViewController


#pragma mark -  修改接口

/**
 *  创建时间
 */
@property (nonatomic, readwrite, copy) NSString *createTime;

/**
 * 体检报告id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_replyId;
/**
 *  报告明细id
 */
@property (nonatomic, readwrite, strong) PhysicalReportDetailModel *detailsModel;


#pragma mark - 添加接口
/**
 * 体检项id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_itemId;



@end
