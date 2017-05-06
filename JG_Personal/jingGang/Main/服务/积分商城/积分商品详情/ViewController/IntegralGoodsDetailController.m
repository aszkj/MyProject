//
//  IntegralGoodsDetailController.m
//  jingGang
//
//  Created by 张康健 on 15/11/2.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "IntegralGoodsDetailController.h"
#import "IntegralGoodsPhotoTextDetailView.h"
#import "Masonry.h"
#import "GlobeObject.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "PublicInfo.h"
#import "VApiManager.h"
#import "ZkgLoadingHub.h"
#import "SDCycleScrollView.h"
#import "NSObject+MJExtension.h"
#import "Util.h"
#import "TMCache.h"
#import "MBProgressHUD.h"
#import "WIntegralCartViewController.h"


//图文详情高度
#define kIntegralPhotoTextDetailViewHeight (kScreenHeight-kStatuBarAndNavBarHeight-10)

//触发上拉高度
#define Integral_OffetTrrigerScrollToDown 70

@interface IntegralGoodsDetailController ()<UIScrollViewDelegate>{

    VApiManager     *_vapManager;
    NSDictionary    *_integralDic;
    TMCache         *_integralGoodsCache;
    MBProgressHUD   *_exchangeHub;
}


@property (nonatomic, strong)IntegralGoodsDetails *integralGoodsDetails;

//scrollView最大可滑动的距离
@property (nonatomic, assign)CGFloat ableScrollHeight;

@property (weak, nonatomic) IBOutlet UIView *gdScrollContentView;
@property (weak, nonatomic) IBOutlet UILabel *marketPriceLabel;

@property (nonatomic, strong)IntegralGoodsPhotoTextDetailView *integralGoodsPhotoTextDetailView;
@property (nonatomic, strong)IntegralGoodsPhotoTextDetailView *trueIntegralGoodsPhotoTextDetailView;
@property (weak, nonatomic) IBOutlet UIScrollView *gdScrollView;
@property (weak, nonatomic) IBOutlet SDCycleScrollView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *integralNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *needIntegralLabel;
@property (weak, nonatomic) IBOutlet UILabel *postRetFeetLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromBeginToEndTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *duihuanBtnToTopConstraint;

@end

@implementation IntegralGoodsDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
    
    //添加图文详情view
    [self _loadPhotoTextView];
    
    //请求商品详情数据
    [self _requestIntegralGoodsDetailData];

}


#pragma mark ----------------------- private Method -----------------------
- (void)_init {
    self.navigationController.navigationBar.barTintColor = kGetColor(94, 180, 231);
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(back) target:self];
    [Util setNavTitleWithTitle:@"商品详情" ofVC:self];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _integralGoodsCache = [TMCache sharedCache];
//    [_integralGoodsCache removeObjectForKey:kIntegralGoodsCacheKey];
    _vapManager = [[VApiManager alloc] init];
    NSLog(@"kscreenHeight %.2f",kScreenHeight);
    if (iPhone6p) {
        self.duihuanBtnToTopConstraint.constant = 85;
    }
    
}


#pragma mark - 请求商品详情数据
- (void)_requestIntegralGoodsDetailData {
    
    ZkgLoadingHub *hub = [[ZkgLoadingHub alloc] initHubInView:self.view withLoadingType:LoadingSystemtype];
    IntegralDetailsRequest *request = [[IntegralDetailsRequest alloc] init:GetToken];
    request.api_id = self.integralGoodsID;
    
    [_vapManager integralDetails:request success:^(AFHTTPRequestOperation *operation, IntegralDetailsResponse *response) {
        [hub endLoading];
        
         NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"积分商品详情 response %@",response);
        self.integralGoodsDetails = [IntegralGoodsDetails JGObjectvalueWithKeyValue:dict[@"integralDetails"]];
        _integralDic = dict[@"integralDetails"];
        [self _assignDataToUI];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hub endLoading];
        [Util ShowAlertWithOnlyMessage:error.localizedDescription];
        JGLog(@"error:%@",error.domain);
        
    }];
}


-(void)_assignDataToUI {
    
    //头部
    [self _assignHeaderViewData];
    
    //描述部分
    [self _descriptionPartData];
    
    //时间和等级部分
    [self _timeAndRankPartData];
    
}

#pragma mark - 描述部分
- (void)_descriptionPartData {
    self.marketPriceLabel.text = kNumberToStrRemain2PointYuan(self.integralGoodsDetails.igGoodsPrice);
    self.integralNameLabel.text = self.integralGoodsDetails.igGoodsName;
    self.needIntegralLabel.text = kNumberToStr(self.integralGoodsDetails.igGoodsIntegral);
    self.postRetFeetLabel.text = kNumberToStrRemain2PointYuan(self.integralGoodsDetails.igTransfee);
    self.storeCountLabel.text = kNumberToStr(self.integralGoodsDetails.igGoodsCount);
}


#pragma mark - 时间和会员等级部分
- (void)_timeAndRankPartData {
    
    NSString *beginTimeStr = [NSString stringWithFormat:@"%@",self.integralGoodsDetails.igBeginTime];
    beginTimeStr = [Util trasnLateToHumanReadStrOfServerTimeStr:beginTimeStr];

    NSString *endTimeStr = [NSString stringWithFormat:@"%@",self.integralGoodsDetails.igEndTime];
    endTimeStr = [Util trasnLateToHumanReadStrOfServerTimeStr:endTimeStr];
    //兑换时间
    if (!self.integralGoodsDetails.igTimeType.integerValue) {
        self.fromBeginToEndTimeLabel.text = @"无限制";
    }else {
        self.fromBeginToEndTimeLabel.text = [NSString stringWithFormat:@"%@至%@",beginTimeStr,endTimeStr];
    }
    
    NSString *rankStr = @"";
    switch (self.integralGoodsDetails.igUserLevel.integerValue) {
        case 0:
            rankStr = @"铜牌";
            break;
        case 1:
            rankStr = @"银牌";
            break;
        case 2:
            rankStr = @"金牌";
            break;
        case 3:
            rankStr = @"超级会员";
            break;
        default:
            break;
    }
    
    if (self.integralGoodsDetails.igUserLevel.integerValue != 3) {//超级会员
        rankStr = [NSString stringWithFormat:@"%@及以上会员",rankStr];
    }
    
    self.rankLabel.text = rankStr;
    
}


#pragma mark - 头部视图数据
-(void)_assignHeaderViewData {
    NSLog(@"goodsTime %@",self.integralGoodsDetails.apiId);
    NSInteger imgurlminLength = 5;
    if (self.integralGoodsDetails.igGoodsImg.length > imgurlminLength) {
        NSArray *imgUrlArr = [self.integralGoodsDetails.igGoodsImg componentsSeparatedByString:@"|"];
        NSMutableArray *twiceImgUrlArr = [NSMutableArray arrayWithCapacity:imgUrlArr.count];
        for (NSString *urlStr in imgUrlArr) {
            [twiceImgUrlArr addObject:TwiceImgUrlStr(urlStr, kScreenWidth, kScreenWidth)];
        }
        
        self.headerView.imageURLStringsGroup = (NSArray *)twiceImgUrlArr;
    }
}


#pragma mark - 图文详情view
-(void)_loadPhotoTextView{
    _integralGoodsPhotoTextDetailView = BoundNibView(@"IntegralGoodsPhotoTextDetailView", IntegralGoodsPhotoTextDetailView);
    [self.gdScrollContentView addSubview:_integralGoodsPhotoTextDetailView];
    [_integralGoodsPhotoTextDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.gdScrollContentView.mas_bottom);
        make.left.right.mas_equalTo(self.gdScrollContentView);
        make.height.mas_equalTo(kIntegralPhotoTextDetailViewHeight);
    }];
}

#pragma mark 添加真正的图文详情view
-(void)addTruePhotoTextView{
    [Util setNavTitleWithTitle:@"图文详情" ofVC:self];
    if (!_trueIntegralGoodsPhotoTextDetailView) {
        
        _trueIntegralGoodsPhotoTextDetailView = BoundNibView(@"IntegralGoodsPhotoTextDetailView", IntegralGoodsPhotoTextDetailView);
        [self.view addSubview:_trueIntegralGoodsPhotoTextDetailView];
        [_trueIntegralGoodsPhotoTextDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.right.mas_equalTo(self.view);
            make.height.mas_equalTo(kIntegralPhotoTextDetailViewHeight);
        }];
        //图文详情部分
        _trueIntegralGoodsPhotoTextDetailView.ptPhotoDetailWebUrlStr= self.integralGoodsDetails.igContent;
        WEAK_SELF
        _trueIntegralGoodsPhotoTextDetailView.upBlock = ^(NSInteger selectedIndex){
            //拉上来的时候，，将真实的隐藏
            weak_self.trueIntegralGoodsPhotoTextDetailView.hidden = YES;
            [weak_self.gdScrollView setContentOffset:CGPointMake(0, weak_self.ableScrollHeight) animated:YES];
//            [weak_self performSelector:@selector(_scrollToDown) withObject:nil afterDelay:0.3];
            [Util setNavTitleWithTitle:@"积分商品详情" ofVC:weak_self];
        };
        
    }else{
        
        _trueIntegralGoodsPhotoTextDetailView.hidden = NO;
    }
}


#pragma mark ----------------------- Action Method -----------------------
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 立即兑换
- (IBAction)imiditeliExchange:(id)sender {
    UNLOGIN_HANDLE
    _exchangeHub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    IntegralExchangeRequest *request = [[IntegralExchangeRequest alloc] init:GetToken];
    request.api_id = self.integralGoodsID;
    request.api_count = @1;
    [_vapManager integralExchange:request success:^(AFHTTPRequestOperation *operation, IntegralExchangeResponse *response) {
        
        NSLog(@"兑换结果 %@",response);
        [self _exchangeResultStates:response.exchangeStatus];
        

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}



-(void)_integralCache{
    
    //读取缓存
    NSArray *integralArr = [_integralGoodsCache objectForKey:kIntegralGoodsCacheKey];
    BOOL cached = NO;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_integralDic];
    NSNumber *goodsID = _integralDic[@"id"];
    [dic setObject:goodsID forKey:@"apiId"];
    [dic removeObjectForKey:@"id"];
    
    [dic setObject:@1 forKey:@"igExchangeCount"];
    for (NSDictionary *dic in integralArr) {
        if ([dic[@"apiId"] integerValue] == self.integralGoodsID.integerValue) {
            //缓存过了
            cached = YES;
            break;
        }
    }
    
    if (!cached) {//没有缓存
      NSMutableArray *integralMutableArr = [NSMutableArray arrayWithArray:integralArr];
      [integralMutableArr addObject:dic];
        [_integralGoodsCache setObject:(NSArray *)integralMutableArr forKey:kIntegralGoodsCacheKey];
    }

}


#pragma mark - 处理兑换结果
-(void)_exchangeResultStates:(NSNumber *)exchangeStates{
    
    if (!exchangeStates.integerValue) {//可以兑换
        //缓存操作
        [self _integralCache];
        _exchangeHub.labelText = @"正在兑换..";
        [self performSelector:@selector(_gotoShopCartPage) withObject:nil afterDelay:0.5];
        return;
    }
    _exchangeHub.hidden = YES;
    //无法兑换
    NSString *alertInfo = @"";
    switch (exchangeStates.integerValue) {
        case 1:
            alertInfo = @"已过期";
            break;
        case 2:
            alertInfo = @"等级不够";
            break;
        case 3:
            alertInfo = @"积分不够";
            break;
        case 4:
            alertInfo = @"库存不足";
            break;
        case 5:
            alertInfo = @"超出限制兑换数";
            break;
        case 7:
            alertInfo = @"未开始，不能兑换";
            break;
        default:
            break;
    }
    if (exchangeStates.integerValue == 6) {//未登录
            [Util enterLoginPage];
    }else {
        [Util ShowAlertWithOnlyMessage:alertInfo];
    }
}



- (void)_gotoShopCartPage {
    
    [_exchangeHub hide:YES];
    WIntegralCartViewController *shopVC = [[WIntegralCartViewController alloc] init];
    [self.navigationController pushViewController:shopVC animated:YES];
    
}



#pragma mark - scrollView delegate
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    NSLog(@"will end drag content offset %.2f",scrollView.contentOffset.y);
    if (!(int)_ableScrollHeight) {
        _ableScrollHeight = scrollView.contentSize.height-scrollView.frame.size.height;
    }
    //scrollScrollTopBottonOffset
    if (scrollView.contentOffset.y > _ableScrollHeight + Integral_OffetTrrigerScrollToDown)            {
        //#warning 松手后它可能会往下滑动，，而我是想让他定在那里然后往上滑
        targetContentOffset->y = scrollView.contentOffset.y;
        
        [self performSelector:@selector(_scrollToUp) withObject:nil afterDelay:0.2];
    }
}

-(void)_scrollToUp {

    [self.gdScrollView setContentOffset:CGPointMake(0, _ableScrollHeight+kIntegralPhotoTextDetailViewHeight) animated:YES];
    [self performSelector:@selector(addTruePhotoTextView) withObject:nil afterDelay:0.3];
}

- (void)_scrollToDown {
     [self.gdScrollView setContentOffset:CGPointMake(0, self.ableScrollHeight) animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
