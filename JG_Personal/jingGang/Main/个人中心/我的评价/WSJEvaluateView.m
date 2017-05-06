//
//  WSJEvaluateView.m
//  jingGang
//
//  Created by thinker on 15/9/9.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "WSJEvaluateView.h"
#import "PublicInfo.h"
#import "WSJStarView.h"
#import "GlobeObject.h"
#import "Masonry.h"
#import "SDPhotoBrowser.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "UIImageView+WebCache.h"


@interface WSJEvaluateView ()//<SDPhotoBrowserDelegate>
{
    WSJEvaluateModel *_saveModel;
}

@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) WSJStarView *starView;
@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UILabel *evaluateContentLabel;

@property (nonatomic, strong) UIScrollView *imageScrollView;

@property (nonatomic, strong) UILabel *shopkeeperLabel;
@property (nonatomic, strong) UILabel *supplementLabel;

@end

@implementation WSJEvaluateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initUI];
    }
    return self;
}

-(void)awakeFromNib
{
    [self initUI];
}
#pragma mark - 实例化UI
- (void) initUI
{
    self.titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    self.titleImageView.layer.cornerRadius = 20;
    self.titleImageView.clipsToBounds = YES;
    [self addSubview:self.titleImageView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, __MainScreen_Width - 70, 20)];
    self.titleLabel.textColor = UIColorFromRGB(0X666666);
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.titleLabel];
    
    self.starView = [[WSJStarView alloc ]initWithFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.titleLabel.frame) + 1, 100, 18)];
    [self addSubview:self.starView];
    
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.starView.frame) + 8, CGRectGetMaxY(self.titleLabel.frame), __MainScreen_Width - 170, CGRectGetHeight(self.titleLabel.frame))];
    self.dateLabel.textColor = UIColorFromRGB(0X999999);
    self.dateLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.dateLabel];
    
    //评论内容UI
    self.evaluateContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.titleImageView.frame) + 10, __MainScreen_Width - 20 , 1)];
    self.evaluateContentLabel.font = [UIFont systemFontOfSize:14];
    self.evaluateContentLabel.textColor = UIColorFromRGB(0X999999);
    self.evaluateContentLabel.numberOfLines = 0;
    [self addSubview:self.evaluateContentLabel];
    
    //图片UI
    self.imageScrollView = [[UIScrollView alloc] init];
    [self addSubview:self.imageScrollView];
    // 掌柜回复
    self.shopkeeperLabel = [[UILabel alloc ]init];
    self.shopkeeperLabel.font = [UIFont systemFontOfSize:14];
    self.shopkeeperLabel.textColor = UIColorFromRGB(0X999999);
    self.shopkeeperLabel.numberOfLines = 0;
    self.shopkeeperLabel.backgroundColor = UIColorFromRGB(0Xefefef);
    [self addSubview:self.shopkeeperLabel];
}

#pragma mark - 给cell赋值数据
- (void)setModel:(WSJEvaluateModel *)model
{
    CGFloat height;
    _model = model;
    _saveModel = model;
    
    [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:model.titleImageURL] placeholderImage:[UIImage imageNamed:@"home_head"] ];
    self.titleLabel.text = model.titleName.length > 0 ? model.titleName : @"匿**名";
    self.starView.count = model.starCount;
    self.dateLabel.text = model.date;
    
    CGRect frame = self.evaluateContentLabel.frame;
    frame.size.height = model.evaluateHeight;
    self.evaluateContentLabel.frame = frame;
    self.evaluateContentLabel.text = model.evaluateContent;
    height = CGRectGetMaxY(frame) + 10;
    
#pragma mark -  //附加图片
    for (UIView *v in self.imageScrollView.subviews)
    {
        [v removeFromSuperview];
    }
    if (model.dataImageArray.count > 0)
    {
        self.imageScrollView.hidden = NO;
        self.imageScrollView.frame = CGRectMake(10, height, __MainScreen_Width - 20, 100);
        height = CGRectGetMaxY(self.imageScrollView.frame) + 10;
        [model.dataImageArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake( 100 * idx, 0, 95, 100)];
            [img sd_setImageWithURL:[NSURL URLWithString:TwiceImgUrlStr(obj, img.frame.size.width, img.frame.size.height)]];
            img.tag = idx;
            img.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionImageView:)];
            [img addGestureRecognizer:tap];
            [self.imageScrollView addSubview:img];
        }];
        self.imageScrollView.contentSize = CGSizeMake(model.dataImageArray.count * 100, 1);
    }
    else
    {
        self.imageScrollView.hidden = YES;
    }
    
    
    self.shopkeeperLabel.text = model.shopkeeper;
    self.shopkeeperLabel.frame = CGRectMake(10, height, __MainScreen_Width - 20 , model.shopkeeperHeight);
    
}
#pragma mark - 点击图片进行放大
- (void) actionImageView:(UIGestureRecognizer *)ges
{
    
    // 1.封装图片数据
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    
    for (NSString *url in self.model.dataImageArray) {
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:url]; // 图片路径
        photo.srcImageView = (UIImageView *)ges.view; // 来源于哪个UIImageView
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = ges.view.tag ; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
    
//    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
//    browser.sourceImagesContainerView = self.imageScrollView; // 原图的父控件
//    browser.imageCount = _saveModel.dataImageArray.count; // 图片总数
//    browser.currentImageIndex = (int)ges.view.tag;
//    browser.delegate = self;
//    [browser show];
}
//#pragma mark - photobrowser代理方法
//// 返回临时占位图片（即原来的小图）
//- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
//{
//    UIImageView *img =  (UIImageView *)self.imageScrollView.subviews[index];
//    return img.image;
//}
//// 返回高质量图片的url
//- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
//{
//    float height = __MainScreen_Width * 70 / 66;
//    return [NSURL URLWithString:TwiceImgUrlStr(_saveModel.dataImageArray[index], __MainScreen_Width / 2, height / 2)];
//}

@end
