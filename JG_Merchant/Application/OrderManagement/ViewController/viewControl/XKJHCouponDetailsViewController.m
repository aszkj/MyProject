//
//  XKJHCouponDetailsViewController.m
//  Merchants_JingGang
//
//  Created by thinker on 15/9/5.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHCouponDetailsViewController.h"
#import "XKJHCouponDetailsTableViewCell.h"
#import "XKJHConsumeSucceed.h"

typedef enum :NSInteger{
    NonConsumption,//未消费
    Consumption,//已消费
    overdue//已过期
}couponType;

@interface XKJHCouponDetailsViewController ()<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>
{
    
    __weak IBOutlet NSLayoutConstraint *xianHeight;
    VApiManager *_vapiManager;
}
@property (weak, nonatomic  ) IBOutlet UIScrollView       *scrollView;
//消费劵状态
@property (weak, nonatomic  ) IBOutlet UILabel            *couponStatus;
@property (weak, nonatomic  ) IBOutlet UIView             *statusView;
//消费劵金额
@property (weak, nonatomic  ) IBOutlet UILabel            *couponPriceLabel;
//服务介绍
@property (weak, nonatomic  ) IBOutlet UIWebView          *serverWebView;
@property (weak, nonatomic  ) IBOutlet NSLayoutConstraint *serverHeight;
//tableView
@property (weak, nonatomic  ) IBOutlet UITableView        *tableView;
@property (weak, nonatomic  ) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (weak, nonatomic  ) IBOutlet UIView             *certainVIew;
//数据源
@property (strong, nonatomic) NSMutableArray     *dataSource;

@property (nonatomic, strong) XKJHConsumeSucceed *succeedView;

@end

static NSString *couponDetailsCell = @"couponDetailsCell";
static NSInteger rowHeight = 50;

@implementation XKJHCouponDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self requestData];
}
- (void)requestData
{
    //消费劵状态
    switch ([self.groupDoods.status intValue]) {
        case 0:
        {
            [self setStatusType:NonConsumption];
        }
            break;
        case 1:
        {
            [self setStatusType:Consumption];
        }
            break;
        case -1:
        {
            [self setStatusType:overdue];
        }
            break;
        default:
            break;
    }
    //消费劵价格
    self.couponPriceLabel.text = [NSString stringWithFormat:@"￥%@元",kNumberToStr(self.groupDoods.groupPrice)];
    
    [self.dataSource addObject:[NSString stringWithFormat:@"服务名称:%@",self.groupDoods.ggName]];
    [self.dataSource addObject:[NSString stringWithFormat:@"消费者昵称:%@",self.groupDoods.nickName]];
    [self.dataSource addObject:[NSString stringWithFormat:@"有效期:%@-%@",self.groupDoods.beginTime,self.groupDoods.endTime ? self.groupDoods.endTime : @"长期有效"]];
    [self.dataSource addObject:[NSString stringWithFormat:@"消费者手机:%@",self.groupDoods.mobile]];
    [self.tableView reloadData];
    
    //服务介绍
    [self.serverWebView loadHTMLString:self.groupDoods.groupNotice baseURL:nil];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
    self.serverHeight.constant = 80 + fittingSize.height;
    self.scrollView.contentSize = CGSizeMake(1, self.scrollView.contentSize.height + fittingSize.height);
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.tableViewHeight.constant = self.dataSource.count * rowHeight;
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XKJHCouponDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:couponDetailsCell];
    cell.titleLabel.text = self.dataSource[indexPath.row];
    if (indexPath.row == 2)
    {
        cell.titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    else
    {
        cell.titleLabel.adjustsFontSizeToFitWidth = NO;
    }
    self.scrollView.contentSize = CGSizeMake(1, CGRectGetMaxY(self.certainVIew.frame) + 15);
    return cell;
}
#pragma mark - 实例化UI
- (void)initUI
{
    self.couponPriceLabel.adjustsFontSizeToFitWidth = YES;
    _vapiManager = [[VApiManager alloc] init];
    self.serverWebView.delegate = self;
    self.serverWebView.scrollView.scrollEnabled = NO;
    self.dataSource = [NSMutableArray array];
    [Util setNavTitleWithTitle:@"消费劵详情" ofVC:self];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(btnClick) target:self];
    self.view.backgroundColor = VCBackgroundColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XKJHCouponDetailsTableViewCell" bundle:nil] forCellReuseIdentifier:couponDetailsCell];
    self.tableView.rowHeight = rowHeight;
    xianHeight.constant = 0.3;
    
}
//返回上一级界面
- (void) btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 设置消费劵状态
- (void)setStatusType:(couponType)type
{
    switch (type) {
        case NonConsumption:
        {
            self.couponStatus.text = @"未使用";
            self.statusView.backgroundColor = UIColorFromRGB(0XFB5117);
        }
            break;
        case Consumption:
        {
            self.couponStatus.text = @"已消费";
            self.couponStatus.textColor =  UIColorFromRGB(0X999999);
            self.statusView.backgroundColor = UIColorFromRGB(0X999999);
        }
            break;
        case overdue:
        {
            self.couponStatus.text = @"已过期";
            self.couponStatus.textColor =  UIColorFromRGB(0X999999);
            self.statusView.backgroundColor = UIColorFromRGB(0X999999);
        }
            
        default:
            break;
    }
}

#pragma mark - 确认事件
- (IBAction)certainAction:(UIButton *)sender
{
    switch ([self.groupDoods.status intValue]) {
        case 0:
        {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.labelText = @"正在消费中...";
            [hud show:YES];
            
            GroupConsumerSureRequest *consumerRequest = [[GroupConsumerSureRequest alloc ]init:GetToken];
            consumerRequest.api_groupSn = self.groupDoods.groupSn;
            [_vapiManager groupConsumerSure:consumerRequest success:^(AFHTTPRequestOperation *operation, GroupConsumerSureResponse *response) {
                NSLog(@"cheshi ---- %@",response);
                if (response.subCode.length > 0)
                {
                    [Util ShowAlertWithOnlyMessage:@"消费失败"];
                }
                else
                {
                    [self succeedPrompt];
                }
                [MBProgressHUD hideHUDForView:self.view animated: YES];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [Util ShowAlertWithOnlyMessage:@"网络异常..."];
                [MBProgressHUD hideHUDForView:self.view.window  animated:YES];
            }];
        }
            break;
        case 1:
        {
            [Util ShowAlertWithOnlyMessage:@"该消费劵已消费，消费失败"];
        }
            break;
        case -1:
        {
            [Util ShowAlertWithOnlyMessage:@"该消费劵已过期，消费失败"];
        }
            break;
        default:
            break;
    }
}
#pragma mark - 消费券成功提示
- (void)succeedPrompt
{
    self.succeedView.hidden = NO;
    WEAK_SELF
    self.succeedView.succeedBlock = ^(){
        [weak_self setStatusType:Consumption];
        [weak_self.navigationController popViewControllerAnimated:YES];
    };
}
-(XKJHConsumeSucceed *)succeedView
{
    if (_succeedView == nil)
    {
        _succeedView = [[NSBundle mainBundle] loadNibNamed:@"XKJHConsumeSucceed" owner:nil options:nil][0];
        [_succeedView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenWidth, kScreenHeight));
        }];
        [self.view.window addSubview:_succeedView];
    }
    return _succeedView;
}

@end
