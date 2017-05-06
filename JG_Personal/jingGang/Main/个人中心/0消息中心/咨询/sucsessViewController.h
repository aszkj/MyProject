//
//  sucsessViewController.h
//  jingGang
//
//  Created by yi jiehuang on 15/6/24.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sucsessViewController : UIViewController<UIWebViewDelegate>

@property (nonatomic, copy)NSString  * Web_URL;
@property (nonatomic, copy)NSString  * is_answer;//如果是个人中心我的问答调过来的。
@property (nonatomic, copy)NSString  * web_id;//具体的某一个问答的id号
@property (nonatomic, copy)NSString  * experts_id ;//专家id
@property (nonatomic, copy)NSString  * vc_str;
//@property (nonatomic, copy)NSString  * tit_Id;//咨询帖子id

@end
