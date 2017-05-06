//
//  RepyCommentVC.h
//  jingGang
//
//  Created by 张康健 on 15/6/25.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CommentCompletedBlock)(void);

@interface RepyCommentVC : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property (nonatomic,strong)NSNumber *invitationID;

@property (nonatomic,strong)NSNumber *rePyID;

@property (nonatomic,copy)CommentCompletedBlock commentCompletedBlock;



@end
