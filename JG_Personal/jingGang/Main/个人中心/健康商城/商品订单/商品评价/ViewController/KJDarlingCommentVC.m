//
//  KJDarlingCommentVC.m
//  jingGang
//
//  Created by 张康健 on 15/8/17.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "KJDarlingCommentVC.h"
#import "KJDarlingTableView.h"
#import "VApiManager.h"
#import "GoodsInfoModel.h"
#import "DarlingCommentModel.h"
#import "NSDictionary+JsonString.h"
#import "GlobeObject.h"
#import "MBProgressHUD.h"
#import "Util.h"
#import "WSProgressHUD.h"
#import "KJShoppingAlertView.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"


@interface KJDarlingCommentVC (){

    VApiManager *_vapManager;
    NSMutableArray *_goodsModelArr;
}

@property (weak, nonatomic) IBOutlet KJDarlingTableView *dc_darlingTableView;

@end

@implementation KJDarlingCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
    
}


-(void)_init{
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [Util setNavTitleWithTitle:@"宝贝评价" ofVC:self];
    _vapManager = [[VApiManager alloc] init];
    _goodsModelArr = [NSMutableArray arrayWithCapacity:_goodsInfos.count];
    NSLog(@"goods info %@",self.goodsInfos);
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(commentBack) target:self];
    for (NSDictionary *dic in self.goodsInfos) {
        GoodsInfoModel *model = [[GoodsInfoModel alloc] initWithJSONDic:dic];
        [_goodsModelArr addObject:model];
    }
    
    self.dc_darlingTableView.goodsArr = (NSArray *)_goodsModelArr;
    [self.dc_darlingTableView reloadData];
}



- (IBAction)makeCommentAction:(id)sender {
    
    //拿到table的数组
    NSArray *commentDataArr = (NSArray *)self.dc_darlingTableView.commentModelArr;
    
    if ([self _checkCommentContentIsEmptyOfCommentArr:commentDataArr]) {//有没评论的内容
        [Util ShowAlertWithOnlyMessage:@"请填写评价内容"];
        return;
    }

    //根据数组组装成json串
    NSString *requestStr = [self _makeCommentRequestDicWithArr:commentDataArr];
   
    NSLog(@"comment str %@",requestStr);
    //评论请求
    [self _commentSaveRequestWithJsonStr:requestStr];
    
}

//评论请求
-(void)_commentSaveRequestWithJsonStr:(NSString *)commentJSONStr{
    [WSProgressHUD showWithMaskType:WSProgressHUDMaskTypeBlack];
    SelfOrderEvaluateSaveRequest *reqquest = [[SelfOrderEvaluateSaveRequest alloc] init:GetToken];
    reqquest.api_evaluateInfo = commentJSONStr;
    //评论操作
    [_vapManager selfOrderEvaluateSave:reqquest success:^(AFHTTPRequestOperation *operation, SelfOrderEvaluateSaveResponse *response) {
        
        [WSProgressHUD dismiss];
        NSLog(@"response --- %@",response );
        if (response.errorCode.integerValue == 5) {
            KSensitiveWords
        }else  if (response.errorCode.integerValue > 0) {
            [KJShoppingAlertView showAlertTitle:@"评论失败" inContentView:self.view];
        }else{
            
            [KJShoppingAlertView showAlertTitle:@"评论成功" inContentView:self.view];
        }
        
        [self performSelector:@selector(commentBack) withObject:nil afterDelay:1.0];
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
          [KJShoppingAlertView showAlertTitle:@"评论失败" inContentView:self.view];
          [WSProgressHUD dismiss];
          [self performSelector:@selector(commentBack) withObject:nil afterDelay:1.0];

    }];

}



-(BOOL)_checkCommentContentIsEmptyOfCommentArr:(NSArray *)commentDataArr{

    BOOL isContentEmpty = NO;
    for (DarlingCommentModel *model in commentDataArr) {
        if (isEmpty(model.commentTextContent)) {
            isContentEmpty = YES;
            break;
        }
    }
    return isContentEmpty;
}


-(NSString *)_makeCommentRequestDicWithArr:(NSArray *)commentDataArr{
    
    NSMutableArray *evaluateArr = [NSMutableArray arrayWithCapacity:commentDataArr.count];
    for (DarlingCommentModel *model in commentDataArr) {
        NSLog(@"goods id %@",model.goodsId);
        
        //数据的处理
        if (model.commentLevel == 2) {//中评
            model.commentLevel = 0;
        }else if (model.commentLevel == 3){//差评
            model.commentLevel = -1;
        }else if (!model.commentLevel){//没评,默认给个好评
            model.commentLevel = 1;
        }
        
        //设置评级默认值
        if (!model.descriptionStars) {
            model.descriptionStars = 1;
        }
        if (!model.deliveryServiceStars) {
            model.deliveryServiceStars = 1;
        }
        if (!model.deliveryServiceStars) {
            model.deliveryServiceStars = 1;
        }
        
         NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
        [dic setObject:model.goodsId forKey:@"goodsId"];
        [dic setObject:@(model.descriptionStars) forKey:@"description"];
        [dic setObject:@(model.deliveryServiceStars) forKey:@"shipEvaluate"];
        [dic setObject:@(model.serviceAltitudeStars) forKey:@"serviceEvaluate"];
        [dic setObject:@(model.commentLevel) forKey:@"evaluateBuyerVal"];
        
        if (![model.commentTextContent isEqualToString:@""]) {
            [dic setObject:model.commentTextContent forKey:@"evaluateInfo"];
        }
        if (![model.joinedImgUrlStr isEqualToString:@""]) {
            [dic setObject:model.joinedImgUrlStr forKey:@"imgPath"];
        }
        
        [dic setObject:model.goodsCount forKey:@"goodsCount"];
        [dic setObject:model.goodsPrice forKey:@"goodsPrice"];
        [dic setObject:model.goodsGspVal forKey:@"goodsGspVal"];
        
        [evaluateArr addObject:(NSDictionary *)dic];
    }
    
    NSDictionary *requestDic = @{@"id":self.orderID,
                                 @"evaluate":(NSArray *)evaluateArr};
    
    return [requestDic jsonString];

}

- (void)commentBack {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
