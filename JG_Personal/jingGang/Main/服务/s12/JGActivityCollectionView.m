//
//  JGActivityCollectionController.m
//  jingGang
//
//  Created by dengxf on 15/12/9.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "JGActivityCollectionView.h"
#import "JGActivityItemCell.h"
#import "JGActivityHeaderView.h"
#import "JGActivityFootiew.h"
#import "UIImageView+WebCache.h"
#import "GlobeObject.h"
#import "JGIntegralItemCell.h"

@interface JGActivityCollectionView ()<UIScrollViewDelegate>

@end

static NSString * kActivityCollectionCell = @"kActivityCollectionCell";

@implementation JGActivityCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.dataSource = self;
    self.delegate = self;
     UIImageView *backImge = [[UIImageView alloc] initWithFrame:self.bounds];
     backImge.image = [UIImage imageNamed:@"christmas_bggroundImg"];
     self.backgroundView = backImge;
    [self registerNib:[UINib nibWithNibName:@"JGIntegralItemCell" bundle:nil] forCellWithReuseIdentifier:@"integralItemCell"];
    [self registerClass:[JGActivityHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
    [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot"];
}

- (void)setShops:(NSArray *)shops {
    _shops = shops;
}


- (void)setupLayout {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((ScreenWidth - 3 * 10) / 2, 280);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10);
    layout.minimumLineSpacing = 10;
    self.collectionViewLayout = layout;
}

- (void)setApiBO:(JGActivityHotSaleApiBO *)apiBO {
    _apiBO = apiBO;
}


- (void)setIntegarlCount:(CGFloat)integarlCount {
     _integarlCount = integarlCount;
}

- (void)setActivityApiBO:(ActivityHotSaleApiBO *)activityApiBO {
     _activityApiBO = activityApiBO;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.shops.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
     JGIntegralItemCell *cell = [self dequeueReusableCellWithReuseIdentifier:@"integralItemCell" forIndexPath:indexPath];
     cell.layer.borderWidth = 0.25;
     cell.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.8].CGColor;
     cell.backgroundColor = kGetColorWithAlpha(240, 240, 240, 1);
     cell.listBO = self.shops[indexPath.item];
//     cell.backgroundColor = JGColor(254, 255, 255, 1);
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
     if (self.selectedItemShopBlock) {
          self.selectedItemShopBlock(_shops[indexPath.item]);
     }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
          JGActivityHeaderView *reusableView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head" forIndexPath:indexPath];
          reusableView.backgroundColor = [UIColor clearColor];
         UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, reusableView.height)];
         [reusableView addSubview:headerView];
          UIImageView *headimg = [[UIImageView alloc] init];
          headimg.x = 0;
          headimg.y = 0;
          headimg.width = ScreenWidth;
          headimg.height = [self getImageHeightWithNormalHeight:290];
//         headimg.image = [UIImage imageNamed:@"christmas_header"];
         [headimg sd_setImageWithURL:[NSURL URLWithString:self.activityApiBO.headImage] placeholderImage:[UIImage imageNamed:@"christmas_header"] options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
         } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
         }];
         
         [headerView addSubview:headimg];
         
         UIImageView *bottomBg = [[UIImageView alloc] init];
         bottomBg.userInteractionEnabled = YES;
         bottomBg.x = 0;
         bottomBg.y = CGRectGetMaxY(headimg.frame);
         bottomBg.width = ScreenWidth;
         bottomBg.height = 43;
         bottomBg.image = [UIImage imageNamed:@"christmas_bottom"];
         [headerView addSubview:bottomBg];
         
         UIImageView *iconImg = [[UIImageView alloc] init];
         iconImg.x = 16;
         iconImg.y = (bottomBg.height - 11)/2 + 6;
         iconImg.width = 12;
         iconImg.height = 11;
         iconImg.image = [UIImage imageNamed:@"christmas_shopIcon"];
         [bottomBg addSubview:iconImg];
         
         UILabel *shopLab = [[UILabel alloc] init];
         shopLab.x = CGRectGetMaxX(iconImg.frame) + 2;
         shopLab.y = iconImg.y - 4;
         shopLab.width = 85;
         shopLab.height = 21;
         shopLab.text = @"兑换商品";
         shopLab.font = [UIFont systemFontOfSize:12];
         shopLab.textColor = JGColor(78, 78, 78, 1);
         [bottomBg addSubview:shopLab];
         
         UILabel *integrateLab = [[UILabel alloc] init];
         integrateLab.x = CGRectGetMaxX(shopLab.frame) + 12;
         integrateLab.y = shopLab.y;
         integrateLab.width = 120;
         integrateLab.height = 21;
         integrateLab.text = [NSString stringWithFormat:@"我的积分:  %.1f",self.integarlCount];
         integrateLab.font = shopLab.font;
         integrateLab.textColor = shopLab.textColor;
         [bottomBg addSubview:integrateLab];
         
         UIButton *filterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
         CGFloat filterBtnWidth = 100;
         CGFloat filterBtnHight = bottomBg.height;
         CGFloat marginW = 0;
         filterBtn.x = ScreenWidth - filterBtnWidth - marginW;
         filterBtn.y = 0;
         filterBtn.width = filterBtnWidth;
         filterBtn.height = filterBtnHight;
         filterBtn.backgroundColor = [UIColor clearColor];
         [filterBtn setImage:[UIImage imageNamed:@"christmas_ filter"] forState:UIControlStateNormal];
         [filterBtn setTitle:@"筛选" forState:UIControlStateNormal];
         filterBtn.imageEdgeInsets = UIEdgeInsetsMake(12, 16, 0, 0);
         filterBtn.titleEdgeInsets = UIEdgeInsetsMake(12, 24, 0, 0);
         [filterBtn setTitleColor:integrateLab.textColor forState:UIControlStateNormal];
         filterBtn.titleLabel.font = integrateLab.font;
         filterBtn.showsTouchWhenHighlighted = YES;
         [filterBtn addTarget:self action:@selector(filterButtonClick:) forControlEvents:UIControlEventTouchUpInside];
         [bottomBg addSubview:filterBtn];
         return reusableView;
    }else {
          JGActivityFootiew *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot" forIndexPath:indexPath];
          reusableView.backgroundColor = [UIColor clearColor];
          UIImageView *footimg = [[UIImageView alloc] init];
          [reusableView addSubview:footimg];
          footimg.x = 0;
          footimg.y = 0;
          footimg.width = ScreenWidth;
          footimg.height = reusableView.height;
         footimg.backgroundColor = [UIColor clearColor];
         UIButton *bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
         [bgBtn setImage:[UIImage imageNamed:@"christmas_refresh"] forState:UIControlStateNormal];
         [bgBtn setTitle:@"上拉加载更多商品.." forState:UIControlStateNormal];
         bgBtn.titleLabel.font = [UIFont systemFontOfSize:12];
         bgBtn.titleLabel.textColor = [UIColor whiteColor];
         bgBtn.x = 0;
         bgBtn.y = 0;
         bgBtn.width = ScreenWidth;
         bgBtn.height = 40;
         [footimg addSubview:bgBtn];
         return reusableView;
    }
}

- (void)filterButtonClick:(UIButton *)btn {
     if (self.showFilterView) {
          self.showFilterView(btn);
     }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
     
//     if (!self.showIntegral) {
          return CGSizeMake(ScreenWidth, [self getImageHeightWithNormalHeight:351]);
//     }else {
//          return CGSizeMake(ScreenWidth, [self getImageHeightWithNormalHeight:290 + 10]);
//     }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(ScreenWidth, [self getImageHeightWithNormalHeight:40]);
}

- (CGFloat)getImageHeightWithNormalHeight:(CGFloat)normalHeight
{
    //以iphone6的屏幕宽度为标准
    CGFloat height = kScreenWidth/375 * normalHeight;
    
    return height;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
     [kNotification postNotificationName:@"kIntegarlCollectionContentOffsetYKey" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:self.contentOffset.y],@"integarlContentOffsetY", nil]];
}


@end
