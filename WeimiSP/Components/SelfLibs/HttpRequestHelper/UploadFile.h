//
//  UploadFile.h
//  BaiYing_Thinker
//
//  Created by 鹏 朱 on 15/10/21.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

typedef enum {
    IMImageUploadFileType,
    IMAudioUploadFileType,
    IMVideoUploadFileType
} IMUploadFileType;

typedef void (^UploadFileComplate)(NSDictionary *);
typedef void (^UploadImageSuccedBlock)(NSString *url);
typedef void (^FailureBlock)(NSString *failure);

#import <Foundation/Foundation.h>

@interface UploadFile : NSObject<NSURLConnectionDelegate>

@property (nonatomic, strong) NSMutableData *mResponseData;
@property (nonatomic,copy) UploadFileComplate uploadFileSuccess;

+ (UploadFile *)shareInstance;

#pragma mark - 上传文件
- (void)uploadFileWithURL:(NSURL *)url data:(NSData *)data;
-(void)sendMessageWithDictionary:(NSDictionary *)dic url:(NSString *)url;
#pragma mark - 上传文件
-(void)upLoadFileWithURL:(NSString *)url data:(NSData *)data type:(IMUploadFileType)type uploadFileSuccess:(UploadFileComplate)uploadFileSuccess;
//-(void)_upLoadHeadImgWithImgData;

-(NSString *)getChannelInfoWithChannel:(NSString *)channel url:(NSString *)urlString;


////上传图片回调
-(void)uploadImageWithUIImage:(UIImage *)selectedImg succeedBlock:(UploadImageSuccedBlock)block;
//上次图片、语音
-(void)uploadImageWithFileName:(NSString *)fileName withType:(NSString *)type succeedBlock:(UploadImageSuccedBlock)block failure:(FailureBlock)failure;

/**
 *  上传通讯录
 */
- (void)uploadAddressBook;
@end
