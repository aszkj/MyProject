//
//  KeyboardNextActionHander.m
//  Operator_JingGang
//
//  Created by 张康健 on 15/10/12.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "KeyboardNextActionHander.h"

@interface KeyboardNextActionHander()<UITextFieldDelegate>{
    
    NSMutableArray *_subTextFileds;     //子textFiled,未排序的
    UIView         *_bodyView;          //容器视图
}

@end

@implementation KeyboardNextActionHander

-(id)initWithBodyView:(UIView *)bodyView goNextByType:(GoNextByType)goNextByType
{
    self = [super init];
    if (self) {
        
        _subTextFileds = [NSMutableArray arrayWithCapacity:0];
        _bodyView = bodyView;
        
        //设置textFiled子视图
        [self _setSubTextFiledsWithBodyView:bodyView];
        
        //对子textField排序
        [self _orderSubTextFieldsWithOrderType:goNextByType];
        
        //设置keyboardReturnKeyType
        [self _setTextFieldsReturnKeyType];
        
    }
    return self;
}


-(void)_setTextFieldsReturnKeyType {

    for (int i=0; i<_subTextFileds.count; i++) {
        UITextField *textFiled = _subTextFileds[i];
        if (i == _subTextFileds.count - 1 ) {
            textFiled.returnKeyType = UIReturnKeyDone;
        }else {
            textFiled.returnKeyType = UIReturnKeyNext;
        }
    }
}

-(void)_setSubTextFiledsWithBodyView:(UIView *)bodyView {

    if ([bodyView isMemberOfClass:[UITextField class]]) {//是textFiled
        UITextField *subTextFiled = (UITextField *)bodyView;
        subTextFiled.delegate = self;
        [_subTextFileds addObject:subTextFiled];
        return;
    }else {//不是textFiled
        if (!bodyView.subviews.count) { //没有子视图，返回
            return;
        }else {//有子视图，递归子视图，继续遍历
            for (UIView *subView in bodyView.subviews) {
                [self _setSubTextFiledsWithBodyView:subView];
            }
        }
    }
}

-(void)_orderSubTextFieldsWithOrderType:(GoNextByType)goNextByType {

    switch (goNextByType) {
        case GoNextBySubviews:
            //默认方式
            break;
        case GoNextByPosition:
            //从上往下顺序
            [self _orderByPosition];
            break;
        case GoNextByTag:
            //tag大小
            [self _orderByTag];
            break;
            
        default:
            break;
    }
}

-(void )_orderByPosition {
    
    [_subTextFileds sortUsingComparator:^NSComparisonResult(UITextField* textField1, UITextField* textField2) {
        
        CGRect frame1 = [textField1 convertRect:textField1.frame toView:_bodyView];
        CGRect frame2 = [textField2 convertRect:textField2.frame toView:_bodyView];
        NSNumber *positionY1 = @(frame1.origin.y);
        NSNumber *positionY2 = @(frame2.origin.y);
        return [positionY1 compare:positionY2];
    }];
    
    
}

-(void)_orderByTag {
    
    [_subTextFileds sortUsingComparator:^NSComparisonResult(UITextField* textField1, UITextField* textField2) {
        NSNumber *positionY1 = @(textField1.tag);
        NSNumber *positionY2 = @(textField2.tag);
        return [positionY1 compare:positionY2];
    }];
}


#pragma mark ----------------------- TextField Method -----------------------
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger firstResponderTextFieldIndex = [_subTextFileds indexOfObject:textField];
    if (firstResponderTextFieldIndex == _subTextFileds.count-1) {//最后一个
        if (self.lastNextBlock) {
            self.lastNextBlock();
        }
        [textField resignFirstResponder];
    }else {
        UITextField *nextResponseTextField = (UITextField *)[_subTextFileds objectAtIndex:firstResponderTextFieldIndex+1];
        [nextResponseTextField becomeFirstResponder];
    }
    
    return YES;

}

@end
