//
//  KJOrderDetailGoodsTableView.m
//  jingGang
//
//  Created by 张康健 on 15/8/12.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "KJOrderDetailGoodsTableView.h"
#import "KJOrderDetailGoodsCell.h"
#import "OrderDetailPayWayCell.h"
#import "GlobeObject.h"
#import "GoodsInfoModel.h"
#import "OderDetailModel.h"
#import "UIButton+Block.h"
#import "UIView+firstResponseController.h"
#import "QueryLogisticsViewController.h"
#import "UIView+BlockGesture.h"


@implementation KJOrderDetailGoodsTableView

static NSString *KJOrderDetailGoodsCellID = @"KJOrderDetailGoodsCellID";
static NSString *OrderDetailPayWayCellID = @"OrderDetailPayWayCellID";

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
        [self registerNib:[UINib nibWithNibName:@"KJOrderDetailGoodsCell" bundle:nil]  forCellReuseIdentifier:KJOrderDetailGoodsCellID];
        [self registerNib:[UINib nibWithNibName:@"OrderDetailPayWayCell" bundle:nil]  forCellReuseIdentifier:OrderDetailPayWayCellID];
        
    }
    
    return self;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    NSInteger orsderStatus = self.orderDetailModel.orderStatus.integerValue;
    NSLog(@"订单状态 数字 %ld",self.orderDetailModel.orderStatus.integerValue);
    if (orsderStatus == 10 || orsderStatus == 0) {
        return self.orderListArr.count;
    }else {//非待付款和取消状态，才有付款方式
        return self.orderListArr.count + 1;
    }
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSDictionary *dic = self.orderListArr[section];
    if (section == self.orderListArr.count) {
        return 1;
    }else{
        OderDetailModel *model = (OderDetailModel *)self.orderListArr[section];
        return model.goodsInfos.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == self.orderListArr.count) {//返回最后一个cell
        OrderDetailPayWayCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderDetailPayWayCellID forIndexPath:indexPath];
        cell.payWayLabel.text = self.payWay;
        return cell;
        
    }else{
        KJOrderDetailGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:KJOrderDetailGoodsCellID forIndexPath:indexPath];
        OderDetailModel *orderDetailModel = self.orderListArr[indexPath.section];
        GoodsInfoModel *goodsInfoModel = orderDetailModel.goodsInfos[indexPath.row];
        cell.goodsInfoModel = goodsInfoModel;
        cell.goodsOrderID = orderDetailModel.OderDetailModelID;
        cell.orderStatusNum = orderDetailModel.orderStatus;
        cell.bgView.userInteractionEnabled = YES;
        [cell.bgView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            if (self.clickOrderDetailBlock) {
                self.clickOrderDetailBlock(indexPath,@(goodsInfoModel.goodsId.integerValue));
            }
        }];
        return cell;
    }     
    
//    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == self.orderListArr.count) {
        
        return 57;
        
    }else{
        
        return 105;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == self.orderListArr.count) {//最后一组,
        return nil;
    }else{
        UIView *headerView = BoundNibView(@"KJOrderDetailGoodsSectionHeaderView", UIView);
        UILabel *storeNamelabel = (UILabel *)[headerView viewWithTag:1];
         OderDetailModel *orderDetailModel = self.orderListArr[section];
        storeNamelabel.text = orderDetailModel.storeName;
        UIImageView *storeNameImgView = (UIImageView *)[headerView viewWithTag:2];
        if (!isEmpty(orderDetailModel.storeId)) {
            storeNameImgView.image = [UIImage imageNamed:@"商家"];
        }else {
            storeNameImgView.image = [UIImage imageNamed:@"自营"];
            
            
        }
        return headerView;
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    if (section == self.orderListArr.count) {//最后一组,
        return nil;
    }else{
        UIView *footerView = BoundNibView(@"KJOrderDetailGoodsFooterView", UIView);
        //状态button
        UIButton *orderStatusButton = (UIButton *)[footerView viewWithTag:1];
        OderDetailModel *orderDetailModel = self.orderListArr[section];
        [orderStatusButton setTitle:orderDetailModel.orderStatusStr forState:UIControlStateNormal];
        //查看物流button
        UIButton *lookDeliveryButton = (UIButton *)[footerView viewWithTag:2];
        WEAK_SELF
        [lookDeliveryButton addActionHandler:^(NSInteger tag) {
            QueryLogisticsViewController *quertVC = [[QueryLogisticsViewController alloc] initWithNibName:@"QueryLogisticsViewController" bundle:nil];
            
            NSLog(@" 快递号 %@, 快递公司id %@",orderDetailModel.shipCode,orderDetailModel.expressCompanyId.stringValue);
            quertVC.expressCode = orderDetailModel.shipCode;
            quertVC.expressCompanyId = orderDetailModel.expressCompanyId;
            [weak_self.firstResponseController.navigationController pushViewController:quertVC animated:YES];
            
        }];
        
        
        
        return footerView;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.section != self.orderListArr.count) {
        OderDetailModel *orderDetailModel = self.orderListArr[indexPath.section];
        GoodsInfoModel *goodsInfoModel = orderDetailModel.goodsInfos[indexPath.row];
        if (self.clickOrderDetailBlock) {
            self.clickOrderDetailBlock(indexPath,@(goodsInfoModel.goodsId.integerValue));
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == self.orderListArr.count) {//最后一组，无组头，组尾
        return 0;
    }else{
        return 55;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == self.orderListArr.count) {//最后一组，无组头，组尾
        return 0;
    }else{
        //判断是否可查看物流
        OderDetailModel *orderDetailModel = self.orderListArr[section];
        CGFloat heght = orderDetailModel.canLookGoodsDelivery ? 91 : 44;
        return heght;
    }
}







@end
