//
//  colourBlindnessViewController.m
//  jingGang
//
//  Created by thinker on 15/7/21.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "colourBlindnessView.h"
#import "PublicInfo.h"
#import "blindnessResultViewController.h"
#import "examineResultViewController.h"

#import "IZValueSelectorView.h"

#define K_Heigth (__MainScreen_Height - 108)

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface colourBlindnessView ()<IZValueSelectorViewDataSource,IZValueSelectorViewDelegate>
{
    UIImageView *_titleImageView;  //色盲图片
    
    IZValueSelectorView *_leftSelectorView;  //左边滚筒
    IZValueSelectorView *_rightSelectorView;//右边滚筒
    NSInteger _leftInt;  //保存左边十位数的数
    NSInteger _rightInt;  //保存右边个位数的数
    
    NSInteger _random; //随机数
    
    
    UIView *_progressView; //进度条
    NSMutableArray *_progressImageViewArray;  //保存5个状态图片
    NSInteger _progressInt;//进度个数
    NSInteger _result; //您输入最终数字
    
    
    NSInteger _fitCount; //答对的个数
}

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation colourBlindnessView

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    [self initUI];
//}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _leftInt = 0;
        _rightInt = 0;
        _progressImageViewArray = [NSMutableArray array];
        self.dataSource = @[@"2",@"5",@"6",@"7",@"8",@"10",@"12",@"15",@"16",@"18",@"29",@"42",@"57",@"74",@"96"];
        //实例化UI布局
        [self initUI];
    }
    return self;
}
#pragma mark - 随机获取一张图片
- (void) randomWithImageView
{
    NSInteger idx;
    while (1)
    {
        idx = arc4random() % self.dataSource.count;
        if (idx != _random)
        {
            _random = idx;
            break;
        }
    }
    _titleImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"daltonismo%@",self.dataSource[_random]]];
    NSLog(@"cheshi ---- %d  =++  %d",_random,[self.dataSource[_random] integerValue]);
    if ([self.dataSource[_random] integerValue] < 10 )
    {
        _rightSelectorView.center = CGPointMake(__MainScreen_Width / 2, _rightSelectorView.frame.size.height / 2);
        _leftSelectorView.hidden = YES;
        _leftInt = 0;
    }
    else
    {
        _leftSelectorView.hidden = NO;
        _rightSelectorView.center = CGPointMake(__MainScreen_Width / 3 * 2, _rightSelectorView.frame.size.height / 2);
        _leftSelectorView.center = CGPointMake(__MainScreen_Width / 3, _leftSelectorView.frame.size.height / 2);
    }
    [_leftSelectorView reloadData];
    [_rightSelectorView reloadData];
}


#pragma mark - ---UI 的创建
- (void) initUI
{
//第一层
    _titleImageView = [[UIImageView alloc] init];
    _titleImageView.center = CGPointMake(__MainScreen_Width / 2, K_Heigth / 4 - 10);
    _titleImageView.bounds = CGRectMake(0, 0, K_Heigth / 2 -40, K_Heigth / 2 - 40);
    [self addSubview:_titleImageView];
    
    UILabel *tishi = [[UILabel alloc] init];
    tishi.textColor = [UIColor blackColor];
    tishi.text = @"请填写图片的数字";
    tishi.font = [UIFont systemFontOfSize:14];
    tishi.textAlignment = NSTextAlignmentCenter;
    tishi.center = CGPointMake(__MainScreen_Width / 2, K_Heigth / 2 - 20);
    tishi.bounds = CGRectMake(0, 0, 200, 20);
    [self addSubview:tishi];
    
    
//第二层 进度条
    UIView *progressView = [[UIView alloc] initWithFrame:CGRectMake(0, K_Heigth / 2, __MainScreen_Width, 20)];
    progressView.backgroundColor = [UIColor colorWithRed:218.0 / 255 green:218.0/255 blue:218.0 / 255 alpha:1];
    [self addSubview:progressView];
    
    _progressView = [[UIView alloc] init];
    _progressView.center = CGPointMake(__MainScreen_Width / 2, progressView.frame.size.height / 2);
    _progressView.bounds = CGRectMake(0, 0, __MainScreen_Width - 40, 4);
    _progressView.backgroundColor = [UIColor lightGrayColor];
    [progressView addSubview:_progressView];
    
    for ( NSInteger i = 0 ; i < 5;  i++)
    {
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"button"]];
        img.bounds = CGRectMake(0, 0, 8, 8);
        img.center = CGPointMake(20 + _progressView.frame.size.width / 4 * i, progressView.frame.size.height / 2);
        [progressView addSubview:img];
        [_progressImageViewArray addObject:img];
    }
    
    
//第三层  滚筒
    UIView *picker = [[UIView alloc] init];
    picker.backgroundColor = [UIColor whiteColor];
    picker.frame = CGRectMake(0, K_Heigth / 2 + 20, __MainScreen_Width, K_Heigth / 4 + 20);
    [self addSubview:picker];
    
    UIView *centerView = [[UIView alloc] init];
    centerView.center = CGPointMake(__MainScreen_Width / 2, picker.frame.size.height / 2 + 2);
    centerView.backgroundColor = [UIColor colorWithRed:4.0 / 255 green:145.0 / 255 blue:203.0 / 255 alpha:1];
    centerView.bounds = CGRectMake(0, 0, 200, 30);
    centerView.layer.cornerRadius = 15;
    [picker addSubview:centerView];
    
    
    
    _leftSelectorView = [[IZValueSelectorView alloc] initWithFrame:CGRectMake(0, 0, 80, picker.frame.size.height)];
    _leftSelectorView.center = CGPointMake(__MainScreen_Width / 3, picker.frame.size.height / 2);
    _leftSelectorView.delegate = self;
    _leftSelectorView.dataSource = self;
    [picker addSubview:_leftSelectorView];
    
    _rightSelectorView = [[IZValueSelectorView alloc] initWithFrame:CGRectMake(0, 0, 80, picker.frame.size.height)];
    _rightSelectorView.center = CGPointMake(__MainScreen_Width / 3 * 2, picker.frame.size.height / 2);
    _rightSelectorView.delegate = self;
    _rightSelectorView.dataSource = self;
    [picker addSubview:_rightSelectorView];
    
    
//第四层 按钮
    UIView *backView3 = [[UIView alloc] initWithFrame:CGRectMake(0, K_Heigth / 4 * 3 + 40, __MainScreen_Width, K_Heigth / 4  - 40)];
    backView3.backgroundColor = status_color;
    [self addSubview:backView3];
    
    
    //看不清楚按钮
    UIButton *fuzzy = [UIButton buttonWithType:UIButtonTypeCustom];
    fuzzy.layer.cornerRadius = 3;
    fuzzy.layer.borderWidth = 1;
    fuzzy.layer.borderColor = [[UIColor whiteColor] CGColor];
    [fuzzy setTitle:@"看不清楚" forState:UIControlStateNormal];
    fuzzy.center = CGPointMake(__MainScreen_Width / 7 * 2, backView3.frame.size.height / 2);
    fuzzy.bounds = CGRectMake(0, 0, 100, 30);
    fuzzy.tag = 0;
    [fuzzy addTarget:self action:@selector(resultWithButton:) forControlEvents:UIControlEventTouchUpInside];
    [backView3 addSubview:fuzzy];
    
    //确定按钮
    UIButton *certain = [UIButton buttonWithType:UIButtonTypeCustom];
    certain.layer.cornerRadius = 3;
    certain.tag = 1;
    certain.backgroundColor = [UIColor colorWithRed:4.0 / 255 green:145.0 / 255 blue:203.0 / 255 alpha:1];
    [certain setTitle:@"确定输入" forState:UIControlStateNormal];
    [certain setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    certain.center = CGPointMake(__MainScreen_Width / 7 * 5, backView3.frame.size.height / 2);
    certain.bounds = CGRectMake(0, 0, 100, 30);
    [certain addTarget:self action:@selector(resultWithButton:) forControlEvents:UIControlEventTouchUpInside];
    [backView3 addSubview:certain];
    
    
    [self randomWithImageView];
    
    
}
#pragma  mark - 点击两个按钮
- (void) resultWithButton:(UIButton *)btn
{
    if (_progressInt < 5)
    {
        
        NSInteger result = [self.dataSource[_random] integerValue];
        UIImageView * imageView = _progressImageViewArray[_progressInt];
        NSLog(@"cheshi ---- %d    ++   %d",result,_result);
        if (result == _result && btn.tag)
        {
            imageView.image = [UIImage imageNamed:@"rightPysical"];
            _fitCount ++;
        }
        else
        {
            imageView.image = [UIImage imageNamed:@"wrong"];
        }
        if (_progressInt != 0)
        {
            UIView *v = [[UIView alloc] init];
            v.backgroundColor = UIColorFromRGB(0x5EC9F1);
            v.center = CGPointMake( imageView.center.x - (__MainScreen_Width - 40)/8 - 20 , _progressView.frame.size.height / 2);
            v.bounds = CGRectMake(0, 0, _progressView.frame.size.width / 4, 4);
            [_progressView addSubview:v];
        }
        
        _progressInt ++;
        //更新色盲图片
        [self randomWithImageView];
    }
    if (_progressInt == 5)
    {
#warning 跳转结果界面 _fitCount是答对个数
        if (_fitCount >3)
        {
            NSLog(@"恭喜您不是色盲 %d",_fitCount);
        }
        else
        {
            NSLog(@"您是色盲啊！！！%d",_fitCount);
        }
        examineResultViewController *resultVC = [[examineResultViewController alloc] initWithNibName:@"examineResultViewController" bundle:nil];
        resultVC.type = k_Blindnes;
        resultVC.blindnessValue = _fitCount;
        [self.VC.navigationController pushViewController:resultVC animated:YES];
    }
    
}


#pragma  mark   - ----------- IZValueSelector dataSource ------------
- (NSInteger)numberOfRowsInSelector:(IZValueSelectorView *)valueSelector {
    return 10;
}



//ONLY ONE OF THESE WILL GET CALLED (DEPENDING ON the horizontalScrolling property Value)
- (CGFloat)rowHeightInSelector:(IZValueSelectorView *)valueSelector {
    return 30;
}

- (CGFloat)rowWidthInSelector:(IZValueSelectorView *)valueSelector {
    return 30;
}


- (UIView *)selector:(IZValueSelectorView *)valueSelector viewForRowAtIndex:(NSInteger)index {
    UILabel * label = nil;
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _leftSelectorView.frame.size.width, 70)];
    label.text = [NSString stringWithFormat:@"%d",index];
    label.textAlignment =  NSTextAlignmentCenter;
    label.textColor = [UIColor blueColor];
    label.backgroundColor = [UIColor clearColor];
    return label;
}

- (CGRect)rectForSelectionInSelector:(IZValueSelectorView *)valueSelector {
    return CGRectMake(0.0, _leftSelectorView.frame.size.height/2 - 30, 90.0, 30);
    
}

#pragma IZValueSelector delegate
- (void)selector:(IZValueSelectorView *)valueSelector didSelectRowAtIndex:(NSInteger)index
{
    if (valueSelector == _rightSelectorView)
    {
        _rightInt = index;
    }
    else if (valueSelector == _leftSelectorView)
    {
        _leftInt = index;
    }
    _result = _leftInt * 10 + _rightInt;
    NSLog(@"Selected index %d",_result);
}



@end
