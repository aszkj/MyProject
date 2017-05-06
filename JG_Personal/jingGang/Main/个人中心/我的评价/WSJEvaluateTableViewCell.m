//
//  WSJEvaluateTableViewCell.m
//  jingGang
//
//  Created by thinker on 15/8/17.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "WSJEvaluateTableViewCell.h"
#import "PublicInfo.h"
#import "GlobeObject.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "SDPhotoBrowser.h"
#import "KJPhotoBrowser.h"

@interface WSJEvaluateTableViewCell ()<SDPhotoBrowserDelegate>
{
    WSJEvaluateModel *_saveModel;
    __weak IBOutlet UIView *view1;
    __weak IBOutlet UIView *view2;
    
    
    NSMutableArray *_twiceImgUrls;
    NSMutableArray *_imgArr;
    KJPhotoBrowser *_photoBrowGrowser;
}


@property (weak, nonatomic) IBOutlet UIImageView *titleImage;
@property (weak, nonatomic) IBOutlet UIImageView *titleImage2;
@property (weak, nonatomic) IBOutlet UILabel *titleNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleNameLabel2;
//评论回复
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
//回复时间
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

//图片内容
@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollView;
//掌柜回复内容
@property (weak, nonatomic) IBOutlet UILabel *shopkeeperLabel;
//追加内容
@property (weak, nonatomic) IBOutlet UILabel *supplementLabel;
//追加按钮
@property (weak, nonatomic) IBOutlet UIButton *supplementBtn;
@end

@implementation WSJEvaluateTableViewCell

- (void)willCellWithModel:(WSJEvaluateModel *)model
{
    _saveModel = model;
    CGFloat y = 63;
    //已经追加评论，隐藏追加按钮
    if (model.supplement.length > 0)
    {
        self.supplementBtn.hidden = YES;
    }
    else
    {
        self.supplementBtn.hidden = NO;
    }
    //判断是：我的评论、评论列表
    if (model.isMeEvaluate)
    {
        view1.hidden = YES;
        view2.hidden = NO;
        y = y + 20;
        [self.titleImage2 sd_setImageWithURL: [NSURL URLWithString:TwiceImgUrlStr(model.titleImageURL, self.titleImage2.frame.size.width, self.titleImage2.frame.size.height) ] placeholderImage:[UIImage imageNamed:@"per_defult_head"]];
        self.titleNameLabel2.text = model.titleName;
    }
    else
    {
        view1.hidden = NO;
        view2.hidden = YES;
        [self.titleImage sd_setImageWithURL:[NSURL URLWithString:TwiceImgUrlStr(model.titleImageURL, self.titleImage.frame.size.width, self.titleImage.frame.size.height)] placeholderImage:[UIImage imageNamed:@"per_defult_head"]];
        if (model.titleName > 0)
        {
            self.titleNameLabel.text = model.titleName;
        }
        else
        {
            self.titleNameLabel.text = @"匿**名";
        }
    }
    
    //评论内容
    CGRect frame;
    if (model.evaluateContent.length > 0)
    {
        self.contentLabel.text = model.evaluateContent;
        frame = self.contentLabel.frame;
        frame.origin.y = y;
        frame.size.width = __MainScreen_Width - 20;
        frame.size.height = model.evaluateHeight;
        y = CGRectGetMaxY(frame);
        self.contentLabel.frame = frame;
        self.contentLabel.hidden = NO;
    }
    else
    {
        self.contentLabel.hidden = YES;
    }
    //时间
    if (model.date.length > 0)
    {
        self.dateLabel.text = model.date;
        frame = self.dateLabel.frame;
        frame.origin.y = y + 5;
        y = CGRectGetMaxY(frame);
        self.dateLabel.frame = frame;
        self.dateLabel.hidden = NO;
    }
    else
    {
        self.dateLabel.hidden = YES;
    }
#pragma mark -  //附加图片
    if (model.dataImageArray.count)
    {
        self.imageScrollView.hidden = NO;
        frame = self.imageScrollView.frame;
        frame.origin.y = y + 5;
        y = CGRectGetMaxY(frame);
        frame.size.width = __MainScreen_Width - 20;
        self.imageScrollView.frame = frame;
        for (UIView *v in self.imageScrollView.subviews)
        {
            [v removeFromSuperview];
        }
        [model.dataImageArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake( 70 * idx, 0, 66, 70)];
            [img sd_setImageWithURL:[NSURL URLWithString:TwiceImgUrlStr(obj, img.frame.size.width, img.frame.size.height)]];
            img.tag = idx;
            img.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionImageView:)];
            [img addGestureRecognizer:tap];
            [self.imageScrollView addSubview:img];
        }];
        self.imageScrollView.contentSize = CGSizeMake(model.dataImageArray.count * 70, 1);
        
    }
    else
    {
        self.imageScrollView.hidden = YES;
    }
    //掌柜回复
    if (model.shopkeeper.length > 0)
    {
        self.shopkeeperLabel.hidden = NO;
        self.shopkeeperLabel.text = model.shopkeeper;
        frame = self.shopkeeperLabel.frame;
        frame.origin.y = y + 5;
        frame.size.height = model.shopkeeperHeight;
        frame.size.width = __MainScreen_Width - 20;
        y = CGRectGetMaxY(frame);
        self.shopkeeperLabel.frame = frame;
    }
    else
    {
        self.shopkeeperLabel.hidden = YES;
    }
    //追加评论
    if (model.supplement.length > 0)
    {
        self.supplementLabel.hidden = NO;
        self.supplementLabel.text = model.supplement;
        frame = self.supplementLabel.frame;
        frame.origin.y = y + 5;
        y = CGRectGetMaxY(frame);
        frame.size.height = model.supplementHeight;
        frame.size.width = __MainScreen_Width - 20;
        self.supplementLabel.frame = frame;
    }
    else
    {
        self.supplementLabel.hidden = YES;
    }
}
//追加评论事件
- (IBAction)supplementAction:(UIButton *)sender
{
    if (self.supplementBlock)
    {
        self.supplementBlock();
    }
}
- (void)shopDetailTap:(UIGestureRecognizer *)sender
{
    if (self.shopDetailBlock)
    {
        NSLog(@"商品详情页");
        self.shopDetailBlock(_saveModel.goodsID);
    }
}

- (void)awakeFromNib {
    CGFloat width = __MainScreen_Width;
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo (@8);
        make.top.equalTo(@8);
        make.width.equalTo(@(width - 16));
        make.height.equalTo(@70);
    }];
    [self.supplementBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@22);
        make.right.equalTo(@-8);
        make.width.equalTo(@67);
    }];
    CGRect frame = self.titleNameLabel2.frame;
    frame.size.width = __MainScreen_Width - 170;
    self.titleNameLabel2.frame = frame;
    self.imageScrollView.hidden = YES;
    self.shopkeeperLabel.hidden = YES;
    self.supplementLabel.hidden = YES;
    self.dateLabel.adjustsFontSizeToFitWidth = YES;
    self.titleNameLabel2.adjustsFontSizeToFitWidth = YES;
    view2.hidden = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shopDetailTap:)];
    [view2 addGestureRecognizer:tap];
}
- (void) actionImageView:(UIGestureRecognizer *)ges
{
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.sourceImagesContainerView = self.imageScrollView; // 原图的父控件
    browser.imageCount = _saveModel.dataImageArray.count; // 图片总数
    browser.currentImageIndex = (int)ges.view.tag;
    browser.delegate = self;
    [browser show];
//    [_photoBrowGrowser clickImgViewAtIndex:ges.view.tag];
}
#pragma mark - photobrowser代理方法

// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *img =  (UIImageView *)self.imageScrollView.subviews[index];
    return img.image;
}


// 返回高质量图片的url
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    float height = __MainScreen_Width * 70 / 66;
    return [NSURL URLWithString:TwiceImgUrlStr(_saveModel.dataImageArray[index], __MainScreen_Width / 2, height / 2)];
}

@end
