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


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self _init];
    }
    return self;
}

-(void)_init {

    self.backgroundColor = [UIColor whiteColor];
    self.selectedBackGroundColor = KSelectedBgColor;
    self.segementLayerBorderColor = KSelectedBgColor;
    self.segementLayerBorderWidth = 1.0f;
    self.segementLayerCornerRadius = 3.0f;
    self.textColor = UIColorFromRGB(0x333333);
    self.selectedTextColor = self.textColor;
    self.textFont = [UIFont systemFontOfSize:14.0f];
}

- (void)_setupUI{
    
    NSInteger segementItemCount = self.segementTitles.count;
    CGFloat itemWidth = self.frame.size.width / segementItemCount;
    CGFloat itemHeight = self.frame.size.height;
    for (NSInteger i=0; i<segementItemCount; i++) {
        UIButton *segementButton = [[UIButton alloc] initWithFrame:CGRectMake(i*itemWidth, 0, itemWidth, itemHeight)];
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
    self.layer.borderColor = self.segementLayerBorderColor.CGColor;
    self.layer.borderWidth = self.segementLayerBorderWidth;
    self.clipsToBounds = YES;
}

- (void)setSegementTitles:(NSArray *)segementTitles {
    _segementTitles = segementTitles;
    [self _setupUI];
}

- (void)_configureSegementButton:(UIButton *)segementButton {
    
    [segementButton setTitleColor:self.textColor forState:UIControlStateNormal];
    [segementButton setTitleColor:self.selectedTextColor forState:UIControlStateSelected];
    segementButton.backgroundColor = segementButton.selected ? self.selectedBackGroundColor : self.backgroundColor;
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
