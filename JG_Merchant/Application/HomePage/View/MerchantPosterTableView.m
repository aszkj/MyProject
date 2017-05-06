//
//  MerchantPosterTableView.m
//  Merchants_JingGang
//
//  Created by 张康健 on 15/11/7.
//  Copyright © 2015年 XKJH. All rights reserved.
//
#import "MerchantPosterTableView.h"
#import "NoticeCell.h"
#import "MerchantPosterDetailController.h"
#import "UIView+firstResponseController.h"
#import "MerchantPosterDetailVC.h"
#import "NodataShowView.h"

@interface MerchantPosterTableView ()
@property (nonatomic, strong) NodataShowView *noDataView;

@end

@implementation MerchantPosterTableView

static NSString *NoticeCellID = @"NoticeCellID";

-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    self = [super initWithFrame:frame style:style];
    if (self) {
        
        [self _init];
    }
    return self;
}


- (void)_init {
    
    self.delegate = self;
    self.dataSource = self;
//    self.rowHeight = 80;
    [self registerNib:[UINib nibWithNibName:@"NoticeCell" bundle:nil] forCellReuseIdentifier:NoticeCellID];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataLogicModule.currentDataModelArr.count == 0) {
        self.noDataView = [NodataShowView showInContentView:tableView withReloadBlock:^{
            [tableView reloadData];
        } requestResultType:NoNoticeDataType];
    }
    else
    {
        [self.noDataView hide];
    }
    return self.dataLogicModule.currentDataModelArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 83;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NoticeCell *cell = [self dequeueReusableCellWithIdentifier:NoticeCellID forIndexPath:indexPath];
    if (self.posterType == PoserOperater_Send) {
        cell.opNotices = self.dataLogicModule.currentDataModelArr[indexPath.row];
    }else if(self.posterType == PosterPlat_Send){
        cell.articleBO = self.dataLogicModule.currentDataModelArr[indexPath.row];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MerchantPosterDetailVC *poserDetailVC = [[MerchantPosterDetailVC alloc] init];
    NSNumber *posterID;
    if (self.posterType == PoserOperater_Send) {
        OpNotices *model = self.dataLogicModule.currentDataModelArr[indexPath.row];
        posterID = model.apiId;
        poserDetailVC.postDetailType = PoserOperater_Send;
    }else if(self.posterType == PosterPlat_Send){
        ArticleBO *model = self.dataLogicModule.currentDataModelArr[indexPath.row];
        posterID = model.apiId;
        poserDetailVC.postDetailType = PosterPlat_Send;
    }
    poserDetailVC.posterID = posterID;
    poserDetailVC.title = @"公告详情";
    [self.firstResponseController.navigationController pushViewController:poserDetailVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}




@end
