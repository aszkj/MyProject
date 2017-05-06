//
//  EditPersonInfoController.h
//  weimi
//
//  Created by 张康健 on 16/2/19.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^EditPersonInfoBlock)(NSString *nickName,UIImage *headerImage,NSString *telNumber);
@interface EditPersonInfoController : UIViewController

@property (nonatomic, copy)NSString *nickName;
@property (nonatomic, strong)UIImage *headerImage;
@property (nonatomic, copy)NSString *telNumber;

@property (nonatomic, copy)EditPersonInfoBlock editPersonInfoBlock;

@end
