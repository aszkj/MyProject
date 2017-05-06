//
//  ShareSettingController.h
//  jingGang
//
//  Created by 张康健 on 15/12/22.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShareContentEditSuccessBlcok)(NSString *shareContent);

@interface ShareSettingController : UIViewController<UITextViewDelegate>

@property (nonatomic, copy)ShareContentEditSuccessBlcok shareContentEditSuccessBlcok;

@property (nonatomic, copy)NSString *shareContent;

@end
