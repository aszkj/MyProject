//
//  GifManager.h
//  FLAnimatedImageDemo
//
//  Created by 张康健 on 15/12/2.
//  Copyright © 2015年 Flipboard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLAnimatedImage.h"

@interface GifManager : NSObject

+ (void)loadAnimatedImageWithURL:(NSURL *const)url
                        progress:(void (^)(float progress))progress
                      completionFLImage:(void (^)(FLAnimatedImage *animatedImage))completion
           completionNormalImage:(void (^)(UIImage *animatedImage))completion;

+ (void)removeGifCache;
@end
