//
//  JGShareView.m
//  jingGang
//
//  Created by 张康健 on 15/9/25.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "JGShareView.h"
#import "Masonry.h"

#import "UIView+BlockGesture.h"
#import "shareView.h"

@interface JGShareView() {


}

@property (weak, nonatomic) IBOutlet UIView *maskView;

@property (nonatomic, strong)shareView *shareView;

@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *content;
@property (nonatomic, copy)NSString *imgUrlStr;
@property (nonatomic, copy)NSString *urlStr;

@property (nonatomic, strong)JGShareView *jgShareView;

@end

@implementation JGShareView

//标题，内容，图片url,分享内容点击后的url
+ (id)shareViewWithTitle:(NSString *)shareTitle
                 content:(NSString *)shareContent
               imgUrlStr:(NSString *)shareImgUrl
                  ulrStr:(NSString *)shareUlrStr
             contentView:(UIView *)contentView
          shareImagePath:(NSString *)shareImagePath
{
    JGShareView *jgshareView = [self JGShareView];
    
    [contentView addSubview:jgshareView];
    [jgshareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(contentView);
    }];
    
    shareView *shareView = [self _loadShareView:jgshareView];
    shareView.shareTitle = shareTitle;
    shareView.shareContent = shareContent;
    shareView.shareHeadImgUrl = shareImgUrl;
    shareView.shareUrl = shareUlrStr;
    shareView.shareImagePath = shareImagePath;
    
    
    ShareModel *shareModel = [[ShareModel alloc] init];
    shareModel.shareTitle = shareTitle;
    shareModel.shareContent = shareContent;
    shareModel.shareImgUrl = shareImgUrl;
    shareModel.shareUlrStr = shareUlrStr;
    shareModel.shareImagePath = shareImagePath;
    
    WeiBoShareModel *weiboModel = [[WeiBoShareModel alloc] init];
    QQShareModel *qqShareModel = [[QQShareModel alloc] init];
    WXShareModel *wxShareModel = [[WXShareModel alloc] init];
    WXFriendShareModle *wxFriendShareModel = [[WXFriendShareModle alloc] init];
    jgshareView.weiBoShareModel = weiboModel;
    jgshareView.qqShareModel = qqShareModel;
    jgshareView.wxShareModel = wxShareModel;
    jgshareView.wxFriendShareModle = wxFriendShareModel;
    
    
    [[self class] _setEveryShareModel:jgshareView.weiBoShareModel withBaseShareModel:shareModel];
    [[self class] _setEveryShareModel:jgshareView.qqShareModel withBaseShareModel:shareModel];
    [[self class] _setEveryShareModel:jgshareView.wxShareModel withBaseShareModel:shareModel];
    [[self class] _setEveryShareModel:jgshareView.wxFriendShareModle withBaseShareModel:shareModel];
    
    
    [self _configureMaskView:jgshareView];
    
    jgshareView.jgShareView = jgshareView;
    
    return jgshareView;
}

+ (void)_setEveryShareModel:(ShareModel *)shareModel withBaseShareModel:(ShareModel *)baseShareModel{
    shareModel.shareTitle = baseShareModel.shareTitle;
    shareModel.shareContent = baseShareModel.shareContent;
    shareModel.shareImgUrl = baseShareModel.shareImgUrl;
    shareModel.shareUlrStr = baseShareModel.shareUlrStr;
    shareModel.shareImagePath  = baseShareModel.shareImagePath;
}


+ (void)_configureMaskView:(JGShareView *)jgshareView {
    
    __block JGShareView *jgshareblokView = jgshareView;
    [jgshareView.maskView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [UIView animateWithDuration:0.3 animations:^{
            [jgshareblokView.shareView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(jgshareblokView.mas_bottom).offset(200);
            }];
            [jgshareblokView layoutIfNeeded];
        }];
         [[self class] performSelector:@selector(_unShow:) withObject:jgshareblokView afterDelay:0.5];
    }];
}

-(void)_onShow {
    self.hidden = YES;
}


+ (shareView *)_loadShareView:(JGShareView *)jgShareView{
    
    jgShareView.maskView.hidden = NO;
    jgShareView.shareView = [shareView instance];
    __block JGShareView *jShareView = jgShareView;
    jgShareView.shareView.cancelShareBlock = ^{
        [UIView animateWithDuration:0.3 animations:^{
            
            [jShareView.shareView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(jShareView.mas_bottom).offset(200);
            }];
            [jShareView layoutIfNeeded];
        }];
        
        [[self class] performSelector:@selector(_unShow:) withObject:jShareView afterDelay:0.5];
    };
    
    
    jgShareView.shareView.weiboShareBlock = ^{
        
        //        jShareView.shareView.shareTitle = jShareView.weiBoShareModel.shareTitle;
        //        jShareView.shareView.shareContent = jShareView.weiBoShareModel.shareContent;
        //        jShareView.shareView.shareHeadImgUrl = jShareView.weiBoShareModel.shareImgUrl;
        //        jShareView.shareView.shareUrl = jShareView.weiBoShareModel.shareUlrStr;
        [[self class] _setShareModelContent:jShareView.weiBoShareModel withJGShareView:jShareView];
        
    };
    
    jgShareView.shareView.qqShareBlock = ^{
        NSLog(@"title %@",jShareView.qqShareModel.shareTitle);
        [[self class] _setShareModelContent:jShareView.qqShareModel withJGShareView:jShareView];
    };
    
    jgShareView.shareView.wxShareBlock = ^{
        [[self class] _setShareModelContent:jShareView.wxShareModel withJGShareView:jShareView];
    };
    jgShareView.shareView.wxFriendShareBlock = ^{
        [[self class] _setShareModelContent:jShareView.wxFriendShareModle withJGShareView:jShareView];
    };
    
    [jgShareView addSubview:jgShareView.shareView];
    [jgShareView.shareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(jgShareView);
        make.bottom.mas_equalTo(jgShareView.mas_bottom).with.offset(200);
        make.height.mas_equalTo(@200);
    }];
    
    return jgShareView.shareView;
}

+ (void)_setShareModelContent:(ShareModel *)model withJGShareView:(JGShareView *)jShareView{
    NSLog(@"title %@, content %@",model.shareTitle,model.shareContent);
    jShareView.shareView.shareTitle = model.shareTitle;
    jShareView.shareView.shareContent = model.shareContent;
    jShareView.shareView.shareHeadImgUrl = model.shareImgUrl;
    jShareView.shareView.shareUrl = model.shareUlrStr;
    jShareView.shareView.shareImagePath = model.shareImagePath;
}


+ (void)_unShow:(JGShareView *)shareView {
    
    shareView.hidden = YES;
    if (shareView.hiddenBlock) {
        shareView.hiddenBlock();
    }
}

-(void)show {
    self.jgShareView.hidden = NO;
    //每次上来，检测客户端安装没
    [self.shareView examinClientInstalled];
    //上来
    [self performSelector:@selector(upShareView) withObject:nil afterDelay:0.3];
}


-(void)upShareView {
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.jgShareView.shareView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.jgShareView);
        }];
        [self.jgShareView layoutIfNeeded];
    }];
}


+ (JGShareView *)JGShareView {

    return BoundNibView(@"JGShareView", JGShareView);

}

#pragma mark ----------------------- setter Method -----------------------




@end


#pragma ============================ShareModel IMP==========================
@implementation ShareModel
@end

@implementation WeiBoShareModel
@end

@implementation QQShareModel
@end

@implementation WXShareModel
@end

@implementation WXFriendShareModle
@end






