//
//  DLSelectCouponView.m
//  YilidiBuyer
//
//  Created by mm on 16/11/21.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLSelectCouponView.h"
#import "MycommonTableView.h"
#import "DLCouponModel.h"
#import "DLSelectCouponCell.h"

const CGFloat ticketAllViewHeight = 388.0f;

@interface DLSelectCouponView()

@property (weak, nonatomic) IBOutlet MycommonTableView *selectCouponTableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *donotUseTicketViewBottomConstraint;
@property (nonatomic,assign) SelectTicketType selectTicketType;

@property (nonatomic,copy) NSArray *couponList;

@property (nonatomic,copy) NSArray *pledgeTicketsList;
@property (weak, nonatomic) IBOutlet UIButton *notUseTicketButton;
@property (weak, nonatomic) IBOutlet UILabel *donotUseTicketTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectTicketTypeLabel;
@property (nonatomic,assign) BOOL userMadeChoice;

@end

@implementation DLSelectCouponView


#pragma mark ---------------------Init Method------------------------------
- (void)awakeFromNib {
    [super awakeFromNib];
    self.donotUseTicketViewBottomConstraint.constant = -ticketAllViewHeight;
    [self layoutIfNeeded];
    [self _initSelectCouponTableView];
}

- (void)_initSelectCouponTableView {
    
    WEAK_SELF
    self.selectCouponTableView.cellHeight = kSelectCouponCellHeight;
    [self.selectCouponTableView configurecellNibName:@"DLSelectCouponCell" configurecellData:^(UITableView *tableView, id cellModel, UITableViewCell *cell) {
        DLSelectCouponCell *selectCouponCell = (DLSelectCouponCell *)cell;
        DLCouponModel *couponModel = (DLCouponModel *)cellModel;
        WEAK_OBJ(couponModel)
        [selectCouponCell setCellModel:couponModel];
        [selectCouponCell setCellTicketType:weak_self.selectTicketType];
        selectCouponCell.selectCouponBlock = ^(UIButton *couponSelectButton){
            [weak_self selectCouponForCouponModel:weak_couponModel selected:couponSelectButton.selected];
        };
    }];
    self.selectCouponTableView.firstSectionHeaderHeight = 39.0f;
    [self.selectCouponTableView configureFirstSectioHeaderNibName:@"DLSelectTicketHeaderView" ConfigureTablefirstSectionHeaderBlock:^(UITableView *tableView, id cellModel, UIView *firstSectionHeaderView) {
        
    }];
}

#pragma mark ---------------------View Event Method------------------------------
- (IBAction)closeAction:(id)sender {
    [self _closeSelectCouponConfigure];
}

- (IBAction)donotUseTicketAction:(id)sender {
    [self _markUserMadeChoice];
    UIButton *donotUseTicketButton = (UIButton *)sender;
    donotUseTicketButton.selected = !donotUseTicketButton.selected;
    if (donotUseTicketButton.selected) {//不使用券
        [self _selectAllSelectedTicket:NO];
        [self.selectCouponTableView reloadData];
    }
}

#pragma mark ---------------------Public Method------------------------------
- (void)showAvaliableTicketsWithTicketType:(SelectTicketType)selectTicketType {
    self.selectTicketType = selectTicketType;
    [self _selfShowConfigure];
}

#pragma mark ---------------------Private Method------------------------------
- (void)_selfShowConfigure {
    self.hidden = NO;
    if (self.needResetOtherTypeSelectTicket) {
        [self _cancelOtherTicketsSelected];
    }
    [self _showTicketsList];
    [self _configureOtherUI];
    [self _showAnimation];
}

- (void)_markUserMadeChoice {
    if (self.userMadeChoice) {
        return;
    }
    self.userMadeChoice = YES;
}

- (void)_configureOtherUI {
    NSString *ticketTypeStr = nil;
    NSString *notUseTicketButtonSelectedImgName = nil;
    if (self.selectTicketType == CouponTicket) {
        ticketTypeStr = @"优惠券";
        notUseTicketButtonSelectedImgName = @"couponSelectedRed";
    }else if (self.selectTicketType == PledgeTicket){
        ticketTypeStr = @"抵用券";
        notUseTicketButtonSelectedImgName = @"couponSelectedBlue";
    }
    self.donotUseTicketTypeLabel.text = jFormat(@"不使用%@",ticketTypeStr);
    self.selectTicketTypeLabel.text = jFormat(@"选择%@",ticketTypeStr);
    self.notUseTicketButton.selected = !self.willShowTicketUseTicket;
    [self.notUseTicketButton setBackgroundImage:IMAGE(notUseTicketButtonSelectedImgName) forState:UIControlStateSelected];
 
}

- (void)_cancelOtherTicketsSelected {
    NSArray *ticketArr = nil;
    if (self.selectTicketType == CouponTicket) {
        ticketArr =  self.pledgeTicketsList;
    }else if (self.selectTicketType == PledgeTicket) {
         ticketArr =  self.couponList;
    }
    for (DLCouponModel *ticketModel in ticketArr) {
        if (ticketModel.wouldUse && ticketModel.selected) {
            ticketModel.selected = NO;
        }
    }
}

- (void)_showTicketsList {
    if (self.selectTicketType == CouponTicket) {
        [self _showCoupList];
    }else if (self.selectTicketType == PledgeTicket){
        [self _showPledgeList];
    }
}

- (void)_showCoupList {
    self.selectCouponTableView.dataLogicModule.currentDataModelArr = [self.couponList mutableCopy];
    [self.selectCouponTableView reloadData];
}

- (void)_showPledgeList {

    self.selectCouponTableView.dataLogicModule.currentDataModelArr = [self.pledgeTicketsList mutableCopy];
    [self.selectCouponTableView reloadData];

}

- (void)selectCouponForCouponModel:(DLCouponModel *)selectCouponModel selected:(BOOL)selected {
    [self _markUserMadeChoice];
    if (selected) {
        if (self.isTicketSingleSelection) {
            [self _selectAllSelectedTicket:NO];
            [self.selectCouponTableView reloadData];
        }else {
            
        }
        if (self.notUseTicketButton.selected) {
            self.notUseTicketButton.selected = NO;
        }
    }
    selectCouponModel.selected = selected;
}

- (void)_selectAllSelectedTicket:(BOOL)select {
    for (DLCouponModel *model in self.selectCouponTableView.dataLogicModule.currentDataModelArr) {
            model.selected = select;
        }
}

- (void)_closeSelectCouponConfigure {
    [self _reasignCouponListToOriginalCouplist];
    emptyBlock(self.closeSelectCouponBlock,[self _getAvaliableSelectedCoupons],!self.notUseTicketButton.selected);
    emptyBlock(self.userMadeChoiceBlock,self.userMadeChoice);
    [self _closeSelfUI];
}

- (void)_closeSelfUI {
    [self _closeAnimation];
    [self performSelector:@selector(hidenSelf) withObject:nil afterDelay:0.35];
}

- (void)hidenSelf {
    self.hidden = YES;
}

- (void)_showAnimation {
    [self _animateWithConst:0];
}

- (void)_closeAnimation {
    [self _animateWithConst:-ticketAllViewHeight];
}

- (void)_animateWithConst:(CGFloat)animateConst {
    [UIView animateWithDuration:0.3 animations:^{
        self.donotUseTicketViewBottomConstraint.constant = animateConst;
        [self layoutIfNeeded];
    }];
}

- (void)_reasignCouponListToOriginalCouplist {
    NSArray *nowTableCouponList = [self.selectCouponTableView.dataLogicModule.currentDataModelArr copy];
    if (self.selectTicketType == CouponTicket) {
        _couponList = nowTableCouponList;
    }else if (self.selectTicketType == PledgeTicket){
        _pledgeTicketsList = nowTableCouponList;
    }

}

- (NSArray *)_getAvaliableSelectedCoupons {
    NSMutableArray *avaliableSelectedCoupons = [NSMutableArray arrayWithCapacity:0];
    for (DLCouponModel *couponModel in self.selectCouponTableView.dataLogicModule.currentDataModelArr) {
        if (couponModel.wouldUse && couponModel.selected) {
            [avaliableSelectedCoupons addObject:couponModel];
        }
    }
    return [avaliableSelectedCoupons copy];
}


- (NSArray *)_sortCouponsAndAddLastCouponModelWithOriginalCoupons:(NSArray *)originalCoupons{
    
    NSMutableArray *newCouponArrs = [NSMutableArray arrayWithArray:0];

    //排序，可选的在前面，不可选的在后面
    NSMutableArray *avaliableCoupons = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *unavaliableCoupons = [NSMutableArray arrayWithCapacity:0];
    
    for (DLCouponModel *couponModel in originalCoupons) {
        if (couponModel.wouldUse) {
            [avaliableCoupons addObject:couponModel];
        }else {
            [unavaliableCoupons addObject:couponModel];
        }
    }
    
    [newCouponArrs addObjectsFromArray:avaliableCoupons];
    [newCouponArrs addObjectsFromArray:unavaliableCoupons];
    
    return [newCouponArrs copy];
}


#pragma mark ---------------------Setter/Getter Method------------------------------
- (void)setCoupons:(NSArray *)coupons {
    if (self.couponList) {
        return;
    }
    self.couponList = [self _sortCouponsAndAddLastCouponModelWithOriginalCoupons:coupons];
}

- (void)setPledgeTickets:(NSArray *)pledgeTickets {
    if (self.pledgeTicketsList) {
        return;
    }
    self.pledgeTicketsList = [self _sortCouponsAndAddLastCouponModelWithOriginalCoupons:pledgeTickets];
}





@end
