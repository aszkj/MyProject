//
//  WMERResultViewController.m
//  jingGang
//
//  Created by thinker on 15/10/22.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "WMERResultViewController.h"
#import "Util.h"
#import "VApiManager.h"
#import "PublicInfo.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "MERMenusViewController.h"
#import "PhysicalReportDetailController.h"


@interface WMERResultViewController ()
{
    NSArray *_dateArray;
}
@end

@implementation WMERResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

#pragma mark - 实例化UI
- (void)initUI
{
    NSString *dateStr = self.createTime;
    NSMutableCharacterSet *set = [[NSMutableCharacterSet alloc] init];
    [set addCharactersInString:@"-"];
    [set addCharactersInString:@" "];
    _dateArray = [dateStr componentsSeparatedByCharactersInSet:set];
    [Util setNavTitleWithTitle:[NSString stringWithFormat:@"%@年%@月%@日体检报告",_dateArray[0],_dateArray[1],_dateArray[2]] ofVC:self];
    self.view.backgroundColor = background_Color;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(btnClick) target:self];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
}

#pragma mark - 继续录入
- (IBAction)inputMER:(id)sender {
    NSArray *arrayVC = self.navigationController.viewControllers;
//    MERMenusViewController *menusVC;
    UIViewController *VC;
    for (UIViewController *vc in arrayVC)
    {
        if ([vc isKindOfClass:[MERMenusViewController class]] || [vc isKindOfClass:[PhysicalReportDetailController class]])
        {
            VC = (MERMenusViewController *)vc;
        }
    }
    [self.navigationController popToViewController:VC animated:YES];
    
}

#pragma mark - 录入完成
- (IBAction)commitMER:(id)sender {
    PhysicalReportDetailController *vc = [[PhysicalReportDetailController alloc]init];
    vc.apiId = self.apiId;
    vc.strYear = _dateArray[0];
    vc.strMonth = _dateArray[1];
    vc.strDay  = _dateArray[2];
    [self.navigationController pushViewController:vc animated:YES];
}


//返回上一级界面
- (void) btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
