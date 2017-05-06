//
//  questionViewController.h
//  jingGang
//
//  Created by yi jiehuang on 15/6/11.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VApiManager.h"
#import "AccessToken.h"
#import "GlobeObject.h"

@interface questionViewController : UIViewController<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, retain)NSMutableArray      *img_choose_array;//装图片的数组
@property (nonatomic, retain)NSMutableArray      *del_btn_array;//装删除按钮的数组
@property (nonatomic, strong)UILongPressGestureRecognizer *longPressGestureRecognizer;
@property (nonatomic, copy) NSString             *uID;//专家用户id

@property (nonatomic, copy)NSString              *bar_title;//bar标题
@property (nonatomic, copy)NSString              *title_str;//标题
@property (nonatomic, copy)NSString              *dis_str;//提问详情
@property (nonatomic, copy)NSString              *title_ID;//提问帖子ID
@property (nonatomic, copy)NSString              *imgs_url;//提问帖子图片地址
@property (nonatomic, copy)NSString              *web_id;//如果是我的问答跳转过来就会传值
@property (nonatomic, copy)NSString              *experts_id ;//专家id
@property (nonatomic, copy)NSString              *is_answer;//如果是个人中心我的问答调过来的

//@property (nonatomic, copy)NSString              

@end
