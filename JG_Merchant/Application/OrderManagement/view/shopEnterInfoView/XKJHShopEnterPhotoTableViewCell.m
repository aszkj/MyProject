//
//  XKJHShopEnterPhotoTableViewCell.m
//  Merchants_JingGang
//
//  Created by thinker on 15/9/6.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHShopEnterPhotoTableViewCell.h"
#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

@interface XKJHShopEnterPhotoTableViewCell ()
{
    CGFloat _width;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *xianHeight;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@property (nonatomic,strong) NSMutableArray *imageViewArr;

@end

@implementation XKJHShopEnterPhotoTableViewCell

- (void)awakeFromNib {
    self.imageViewArr = [NSMutableArray array];
    self.xianHeight.constant = 0.3;
    _width = (self.contentScrollView.frame.size.width ) / 3;
}
- (void)setModel:(XKJHShopEnterInfoModel *)model
{
    _model = model;
    [self initUI];
}
- (void) initUI
{
    for (UIView *v in self.contentScrollView.subviews)
    {
        [v removeFromSuperview];
    }
    for (NSInteger i = 0 ; i < self.model.imageArray.count; i++)
    {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake((_width +15) * i, 0, _width, CGRectGetHeight(self.contentScrollView.frame))];
        if (![self.model.imageArray[i] isKindOfClass:[UIImage class]])
        {
            [img sd_setImageWithURL:[NSURL URLWithString:self.model.imageURLArray[i]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [self.model.imageArray replaceObjectAtIndex:i withObject:image];
            }];
        }
        else
        {
            img.image = self.model.imageArray[i];
        }
        
        img.userInteractionEnabled = YES;
        img.tag = i + 1000;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionImageView:)];
        [img addGestureRecognizer:tap];
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteBtn setImage:[UIImage imageNamed:@"delete5s"] forState:UIControlStateNormal];
        deleteBtn.frame = CGRectMake((_width +15) * i + _width - 25, 0, 25, 25);
        deleteBtn.tag = i;
        [deleteBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentScrollView addSubview:img];
        [self.contentScrollView addSubview:deleteBtn];
        
        
    }
    self.contentScrollView.contentSize = CGSizeMake(self.model.imageArray.count *(_width + 15) - 15, 1);
}
- (void) actionImageView:(UIGestureRecognizer *)ges
{
    [self.imageViewArr removeAllObjects];
    for (UIView *v in self.contentScrollView.subviews)
    {
        if (v.tag >= 1000)
        {
            UIImageView *img = (UIImageView *)v;
            MJPhoto *photo = [[MJPhoto alloc] init];
            photo.image = img.image;
            photo.srcImageView = img;
            [self.imageViewArr addObject:photo];
        }
    }
//    MJPhoto *photo = [[MJPhoto alloc] init];
//    photo.image = self.model.imageArray[i];
//    //        photo.url = [NSURL URLWithString:@"http://f1.jgyes.com/1,20bc0e8abf0f"];
//    photo.srcImageView = img;
//    [self.imageViewArr addObject:photo];
    
    // 2.显示相册  放大
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = (ges.view.tag - 1000); // 弹出相册时显示的第一张图片是？
    browser.photos = self.imageViewArr; // 设置所有的图片
    [browser show];

}
- (void) deleteAction:(UIButton *)btn
{
    [self.model.imageArray removeObjectAtIndex:btn.tag];
    for (UIView *v in self.contentScrollView.subviews)
    {
        [v removeFromSuperview];
    }
    [self initUI];
    if (self.model.imageArray.count == 0)
    {
        if (self.reloadData)
        {
            self.reloadData();
        }
    }
}

@end
