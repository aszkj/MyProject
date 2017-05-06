//
//  AddressChoicePickerView.h
//  Wujiang
//
//  Created by zhengzeqin on 15/5/27.
//  Copyright (c) 2015年 com.injoinow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AreaObject.h"
@class AddressChoicePickerView;
typedef void (^AddressChoicePickerViewBlock)(AddressChoicePickerView *view,UIButton *btn,AreaObject *locate);
@interface AddressChoicePickerView : UIView

@property (copy, nonatomic)AddressChoicePickerViewBlock block;
//区域 数组
@property (strong, nonatomic) NSArray *regionArr;
//省 数组
@property (strong, nonatomic) NSMutableArray *provinceArr;
//城市 数组
@property (strong, nonatomic) NSMutableArray *cityArr;
//区县 数组
@property (strong, nonatomic) NSMutableArray *areaArr;
//picker字典
@property (strong, nonatomic)NSDictionary *pickerDic;
//picker数组
@property (strong, nonatomic)NSArray *pickerArr;
- (void)show;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com