//
//  PhotoVedioFrameCapture.h
//  摄像头区域定制测试
//
//  Created by 张康健 on 15/7/27.
//  Copyright (c) 2015年 com.organazation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

typedef void(^PhotoFrameCaptureBlock)(float r_value);

@interface PhotoVedioFrameCapture : NSObject

//初始化，给定摄像头显示区域view
-(id)initWithPhotoView:(UIView *)photoView;

//视频帧回调block
@property (nonatomic,copy)PhotoFrameCaptureBlock photoFrameCaptureBlock;

//开始摄像头会话，并回调每一帧RGB中r的值
- (void)setupAVCaptureWithFrameRvlue:(PhotoFrameCaptureBlock)r_Block withError:(void(^)(NSError *error))errorBlock;


//关闭视频会话
- (void)stopAVCapture;

@end
