//
//  DLRedPacketEntrancePageVC.m
//  YilidiBuyer
//
//  Created by yld on 16/10/19.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLRedPacketEntrancePageVC.h"
#import "DLGrabRedPacketGamePageVC.h"
#import "DLGrabRedPacketGameInfoModel.h"
#import "RedPacketGameManager.h"


@interface DLRedPacketEntrancePageVC ()
@property (weak, nonatomic) IBOutlet UILabel *stillCanStratchRedPacketCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *grabedRedPacketCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *nowGrabRedPacketButton;
@property (weak, nonatomic) IBOutlet UILabel *stillCanGrabRedPacketCountLabel;
@property (weak, nonatomic) IBOutlet UITextView *grabRedPacketGameRuleTextView;

@property (nonatomic,strong) DLGrabRedPacketGameInfoModel *grabRedPacketGameInfoModel;
@property (weak, nonatomic) IBOutlet UIImageView *hasNoRedPacketGameBgBiew;

@property (nonatomic,strong) RedPacketGameManager *redPacketGameManager;



@end

@implementation DLRedPacketEntrancePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageTitle = @"抢红包";
    self.redPacketGameManager = [[RedPacketGameManager alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self _requestGrabRedPacketGameInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark ---------------------Private Method------------------------------
- (void)_assignUIWithRedPacketGameInfo:(DLGrabRedPacketGameInfoModel *) grabRedPacketGameInfoModel{
    self.grabedRedPacketCountLabel.text = jFormat(@"已抢红包：%ld",grabRedPacketGameInfoModel.receivedRedEnvelopCount);
    self.nowGrabRedPacketButton.enabled = grabRedPacketGameInfoModel.residueTimes > 0;
    self.stillCanGrabRedPacketCountLabel.text = jFormat(@"%ld",grabRedPacketGameInfoModel.residueTimes);
    self.grabRedPacketGameRuleTextView.text = grabRedPacketGameInfoModel.activityRule;
    self.hasNoRedPacketGameBgBiew.hidden = !isEmpty(grabRedPacketGameInfoModel.activityId);
    
}

#pragma mark ---------------------PageNavigate Method------------------------------
- (void)_enterGrapRedPacketPageWithRedPacketGameInfo:(DLGrabRedPacketGameInfoModel *)grabRedPacketGameInfoModel hasRedPacketGame:(BOOL)hasRedPacketGame{
    DLGrabRedPacketGamePageVC *grabRedPacketResultPageVC = [[DLGrabRedPacketGamePageVC alloc] init];
    grabRedPacketResultPageVC.grabRedPacketGameInfoModel = grabRedPacketGameInfoModel;
    grabRedPacketResultPageVC.hasRedPacketGame = hasRedPacketGame;
    [self navigatePushViewController:grabRedPacketResultPageVC animate:YES];
}

#pragma mark ---------------------Api Method------------------------------
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
            [weak_self _enterGrapRedPacketPageWithRedPacketGameInfo:redPacketGameInfoModel hasRedPacketGame:NO];
        }else if (requestRedPacketGameInfoResultErrorType == CanGrapRedPacket) {
            [weak_self _enterGrapRedPacketPageWithRedPacketGameInfo:redPacketGameInfoModel hasRedPacketGame:YES];
        }
    }];
}



//- (void)_requestGrabRedPacket {
//    [AFNHttpRequestOPManager postWithParameters:nil subUrl:kUrl_GetGrabRedPacket block:^(NSDictionary *resultDic, NSError *error) {
//    
//    }];
//}


- (IBAction)grabRedPacketNow:(id)sender {
    [self _requestNowGrabRedPacketGameInfo];
}

@end
