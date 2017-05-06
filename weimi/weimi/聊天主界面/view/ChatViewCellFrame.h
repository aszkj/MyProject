//
//  ChatViewCellFrame.h
//  BaiYing_Thinker
//
//  Created by 鹏 朱 on 15/11/4.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Message.pb.h"
#import "RTLabel.h"
#import "SessonContentModel.h"



@class SessonContentModel;

typedef enum : NSUInteger {
    
    TextDataModelType = 1,
    ImageDataModelType = 2,
    VideoDataModelType = 3,
    AudioDataModelType = 4,
    WebDataModelType = 5,
    TextAndImageDataModelType = 6,
    
} DataModelType; //明细控制器类型

@interface ChatViewCellFrame : NSObject

@property (nonatomic, strong) SessonContentModel *messageModel;
@property (nonatomic, assign) CGSize webViewSize;
@property (nonatomic, assign) ProtoMessageContentType dataModelType;

@property (nonatomic, assign) CGRect headImageRect;
@property (nonatomic, assign) CGRect textRect;
@property (nonatomic, assign) CGRect imageRect;
@property (nonatomic, assign) CGRect webRect;
@property (nonatomic, assign) CGRect videoRect;
@property (nonatomic, assign) CGRect voiceImageRect;
@property (nonatomic, assign) CGRect voiceTimeRect;

//背景图位置
@property (nonatomic, assign) CGRect backImageRect;
//错误提示按钮位置
@property (nonatomic, assign) CGPoint errorPoint;
//发送中提示
@property (nonatomic, assign) CGPoint activityPoint;



- (CGFloat)cellHeight;
- (id)initWithDataModel:(SessonContentModel *)dataModel dataModelType:(ProtoMessageContentType)dataModelType webSize:(CGSize)webSize;
- (id)initWithDateModel:(SessonContentModel *)dataModel;

@end
