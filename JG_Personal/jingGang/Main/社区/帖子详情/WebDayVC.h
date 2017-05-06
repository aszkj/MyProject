//
//  WebDayVC.h
//  jingGang
//
//  Created by wangying on 15/6/15.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    Need_Big_Repy,//有大恢复
    Do_not_need_Big_Repy,
} RepyType;

@interface WebDayVC : UIViewController
@property(nonatomic,strong)NSString *strUrl;
@property(nonatomic,assign)NSInteger ind;
@property(nonatomic,assign)BOOL isDianZan;

/**
 *  1:帖子（链接），2商品，3商户，4资讯（静港项目）（链接）5服务商户 6服务   dic[@"adType"] == 1 dic才有值(帖子或或者链接)
 */
@property(nonatomic,strong) NSDictionary *dic;

//回复类型,回复帖子，回复评论
@property (nonatomic,assign)RepyType repyType;

@property (nonatomic,copy)void (^backBlock)();


@end
