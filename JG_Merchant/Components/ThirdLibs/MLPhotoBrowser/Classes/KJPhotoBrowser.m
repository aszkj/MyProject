//
//  KJPhotoBrowser.m
//  jingGang
//
//  Created by 张康健 on 15/8/24.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "KJPhotoBrowser.h"
#import "MLPhotoBrowserViewController.h"

@interface KJPhotoBrowser()<MLPhotoBrowserViewControllerDataSource,MLPhotoBrowserViewControllerDelegate>{

    NSArray *_imgUrlArr;
    NSArray *_imgViewArr;
}
@end

@implementation KJPhotoBrowser

-(id)initWithImgUrls:(NSArray *)imgUrls imgViewArrs:(NSArray *)imgViewArr{

    self = [super init];
    if (self) {
        _imgUrlArr = imgUrls;
        _imgViewArr = imgViewArr;
    }
    return  self;
}

-(void)clickImgViewAtIndex:(NSInteger)index {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    // 图片游览器
    MLPhotoBrowserViewController *photoBrowser = [[MLPhotoBrowserViewController alloc] init];
    // 缩放动画
    photoBrowser.status = UIViewAnimationAnimationStatusZoom;
    // 可以删除
    //    photoBrowser.editing = YES;
    // 数据源/delegate
    photoBrowser.delegate = self;
    photoBrowser.dataSource = self;
    // 当前选中的值
    photoBrowser.currentIndexPath = [NSIndexPath indexPathForItem:indexPath.row inSection:0];
    // 展示控制器
    [photoBrowser show];
}

#pragma mark - <MLPhotoBrowserViewControllerDataSource>
- (NSInteger)photoBrowser:(MLPhotoBrowserViewController *)photoBrowser numberOfItemsInSection:(NSUInteger)section{
    return _imgUrlArr.count;
}


#pragma mark - 每个组展示什么图片,需要包装下MLPhotoBrowserPhoto
- (MLPhotoBrowserPhoto *) photoBrowser:(MLPhotoBrowserViewController *)browser photoAtIndexPath:(NSIndexPath *)indexPath{
    // 包装下imageObj 成 ZLPhotoPickerBrowserPhoto 传给数据源
    MLPhotoBrowserPhoto *photo = [[MLPhotoBrowserPhoto alloc] init];
    photo.photoObj = [_imgUrlArr objectAtIndex:indexPath.row];
    // 缩略图
    UIImageView *imgView = _imgViewArr[indexPath.row];
    photo.toView = imgView;
    photo.thumbImage = imgView.image;
    return photo;
}




@end
