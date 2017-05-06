//
//  FileDownload.m
//  BaiYing_Thinker
//
//  Created by 鹏 朱 on 15/10/21.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "FileDownload.h"
#import "NSString+MD5.h"
#import <AFNetworking.h>

#define kTimeOut        2.0f
// 每次下载的字节数
#define kBytesPerTimes  20250

@interface FileDownload()

@property (nonatomic, strong) NSString *cacheFile;
@property (nonatomic, strong) UIImage *cacheImage;

@end

@implementation FileDownload

//- (NSString *)cacheFile
//{
//    if (!_cacheFile) {
//        NSString *cacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
//        _cacheFile = [cacheDir stringByAppendingPathComponent:@"123.png"];
//    }
//    return _cacheFile;
//}

+ (FileDownload *)shareInstance
{
    static FileDownload *_this = nil;
    static dispatch_once_t onceTokenInit;
    dispatch_once(&onceTokenInit, ^{
        _this = [[FileDownload alloc] init];
    });
    return _this;
}

- (UIImage *)cacheImage
{
    if (!_cacheImage) {
        _cacheImage = [UIImage imageWithContentsOfFile:self.cacheFile];
    }
    return _cacheImage;
}

- (void)setCacheFile:(NSString *)urlStr
{
    NSString *cacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    
    urlStr = [urlStr MD5];
    
    _cacheFile = [cacheDir stringByAppendingPathComponent:urlStr];
}

- (void)downloadFileWithURL:(NSURL *)url completion:(void (^)(UIImage *image))completion
{
    // GCD中的串行队列异步方法
    dispatch_queue_t q = dispatch_queue_create("cn.itcast.download", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(q, ^{
        NSLog(@"%@", [NSThread currentThread]);
        
        // 把对URL进行MD5加密之后的结果当成文件名
        self.cacheFile = [url absoluteString];
        
        // 1. 从网络下载文件,需要知道这个文件的大小
        long long fileSize = [self fileSizeWithURL:url];
        // 计算本地缓存文件大小
        long long cacheFileSize = [self localFileSize];
        
        if (cacheFileSize == fileSize) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(self.cacheImage);
            });
            NSLog(@"文件已经存在");
            return;
        }
        
        // 2. 确定每个数据包的大小
        long long fromB = 0;
        long long toB = 0;
        // 计算起始和结束的字节数
        while (fileSize > kBytesPerTimes) {
            // 20480 + 20480
            //
            toB = fromB + kBytesPerTimes - 1;
            
            // 3. 分段下载文件
            [self downloadDataWithURL:url fromB:fromB toB:toB];
            
            fileSize -= kBytesPerTimes;
            fromB += kBytesPerTimes;
        }
        [self downloadDataWithURL:url fromB:fromB toB:fromB + fileSize - 1];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(self.cacheImage);
        });
    });
}

#pragma mark 下载指定字节范围的数据包
/**
 NSURLRequestUseProtocolCachePolicy = 0,        // 默认的缓存策略,内存缓存
 
 NSURLRequestReloadIgnoringLocalCacheData = 1,  // 忽略本地的内存缓存
 NSURLRequestReloadIgnoringCacheData
 */
- (void)downloadDataWithURL:(NSURL *)url fromB:(long long)fromB toB:(long long)toB
{
    NSLog(@"数据包:%@", [NSThread currentThread]);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:kTimeOut];
    
    // 指定请求中所要GET的字节范围
    NSString *range = [NSString stringWithFormat:@"Bytes=%lld-%lld", fromB, toB];
    [request setValue:range forHTTPHeaderField:@"Range"];
    NSLog(@"%@", range);
    
    NSURLResponse *response = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:NULL];
    
    // 写入文件,覆盖文件不会追加
    //    [data writeToFile:@"/Users/aplle/Desktop/1.png" atomically:YES];
    [self appendData:data];
    
    NSLog(@"%@", response);
}

#pragma mark - 读取本地缓存文件大小
- (long long)localFileSize
{
    // 读取本地文件信息
    NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:self.cacheFile error:NULL];
    NSLog(@"%lld", [dict[NSFileSize] longLongValue]);
    
    return [dict[NSFileSize] longLongValue];
}

#pragma mark - 追加数据到文件
- (void)appendData:(NSData *)data
{
    // 判断文件是否存在
    NSFileHandle *fp = [NSFileHandle fileHandleForWritingAtPath:self.cacheFile];
    // 如果文件不存在创建文件
    if (!fp) {
        [data writeToFile:self.cacheFile atomically:YES];
    } else {
        // 如果文件已经存在追加文件
        // 1> 移动到文件末尾
        [fp seekToEndOfFile];
        // 2> 追加数据
        [fp writeData:data];
        // 3> 写入文件
        [fp closeFile];
    }
}

#pragma mark - 获取网络文件大小
- (long long)fileSizeWithURL:(NSURL *)url
{
    // 默认是GET
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:kTimeOut];
    
    // HEAD 头,只是返回文件资源的信息,不返回具体是数据
    // 如果要获取资源的MIMEType,也必须用HEAD,否则,数据会被重复下载两次
    request.HTTPMethod = @"HEAD";
    
    // 使用同步方法获取文件大小
    NSURLResponse *response = nil;
    
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:NULL];
    
    // expectedContentLength文件在网络上的大小
    NSLog(@"%lld", response.expectedContentLength);
    
    return response.expectedContentLength;
}

- (void)downloadFileWithURL:(NSString *)urlString fileName:(NSString *)fileName completion:(void (^)(NSData *))completion {
    
    //下载附件
    NSURL *url = [NSURL URLWithString:urlString];
//    NSString *fileUrl = [NSString stringWithFormat:@"%@/%@", urlString, fileName];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.inputStream   = [NSInputStream inputStreamWithURL:url];
    operation.outputStream  = [NSOutputStream outputStreamToFileAtPath:fileName append:NO];
    
    //下载进度控制
     [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
         
         NSLog(@"File is download：%f", (float)totalBytesRead/totalBytesExpectedToRead);
         
     }];
    
    //已完成下载
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = [NSData dataWithContentsOfFile:fileName];
        if (completion) {
            completion(data);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    [operation start];
}

@end
