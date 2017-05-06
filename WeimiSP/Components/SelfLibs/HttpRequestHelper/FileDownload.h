//
//  FileDownload.h
//  BaiYing_Thinker
//
//  Created by 鹏 朱 on 15/10/21.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileDownload : NSObject

+ (FileDownload *) shareInstance;

- (void)downloadFileWithURL:(NSURL *)url completion:(void (^)(UIImage *image))completion;
- (void)downloadFileWithURL:(NSString *)urlString fileName:(NSString *)fileName completion:(void (^)(NSData *))completion;

@end
