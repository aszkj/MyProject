//
//  FaceDetailVC.h
//  jingGang
//
//  Created by 张康健 on 15/6/16.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^ClickItemBlock)(long clikeID);
@interface FaceDetailVC : UIViewController

@property (nonatomic,strong)NSString *faceDetail_Title;

@property (nonatomic,assign)long faceDetailID;

@property (nonatomic,copy)ClickItemBlock clickItemBlock;


@end
