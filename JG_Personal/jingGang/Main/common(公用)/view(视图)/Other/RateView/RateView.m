//
//  RateView.m
//  jingGang
//
//  Created by 张康健 on 15/8/17.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "RateView.h"

@interface RateView(){
    
    NSMutableArray *_starButtonArr;
    
}

@end

@implementation RateView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    _startCount = 0;
    _starButtonArr = [NSMutableArray arrayWithCapacity:5];
    for (int i=1; i <=5; i++) {
        UIButton *startButton = (UIButton *)[self viewWithTag:i];
        [_starButtonArr addObject:startButton];
    }
    
}

- (IBAction)clickStartAction:(id)sender {
    
    [self _dealwithClickAtStarIndex:((UIButton *)sender).tag ];
}

//每点击一次就对button数组处理，，选中点击之前的button,取消点击之后的button
-(void)_dealwithClickAtStarIndex:(NSInteger)starIndex{
    _startCount = starIndex;
    
    if (starIndex == 1) {//如果选择的是第一颗星星，并且之后没有选中的，那么取消第一个星星
        UIButton *firstStarButton = (UIButton *)_starButtonArr[0];
        if (firstStarButton.selected) {//如果第一个button是选中，才进行处理
            if ([self _dealwithFirstStarClick]) {//第一个之后没选中的
                firstStarButton.selected = NO;
                if (self.clickStarBackBlock) {
                    self.clickStarBackBlock(0);
                }
                return;
            }
        }
    }
    
    [self _dealWithClickiStarAtIndex:starIndex];
    if (self.clickStarBackBlock) {
        self.clickStarBackBlock(starIndex);
    }
}

-(void)_dealWithClickiStarAtIndex:(NSInteger)starIndex{

    for (int i=0; i<_starButtonArr.count; i++) {
        UIButton *starButton = _starButtonArr[i];
        if (i < starIndex) {
            starButton.selected = YES;
        }else{
            starButton.selected = NO;
        }
    }
}

//处理点击第一颗星星，并且之后星星都没有选中的情况
-(BOOL)_dealwithFirstStarClick{
    
    BOOL noSeleced = YES;
    for (NSInteger i=1; i<5; i++) {
        UIButton *starButton = _starButtonArr[i];
        if (starButton.selected) {
            noSeleced = NO;
            break;
        }
    }
    return noSeleced;
    
}


-(void)setStartCount:(NSInteger)startCount{
    _startCount = startCount;
    if (startCount > 0) {
        [self _dealWithClickiStarAtIndex:startCount];
    }else{//等于0，将所有星星都取消
        for (UIButton *button in _starButtonArr) {
            button.selected = NO;
        }
    }
}



@end
