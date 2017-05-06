//
//  ComplainViewPhotoCell.m
//  Operator_JingGang
//
//  Created by HanZhongchou on 15/11/12.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "ComplainViewPhotoCell.h"
@interface ComplainViewPhotoCell()
/**
 *  证据图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageViewComplainPhoto;

@end

@implementation ComplainViewPhotoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setStrPhotoUrl:(NSString *)strPhotoUrl
{
    _strPhotoUrl = strPhotoUrl;
    NSURL *url = [NSURL URLWithString:_strPhotoUrl];
    
    [self.imageViewComplainPhoto sd_setImageWithURL:url placeholderImage:DefaultImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        JGLog(@"UIImage---%@,cacheType----%ld,imageURL----%@",image,(long)cacheType,imageURL);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

@end
