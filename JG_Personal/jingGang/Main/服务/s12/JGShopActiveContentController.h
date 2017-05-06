//
//  JGShopActiveContentController.h
//  jingGang
//
//  Created by dengxf on 15/12/9.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ControllerType) {
    ControllerPopImageType = 0 ,  // 弹出图片类型
    ControllerCustomViewType      // 弹出自定义视图类型
};

typedef NS_ENUM(NSUInteger, FilterButtonType) {
    FilterUserShouldConvertType = 0, // 我能兑换的
    FilterAllShopType,               // 全部
    FilterSectionType,               // 分段的
    FilterMostUpType                 // 5000以上的
};

typedef void(^FilterButtonClickBlock)(FilterButtonType buttonType,NSString *title);

typedef void(^CloseViewClickBlock)(void);

typedef void(^PushActivityPageBlock)(void);

@interface JGShopActiveContentController : UIViewController

/**
 *  弹出内容控制器类型
 */
@property (assign, nonatomic) ControllerType controllerType;

@property (copy , nonatomic) FilterButtonClickBlock filterButtonClickBlock;

@property (copy , nonatomic) CloseViewClickBlock closeViewClickBlock;

@property (copy , nonatomic) PushActivityPageBlock pushActivityPageBlock;


- (instancetype)initWithControllerType:(ControllerType)controllerType withModelObject:(id)object;

- (instancetype)initWithControllerType:(ControllerType)controllerType imageUrlString:(NSString *)urlString;

@end
