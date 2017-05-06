//
//  DeleteImageView.h
//  jingGang
//
//  Created by dengxf on 15/10/22.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, StateType) {
    DeleteButtonHidden = 0,
    DeleteButtonShow,
};

@class DeleteImageView;
@protocol DeleImageViewDelegate<NSObject>

@optional

- (void)deleImageViewLongPress:(DeleteImageView *)deleteImageView state:(StateType)stateType;

- (void)deleteButtonClick:(DeleteImageView *)deleteImageView;

@end


@interface DeleteImageView : UIImageView

@property (assign, nonatomic) id<DeleImageViewDelegate>delegate;

/**
 *   是否显示按钮
 */
@property (assign, nonatomic) BOOL isShowDeleteButtn;

@end
