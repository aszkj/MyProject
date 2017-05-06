//
//  XKJHCommentManageMentCell.m
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/8.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHCommentManageMentCell.h"
#import "ShowGoodsPhotoView.h"
#import "RepyController.h"
#import "UIView+firstResponseController.h"
@interface XKJHCommentManageMentCell() {

    NSLayoutConstraint *_repyHeightConstraint;
}

@property (weak, nonatomic) IBOutlet UILabel *commentPersonNickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentAddTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *serviceNameLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightNowRepyButtonHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *repyView;
@property (weak, nonatomic) IBOutlet UILabel *repyLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet ShowGoodsPhotoView *commentPhotoView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *showPhotoHeightConstriant;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *repyHeightConstriant;

@end

@implementation XKJHCommentManageMentCell

- (void)awakeFromNib {

    _repyHeightConstraint = self.repyHeightConstriant;
    
}

-(void)layoutSubviews {
    
   [super layoutSubviews];
    NSLog(@"评价时间-- %@",self.groupEvaluatesModel.evaluateTime);
    NSString *commentStr = [NSString stringWithFormat:@"%@",self.groupEvaluatesModel.evaluateTime];
//    if (commentStr.length > 10) {
//        //处理时间
//        commentStr = [commentStr stringByReplacingCharactersInRange:NSMakeRange(4, 1) withString:@"年"];
//        commentStr = [commentStr stringByReplacingCharactersInRange:NSMakeRange(7, 1) withString:@"月"];
//        commentStr = [commentStr stringByReplacingCharactersInRange:NSMakeRange(10, 1) withString:@"日 "];
    self.commentAddTimeLabel.text = [NSString stringWithFormat:@"评价时间：%@",commentStr];
//    }
    
    self.serviceNameLabel.text = self.groupEvaluatesModel.goodsName;
    self.commentPersonNickNameLabel.text = self.groupEvaluatesModel.nickName;
    
    NSLog(@"评价服务名称 %@",self.groupEvaluatesModel.goodsName);
    
    self.commentLabel.text = self.groupEvaluatesModel.content;
    NSInteger imgUrlMinLength = 5;
    if (self.groupEvaluatesModel.photoUrls.length > imgUrlMinLength) {
        NSArray *commentPhotoArr = [self.groupEvaluatesModel.photoUrls componentsSeparatedByString:@";"];
        self.showPhotoHeightConstriant.constant = 70;
        self.commentPhotoView.imgUrlArr = commentPhotoArr;
        self.commentPhotoView.hidden = NO;
    }else {
        self.showPhotoHeightConstriant.constant = 9;
        self.commentPhotoView.hidden = YES;
    }

    if (!self.groupEvaluatesModel.replyContent) {
        self.rightNowRepyButtonHeightConstraint.constant = 24;
        self.repyHeightConstriant.constant = 0;
        self.repyView.hidden = YES;
    }else {
        self.rightNowRepyButtonHeightConstraint.constant = 0;
        self.repyLabel.text = [NSString stringWithFormat:@"[掌柜回复]我来说说。%@",self.groupEvaluatesModel.replyContent];
        CGFloat height = kStringSize(self.repyLabel.text, 14, kScreenWidth-44, 1000).height;
        self.repyHeightConstriant.constant = height+15;
        self.repyView.hidden = NO;
    }
}


- (IBAction)repyAction:(id)sender {
    
    RepyController *repyVC = [[RepyController alloc] init];
    repyVC.repyOrderID = self.groupEvaluatesModel.orderId;
    [self.firstResponseController.navigationController pushViewController:repyVC animated:YES];
}

@end
