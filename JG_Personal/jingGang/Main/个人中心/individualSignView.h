//
//  individualSignView.h
//  jingGang
//
//  Created by thinker on 15/10/27.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface individualSignView : UIView


@property (weak, nonatomic) IBOutlet UILabel *signDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *signJifenLabel;


/**
 *  签到所得积分
 */
@property (nonatomic, assign) NSInteger integral;
/**
 *  连续签到几天
 */
@property (nonatomic, assign) NSInteger day;

/**
 *  点击知道了，事件回调
 */
@property (nonatomic, copy) void (^signBlock)(NSInteger);



@end

