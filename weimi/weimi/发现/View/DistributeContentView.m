//
//  DistributeContentView.m
//  weimi
//
//  Created by 张康健 on 16/1/20.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "DistributeContentView.h"
#import "PersonDistributeContentModel.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import "UIView+BlockGesture.h"


@implementation DistributeContentView


-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.distributeLabel];
        [self addSubview:self.distributeImageView];
        
        [self _makeContraint];
        
    }
    return self;
}

-(void)_makeContraint {

    [self.distributeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.top.mas_equalTo(self);
        make.right.mas_equalTo(-5);
    }];
    
    [self.distributeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kDistributeImageHeight, kDistributeImageHeight));
        
        make.top.mas_equalTo(self.distributeLabel.mas_bottom).with.offset(5);
        make.left.mas_equalTo(5);
    }];
    self.distributeImageView.userInteractionEnabled = YES;
    WEAK_SELF;
    [self.distributeImageView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        
        NSMutableArray *imageViewArr = [NSMutableArray array];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.image = weak_self.distributeImageView.image;
        photo.srcImageView = weak_self.distributeImageView;
        [imageViewArr addObject:photo];
        
        
        // 2.显示相册  放大
        MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
        browser.currentPhotoIndex = 0; // 弹出相册时显示的第一张图片是？
        browser.photos = imageViewArr; // 设置所有的图片
        [browser show];
    }];

    
}



-(void)setDistributeContentModel:(PersonDistributeContentModel *)distributeContentModel {
    _distributeContentModel = distributeContentModel;
    
    self.distributeLabel.text = _distributeContentModel.distributeText;
    NSString *distriButeUrl = _distributeContentModel.distributePhotoUrlArr.firstObject;
//    NSString *imgUrl = TwiceImgUrl(distriButeUrl, 70, 70);
    [self.distributeImageView sd_setImageWithURL:TwiceImgUrl(distriButeUrl, 70, 70) placeholderImage:nil];
    
    [self _remakeConstraint];
    
}


-(void)_remakeConstraint {
    if (!self.distributeContentModel.distributeText) {
        self.distributeLabel.hidden = YES;
        if (self.distributeContentModel.distributePhotoUrl) {
            [self.distributeImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(kDistributeImageHeight, kDistributeImageHeight));
                make.left.mas_equalTo(5);
                make.top.mas_equalTo(self);
            }];
        }
    }else {
        self.distributeLabel.hidden = NO;
    
    }
    
    if (self.distributeContentModel.distributePhotoUrl.length>5) {
        self.distributeImageView.hidden = NO;
        [self.distributeImageView sd_setImageWithURL:[NSURL URLWithString:self.distributeContentModel.distributePhotoUrl] placeholderImage:nil];
    }else {
        self.distributeImageView.hidden = YES;
    }
}

-(UILabel *)distributeLabel {
    if (!_distributeLabel) {
        _distributeLabel = [XKO_CreateUIViewHelper createLabelWithFont:    [UIFont customFontOfSize:14] fontColor:kGetColor(192, 192, 192) text:nil];
        _distributeLabel.numberOfLines = 0;
    }
    return _distributeLabel;
}


-(UIImageView *)distributeImageView {

    if (!_distributeImageView) {
        _distributeImageView = [UIImageView new];
        _distributeImageView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _distributeImageView.contentMode = UIViewContentModeScaleAspectFill;
        _distributeImageView.clipsToBounds = YES;
    }
    
    return _distributeImageView;
}

@end
