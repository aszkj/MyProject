//
//  KJGoodDetailPhotoTextDetailView.m
//  jingGang
//
//  Created by 张康健 on 15/8/7.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "KJGoodDetailPhotoTextDetailView.h"
#import "Util.h"

@interface KJGoodDetailPhotoTextDetailView()<UIWebViewDelegate,UIScrollViewDelegate>{
    NSArray *_contentWebViewArr;
}

@end

@implementation KJGoodDetailPhotoTextDetailView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self _initInfo];
}

-(void)_initInfo{
    //不能在这里面初始化topBar属性，
//    [self.ptTopbarControl setDefaultAtrribute];
    self.ptTopbarControl.sectionTitles = @[@"图文详情"];
    self.ptTopbarControl.selectionIndicatorColor = [UIColor clearColor];
    
    //设置父视图代理
    self.ptPhotoDetailWeb.scrollView.delegate = self;
    self.ptPackageListWeb.scrollView.delegate = self;
    
    _contentWebViewArr = @[self.ptPhotoDetailWeb,self.ptPackageListWeb];
    //test
    

}

#pragma mark - layout subviews
-(void)layoutSubviews{
    
    [super layoutSubviews];
    //这个设置一定要在layoutsubView里面调
    [self.ptTopbarControl setDefaultAtrribute];
    self.ptTopbarControl.selectionIndicatorHeight = 0.4;
}


#pragma mark - web ScrollView delegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
   
//        NSLog(@"small scroll end drag content offset y %.2f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y < -50) {
        if (self.upBlock) {
            self.upBlock(self.ptTopbarControl.selectedSegmentIndex);
        }
    }
    
}



#pragma mark - action Method
- (IBAction)indexChangedAction:(id)sender {
    
    HMSegmentedControl *segmentedControl = (HMSegmentedControl *)sender;
    //找到之前显示的view，将其隐藏
    UIView *lastDisplayedView = [Util getDisplayedViewAtViewArrs:_contentWebViewArr];
    lastDisplayedView.hidden = YES;
    
    //显示选中的index对应的contentView
    UIView *willDisplayedView = [_contentWebViewArr objectAtIndex:segmentedControl.selectedSegmentIndex];
    willDisplayedView.hidden = NO;
}


#pragma mark - setter Method
-(void)setPtPackageListWebUrlStr:(NSString *)ptPackageListWebUrlStr{

//    [_ptPackageListWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:ptPackageListWebUrlStr]]];
    [_ptPackageListWeb loadHTMLString:ptPackageListWebUrlStr baseURL:nil];
    _ptPackageListWebUrlStr = ptPackageListWebUrlStr;
}


-(void)setPtPhotoDetailWebUrlStr:(NSString *)ptPhotoDetailWebUrlStr{
    
//    [_ptPhotoDetailWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:ptPhotoDetailWebUrlStr]]];
    [_ptPhotoDetailWeb loadHTMLString:ptPhotoDetailWebUrlStr baseURL:nil];
    _ptPhotoDetailWebUrlStr = ptPhotoDetailWebUrlStr;
}


-(void)setCurrentIndex:(NSInteger)currentIndex{
    
    self.ptTopbarControl.selectedSegmentIndex = currentIndex;
    
    if (currentIndex == 0) {//显示图文详情web
        self.ptPhotoDetailWeb.hidden = NO;
        self.ptPackageListWeb.hidden = YES;
    }else{//显示包装列表
        self.ptPhotoDetailWeb.hidden = YES;
        self.ptPackageListWeb.hidden = NO;
    }
    
    _currentIndex = currentIndex;
}

@end
