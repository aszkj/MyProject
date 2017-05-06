//
//  ZongHeZhengVC.h
//  jingGang
//
//  Created by 张康健 on 15/6/4.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    Commin_From_Body,       //从body页面进来
    commin_From_Zong_He_Zheng,//综合征点击进来
    Commin_From_JiBing,//疾病点击进来
    Commin_From_Heart, //从心理进来
//    Commin_From_Figure, //从形体进来
    Commin_From_Skin   //从皮肤进来
}ZZComminType;

@interface ZongHeZhengVC : UIViewController

//自测题ID
@property (nonatomic,strong)NSNumber *selfTestTiID;

@property (nonatomic,assign)ZZComminType comminType;

//下面分享需要用到的
@property (nonatomic,assign) long selectedID;

@property (nonatomic,copy) NSString *selectedTitle;

@property (nonatomic,copy) NSString *selectedContent;

@property (nonatomic,copy) NSString *selectedThumbNail;



@end
