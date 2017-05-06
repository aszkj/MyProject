//
//  SegementView.m
//  YilidiSeller
//
//  Created by yld on 16/6/29.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "SegementView.h"
#import "GlobleConst.h"

@implementation SegementView

- (instancetype)initWithSegementFrame:(CGRect)frame
                       segementTitles:(NSArray *)titles
{
    self = [super initWithFrame:frame];
    if (self) {
        _segementTitles = titles;
        [self _init];
        [self _setupUI];
    }
    return self;
}

-(void)_init {
    

    
    self.backgroundColor = UIColorFromRGB(0x045c98);
    self.selectedBackGroundColor = [UIColor whiteColor];
//    self.segementLayerBorderColor = UIColorFromRGB(0xF6E3B5);
//    self.segementLayerBorderWidth = 0.0f;
    self.segementLayerCornerRadius = 3.0f;
    self.segementInset = UIEdgeInsetsMake(1, 1, 1, 1);
    self.textColor = [UIColor whiteColor];
    self.selectedTextColor = KSelectedBgColor;
    self.textFont = [UIFont systemFontOfSize:15.0f];
}

- (void)_setupUI{
    
    NSInteger segementItemCount = self.segementTitles.count;
    CGFloat itemWidth = (self.frame.size.width-self.segementInset.left-self.segementInset.right) / segementItemCount;
    CGFloat itemHeight = self.frame.size.height - self.segementInset.top - self.segementInset.bottom;
    for (NSInteger i=0; i<segementItemCount; i++) {
        UIButton *segementButton = [[UIButton alloc] initWithFrame:CGRectMake(i*itemWidth+self.segementInset.left, self.segementInset.top, itemWidth, itemHeight)];
        [self addSubview:segementButton];
        segementButton.tag = i + 10;
        segementButton.titleLabel.font = self.textFont;
        [segementButton setTitle:self.segementTitles[i] forState:UIControlStateNormal];
        if (i == 0) {
            self.selectedSegementIndex = i;
            segementButton.selected = YES;
        }
        [self _configureSegementButton:segementButton];
        [segementButton addTarget:self action:@selector(clickSegement:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.layer.cornerRadius = self.segementLayerCornerRadius;
//    self.layer.borderColor = self.segementLayerBorderColor.CGColor;
//    self.layer.borderWidth = self.segementLayerBorderWidth;
    self.clipsToBounds = YES;
    
}

- (void)_configureSegementButton:(UIButton *)segementButton {
    
    [segementButton setTitleColor:self.textColor forState:UIControlStateNormal];
    [segementButton setTitleColor:self.selectedTextColor forState:UIControlStateSelected];
    segementButton.backgroundColor = segementButton.selected ? self.selectedBackGroundColor : self.backgroundColor;
    segementButton.layer.cornerRadius = self.segementLayerCornerRadius;
}


- (void)clickSegement:(UIButton *)segementButton {
    if (segementButton.selected) {
        return;
    }
    
    segementButton.selected = YES;
    segementButton.backgroundColor = self.selectedBackGroundColor;
    
    UIButton *lastSelectedButton = (UIButton *)[self viewWithTag:self.selectedSegementIndex+10];
    lastSelectedButton.selected = NO;
    lastSelectedButton.backgroundColor = self.backgroundColor;
    
    self.selectedSegementIndex = segementButton.tag-10;
    if (self.selectedSegementBlock) {
        self.selectedSegementBlock(self.selectedSegementIndex);
    }
    
}



@end
