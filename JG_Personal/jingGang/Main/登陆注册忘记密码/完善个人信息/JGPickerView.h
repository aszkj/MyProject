//
//  JGPickerView.h
//  jingGang
//
//  Created by Ai song on 16/1/28.
//  Copyright © 2016年 Dengxf_Dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AreaObject.h"
@class JGPickerView;

typedef void (^AddressChoicePickerViewBloc)(JGPickerView *view,UIButton *btn,AreaObject *locate);
@interface JGPickerView : UIView
@property (copy, nonatomic)AddressChoicePickerViewBloc block;
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
