//
//  comunitchildViewController.h
//  jingGang
//
//  Created by yi jiehuang on 15/5/26.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VApiManager.h"

#import "AccessToken.h"

@interface comunitchildViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

//@property (nonatomic, copy)NSString    * title_name;
@property (nonatomic, copy)NSString    * head_img_str;
//@property (nonatomic, copy)NSString    * num_lab;//帖子数
//@property (nonatomic, copy)NSString    * dis_lab;

@property int cycleId;
@property (nonatomic, strong) NSString *JGTitle;



//@property (nonatomic, assign)int          witch_vc;//如果是生活界面跳转过来就赋值

@end
