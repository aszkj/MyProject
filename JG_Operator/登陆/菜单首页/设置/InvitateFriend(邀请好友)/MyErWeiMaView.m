//
//  MyErWeiMaView.m
//  jingGang
//
//  Created by 张康健 on 15/11/14.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "MyErWeiMaView.h"
#import "UIImageView+WebCache.h"
#import "Global.h"
#import "UIView+Screenshot.h"
//#import "TakePhotoUpdateImg.h"

@interface MyErWeiMaView()<UIWebViewDelegate>{


}
@property (weak, nonatomic) IBOutlet UIButton *shareErWeiMaBtn;
@property (weak, nonatomic) IBOutlet UITextView *shareContentTextView;
@property (weak, nonatomic) IBOutlet UIView *userErweimaBgView;
@property (weak, nonatomic) IBOutlet UIView *userInfoBgView;
@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImgView;

@property (weak, nonatomic) IBOutlet UILabel *userNickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userInvitationLabel;
@property (weak, nonatomic) IBOutlet UIWebView *userErWeiMaWebView;
@property (weak, nonatomic) IBOutlet UIButton *immediatelyInviteButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeight;

@property (nonatomic,strong) UIImage *shareImage;


@end

@implementation MyErWeiMaView


-(void)awakeFromNib {

    self.userErWeiMaWebView.scrollView.scrollEnabled = NO;
    self.userErWeiMaWebView.delegate = self;
    self.immediatelyInviteButton.layer.cornerRadius = 4.0;
    self.shareErWeiMaBtn.layer.cornerRadius = 4.0;
    if (kScreenHeight == 480) {
        self.topHeight.constant = 20.0;
    }
    

}

#pragma mark - 分享邀请码
- (IBAction)immediatelyInviteButtonClick:(id)sender {
    if([self.delegate respondsToSelector:@selector(myErWeiMaViewImmediatelyInviteButtonClick)])
    {
        return [self.delegate myErWeiMaViewImmediatelyInviteButtonClick];
    }
}

#pragma mark - 分享二维码
- (IBAction)shareErWeimaAction:(id)sender {
    
    if (self.shareErweimaBlock) {
        self.shareErweimaBlock();
    }
    
    if ([self.delegate respondsToSelector:@selector(shareErweimaButtonClick)]) {
        [self.delegate shareErweimaButtonClick];
    }
}

-(void)_snapErweiMaView {
    UIImage *erweimaSnapedImg = [self screenshot];
    CGFloat scale = [UIScreen mainScreen].scale;
    UIImage *screepedImage =  [UIImage imageWithCGImage:CGImageCreateWithImageInRect(erweimaSnapedImg.CGImage, CGRectMake(self.userInfoBgView.frame.origin.x*scale, self.userInfoBgView.frame.origin.y*scale, self.userInfoBgView.frame.size.width*scale, (self.userInfoBgView.frame.size.height + self.userErweimaBgView.frame.size.height+41)*scale))];
    
    self.shareImage = screepedImage;
    NSData *imageData = UIImageJPEGRepresentation(self.shareImage, 0.5);
    [self upLoadHeadImgWithImgData:imageData];}


-(void)setErweimoModel:(ErweiMoModel *)erweimoModel
{
    _erweimoModel = erweimoModel;
//    [self.userHeaderImgView sd_setImageWithURL:[NSURL URLWithString:erweimoModel.userHeaderUrlStr] placeholderImage:nil];
    
    self.userNickNameLabel.text = erweimoModel.userNickName;
    self.userInvitationLabel.text = erweimoModel.userInvitationCode;
    self.shareContentTextView.text = erweimoModel.userShareContent;
    [self.userErWeiMaWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:erweimoModel.userErWeiMoHtmlStr]]];
}


#pragma mark -----------------------  webview delegate -----------------------
- (void)webViewDidFinishLoad:(UIWebView *)webView {

//    [self _snapErweiMaView];
    [self performSelector:@selector(_snapErweiMaView) withObject:nil afterDelay:0.1f];
}

#pragma mark - 上传图片 - 生成url

-(void)upLoadHeadImgWithImgData:(NSData *)imgData {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    WEAK_SELF
    NSString *postImageUrl = [NSString stringWithFormat:@"%@/v1/image",BaseUrl];
    [manager POST:postImageUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imgData name:@"file" fileName:@"filename" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *newCommentImgUrl =  [[responseObject[@"items"] objectAtIndex:0] objectForKey:@"fileUrl"];
        
        if (weak_self.erweimaSnapUrlGetBlock) {
            weak_self.erweimaSnapUrlGetBlock(weak_self.shareImage,newCommentImgUrl);
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


@end


@implementation ErweiMoModel


@end
