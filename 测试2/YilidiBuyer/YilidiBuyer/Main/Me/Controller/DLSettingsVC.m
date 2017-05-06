//
//  DLSettingsVC.m
//  YilidiSeller
//
//  Created by User on 16/3/30.
//  Copyright © 2016年 Dellidc. All rights reserved.
//

#import "DLSettingsVC.h"
#import "DLSettingCell.h"
#import "DLAboutUsVC.h"
#import "NSString+Teshuzifu.h"
#import "DLLoginVC.h"
@interface DLSettingsVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UITextView *aboutUs;

@end

@implementation DLSettingsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageTitle = @"设置";
    
    [self _initLoadSetTableView];
   
}




#pragma mark ------------------------Init---------------------------------
- (void)_initLoadSetTableView{
    
    //设置表视图
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.8f) style:UITableViewStylePlain];
    [_tableView setScrollEnabled:NO];
    [self _setExtraCellLineHidden:_tableView];
    _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    self.view.backgroundColor = UIColorFromRGB(0xE5E5E5);
    self.tableView.backgroundColor =UIColorFromRGB(0xE5E5E5);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DLSettingCell" bundle:nil] forCellReuseIdentifier:@"DLSettingCell"];
    
    [self.view addSubview:_tableView];
    
}

#pragma mark ------------------------Private-------------------------
- (CGFloat)_getCacheSize {
    CGFloat cacheSize = [[SDImageCache sharedImageCache] getSize] / (1024*1024*1.0);
    return  cacheSize;
}

/***清除tableView多余的线***/
- (void)_setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    
    view.backgroundColor = [UIColor clearColor];
    //线从最左边开始延伸显示
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [tableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
    [tableView setTableFooterView:view];
    
}


#pragma mark ------------------------Api----------------------------------
#pragma mark ------------------------Page Navigate---------------------------


#pragma mark ------------------------View Event---------------------------

#pragma mark ------------------------Delegate-----------------------------
#pragma -- mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 0) {
        
        
    }else if (indexPath.section == 1) {
        
        switch (indexPath.row) {
            case 0:
            {
                DLAboutUsVC *us = [[DLAboutUsVC alloc]init];
                [self.navigationController pushViewController:us animated:YES];
            }
                break;
            case 1:
            {
                
            }
                break;
            case 2:
            {
                [self showSimplyAlertWithTitle:@"提示" message:@"确认清除缓存?" sureAction:^(UIAlertAction *action) {
                    [self showLoadingHub];
                    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                        [self hideLoadingHub];
                        DLSettingCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                        cell.accessoryLabel.text = [NSString stringWithFormat:@"%.1fM",[self _getCacheSize]];
                    }];
                } cancelAction:nil];
                
            }
                break;
                
            default:
                break;
        }
    }else {
        
        UIAlertController *alertCtr = [UIAlertController alertControllerWithTitle:nil message:@"确定要退出登录吗?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAct = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *sureAct = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self requestLogout];
        }];
        
        [alertCtr addAction:cancelAct];
        [alertCtr addAction:sureAct];
        
        [self presentViewController:alertCtr animated:YES completion:nil];
        
        
    }
    
    
}

//线从最左边开始延伸显示
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
}

#pragma -- mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
        return 1;
    }else if (section == 1) {
        return 3;
    } else {
        return 1;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section==0) {
        return 10.0f;
    }else if (section==1){
        return 10.0f;
    }else{
        return 20.0f;
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DLSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DLSettingCell"];
    
    //设置字体 ,颜色
    [cell.leftTitle setTextColor:kGetColor(93, 94, 95)];
    [cell.midTitle setTextColor:kGetColor(93, 94, 95)];
    
    if (indexPath.section == 0) {
        
        cell.leftTitle.text = @"设置头像";
        cell.accessoryImage.frame = CGRectMake(cell.accessoryImage.frame.origin.x, cell.accessoryImage.frame.origin.y, 80, 80);
        cell.accessoryImage.image = [UIImage imageNamed:@"home_icon_05"];
    }else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                cell.leftTitle.text = @"关于我们";
                cell.accessoryImage.image = [UIImage imageNamed:@"icon_06"];
                
                break;
                
            case 1:
                cell.leftTitle.text = @"当前版本";
                cell.accessoryLabel.text = [NSString stringWithFormat:@"V%@",[Util appVersion]];
                
                break;
            case 2:
                cell.leftTitle.text = @"清除缓存";
                cell.accessoryLabel.text = [NSString stringWithFormat:@"%.1fM",[self _getCacheSize]];
                
            default:
                break;
        }
    }else {
        cell.midTitle.text = @"退出登录";
    }
    
    return cell;
}


#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------





//退出登录
- (void)requestLogout {
    
//    [AFNHttpRequestOPManager getInfoWithSubUrl:kUrl_Logout parameters:nil block:^(id result, NSError *error) {
//        //退出后弹出登录页面
//        DLLoginVC *logout = [[DLLoginVC alloc]init];
//        [self presentViewController:logout animated:YES completion:nil];
//        
//        //删除本地token
//        [kUserDefaults setObject:nil forKey:token];
//        [kUserDefaults synchronize];
//        
//        //删除本地保存的店铺基本信息
//        NSError *err = nil;
//        NSFileManager *manager = [NSFileManager defaultManager];
//        if (![manager removeItemAtPath:kFilePathWithName(kShopInfo) error:&err]) {
//            DebugLog(@"删除失败:%@",error.userInfo);
//        }else {
//            DebugLog(@"删除成功");
//        }
//        
//    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
