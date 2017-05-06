//
//  LoadingView.h
//  加载图片测试
//
//  Created by ZZCM on 15/2/5.
//  Copyright (c) 2015年 ZZCM. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    LoadingAlone,               //只含loading
    LoadingWithAlertMessage,    //loading和提示信息
    LoadingSystemtype           //系统的菊花
}LoadingType;                   //加载类型

@interface LoadingView : UIView

//开始加载
-(void)beginLoading;

//结束加载
-(void)endLoading;
@property (weak, nonatomic) IBOutlet UIImageView *loadingAloneImgView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *systemIndicator;
@property (weak, nonatomic) IBOutlet UIView *indicatorBaseView;

@property (weak, nonatomic) IBOutlet UIView *loadingWithAlertMessageView;
@property (weak, nonatomic) IBOutlet UIImageView *loadingWithAlertImgView;
@property (weak, nonatomic) IBOutlet UILabel *loadinLabel;

@property (nonatomic,strong)NSString *loadingMessage;

@property (nonatomic,assign)LoadingType loadingType;

@property (nonatomic,strong)UIColor *bgColor;

-(void)showLoadingFullInView:(UIView *)superView
             withLoadingType:(LoadingType)loadingType;

-(void)showLoadingPartInView:(UIView *)superView
                  withTopgap:(CGFloat)topGap
                   bottonGap:(CGFloat)bottonGap
                     leftGap:(CGFloat)leftGap
                    rightGap:(CGFloat)rightGap
             withLoadingType:(LoadingType)loadingType;


@end
