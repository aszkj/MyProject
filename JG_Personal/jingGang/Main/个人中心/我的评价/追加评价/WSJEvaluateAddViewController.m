//
//  WSJEvaluateAddViewController.m
//  jingGang
//
//  Created by thinker on 15/8/19.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "WSJEvaluateAddViewController.h"
#import "UIImageView+WebCache.h"
#import "PublicInfo.h"
#import "GlobeObject.h"
#import "VApiManager.h"
#import "KJShoppingAlertView.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "Masonry.h"

@interface WSJEvaluateAddViewController ()
{
    UIView *_shopView;
    UIView *_evaluateView;
    UIView *_evaluateAddView;
    UIButton *certainBtn;
    VApiManager *_vapiManager;
}
@property (weak, nonatomic  ) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) UILabel      *evaluateContent;
@property (nonatomic, strong) UILabel      *shopkeeperLabel;
@property (nonatomic, strong) UITextField  *addEvaluateText;

@end

@implementation WSJEvaluateAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
}
- (void) initUI
{
    _vapiManager = [[VApiManager alloc] init];
    //商品
    _shopView = [self createShoppView];
    [self.scrollView addSubview:_shopView];
    //之前评论
    _evaluateView = [self createEvaluateViewEvaluate:self.model.evaluateContent withShopkeeper:self.model.shopkeeper];
    CGRect rect = _evaluateView.frame;
    rect.origin.y = CGRectGetMaxY(_shopView.frame) + 10;
    _evaluateView.frame = rect;
    [self.scrollView addSubview:_evaluateView];
    
    //追加评论
    _evaluateAddView = [self createEvaluateAddView];
    rect = _evaluateAddView.frame;
    rect.origin.y = CGRectGetMaxY(_evaluateView.frame) + 10;
    _evaluateAddView.frame = rect;
    [self.scrollView addSubview:_evaluateAddView];
    
    //确定按钮
    certainBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    certainBtn.frame = CGRectMake(10, CGRectGetMaxY(_evaluateAddView.frame) + 10, __MainScreen_Width - 20 , 40 );
    certainBtn.layer.cornerRadius = 5;
    certainBtn.backgroundColor = status_color;
    [certainBtn addTarget:self action:@selector(certainAction) forControlEvents:UIControlEventTouchUpInside];
    [certainBtn setTitle:@"发表评论" forState:UIControlStateNormal];
    [certainBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.scrollView addSubview:certainBtn];
    self.scrollView.contentSize = CGSizeMake(1, CGRectGetMaxY(certainBtn.frame) + 10);

    //返回上一级控制器按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(btnClick) target:self];
//    UIButton *button_na = [[UIButton alloc]initWithFrame:CGRectMake(20, 30, 35, __NavScreen_Height-15)];
//    [button_na setImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
//    [button_na addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:button_na];
//    self.navigationItem.leftBarButtonItem = bar;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyWillShow) name:UIKeyboardWillShowNotification object:nil];

    //设置背景颜色
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
}
- (void) keyWillShow
{
    [UIView animateWithDuration:0.3 animations:^{
        self.scrollView.contentOffset = CGPointMake(0, CGRectGetMinY(certainBtn.frame) - 160);
    } completion:^(BOOL finished) {
        self.scrollView.contentSize = CGSizeMake(1, CGRectGetMaxY(certainBtn.frame) + __MainScreen_Height - 200);
    }];
}
- (IBAction)hiddenKey:(id)sender
{
    [self.addEvaluateText resignFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        self.scrollView.contentSize = CGSizeMake(1, CGRectGetMaxY(certainBtn.frame) + 10);
    }];
}

//返回上一级界面
- (void) btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(__MainScreen_Width/2 - 30, __StatusScreen_Height, 60, 40)];
    l.text = @"追加评论";
    l.font = [UIFont systemFontOfSize:18];
    l.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = l;
}
//创建商品头部，第一层
- (UIView *) createShoppView
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, 100)];
    v.backgroundColor = [UIColor whiteColor];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
    [img sd_setImageWithURL:[NSURL URLWithString:TwiceImgUrlStr(self.model.titleImageURL, img.frame.size.width, img.frame.size.height)]];
    [v addSubview:img];
    
    UILabel *titleName = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, __MainScreen_Width - 110, 60)];
    titleName.text = self.model.titleName;
    titleName.font = [UIFont systemFontOfSize:15];
    titleName.textColor = UIColorFromRGB(0X666666);
    titleName.adjustsFontSizeToFitWidth = YES;
    titleName.numberOfLines = 0;
    [v addSubview:titleName];
    
    UILabel *evaluate = [[UILabel alloc] initWithFrame:CGRectMake(100, CGRectGetMaxY(titleName.frame), 100, 20)];
    evaluate.textColor = UIColorFromRGB(0X59C4F0);
    evaluate.text = @"已经评论";
    evaluate.font = [UIFont systemFontOfSize:14];
    [v addSubview:evaluate];
    
    
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(__MainScreen_Width - 110, CGRectGetMaxY(titleName.frame), 100, 20)];
    NSArray *date = [self.model.date componentsSeparatedByString:@" "];
    dateLabel.text = date[0];
    dateLabel.textAlignment = NSTextAlignmentRight;
    dateLabel.textColor = UIColorFromRGB(0X999999);
    dateLabel.font = [UIFont systemFontOfSize:14];
    [v addSubview:dateLabel];
    
    return v;
}
//创建之前评价，第二层
- (UIView *) createEvaluateViewEvaluate:(NSString *)evaluate withShopkeeper:(NSString *)shopkeeper
{
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor whiteColor];
    
    UIView *v1 = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 10, 20)];
    v1.backgroundColor = status_color;
    [v addSubview:v1];
    UILabel *zhiqian = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
    zhiqian.text = @" 之前评论";
    zhiqian.textColor = UIColorFromRGB(0X666666);
    zhiqian.font = [UIFont systemFontOfSize:15];
    [v addSubview:zhiqian];
    
    CGFloat height = CGRectGetMaxY(zhiqian.frame);
    CGRect rect;
    if (evaluate != nil)
    {
        rect = [evaluate boundingRectWithSize:CGSizeMake(__MainScreen_Width - 20, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
        self.evaluateContent = [[UILabel alloc] initWithFrame:CGRectMake(10, height + 10, __MainScreen_Width - 20, rect.size.height)];
        self.evaluateContent.textColor = UIColorFromRGB(0X666666);
        self.evaluateContent.text = evaluate;
        self.evaluateContent.numberOfLines = 0;
        self.evaluateContent.font = [UIFont systemFontOfSize:15];
        height = CGRectGetMaxY(self.evaluateContent.frame);
        [v addSubview:self.evaluateContent];

    }
    if (shopkeeper != nil)
    {
        rect = [shopkeeper boundingRectWithSize:CGSizeMake(__MainScreen_Width - 20, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
        self.shopkeeperLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, height + 10, __MainScreen_Width - 20, rect.size.height)];
        self.shopkeeperLabel.textColor = UIColorFromRGB(0X666666);
        self.shopkeeperLabel.text = shopkeeper;
        self.shopkeeperLabel.numberOfLines = 0;
        self.shopkeeperLabel.backgroundColor = UIColorFromRGB(0Xf6f6f6);
        self.shopkeeperLabel.font = [UIFont systemFontOfSize:15];
        height = CGRectGetMaxY(self.shopkeeperLabel.frame);
        [v addSubview:self.shopkeeperLabel];
    }
    v.frame = CGRectMake(0, 0, __MainScreen_Width, height + 10);
    return v;
}
//创建追加评论
- (UIView *)createEvaluateAddView
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , __MainScreen_Width, 90)];
    v.backgroundColor = [UIColor whiteColor];
    
    UIView *v1 = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 10, 20)];
    v1.backgroundColor = status_color;
    [v addSubview:v1];
    UILabel *zhuijia = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
    zhuijia.text = @" 追加评论";
    zhuijia.textColor = UIColorFromRGB(0X666666);
    zhuijia.font = [UIFont systemFontOfSize:15];
    [v addSubview:zhuijia];
    
    self.addEvaluateText = [[UITextField alloc] initWithFrame:CGRectMake(10, 40, __MainScreen_Width - 20, 40)];
    self.addEvaluateText.backgroundColor = UIColorFromRGB(0Xf6f6f6);
    self.addEvaluateText.placeholder = @"  宝贝好用么？可以追加评论哟。";
    [v addSubview:self.addEvaluateText];
    return v;
}
#pragma mark - 发表评论
- (void) certainAction
{
    [self hiddenKey:nil];
    WEAK_SELF
    if (self.addEvaluateText.text.length > 0)
    {
        SelfEvaluateAddSaveRequest *evaluateSave = [[SelfEvaluateAddSaveRequest alloc] init:GetToken];
        evaluateSave.api_evalId = self.model.goodsID;
        evaluateSave.api_evaluateInfo = self.addEvaluateText.text;
        [_vapiManager selfEvaluateAddSave:evaluateSave success:^(AFHTTPRequestOperation *operation, SelfEvaluateAddSaveResponse *response) {
            NSLog(@"cheshi ---- %@",response);
            if (response.errorCode.integerValue == 5) {
                KSensitiveWords
            }else  if (response.errorCode.length == 0)
            {
                [weak_self successEvaluateAdd];
            }
            else
            {
                [KJShoppingAlertView showAlertTitle:response.subMsg inContentView:weak_self.view.window];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error ---- %@",error);
            [KJShoppingAlertView showAlertTitle:@"追加评论失败,请检查网络" inContentView:weak_self.view.window];
        }];
    }
    else
    {
        [KJShoppingAlertView showAlertTitle:@"追加评论不能为空" inContentView:self.view.window];
    }
}

- (void) successEvaluateAdd

{
    [KJShoppingAlertView showAlertTitle:@"发表评论成功！" inContentView:self.view.window];
    
    NSString *str = [NSString stringWithFormat:@"[追加评论]：%@",self.addEvaluateText.text];
    CGRect rect = [str boundingRectWithSize:CGSizeMake(__MainScreen_Width - 20, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    UILabel *addEvaluate = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetHeight(_evaluateView.frame)  , __MainScreen_Width - 20, rect.size.height)];
    addEvaluate.textColor = UIColorFromRGB(0X666666);
    addEvaluate.text = str;
    addEvaluate.numberOfLines = 0;
    addEvaluate.font = [UIFont systemFontOfSize:15];
    [_evaluateView addSubview:addEvaluate];
    
    CGRect frame = _evaluateView.frame;
    frame.size.height += rect.size.height + 10;
    _evaluateView.frame = frame;
    
    _evaluateAddView.hidden = YES;
    certainBtn.hidden = YES;
    
}

@end
