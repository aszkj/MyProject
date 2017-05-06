//
//  NewDetailVC.h
//  jingGang
//
//  Created by wangying on 15/5/30.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JGMessageManager.h"
@interface NewDetailVC : UIViewController
@property(nonatomic,assign)NSInteger indett;

@property (nonatomic,strong)NSArray *zixun_messageArr;

//展示消息类型，咨询，自定义
@property (nonatomic, assign)RemotePushMessageType showMessageType;


@end
