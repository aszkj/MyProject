//
//  IntegralHomeHeaderView.m
//  jingGang
//
//  Created by 张康健 on 15/11/22.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "IntegralHomeHeaderView.h"
#import "IntegralGoodsDetailController.h"
#import "VApiManager.h"
#import "AdRecommendModel.h"
#import "GlobeObject.h"
#import "WebDayVC.h"
#import "MJExtension.h"
#import "H5Base_url.h"
#import "UIView+firstResponseController.h"
#import "KJGoodsDetailViewController.h"
#import "RecommentCodeDefine.h"

@interface IntegralHomeHeaderView()<SDCycleScrollViewDelegate>{

    VApiManager *_vapManager;
    NSMutableArray *_headerModelArr;
}

@end

@implementation IntegralHomeHeaderView

- (void)awakeFromNib {
    
    _vapManager = [[VApiManager alloc] init];
    self.headerView.delegate = self;
}

- (void)headerRequestData {
    
    //请求头部广告
    [self _requestHeaderDataWithAdCode:IntegralShopHomeAdCode];
    
}

-(void)_requestHeaderDataWithAdCode:(NSString *)adCode{
    
    SnsRecommendListRequest *request = [[SnsRecommendListRequest alloc] init:GetToken];
    request.api_posCode = adCode;
    [_vapManager snsRecommendList:request success:^(AFHTTPRequestOperation *operation, SnsRecommendListResponse *response) {
        //头部图片数组
        NSMutableArray *headImgUrlArr = [NSMutableArray arrayWithCapacity:response.advList.count];
        _headerModelArr = [NSMutableArray arrayWithCapacity:response.advList.count];
        for (NSDictionary *dic in response.advList) {
            AdRecommendModel *model = [[AdRecommendModel alloc] initWithJSONDic:dic];
            NSString *urlStr = TwiceImgUrlStr(model.adImgPath, CGRectGetWidth(self.headerView.frame), CGRectGetHeight(self.headerView.frame));
            [headImgUrlArr addObject:urlStr];
            [_headerModelArr addObject:model];
        }
        
        NSLog(@"头部图片 %@",headImgUrlArr);
        //刷新头部
        self.headerView.imageURLStringsGroup = (NSArray *)headImgUrlArr;
        //
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
}


#pragma mark ----------------------- SDCycle HeaderView delegate -----------------------
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    AdRecommendModel *model = _headerModelArr[index];
    if (model.itemId) {
        if (model.adType.integerValue == 1 || model.adType.integerValue == 4) {//资讯
            WebDayVC *webVC = [[WebDayVC alloc] init];
            webVC.dic = (NSDictionary *)[model keyValues];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:webVC];
            NSString *url = [NSString stringWithFormat:@"%@%@",Base_URL,model.adUrl];
            webVC.strUrl = url;
            webVC.ind = 1;
            nav.navigationBar.barTintColor = [UIColor colorWithRed:74.0/255 green:182.0/255 blue:236.0/255 alpha:1];
            [self.firstResponseController presentViewController:nav animated:YES completion:nil];
        }else if (model.adType.integerValue == 2){//商品详情
            IntegralGoodsDetailController *integralGoodsDetailVC = [[IntegralGoodsDetailController alloc] init];
            NSInteger goodDetailId = [model.itemId integerValue];
            //积分商城跳转
            integralGoodsDetailVC.integralGoodsID = @(goodDetailId);
            [self.firstResponseController.navigationController pushViewController:integralGoodsDetailVC animated:YES];
        }
    }
}





@end
