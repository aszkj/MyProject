
//
//  BaseInfoPhotoTableViewCell.m
//  Operator_JingGang
//
//  Created by thinker on 15/9/18.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "BaseInfoPhotoTableViewCell.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

@interface BaseInfoPhotoTableViewCell ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic,strong) NSMutableArray *imageViewArr;

@end

@implementation BaseInfoPhotoTableViewCell

- (void)awakeFromNib {
}

- (void)setDataImage:(NSArray *)dataImage
{
    _dataImage = dataImage;
    for ( UIView *v in self.scrollView.subviews)
    {
        [v removeFromSuperview];
    }
    [self initUI];
    
}
- (void) initUI
{
    CGFloat _width = 100;
    for (NSInteger i = 0 ; i < _dataImage.count; i++)
    {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake((_width +10) * i, 0, _width, CGRectGetHeight(self.scrollView.frame))];
        [img sd_setImageWithURL:[NSURL URLWithString:_dataImage[i]]];
        img.userInteractionEnabled = YES;
        img.tag = i +1000;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionImageView:)];
        [img addGestureRecognizer:tap];
        [self.scrollView addSubview:img];

    }
    self.scrollView.contentSize = CGSizeMake(_dataImage.count *(_width + 10) - 10, 1);
}
- (void)actionImageView:(UIGestureRecognizer *)ges
{
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity: [_dataImage count] ];
    for (int i = 0; i < [_dataImage count]; i++) {
        // 替换为中等尺寸图片
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString: _dataImage[i]]; // 图片路径
        
        UIImageView * imageView = (UIImageView *)[self.scrollView viewWithTag: ges.view.tag ];
        photo.srcImageView = imageView;
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = ges.view.tag - 1000; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
}

@end
