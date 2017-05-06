//
//  DLGrabRedPacketResultPageVC.m
//  YilidiBuyer
//
//  Created by yld on 16/10/19.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLGrabRedPacketResultPageVC.h"
#import "MycommonTableView.h"
#import "DLGrabRedPacketResultCell.h"
#import "RedPacketGameManager.h"
#import "DLCouponModel.h"
#import "UINavigationController+SUIAdditions.h"
#import "DLMyWalletVC.h"

@interface DLGrabRedPacketResultPageVC ()

@property (weak, nonatomic) IBOutlet MycommonTableView *redPacketTicketTableView;
@property (weak, nonatomic) IBOutlet UIImageView *gotRedPacketBgImgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *redPacketQuanBgViewToTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *redPacketTableViewToTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *gotRedPacketImgViewWidthToHeightAspecia;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *redPacketBgImgViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *goonGrabRedPacketButtonToBottomConstraint;
@property (weak, nonatomic) IBOutlet UIButton *goonGrabRedPacketButton;
@property (nonatomic,assign) BOOL hasGotRedPacket;
@property (nonatomic,strong) RedPacketGameManager *redPacketGameManager;

@end

@implementation DLGrabRedPacketResultPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.redPacketGameManager = [[RedPacketGameManager alloc] init];

    [self _initActivityGoodsListTableView];
   
    [self _init];
    
    [self _requestGrabRedPacketGameInfo];
    
}

#pragma mark ------------------------Init---------------------------------
- (void)_init {
    
    self.pageTitle = @"抢红包";
    if (iPhone4) {
        self.redPacketQuanBgViewToTopConstraint.constant = 0;
        self.redPacketTableViewToTopConstraint.constant =  self.redPacketTableViewToTopConstraint.constant - 40;
    }
    self.redPacketBgImgViewHeightConstraint.constant = kScreenWidth * 0.93 / 0.68;
    self.hasGotRedPacket = self.grabedCoupList.count;
    if (!self.hasGotRedPacket) {
        self.gotRedPacketBgImgView.image = IMAGE(@"unGotRedPacketBg1");
        self.redPacketTicketTableView.hidden = YES;

        self.redPacketBgImgViewHeightConstraint.constant = (kScreenWidth * 0.93) / 0.68;
        self.goonGrabRedPacketButtonToBottomConstraint.constant = -70;
        if (iPhone5 || iPhone4) {
            self.goonGrabRedPacketButtonToBottomConstraint.constant = -60;
        }
    }else {
        [self _reloadTableData];
    }
}

- (void)_initActivityGoodsListTableView {
    
    WEAK_SELF
    self.redPacketTicketTableView.cellHeight = DLGrabRedPacketResultCellHeight;
    
    [self.redPacketTicketTableView configurecellNibName:@"DLGrabRedPacketResultCell" configurecellData:^(UITableView *tableView,id cellModel, UITableViewCell *cell) {
        DLGrabRedPacketResultCell *goodsCell = (DLGrabRedPacketResultCell *)cell;
        DLCouponModel *couponModel = (DLCouponModel *)cellModel;
        [goodsCell setCellModel:couponModel];
        
    } clickCell:^(UITableView *tableView,id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
        
    }];
    self.redPacketTicketTableView.dataLogicModule.isRequestByPage = NO;
}

#pragma mark ------------------------Private-------------------------
- (void)_canGoOnGrabRedPacket:(BOOL)canGoOnGrabRedPacket {
    self.goonGrabRedPacketButton.enabled = canGoOnGrabRedPacket;
    if (canGoOnGrabRedPacket) {
        self.goonGrabRedPacketButton.backgroundColor = [UIColor yellowColor];
    }else {
        self.goonGrabRedPacketButton.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
}
- (void)_assignUIWithRedPacketGameInfo:(DLGrabRedPacketGameInfoModel *) grabRedPacketGameInfoModel{
    self.goonGrabRedPacketButton.enabled = grabRedPacketGameInfoModel.residueTimes > 0;
    self.goonGrabRedPacketButton.backgroundColor = grabRedPacketGameInfoModel.residueTimes > 0 ? UIColorFromRGB(0xEBCE3B) : [UIColor groupTableViewBackgroundColor];
}


#pragma mark ------------------------Api----------------------------------
- (void)_reloadTableData {
    self.redPacketTicketTableView.dataLogicModule.currentDataModelArr = [self.grabedCoupList mutableCopy];
    [self.redPacketTicketTableView reloadData];
}

- (void)_requestGrabRedPacketGameInfo {
    WEAK_SELF
    [self.redPacketGameManager requestGrabRedPacketGameInfoResultBlock:^(DLGrabRedPacketGameInfoModel *redPacketGameInfoModel, RequestRedPacketGameInfoResultErrorType requestRedPacketGameInfoResultErrorType) {
        [weak_self _assignUIWithRedPacketGameInfo:redPacketGameInfoModel];
    }];
}

- (void)_requestNowGrabRedPacketGameInfo {
    [self showLoadingHub];
    WEAK_SELF
    [self.redPacketGameManager requestBeginGrabRedPacketGameInfoResultBlock:^(DLGrabRedPacketGameInfoModel *redPacketGameInfoModel, RequestRedPacketGameInfoResultErrorType requestRedPacketGameInfoResultErrorType) {
        [self hideLoadingHub];
        if (requestRedPacketGameInfoResultErrorType == CannotGrapRedPacket) {
            [weak_self _assignUIWithRedPacketGameInfo:redPacketGameInfoModel];
            [Util ShowAlertWithOnlyMessage:@"对不起，您不能再抢红包了"];
        }else if (requestRedPacketGameInfoResultErrorType == NoRedPacketGame){
            emptyBlock(self.goonGrabRedPacketBlock,redPacketGameInfoModel,NO);
            [super goBack];
        }else if (requestRedPacketGameInfoResultErrorType == CanGrapRedPacket) {
            emptyBlock(self.goonGrabRedPacketBlock,redPacketGameInfoModel,YES);
            [super goBack];
        }
    }];
    
}

#pragma mark ------------------------Page Navigate---------------------------
- (void)_enterMyWalletPage {
    DLMyWalletVC *myWalletVC = [[DLMyWalletVC alloc] init];
    myWalletVC.index = 0;
    [self navigatePushViewController:myWalletVC animate:YES];
}

#pragma mark ------------------------View Event---------------------------
- (IBAction)goonGrabRedPacketAction:(id)sender {
    [self _requestNowGrabRedPacketGameInfo];
}

- (IBAction)lookMyRedPacketAction:(id)sender {
    [self _enterMyWalletPage];
}

- (void)goBack {
    emptyBlock(self.backBlock);
    [super goBack];
}

#pragma mark ------------------------Delegate-----------------------------

#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------



@end
