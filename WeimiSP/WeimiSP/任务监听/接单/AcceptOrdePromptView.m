//
//  AcceptOrdePromptView.m
//  WeimiSP
//
//  Created by thinker on 16/2/24.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "AcceptOrdePromptView.h"
#import <WEMETaskcontrollerApi.h>
#import <ReactiveCocoa.h>

@interface AcceptOrdePromptView ()<UIScrollViewDelegate,UIAlertViewDelegate>
{
    CGFloat _contentHeight;
}

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIButton *onlineStateBtn;
@property (nonatomic, strong) UIView *contentBackView;

/**
 *  取消订单
 */
@property (nonatomic, strong) UIButton *cancelButton;

@end

@implementation AcceptOrdePromptView

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}



#pragma mark - 实例化UI
- (void)initUI
{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.backView];
    
    [self addSubview:self.onlineStateBtn];
    [_onlineStateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@-20);
        make.centerX.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(AcceptOrderButtonHeight, AcceptOrderButtonHeight));
    }];
    
    [self addSubview:self.contentBackView];
    [_contentBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
        make.top.equalTo(@159);
        make.bottom.equalTo(_onlineStateBtn.mas_top).with.offset(-15);
    }];
    [self addSubview:self.cancelButton];
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_right).with.offset(-25);
        make.centerY.equalTo(_contentBackView.mas_top).with.offset(5);
    }];
    _contentHeight = kScreenHeight - AcceptOrderButtonHeight - 20 - 25 - 159;
    
    [_contentView addSubview:self.orderDetailView];
    [_contentView addSubview:self.orderMapView];
    _contentView.contentSize = CGSizeMake(kScreenWidth - 40 , _contentHeight * 2);
}

#pragma mark - getter

-(UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:self.frame];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0.5;
    }
    return _backView;
}

-(UIButton *)onlineStateBtn
{
    if (!_onlineStateBtn) {
        _onlineStateBtn = [XKO_CreateUIViewHelper createUIButtonWithFrame:CGRectMake(0, 0, 60, 60) title:@"接单" titleColor:[UIColor whiteColor] titleFont:kFontSize16 backgroundColor:UIColorFromRGB(0X59C4F0) hasRadius:YES targetSelector:@selector(acceptOrdeAction:) target:self];
        _onlineStateBtn.layer.cornerRadius = 30;
        _onlineStateBtn.hidden = YES;
    }
    return _onlineStateBtn;
}
-(UIView *)contentBackView
{
    if (!_contentBackView) {
        _contentBackView = [[UIView alloc] init];
        _contentBackView.layer.cornerRadius = 5;
        _contentBackView.clipsToBounds = YES;
        _contentBackView.backgroundColor = [UIColor clearColor];
        
        UIImageView *triangleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AcceptOrde_sanjiao"]];
//        triangleImage.alpha = 0.5;
        [_contentBackView addSubview:triangleImage];
        [triangleImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@0);
            make.bottom.equalTo(@0);
            make.height.equalTo(@10);
        }];
        [_contentBackView addSubview:self.contentView];
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.bottom.equalTo(triangleImage.mas_top).with.offset(0);
        }];
    }
    return _contentBackView;
}
-(UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] init];
        _contentView.layer.cornerRadius = 5;
        _contentView.clipsToBounds = YES;
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.pagingEnabled = YES;
        _contentView.showsVerticalScrollIndicator = NO;
        _contentView.bounces = NO;
        _contentView.delegate = self;
    }
    return _contentView;
}
- (UIButton *)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_cancelButton setBackgroundImage:[UIImage imageNamed:@"AcceptOrde_delete"] forState:UIControlStateNormal];
        
        @weakify(self);
        [[_cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside]
         subscribeNext:^(id x) {
             @strongify(self);
             
             UIAlertView *alerView = [[UIAlertView alloc ]initWithTitle:@"提示" message:@"您是否要拒绝该订单？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拒绝", nil];
             
             [[alerView rac_buttonClickedSignal] subscribeNext:^(NSNumber *indexNumber) {
                 NSInteger index = indexNumber.integerValue;
                 if (index == 0) {  return; }
                 [self rejectTask];
             }];
             
             [alerView show];
         }];

    }
    return _cancelButton;
}

- (AcceptOrderDetailView *)orderDetailView
{
    if (!_orderDetailView) {
        _orderDetailView = [[AcceptOrderDetailView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 40, _contentHeight)];
    }
    return _orderDetailView;
}

-(OrderMapView *)orderMapView
{
    if (!_orderMapView) {
        _orderMapView = [[OrderMapView alloc] initWithFrame:CGRectMake(0, _contentHeight, kScreenWidth - 40, _contentHeight)];
        _orderMapView.scrollView = _contentView;
    }
    return _orderMapView;
}

-(void)setOrderDate:(NSString *)orderDate
{
    _orderDate = orderDate;
    self.orderDetailView.dateLabel.text = orderDate;
}
-(void)setShangmenTitle:(NSString *)title
{
    _shangmenTitle = title;
    self.orderDetailView.shangmen.text = title;
}
-(void)setOrderContent:(NSString *)orderContent
{
    _orderContent = orderContent;
    self.orderDetailView.contentLabel.text = orderContent;
}
-(void)setOrderAddress:(NSString *)orderAddress{
    _orderAddress = orderAddress;
    self.orderMapView.pointAnnotation.title = orderAddress;
}
-(void)setOrderLocation:(CLLocationCoordinate2D)orderLocation{
    _orderLocation = orderLocation;
    self.orderMapView.mapView.centerCoordinate = orderLocation;
    self.orderMapView.pointAnnotation.coordinate = orderLocation;
}


#pragma mark - private methord


#pragma mark - 接收订单
- (void)acceptOrdeAction:(UIButton *)btn
{
    
}
#pragma mark - 取消订单
- (void)cancelOrderAction
{
    UIAlertView *alerView = [[UIAlertView alloc ]initWithTitle:@"提示" message:@"您是否要拒绝该订单？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拒绝", nil];
    [alerView show];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < _contentHeight)
    {
        _orderDetailView.bottomView.hidden = NO;
        _orderMapView.topView.hidden = YES;
    }
    else
    {
        _orderDetailView.bottomView.hidden = YES;
        _orderMapView.topView.hidden = NO;
    }
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    _orderDetailView.bottomView.hidden = NO;
    _orderMapView.topView.hidden = NO;
}


#pragma mark - UIAlertViewDelegate

- (void)rejectTask {
    
    WEAK_SELF
    [[WEMETaskcontrollerApi sharedAPI] rejectUsingGETWithCompletionBlock:^(WEMESimpleResponse *output, NSError *error) {
        if (IsEmpty(error) && output.success.integerValue == YES)
        {
            if (weak_self.cancelOrderBlock) {
                weak_self.cancelOrderBlock();
            }
        }
        else
        {
            [NSError checkErrorFromServer:error response:output];
//            if (IsEmpty(error))
//            {
//                [Util ShowAlertWithOnlyMessage:output.errorDescription];
//            }
//            else
//            {
//                [Util ShowAlertWithOnlyMessage:error.localizedDescription];
//            }
        }
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex)
    {
        WEAK_SELF
        [[WEMETaskcontrollerApi sharedAPI] rejectUsingGETWithCompletionBlock:^(WEMESimpleResponse *output, NSError *error) {
            if (IsEmpty(error) && output.success.integerValue == YES)
            {
                weak_self.hidden = YES;
                if (weak_self.cancelOrderBlock) {
                    weak_self.cancelOrderBlock();
                }
            }
            else
            {
                [NSError checkErrorFromServer:error response:output];
            }
        }];
    }
}




@end
