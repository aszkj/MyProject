        //
//  IntegralGoodsPhotoTextDetailView.m
//  jingGang
//
//  Created by 张康健 on 15/11/3.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "IntegralGoodsPhotoTextDetailView.h"
#define kIntegralDetailViewTriggleDistance 50


@interface IntegralGoodsPhotoTextDetailView()<UIScrollViewDelegate> {

}

//图文详情web
@property (weak, nonatomic) IBOutlet UIWebView *ptPhotoDetailWeb;


@end

@implementation IntegralGoodsPhotoTextDetailView


-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self _initInfo];
}

-(void)_initInfo{
    //不能在这里面初始化topBar属性，

    //设置父视图代理
    self.ptPhotoDetailWeb.scrollView.delegate = self;
    
}

#pragma mark - layout subviews
-(void)layoutSubviews{
    [super layoutSubviews];
}


#pragma mark - web ScrollView delegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView.contentOffset.y < -kIntegralDetailViewTriggleDistance) {
        if (self.upBlock) {
            self.upBlock();
        }
    }
}

#pragma mark - setter Method
-(void)setPtPhotoDetailWebUrlStr:(NSString *)ptPhotoDetailWebUrlStr{
    
    [_ptPhotoDetailWeb loadHTMLString:ptPhotoDetailWebUrlStr baseURL:nil];
//    [_ptPhotoDetailWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:ptPhotoDetailWebUrlStr]]];
    
    _ptPhotoDetailWebUrlStr = ptPhotoDetailWebUrlStr;
}


@end






