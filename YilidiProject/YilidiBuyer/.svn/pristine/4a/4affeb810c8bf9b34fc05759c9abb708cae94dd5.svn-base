//
//  DLActivityDetailVC.m
//  YilidiBuyer
//
//  Created by mm on 17/4/7.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "DLActivityDetailVC.h"
#import "DLMessageModel.h"
#import <UIImageView+WebCache.h>
#import "GlobleErrorView.h"


@interface DLActivityDetailVC ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgViewHeightConstraint;

@end

@implementation DLActivityDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self _requestMessageDetail];
}


- (void)_requestMessageDetail {
    self.requestParam = @{@"msgId":self.messageId};
    [self showLoadingHub];
    [AFNHttpRequestOPManager postWithParameters:self.requestParam subUrl:kUrl_GetMessageDetails block:^(NSDictionary *resultDic, NSError *error) {
        [self dissmiss];
        NSDictionary *message = resultDic[EntityKey];
        if (!isEmpty(message)) {
            DLMessageModel *model = [[DLMessageModel alloc] initWithDefaultDataDic:message];
            [self assignDataWithMessageModel:model];
        }else {
            [GlobleErrorView showInContentView:self.view withReloadBlock:nil alertTitle:@"当前活动已结束" alertImageName:@"活动结束"];
        }
    }];
}

- (void)assignDataWithMessageModel:(DLMessageModel *)messageModel {
    [self.titleLabel kj_safeSetText:messageModel.msgAbstract];
    [self.contentLabel kj_safeSetText:messageModel.msgContent];
    if (isEmpty(messageModel.msgTitle)) {
        messageModel.msgTitle = @"活动详情";
    }
    self.pageTitle = messageModel.msgTitle;
    WEAK_SELF
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:messageModel.msgImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) {
            return;
        }
        CGSize size = image.size;
        CGFloat imgAspecio = size.height/size.width;
        CGFloat imgHeight = (kScreenWidth-20) * imgAspecio;
        weak_self.imgViewHeightConstraint.constant = imgHeight;
    }];

}

@end
