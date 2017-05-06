//
//  DLOrderCommentVC.m
//  YilidiBuyer
//
//  Created by mm on 17/2/7.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "DLOrderCommentVC.h"
#import "MycommonTableView.h"
#import "DLOrderMakeCommentCell.h"
#import "DLMerchantServiceCommentFooterView.h"
#import "MerchantCommentModel.h"
#import "GoodsModel.h"
#import "ProjectStandardUIDefineConst.h"
#import "ProjectRelativeDefineNotification.h"
#import <SDImageCache.h>

@interface DLOrderCommentVC ()

@property (weak, nonatomic) IBOutlet MycommonTableView *orderCommentTableView;
@property (nonatomic,strong) NSMutableArray *orderGoodsComments;
@property (nonatomic,strong) MerchantCommentModel *merchantCommentModel;
@property (weak, nonatomic) IBOutlet UIButton *subbmitCommentButton;
@property (weak, nonatomic) IBOutlet UIButton *nickCommentButton;

@end

@implementation DLOrderCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageTitle = @"评价晒单";
    
    [self _registerNotification];
    
    [self _initOrderCommentTableView];
    
    [self _requestOrderGoodsInfo];
    
    [self _initUI];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
//    [Util ShowAlertWithOnlyMessage:@"评论图片过多，系统出现内存警告了"];
    DDLogVerbose(@"内存警告了");
    [[SDImageCache sharedImageCache] clearMemory];

    
}

#pragma mark ------------------------Init---------------------------------
- (void)_initOrderCommentTableView {
    WEAK_SELF
    [self.orderCommentTableView configurecellNibName:@"DLOrderMakeCommentCell" configurecellData:^(UITableView *tableView, id cellModel, UITableViewCell *cell) {
        OrderCommentModel *model = (OrderCommentModel *)cellModel;
        DLOrderMakeCommentCell *commentCell = (DLOrderMakeCommentCell *)cell;
        commentCell.orderCommentModel = model;
        commentCell.needToUpdateCellHeightBlock = ^{
            [weak_self.orderCommentTableView reloadData];
        };
    } clickCell:^(UITableView *tableView, id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
        
    }];
    self.orderCommentTableView.firstSectionFooterHeight = kDLMerchantServiceCommentFooterViewHeight;
    [self.orderCommentTableView configureFirstSectioFooterNibName:@"DLMerchantServiceCommentFooterView" ConfigureTablefirstSectionFooterBlock:^(UITableView *tableView, id cellModel, UIView *firstSectionFooterView) {
        DLMerchantServiceCommentFooterView *merchantServiceCommentFooterView = ( DLMerchantServiceCommentFooterView *)firstSectionFooterView;
        merchantServiceCommentFooterView.merchantCommentModel = weak_self.merchantCommentModel;
    }];
    
    self.orderCommentTableView.cellHeightBlock = ^CGFloat(UITableView *tableView,id cellModel){
        OrderCommentModel *model = (OrderCommentModel *)cellModel;
        return model.commentTotalHeight;
    };
    
    self.orderCommentTableView.listenTableViewScrollOffsetBlock = ^(CGFloat y){
//        [weak_self.view endEditing:YES];
    };
    
    
}

- (void)_initUI {
    [self _configureSubbmitCommentButton:NO];
}

- (void)_initOrderGoodsCommentsWithGoodsArr:(NSArray *)goodsArr {
    self.orderGoodsComments = [NSMutableArray arrayWithCapacity:0];
    
    for (GoodsModel *goodsModel in goodsArr) {
        OrderCommentModel *model = [[OrderCommentModel alloc] initWithDefaultDataDic:nil];
        model.saleProductScore = 5.0f;
        model.commentGoodsImgUrl = goodsModel.goodsThumbnail;
        model.commentGoodsId = goodsModel.goodsId;
        [self.orderGoodsComments addObject:model];
    }
    
    [self.orderCommentTableView configureTableAfterRequestTotalData:self.orderGoodsComments];
}

#pragma mark ------------------------Private-------------------------
- (void)_registerNotification {
    [kNotification addObserver:self selector:@selector(observeHasCommentStartNotification) name:KNotificationHasCommentStarNotification object:nil];
}


- (NSString *)_submmitCommentCheckError{
    NSString *errorStr=nil;
    
    if (self.merchantCommentModel.merchantServiceCommentScore < 1) {
        return @"亲，商家服务未评价哦";
    }
    
    if (self.merchantCommentModel.merchantShipServiceCommentScore < 1) {
        return @"亲，配送服务未评价哦";
    }
    
    if (![self _hasAllGoodsCommentDecriptionStart]) {
        return @"亲，有商品未评价描述哦";
    }
    
    return errorStr;
}

- (BOOL)_hasAllGoodsCommentDecriptionStart {
    BOOL allGoodsHasCommentDecriptionStart = YES;
    for (OrderCommentModel *model in self.orderGoodsComments) {
        if (model.saleProductScore < 1) {
            allGoodsHasCommentDecriptionStart = NO;
            break;
        }
    }
    return allGoodsHasCommentDecriptionStart;
}

- (void)_configureSubbmitCommentButton:(BOOL)canComment {
    self.subbmitCommentButton.enabled = canComment;
    self.subbmitCommentButton.backgroundColor = canComment ? KSelectedBgColor : KWeakTextColor;
}

- (NSArray *)_getGoodsComments {
    NSMutableArray *goodsComments = [NSMutableArray arrayWithCapacity:0];
    for (OrderCommentModel *commentModel in self.orderGoodsComments) {
        NSMutableDictionary *goodsCommentDic = [NSMutableDictionary dictionaryWithCapacity:5];
        [goodsCommentDic setObject:commentModel.commentGoodsId forKey:@"saleProductId"];
        [goodsCommentDic setObject:@(commentModel.saleProductScore) forKey:@"saleProductScore"];
        if (commentModel.commentContent) {
            [goodsCommentDic setObject:commentModel.commentContent forKey:@"evaluateContent"];
        }
        
        NSArray *commentGoodsImgs = [commentModel commentImgUrls];
        if (commentGoodsImgs.count) {
            [goodsCommentDic setObject:commentGoodsImgs forKey:@"evaluateImages"];
        }
        [goodsComments addObject:goodsCommentDic];
    }
    return [goodsComments copy];
}

#pragma mark ------------------------Api----------------------------------
- (void)_requestSubmmitComment {
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:5];
//    [param setObject:self.merchantCommentModel.merchantStoreId forKey:@"storeId"];
    [param setObject:@(self.merchantCommentModel.merchantServiceCommentScore) forKey:@"serviceScore"];
    [param setObject:@(self.merchantCommentModel.merchantShipServiceCommentScore) forKey:@"deliverScore"];
    NSInteger isNickComment = self.nickCommentButton.selected;
    [param setObject:@(isNickComment) forKey:@"isAnonymous"];
    [param setObject:[self _getGoodsComments] forKey:@"saleProductEvaluations"];
    [param setObject:self.orderNo forKey:@"saleOrderNo"];

    [self showLoadingHub];
    [AFNHttpRequestOPManager postWithParameters:param subUrl:kUrl_MakeOrderComment block:^(NSDictionary *resultDic, NSError *error) {
        [self hideLoadingHub];
        if (error.code == 1) {
//            [self delayGoBack];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (void)_requestOrderGoodsInfo {
    
        [self showLoadingHub];
        NSDictionary *paramDic = @{@"saleOrderNo":self.orderNo};
        [AFNHttpRequestOPManager postWithParameters:paramDic subUrl:kUrl_OrderDetail block:^(NSDictionary *resultDic, NSError *error) {
            [self hideLoadingHub];
    
            NSArray *orderGoodsArr = resultDic[EntityKey] [@"saleOrderItemList"];
            [self _initOrderGoodsCommentsWithGoodsArr:[GoodsModel objectGoodsModelWithGoodsArr:orderGoodsArr]];
        
        }];
    

}

#pragma mark ------------------------Page Navigate---------------------------

#pragma mark ------------------------View Event---------------------------
- (IBAction)submmitCommentAction:(id)sender {
    NSString *submmitError = [self _submmitCommentCheckError];
    if (submmitError) {
        [Util ShowAlertWithOnlyMessage:submmitError];
        return;
    }
    [self _requestSubmmitComment];
    
}
- (IBAction)nickCommentAction:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    self.nickCommentButton.selected = !button.selected;
}

- (void)goBack {
    WEAK_SELF
    [self showAlertWithTitle:@"提示" message:@"是否放弃本次评价" sureTitle:@"确定" cancelTitle:@"取消" sureAction:^(UIAlertAction *action) {
#warning 这里不能用super,super，它还是要先从self找起，简洁引用了self,导致循环引用
//        [super goBack];
        [weak_self.navigationController popViewControllerAnimated:YES];
    } cancelAction:^(UIAlertAction *action) {
        
    }];
}

- (void)dealloc {
    [kNotification removeObserver:self];
}

#pragma mark ------------------------Delegate-----------------------------

#pragma mark ------------------------Notification-------------------------
- (void)observeHasCommentStartNotification {
    BOOL canSubbmitComment = [self _submmitCommentCheckError] == nil;
    [self _configureSubbmitCommentButton:canSubbmitComment];
}

#pragma mark ------------------------Getter / Setter----------------------

- (MerchantCommentModel *)merchantCommentModel{
    if (!_merchantCommentModel) {
        _merchantCommentModel = [[MerchantCommentModel alloc] init];
    }
    return _merchantCommentModel;
}

@end
