//
//  GifManager.m
//  FLAnimatedImageDemo
//
//  Created by 张康健 on 15/12/2.
//  Copyright © 2015年 Flipboard. All rights reserved.
//

#import "GifManager.h"
#import "UIImageView+WebCache.h"
#define GifCachePath [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/gif"]
@implementation GifManager

+ (void)loadAnimatedImageWithURL:(NSURL *const)url
                        progress:(void (^)(float progress))progress
               completionFLImage:(void (^)(FLAnimatedImage *animatedImage))completionFlImage
           completionNormalImage:(void (^)(UIImage *animatedImage))completionNormalImage

{

    NSString *const filename = url.lastPathComponent;
    NSString *diskPath = [NSString stringWithFormat:@"%@/%@",GifCachePath,filename];
    
//    [[self class] removeGifCache];
    [[self class] creatDictionaryAtPath:diskPath];
    
    NSData * __block cachedData = [[NSFileManager defaultManager] contentsAtPath:diskPath];
    if (cachedData.length>0) {//有缓存
            FLAnimatedImage * __block animatedImage = [[FLAnimatedImage alloc] initWithAnimatedGIFData:cachedData];
            completionFlImage(animatedImage);
    }else {//无缓存，下载
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:url options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            if (data) {
                FLAnimatedImage * __block animatedImage = [[FLAnimatedImage alloc] initWithAnimatedGIFData:data];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            completionFlImage(animatedImage);
                        });
                [data writeToFile:diskPath atomically:YES];
            }
        }];
    }
}

+ (void)removeGifCache {

    [[NSFileManager defaultManager] removeItemAtPath:GifCachePath error:nil];
    
}

+ (void)creatDictionaryAtPath:(NSString *)diskPath {

    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDictionary;
    if (![fileManager fileExistsAtPath:GifCachePath isDirectory:&isDictionary]) {
        [fileManager createDirectoryAtPath:GifCachePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if (![fileManager fileExistsAtPath:diskPath]) {
        [fileManager createFileAtPath:diskPath contents:nil attributes:nil];
    }
}



@end
