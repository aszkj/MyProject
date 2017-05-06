//
//  EnvironmentPhotoController.m
//  jingGang
//
//  Created by 鹏 朱 on 15/9/10.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "EnvironmentPhotoController.h"
#import "EnvironmentPhotoCell.h"
#import "EnvironmentInfo.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "UIScrollView+MJRefresh.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

@interface EnvironmentPhotoController ()
{
    CGFloat _cellWidth;
}

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UICollectionView *myCollectionView;
@property(nonatomic,strong) VApiManager *vapManager;
@property (assign, nonatomic) NSInteger currentPage;

@end

@implementation EnvironmentPhotoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    
    CGRect frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarAndStatusBarHeight);
    
    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc] init];
    flowLayout.footerReferenceSize = CGSizeMake(kScreenWidth, 36);
    self.myCollectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
    [self.myCollectionView registerClass:[EnvironmentPhotoCell class] forCellWithReuseIdentifier:@"EnvironmentPhotoCell"];
    self.myCollectionView.backgroundColor = VCBackgroundColor;
    self.myCollectionView.delegate = self;
    self.myCollectionView.dataSource = self;
    [self.view addSubview:self.myCollectionView];
    
    self.title = @"商户环境";
    
    WEAK_SELF
    _myCollectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weak_self.currentPage = 1;
        [weak_self.myCollectionView.footer resetNoMoreData];
        [weak_self _requestGroupStoreAlbunList];
    }];
    
    _myCollectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weak_self _requestGroupStoreAlbunList];
        
    }];
    
    //开始自动刷新
    [self _autoFresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methord
#pragma mark- 初始化UI界面

- (void)initUI
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(goBack) target:self];

    //设置背景颜色
    self.view.backgroundColor = VCBackgroundColor;
    _cellWidth = (kScreenWidth-kEdgeInsetLeft-kEdgeInsetRight-kMinimumInteritemSpacing)/2;
}

#pragma mark- 导航返回
-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 开始自动刷新
-(void)_autoFresh {
    //开始自动刷新
    self.currentPage = 1;
    [self.myCollectionView.header beginRefreshing];
}

- (VApiManager *)vapManager
{
    if (!_vapManager) {
        _vapManager = [[VApiManager alloc] init];
    }
    return _vapManager;
}

#pragma mark - UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"EnvironmentPhotoCell";
    EnvironmentPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    NSDictionary *contentDic = self.dataSource[indexPath.row];
//    EnvironmentInfo *environmentInfo = [self.dataSource objectAtIndex:indexPath.row];
    
    if (cell == nil) {
        cell = [[EnvironmentPhotoCell alloc] initWithFrame:CGRectMake(0, 0, _cellWidth, 100)];
    }
//    cell.titleName.text = environmentInfo.storeName;
//    cell.titleName.text = @"";
    [cell.environmentImg sd_setImageWithURL:[NSURL URLWithString:contentDic[@"path"]] placeholderImage:IMAGE(@"logoeee")];
    cell.environmentImg.tag = indexPath.row + 100;
    UITapGestureRecognizer *singleFingerOne  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(magnifyImage:)];
    singleFingerOne.numberOfTouchesRequired = 1; //手指数
    singleFingerOne.numberOfTapsRequired = 1; //tap次数
    [cell.environmentImg addGestureRecognizer:singleFingerOne];

    return cell;
}

- (void)magnifyImage:(UITapGestureRecognizer*)tap
{
    // 1.封装图片数据
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    
    for (NSDictionary *contentDic in self.dataSource) {
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:contentDic[@"path"]]; // 图片路径
        photo.srcImageView = (UIImageView *)tap.view; // 来源于哪个UIImageView
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = tap.view.tag - 100; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    
    [browser showFromViewController:self];
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    UIView *bottonView = [[UIView alloc] initWithFrame:CGRectZero];
//    if (kind == UICollectionElementKindSectionFooter)
//    {
//
//    }
//    
//    return bottonView;
//}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(_cellWidth, 100);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return kMinimumInteritemSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return kMinimumLineSpacing;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(kMinimumLineSpacing, kEdgeInsetLeft, 0, kEdgeInsetRight);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark - 接口请求

#pragma mark - 提交订单接口
-(void)_requestGroupStoreAlbunList {
    
    GroupStoreAlbunListRequest *request = [[GroupStoreAlbunListRequest alloc] init:GetToken];
    request.api_pageNum = [NSNumber numberWithInteger:_currentPage];
    request.api_pageSize = [NSNumber numberWithInteger:18];
//    request.api_storeId = self.storeId;
    
    WEAK_SELF
    
    [self.vapManager groupStoreAlbunList:request success:^(AFHTTPRequestOperation *operation, GroupStoreAlbunListResponse *response) {
        
        [self updateDatasource:response.storeAlbumList];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self updateDatasource:nil];

        MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:weak_self.view animated:YES];
        hub.labelText = @"提交失败";
        [hub hide:YES afterDelay:1.5];
    }];
}

#pragma mark - 数据请求下来之后，停止上下拉刷新，刷新表等
- (void)updateDatasource:(NSArray *)data {
    
    if (_currentPage == 1) {
        [self.myCollectionView.header endRefreshing];
    }
    
    if (data.count > 0) {
        [self.myCollectionView.footer endRefreshing];
        
        if (_currentPage == 1) {
            self.dataSource = [NSMutableArray arrayWithArray:data];
        } else {
            [self.dataSource addObjectsFromArray:data];
        }
        [self.myCollectionView reloadData];
        
    } else {
        [self.myCollectionView.footer noticeNoMoreData];
    }
    
    _currentPage ++;
}

@end
