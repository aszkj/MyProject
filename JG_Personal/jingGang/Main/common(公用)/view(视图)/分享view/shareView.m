//
//  shareView.m
//  jingGang
//
//  Created by yi jiehuang on 15/5/26.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "shareView.h"
#import "JGShare.h"
#import "GlobeObject.h"
#import "WXApi.h"
#import "Masonry.h"
#import "NSArray+MASHelper.h"
#import <TencentOpenAPI/QQApiInterface.h>


@interface shareView ()
@property (weak, nonatomic) IBOutlet UIView *weiboView;

@property (weak, nonatomic) IBOutlet UIView *qqView;
@property (weak, nonatomic) IBOutlet UIView *wxView;
@property (weak, nonatomic) IBOutlet UIView *wxFriendView;

@end

@implementation shareView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
      //self setTranslatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}



-(void)awakeFromNib{



}


-(void)examinClientInstalled {

//    if (![WXApi isWXAppInstalled]) {
//        self.wxView.hidden = YES;
//        self.wxFriendView.hidden = YES;
//        NSArray *newArr = @[self.weiboView,self.qqView];
//        [self _makeArrConstraintArr:newArr];
//    }
//    
//    if (![QQApiInterface isQQInstalled]){
//        self.qqView.hidden = YES;
//        NSArray *newArr = @[self.weiboView,self.wxView,self.wxFriendView];
//        [self _makeArrConstraintArr:newArr];
//    }
//    
//    if (![WXApi isWXAppInstalled] && ![QQApiInterface isQQInstalled]){
//        self.wxView.hidden = YES;
//        self.wxFriendView.hidden = YES;
//        self.qqView.hidden = YES;
//        NSArray *newArr = @[self.weiboView];
//        [self _makeArrConstraintArr:newArr];
//    }
}

-(void)_makeArrConstraintArr:(NSArray *)newArr {
    
    [newArr mas_distributeViewsAlongAxis:AxisTypeHorizon withFixedSpacing:0 withLeadSpacing:0];
    [newArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(54);
        make.height.mas_equalTo(80);
    }];
    
}


- (IBAction)cancelShare:(id)sender {
    
    if (self.cancelShareBlock) {
        self.cancelShareBlock();
    }
}

+(shareView *)instance
{
//    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"shareView" owner:nil options:nil];
     NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"NewShareView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}



- (IBAction)BtnClick:(id)sender{
    UIButton * btn = (UIButton *)sender;
    NSInteger shareType = btn.tag;
    switch (shareType) {
        case 1:
            if (self.weiboShareBlock) {
                self.weiboShareBlock();
            }
            //新浪微博
            if (self.shareImagePath) {
                [self shareWithImageType:ShareTypeSinaWeibo];
            }else{
                [self shareWithShareType:ShareTypeSinaWeibo];
            }
            
            break;
        case 2:
            if (![QQApiInterface isQQInstalled]){
                [Util ShowAlertWithOutCancelWithTitle:@"确定" message:@"未安装QQ客户端"];
                return;
            }
            
            if (self.qqShareBlock) {
                self.qqShareBlock();
            }
            //QQ空间
            if (self.shareImagePath) {
                [self shareWithImageType:ShareTypeQQSpace];
            }else{
                [self shareWithShareType:ShareTypeQQSpace];
            }
            
            break;
        case 3:
            if (![WXApi isWXAppInstalled]) {
                  [Util ShowAlertWithOutCancelWithTitle:@"确定" message:@"未安装微信客户端"];
                return;
            }
            if (self.wxShareBlock) {
                self.wxShareBlock();
            }
            //微信好友
            if (self.shareImagePath) {
                [self shareWithImageType:ShareTypeWeixiSession];
            }else{
                [self shareWithShareType:ShareTypeWeixiSession];
            }
            
            break;
        case 4:
            if (![WXApi isWXAppInstalled]) {
                 [Util ShowAlertWithOutCancelWithTitle:@"确定" message:@"未安装微信客户端"];
                return;
            }
            if (self.wxFriendShareBlock) {
                self.wxFriendShareBlock();
            }
            //微信朋友圈
            if (self.shareImagePath) {
                [self shareWithImageType:ShareTypeWeixiTimeline];
            }else{
                [self shareWithShareType:ShareTypeWeixiTimeline];
            }
            
            break;
        case 5:
        {
            JGLog(@"选择qq分享");
            if (![QQApiInterface isQQInstalled]){
                [Util ShowAlertWithOutCancelWithTitle:@"确定" message:@"未安装QQ客户端"];
                return;
            }
            BLOCK_EXEC(self.tencentShareBlock);
            if (self.shareImagePath) {
                [self shareWithImageType:ShareTypeQQ];
            }else {
                [self shareWithShareType:ShareTypeQQ];
            }
        }
            break;
            
        default:
            break;
    }
    
}


-(void)shareWithShareType:(ShareType)shareType{

 [JGShare shareWithTitle:self.shareTitle content:self.shareContent headerImgUrl:self.shareHeadImgUrl shareUrl:self.shareUrl shareType:shareType];
    
}

- (void)shareWithImageType:(ShareType)shareType{
    [JGShare shareWithImage:self.shareImagePath shareWithTitle:self.shareTitle content:self.shareContent headerImgUrl:self.shareHeadImgUrl shareUrl:self.shareUrl shareType:shareType];
}

-(void)setShareContent:(NSString *)shareContent{

//    //截取内容前30个字符
//    if (shareContent.length >= 30) {
//        shareContent = [shareContent substringToIndex:30];
//    }
    
    _shareContent = [shareContent copy];
}




@end
