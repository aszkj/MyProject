//
//  JGCheckConsumeController.m
//  Merchants_JingGang
//
//  Created by dengxf on 15/12/28.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "JGCheckConsumeController.h"
#import "JGCheckConsumeCell.h"
#import "VApiManager.h"
#import "UIImageView+WebCache.h"
#import "XKJHOrderCouponDetailsViewController.h"
@interface JGCheckConsumeController ()<UIAlertViewDelegate>

//@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) NSArray *dataArray;

@property (strong,nonatomic) VApiManager *netManager;

@property (strong,nonatomic) NSMutableArray *paramsArray;

@property (strong,nonatomic) NSMutableArray *identifierArray;

@property (strong,nonatomic) UIScrollView *scrollView;

@property (strong,nonatomic) NSDictionary *dataDict;

@property (strong,nonatomic) UIView *orderDeailView;

@property (copy , nonatomic) NSString *orderId;

@property (strong,nonatomic) UIButton *sureBtn;
@end

@implementation JGCheckConsumeController

- (VApiManager *)netManager {
    if (!_netManager) {
        _netManager = [[VApiManager alloc] init];
    }
    return _netManager;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}


- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)identifierArray {
    if (!_identifierArray) {
        _identifierArray = [NSMutableArray array];
    }
    return _identifierArray;
}

- (NSMutableArray *)paramsArray {
    if (!_paramsArray) {
        _paramsArray = [NSMutableArray array];
    }
    return _paramsArray;
}


- (instancetype)initWithCodeParams:(NSDictionary *)codeParams orderId:(NSString *)orderId {
    if (self = [super init]) {
        self.dataArray = codeParams[@"serviceList"];
        self.dataDict = codeParams;
        self.orderId = orderId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configContent];
}

- (void)configContent {
    self.view.backgroundColor = JGColor(235, 235, 235, 1);
    self.title = @"核销订单";
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    UILabel *textLab = [[UILabel alloc] initWithFrame:CGRectMake(15, headerView.height - 21, kScreenWidth, 21)];
    textLab.backgroundColor = [UIColor clearColor];
    textLab.text = @"选择会员的消费码(可多选)";
    textLab.font = [UIFont systemFontOfSize:12];
    textLab.textAlignment = NSTextAlignmentLeft;
    textLab.textColor = [[UIColor lightGrayColor] colorWithAlphaComponent:1.0];
    [headerView addSubview:textLab];
    [self.view addSubview:headerView];
    
    self.scrollView.x = 0;
    self.scrollView.y = CGRectGetMaxY(headerView.frame);
    self.scrollView.width = kScreenWidth;
    
    
    if (self.dataArray.count > 5) {
        self.scrollView.height = 240;
    }else {
        self.scrollView.height = self.dataArray.count * 44 + 6;
    }
    self.scrollView.backgroundColor = [UIColor whiteColor];
    CGFloat btnHeight = 44;
    self.scrollView.contentSize = CGSizeMake(kScreenWidth, btnHeight * self.dataArray.count);
    for (int i = 0; i < self.dataArray.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.x = 0;
        btn.backgroundColor = [UIColor whiteColor];
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, -120, 0, 0);
        btn.titleLabel.textAlignment = NSTextAlignmentLeft;
        btn.y = btnHeight * i;
        btn.width = kScreenWidth;
        btn.height = 43;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:status_color forState:UIControlStateSelected];
        NSDictionary *detailDic = self.dataArray[i];
        [btn setTitle:[NSString stringWithFormat:@"%@",detailDic[@"groupSn"]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 108890 + i;
        btn.layer.borderColor = [UIColor clearColor].CGColor;
        [self.scrollView addSubview:btn];
        
        [btn setImage:[UIImage imageNamed:@"checkbox_sect"] forState:UIControlStateSelected];
        [btn setImage:[UIImage imageNamed:@"checkbox_normal"] forState:UIControlStateNormal];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -170, 0, 0)];
        
        UILabel *lineView = [[UILabel alloc] init];
        lineView.x = 16;
        lineView.y = CGRectGetMaxY(btn.frame);
        lineView.width = kScreenWidth - lineView.x;
        lineView.height = 1;
        lineView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
        [self.scrollView addSubview:lineView];
    }

    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"确定消费" forState:UIControlStateNormal];
    sureBtn.x = 10;
    sureBtn.y = CGRectGetMaxY(self.scrollView.frame) + 15;
    sureBtn.width = kScreenWidth - sureBtn.x * 2;
    sureBtn.height = 40;
    sureBtn.backgroundColor = status_color;
    [sureBtn setTintColor:[UIColor whiteColor]];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
    sureBtn.alpha = 0.6;
    sureBtn.enabled = NO;
    self.sureBtn = sureBtn;
    
    UIView *orderDeailView = [[UIView alloc] init];
    orderDeailView.x = - 10;
    orderDeailView.y = CGRectGetMaxY(sureBtn.frame)  + 16;
    orderDeailView.width = kScreenWidth + 20;
    orderDeailView.height = 80;
    orderDeailView.backgroundColor = [UIColor whiteColor];
    orderDeailView.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3].CGColor;
    [self.view addSubview:orderDeailView];
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.x = 26;
    iconImageView.height = 44;
    iconImageView.width = iconImageView.height;
    iconImageView.y = (orderDeailView.height - iconImageView.height) / 2 ;
    [iconImageView setBackgroundColor:[UIColor lightGrayColor]];
    [orderDeailView addSubview:iconImageView];
    if (self.dataArray.count) {
        NSDictionary *dic = self.dataArray[0];
        [iconImageView sd_setImageWithURL:[NSURL URLWithString:dic[@"groupAccPath"]]];
    }
    
    UILabel *iconLab = [[UILabel alloc] init];
    iconLab.x = CGRectGetMaxX(iconImageView.frame) + 4;
    iconLab.y = iconImageView.y + 2;
    iconLab.width = 100;
    iconLab.height = 21;
    iconLab.backgroundColor = [UIColor clearColor];
    iconLab.text = [NSString stringWithFormat:@"%@    %ld份",self.dataDict[@"storeName"],self.dataArray.count];
    [orderDeailView addSubview:iconLab];
    iconLab.font = [UIFont systemFontOfSize:14];
    iconLab.textAlignment = NSTextAlignmentLeft;
    
    UILabel *priceLab = [[UILabel alloc] init];
    priceLab.x = iconLab.x;
    priceLab.y = CGRectGetMaxY(iconLab.frame) + 4;
    priceLab.width = 100;
    priceLab.height = 21;
    NSString *price = [NSString stringWithFormat:@"%@",self.dataDict[@"totalPrice"]];
    priceLab.text = [NSString stringWithFormat:@"￥%.2f",[price floatValue]];
    [priceLab setTextColor:status_color];
    priceLab.font = [UIFont systemFontOfSize:14];
    [orderDeailView addSubview:priceLab];
    
    UIImageView *detailImage = [[UIImageView alloc] init];
    detailImage.x = orderDeailView.width - 45;
    UIImage *img = [UIImage imageNamed:@"Haircut"]; //13 25
    detailImage.y = (orderDeailView.height - 13) / 2;
    detailImage.width = 13.0 / 2;
    detailImage.height = 13;
    detailImage.image = img;
    [orderDeailView addSubview:detailImage];
    
    self.orderDeailView = orderDeailView;
    JGLog(@"%f",CGRectGetMaxY(orderDeailView.frame));
}

- (void)btnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    
    NSInteger index = btn.tag - 108890;
    NSDictionary *paramDic= self.dataArray[index];
    if (btn.selected) {
        if ([self.paramsArray containsObject:paramDic[@"groupSn"]]) {

        }else {
            [self.paramsArray addObject:paramDic[@"groupSn"]];
            self.sureBtn.alpha = 1;
            self.sureBtn.enabled = YES;
        }

    }else {
        if ([self.paramsArray containsObject:paramDic[@"groupSn"]]) {
            [self.paramsArray removeObject:paramDic[@"groupSn"]];
            if (self.paramsArray.count) {
                
            }else{
                self.sureBtn.alpha = 0.6;
                self.sureBtn.enabled = NO;
            }
        }else {
            
        }
    }
    
    JGLog(@"%@",self.paramsArray);
}

- (void)sureBtnClick:(UIButton *)btn {
    
    NSString *paramsString = [self.paramsArray componentsJoinedByString:@","];
    
    GroupConsumerSureMultiRequest *request = [[GroupConsumerSureMultiRequest alloc] init:GetToken];

    JGLog(@"params:%@",paramsString);
    request.api_multiGroupSn = paramsString;
    
    [self.netManager groupConsumerSureMulti:request success:^(AFHTTPRequestOperation *operation, GroupConsumerSureMultiResponse *response) {

        JGLog(@"res:%@",response);
        
        if (response.subMsg.length) {
            UIAlertView *sucAlertView = [[UIAlertView alloc] initWithTitle:response.subMsg message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [sucAlertView show];
        }else {
            UIAlertView *sucAlertView = [[UIAlertView alloc] initWithTitle:@"消券异常" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [sucAlertView show];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *sucAlertView = [[UIAlertView alloc] initWithTitle:@"网络异常" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [sucAlertView show];
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    UIView *touchView = touch.view;
    if (touchView == self.orderDeailView) {
        XKJHOrderCouponDetailsViewController *orderDetailVC = [[XKJHOrderCouponDetailsViewController alloc] init];
        NSNumber *orderId = [NSNumber numberWithInteger:[self.orderId integerValue]];
        orderDetailVC.api_orderId = orderId;
        [self.navigationController pushViewController:orderDetailVC animated:YES];
    }
}

#pragma mark --- TableViewDelegate ----

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.dataArray.count;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 40;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
//    UILabel *textLab = [[UILabel alloc] initWithFrame:CGRectMake((headerView.height - 21)/2, 0, kScreenWidth, 40)];
//    textLab.backgroundColor = [UIColor clearColor];
//    textLab.text = @"选择会员的消费码(可多选)";
//    textLab.font = [UIFont systemFontOfSize:12];
//    textLab.textAlignment = NSTextAlignmentLeft;
//    textLab.textColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.7];
//    [headerView addSubview:textLab];
//    return  headerView;
//}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *CellId = @"JGCheckConsumeCell";
//    JGCheckConsumeCell *cell   = [tableView dequeueReusableCellWithIdentifier:CellId];
//    if (!cell) {
//        cell = [[JGCheckConsumeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
//    
//    NSDictionary *paramDic = self.dataArray[indexPath.row];
//    [cell.selectedButton setTitle:paramDic[@"groupSn"] forState:UIControlStateNormal];
//    WEAK_SELF;
//    
//    __weak typeof(JGCheckConsumeCell *) wCell = cell;
//    cell.isSelected = [self.identifierArray[indexPath.row] intValue];
//
//    cell.selectedIndexPathBlock = ^(BOOL isSelected){
//        if (isSelected) {
//            if ([weak_self.paramsArray containsObject:paramDic[@"groupSn"]]) {
//                
//            }else {
//                [weak_self.paramsArray addObject:paramDic[@"groupSn"]];
//                [weak_self.identifierArray replaceObjectAtIndex:indexPath.row withObject:@"1"];
//                wCell.isSelected = [weak_self.identifierArray[indexPath.row] intValue];
//            }
//            
//        }else {
//            if ([weak_self.paramsArray containsObject:paramDic[@"groupSn"]]) {
//                [weak_self.paramsArray removeObject:paramDic[@"groupSn"]];
//                [weak_self.identifierArray replaceObjectAtIndex:indexPath.row withObject:@"0"];
//                wCell.isSelected = [weak_self.identifierArray[indexPath.row] intValue];
//            }else {
//                
//            }
//        }
//
//        JGLog(@"\nparam:%@",weak_self.paramsArray);
//    };
//    
//    JGLog(@"identifierArray:%@",self.identifierArray);
//    return cell;
//}
@end
