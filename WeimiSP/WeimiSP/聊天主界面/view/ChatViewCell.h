//
//  ChatViewCell.h
//  BaiYing_Thinker
//
//  Created by 鹏 朱 on 15/11/4.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatViewCellFrame.h"
//#import <NIAttributedLabel.h>
#import "Message.pb.h"
#import "RTLabel.h"
#import "SessonContentModel.h"

typedef void (^PictureDidSelectedBlock)(NSString *);
typedef void (^ResendContentBlock)(NSIndexPath *);
typedef void (^ReloadDataBlock)(void);

@interface ChatViewCell : UITableViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) ChatViewCellFrame *cellFrame;
/**
 *  聊天信息
 */
@property (nonatomic, copy) SessonContentModel *messageModel;
@property (nonatomic,copy) ReloadDataBlock reloadDataBlock;
@property (nonatomic,copy) PictureDidSelectedBlock pictureDidSelectedBlock;
//图片
@property (nonatomic, strong) UIButton *headerBtn;
@property (nonatomic, strong) UIImageView *headerImg;

//文字
@property (nonatomic, strong) RTLabel *textContent;
//图片
@property (nonatomic, strong) UIImageView *imageContent;
//网页插件
@property (nonatomic, strong) UIView *webContent;
//视频插件
@property (nonatomic, strong) UIView *videoContent;
//音频插件
@property (nonatomic, strong) UIView *audioContent;
//聊天时间
@property (nonatomic, strong) UILabel *timeLabel;
//信息发送失败
@property (nonatomic, strong) UIButton *errorButton;
//信息正在发送中
@property (nonatomic, strong) UIActivityIndicatorView *activityView;

/**
 *  信息发送失败重发Block;
 */
@property (nonatomic, strong) ResendContentBlock resendContentBlock;



@property (nonatomic, assign) ProtoMessageContentType dataModelType;
@property (nonatomic, assign) CGSize webSize;

- (void)didSelectedTableViewRow;

// 更新组件状态并刷新
- (void)componentReloadDataWithMessage:(SessonContentModel *)message desc:(NSString *)desc;

+ (RTLabel*)textLabel;

//信息发送成功改变状态
- (void)sendSucceedChangeStatus:(BOOL)b;

@end
