//
//  devicesChildViewController.m
//  jingGang
//
//  Created by yi jiehuang on 15/6/2.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "devicesChildViewController.h"
#import "PublicInfo.h"
#import "KDGoalBar.h"
#import "devicesTableViewCell.h"
#import "shareView.h"
#import "communitBtn.h"
#import "historyViewController.h"
#import "mydevieseViewController.h"
#import "JGBlueToothManager.h"
#import "MBProgressHUD.h"
#import "UIButton+Block.h"
#import "VApiManager.h"
#import "GlobeObject.h"
#import "UIViewExt.h"
#import "JGShareView.h"
#import "BangdingVC.h"
#import "NSDate+Utilities.h"
@interface devicesChildViewController ()
{
    UIScrollView     *_myScrollView;
    KDGoalBar        *_top_view;//顶部的圆圈仕途
    UITableView      *_mytableView;
    UIView          *_viewforshare;
    shareView       *share_view;
    
    UILabel * lab;
    JGBlueToothManager *_jgBlueManager;
    UIButton * bangbtn;

    VApiManager *_vapManager;

    devicesTableViewCell *cell1;
    devicesTableViewCell *cell2;
    
    
    UIView *_syncRemenderView;//同步提示view
    UILabel *remenderLabel;
    
}

@property (nonatomic, strong)JGShareView *shareView;

@end

@implementation devicesChildViewController

- (void)dealloc
{
  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化手环部分
    [self _initTheRing];
    

    _myScrollView = [[UIScrollView alloc]init];
    _myScrollView.frame = self.view.frame;
    _myScrollView.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1];
    [self.view addSubview:_myScrollView];

    _mytableView = [[UITableView alloc]init];
    _mytableView.frame = CGRectMake(0, 0, __MainScreen_Width, 206+103+88+10);
    _mytableView.backgroundColor = [UIColor clearColor];
    _mytableView.delegate = self;
    _mytableView.scrollEnabled = NO;
    _mytableView.dataSource = self;
    [_myScrollView addSubview:_mytableView];
    if (__MainScreen_Height == 480) {
        _myScrollView.contentSize = CGSizeMake(__MainScreen_Width, __MainScreen_Height+100);
    }else{
        _myScrollView.contentSize = CGSizeMake(__MainScreen_Width, __MainScreen_Height);
    }
    
    lab = [[UILabel alloc]init];
    lab.frame = CGRectMake(0, _mytableView.frame.origin.y+_mytableView.frame.size.height+20, __MainScreen_Width, 15);
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = [UIColor lightGrayColor];
    [_myScrollView addSubview:lab];

    bangbtn = [[UIButton alloc]init];
    bangbtn.frame = lab.frame;
    if (_jgBlueManager.bangedPerialUUID && _jgBlueManager.bangedPerialID ) {
        
        lab.text = _jgBlueManager.bangedPerialID;
        
    }else{
        
        lab.text = @"您还未绑定设备，请绑定设备";
    
        [bangbtn addTarget:self action:@selector(bangBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }

    [_myScrollView addSubview:bangbtn];

    
    
    _viewforshare = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __MainScreen_Width, __MainScreen_Height)];
    _viewforshare.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
    communitBtn * btn = [[communitBtn alloc]initWithFrame:_viewforshare.frame];
    [btn addTarget:self action:@selector(viewforshareBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_viewforshare addSubview:btn];

    
    share_view = [shareView instance];
    share_view.frame = CGRectMake(0, __MainScreen_Height, __MainScreen_Width, 200);
    [_viewforshare addSubview:share_view];
    [share_view.cacel_btn setBackgroundImage:[UIImage imageNamed:@"com_cancel_pressed"] forState:UIControlStateHighlighted];
    [share_view.cacel_btn addTarget:self action:@selector(viewforshareBtn:) forControlEvents:UIControlEventTouchUpInside];
    //    view.backgroundColor = [UIColor orangeColor];
//    UIWindow *keyWindow = [[UIApplication sharedApplication]keyWindow];
    [self.view addSubview:_viewforshare];
    _viewforshare.hidden = YES;

    //365,68 kScreenWidth-110
    CGFloat y = kScreenHeight * ( 366 * 1.0 / 568);
    _syncRemenderView = [[UIView alloc] initWithFrame:CGRectMake((kScreenWidth-220)/2+10, y, 220, 50)];
    NSLog(@"%.2f",kScreenHeight);
    _syncRemenderView.layer.cornerRadius = 15;
    _syncRemenderView.layer.masksToBounds = YES;
    _syncRemenderView.backgroundColor = [UIColor blackColor];
    _syncRemenderView.alpha = 0.7;
    [self.view addSubview:_syncRemenderView];
//    _syncRemenderView.hidden = YES;
    
    remenderLabel = [[UILabel alloc] initWithFrame:CGRectMake(20/2, 0, _syncRemenderView.width-20, 50)];
    remenderLabel.font = [UIFont systemFontOfSize:15];
    remenderLabel.textAlignment = NSTextAlignmentCenter;
    remenderLabel.textColor = [UIColor whiteColor];
    remenderLabel.text = @"正在扫描设备..";
    [_syncRemenderView addSubview:remenderLabel];

}




#pragma mark --------------------------手环部分--------------------------------------
#pragma mark - 初始化手环部分
-(void)_initTheRing{

    _jgBlueManager = [JGBlueToothManager shareInstances];
    
    //如果绑定了
    if (_jgBlueManager.bangedPerialUUID) {
        //同步手环对应UI上的数据
        [self _syDataAtUIscned];
        
        //同步手环上的
        [self _syncInfo];
    }

}


- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    [super viewWillAppear:animated];
#pragma mark - test
    if (!_jgBlueManager.bangedPerialUUID && !self.selfIsPopPresented) {//如果没绑定，并且它不是被pop呈现的
        mydevieseViewController *deviceVC = [[mydevieseViewController alloc] init];
        deviceVC.isComminFromTheRing = YES;
        [self.navigationController pushViewController:deviceVC animated:NO];
    }

    
    //只要连接过
    if (_jgBlueManager.bangedPerialUUID) {
        //视图即将出现， 如果不是第一次连接
        if (_jgBlueManager.connectTimeState == NotFirstConnectState) {//非第一次连接，则需要扫描设备并连接绑定的设备
            
        }else if(_jgBlueManager.connectTimeState == FirstConnectState ){//如果是第一次连接
            //参数已经同步了，同步步数
            if (_jgBlueManager.bangedPerialID) {
                
                lab.text = _jgBlueManager.bangedPerialID;
                // [bangbtn resignFirstResponder];
                
                //同步运动数据或者睡眠数据
                if ([self.img_name isEqualToString:@"home_sleep"]) {//睡眠控制器
                    
                    //同步睡眠信息
                    [self _syncSleepInfo];
                    
                }else{//运动步数控制器
                    //同步运动相关信息
                    [self _syncMotionSteps];
                    
                }
                
            }
            
            
        }
        
    }
    
    if (_jgBlueManager.bangedPerialID && _jgBlueManager.bangedPerialUUID) {
        
        
        lab.text = _jgBlueManager.bangedPerialID;
    }else{
        
        lab.text = @"您还未绑定设备，请绑定设备";
        WEAK_SELF
//        if (_jgBlueManager.isJustNowUnbangded) {//如果是刚刚解绑
//            
//            [bangbtn addActionHandler:^(NSInteger tag) {
//                [weak_self bangBtnClick];
//            }];
//            _jgBlueManager.isJustNowUnbangded = NO;
//        }
        [bangbtn addTarget:self action:@selector(bangBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //页面即将出现变得活跃状态
    _jgBlueManager.activeState = BecomeActiveState;
    
    //    [self _getNeededCell];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    //页面即将消失的时候，注销活跃状态
    _jgBlueManager.activeState = ResignActiveState;
    
}

#pragma mark - 初始化运动，睡眠相关信息
-(void)_syDataAtUIscned{
    
    //判断是否当前为睡眠控制器
    if ([self.img_name isEqualToString:@"home_sleep"]) {//睡眠控制器
        //同步睡眠ui信息
//        if (_jgBlueManager.isSleepDataSyned) {//如果睡眠同步过
        
            self.midel_array = @[[self getTimeByMinutes:_jgBlueManager.userBodySyncModel.totalSleepTime],
                                      [self getTimeByMinutes:_jgBlueManager.userBodySyncModel.deepSleepTime],
                                      [self getTimeByMinutes:_jgBlueManager.userBodySyncModel.lightSleepTime]];
//        }else{
//        
//            //或者从缓存模型中取，这里只是暂时
//            self.midel_array = @[@"00:00:00",@"00:00:00",@"00:00:00"];
//        }
        
    }else{//运动步数ui信息
//        if (_jgBlueManager.isMotionSyned) {//如果运动信息同步过
        
            self.midel_array = @[[NSString stringWithFormat:@"%ldsteps",_jgBlueManager.userBodySyncModel.steps],
                                      [NSString stringWithFormat:@"%.1fkm",_jgBlueManager.userBodySyncModel.licheng],
                                      [NSString stringWithFormat:@"%.1fKcal",_jgBlueManager.userBodySyncModel.kaluoli]];
//        }else{
//        
//            self.midel_array = @[@"3000steps",@"10km",@"1kcal"];
//        }
        
    }
}


-(void)_getNeededCell{

//    NSArray * array = [[NSBundle mainBundle]loadNibNamed:@"devicesTableViewCell" owner:self options:nil];
    cell1 = (devicesTableViewCell *)[_mytableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]] ;

    if (self) {
        
    }
    if (_jgBlueManager.bangedPerialUUID) {//只有绑定了，才进行
        
//        cell1._midel_img.hidden = YES;
//        cell1.progressLabel.hidden = NO;
        
    }
    
    cell2 = (devicesTableViewCell *)[_mytableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]];

    
}//获得需要赋值的cell


-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
//    if (self.popoverPresentationController) {
//        NSLog(@"被上一级pop");
//    }else{
//        NSLog(@"不是被上一级pop");
//    }
    [self _getNeededCell];
    
    //获取cell之后,从服务器请求之前手环数据
    _vapManager = [[VApiManager alloc] init];
    
    //判断是否当前为睡眠控制器
    if ([self.img_name isEqualToString:@"home_sleep"]) {//睡眠控制器
        
//        [self _getTheDaySleepDataRequest];
        
    }else{//运动步数控制器
        
//        [self _getTheDayMotionDataRequest];
        
    }
}



-(void)_syncInfo{
    //获得需要赋值的cell
//    [self _getNeededCell];
    
    [_jgBlueManager beginScanperipheralsAndConnectBandedPerialWithCennectResult:^(BOOL connectSuccess) {
        remenderLabel.text = @"扫描设备成功，正在同步数据..";
        [self performSelector:@selector(_HideAsyncView) withObject:nil afterDelay:10.0];
        if (connectSuccess) {//连接成功
            //同步参数
            [_jgBlueManager syncParamater:^(BOOL success) {
                
            }];
            
            //判断是否当前为睡眠控制器
            if ([self.img_name isEqualToString:@"home_sleep"]) {//睡眠控制器
                
                //同步睡眠信息
                [self _syncSleepInfo];
                
            }else{//运动步数控制器
                //同步运动相关信息
                [self _syncMotionSteps];
                
            }

        }
    } falied:^(NSError *error) {
        remenderLabel.text = error.domain;
        if (error.code == 4) {
            [self performSelector:@selector(_HideAsyncView) withObject:nil afterDelay:10.0];
        }
//        [self performSelector:@selector(_HideAsyncView) withObject:nil afterDelay:20.0];
//        [Util ShowAlertWithOutCancelWithTitle:@"提示" message:error.domain];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:error.domain delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//        [alert show];
        
    }];
    
    
}//同步信息



-(void)_syncMotionSteps{
    
//    [cell1._midel_img startAnimating];
//    sleep(2);
    
    WeakSelf;
    __weak typeof(devicesTableViewCell *)weakCell2 = cell2;
    __weak typeof(devicesTableViewCell *)weakCell1 = cell1;

    [_jgBlueManager syncMotionInfoForsyncResult:^(BOOL connectSuccess) {
        StrongSelf;
        [weakCell1._midel_img stopAnimating];
        weakCell1.syncStateLabel.text = @"已同步运动数据";
        remenderLabel.text = @"已同步运动数据";
        [strongSelf performSelector:@selector(_HideAsyncView) withObject:nil afterDelay:3.0];
        //更新UI
        
        dispatch_async(dispatch_get_main_queue(), ^{
            weakCell2._left_lab.text = [NSString stringWithFormat:@"%ldSteps",(long)_jgBlueManager.userBodySyncModel.steps];
            weakCell2._midel_lab.text = [NSString stringWithFormat:@"%.1fKm",_jgBlueManager.userBodySyncModel.licheng];
        });

        //对卡洛里进行四舍五入
        CGFloat kaluoli = _jgBlueManager.userBodySyncModel.kaluoli;
        if ((kaluoli) > ((int)kaluoli)+0.5) {//向上取整
            kaluoli = (int)kaluoli + 1;
        }else{
            kaluoli = (int)kaluoli;
        }
        weakCell2._right_lab.text = [NSString stringWithFormat:@"%dKcal",(int)kaluoli];
        
        
        
        //标志运动数据同步过
        if (!_jgBlueManager.isSleepDataSyned) {
            _jgBlueManager.isSleepDataSyned = YES;
        }
        
        //        cell1.progressLabel.hidden = YES;
        weakCell1._midel_img.hidden = NO;
        
        NSInteger purprogress = (_jgBlueManager.userBodySyncModel.steps * 1.0 / _jgBlueManager.userBodyModel.goalSteps) * 100;

        [weakCell1.rmProgresser updateWithTotalBytes:100 downloadedBytes:purprogress];
        
        weakCell2.peCentLabel.hidden = NO;
        //设置百分比label
        NSString *percentStr  = [NSString stringWithFormat:@"%ld%@",purprogress,@"%"];
        weakCell2.peCentLabel.text = percentStr;
        //上传运动数据
        [strongSelf _updateMotionDataRequest];
        NSLog(@"bushu:%ld",_jgBlueManager.userBodySyncModel.steps);
        NSLog(@"licheng:%.2f",_jgBlueManager.userBodySyncModel.licheng);
        NSLog(@"kaluoli:%.2f",_jgBlueManager.userBodySyncModel.kaluoli);
//        remenderLabel.text = @"已同步数据";
//        _syncRemenderView.hidden = YES;
//        [_syncRemenderView performSelector:@selector(isHidden) withObject:@(YES) afterDelay:0.3];

    } wihtSyncProgress:^(int progress) {
      [cell1._midel_img startAnimating];
        NSLog(@"motionProgress:%d",progress);
      //        [cell1.rmProgresser updateWithTotalBytes:100 downloadedBytes:progress];
        cell1.syncStateLabel.text = @"正在同步运动数据..";
        _syncRemenderView.hidden = NO;
        remenderLabel.text = @"正在同步运动数据..";



    } failed:^(NSError *error) {
        NSLog(@"error domain - %@",error.domain);
        cell1.syncStateLabel.text = error.localizedDescription;
        cell1.syncStateLabel.text = @"正在同步运动数据..";
        [cell1._midel_img stopAnimating];
        remenderLabel.text = error.localizedDescription;
        remenderLabel.text = @"正在同步运动数据..";
        [self performSelector:@selector(_HideAsyncView) withObject:nil afterDelay:30.0];
    }];
    
}//同步运动数据





-(void)_syncSleepInfo{


    [_jgBlueManager syncSleepInfoForsyncResult:^(BOOL connectSuccess) {
        [cell1._midel_img stopAnimating];
        cell1.syncStateLabel.text = @"已同步睡眠数据";
        remenderLabel.text = @"已同步睡眠数据";
        [self performSelector:@selector(_HideAsyncView) withObject:nil afterDelay:3.0];

        cell2._left_lab.text = [self getTimeByMinutes:_jgBlueManager.userBodySyncModel.totalSleepTime];
        cell2._midel_lab.text = [self getTimeByMinutes:_jgBlueManager.userBodySyncModel.deepSleepTime];
        cell2._right_lab.text = [self getTimeByMinutes:_jgBlueManager.userBodySyncModel.lightSleepTime];
        //标志运动数据已经同步
        if (!_jgBlueManager.isMotionSyned) {
            _jgBlueManager.isMotionSyned = YES;
        }
        
        cell2.peCentLabel.hidden = YES;
        NSInteger purprogress = (_jgBlueManager.userBodySyncModel.totalSleepTime * 1.0 / _jgBlueManager.userBodyModel.goalSleepMinute) * 100;
    
        
//        [cell1.rmProgresser updateWithTotalBytes:100 downloadedBytes:purprogress];
        
        //上传睡眠数据
        [self _updateSleepDataRequest];
        
        //        cell1.progressLabel.hidden = YES;
        cell1._midel_img.hidden = NO;

        
    } wihtSyncProgress:^(int progress) {
        [cell1._midel_img startAnimating];
        cell1.syncStateLabel.text = @"正在同步睡眠数据..";
        _syncRemenderView.hidden = NO;
        remenderLabel.text = @"正在同步睡眠数据..";
        
    } failed:^(NSError *error) {
        cell1.syncStateLabel.text = @"同步超时，请重新同步睡眠数据";
        cell1.syncStateLabel.text = error.localizedDescription;
        cell1.syncStateLabel.text = @"正在同步睡眠数据..";
        remenderLabel.text = error.localizedDescription;
        remenderLabel.text = @"正在同步睡眠数据..";
        [self performSelector:@selector(_HideAsyncView) withObject:nil afterDelay:30.0];
        [cell1._midel_img stopAnimating];
    }];
    
    
}//同步睡眠信息

-(void)_HideAsyncView{
    
    [UIView animateWithDuration:0.3 animations:^{
        _syncRemenderView.hidden = YES;
    }];
    
}//隐藏进度view

-(NSString *)getTimeByMinutes:(NSInteger)minutes{
    
    
    NSInteger hour = minutes / 60;
    NSInteger minute = minutes % 60;
    
    return [NSString stringWithFormat:@"%02ld:%02ld:00",hour,minute];
    
}//根据分钟返回时间字符串


#pragma mark - 同步睡眠数据上传
-(void)_updateSleepDataRequest{

    EquipSleepAddRequest *request = [[EquipSleepAddRequest alloc] init:GetToken];
    request.api_sleepSecond = @(_jgBlueManager.userBodySyncModel.totalSleepTime * 60);
    request.api_shallowSleepSecond = @(_jgBlueManager.userBodySyncModel.lightSleepTime * 60);
    request.api_deepSleepSecond = @(_jgBlueManager.userBodySyncModel.deepSleepTime * 60);
    

    
    [_vapManager equipSleepAdd:request success:^(AFHTTPRequestOperation *operation, EquipSleepAddResponse *response) {
        
        NSLog(@"%@",response.errorCode);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}




#pragma mark - 同步运动数据上传
-(void)_updateMotionDataRequest{
    
    EquipAddRequest *request = [[EquipAddRequest alloc] init:GetToken];
//    NSDictionary *userDic = [kUserDefaults objectForKey:userInfoKey];
    
    NSInteger height = (int)_jgBlueManager.userBodyModel.height;
    NSInteger weight = _jgBlueManager.userBodyModel.weight;
    
    request.api_heigth = @(height);
    request.api_weight = @(weight);
    request.api_stepNumber = @(_jgBlueManager.userBodySyncModel.steps);
    
    [_vapManager equipAdd:request success:^(AFHTTPRequestOperation *operation, EquipAddResponse *response) {
        
        NSLog(@"%@",response.errorCode);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellStr = @"cellStr";
    devicesTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (!cell) {
        NSArray * array = [[NSBundle mainBundle]loadNibNamed:@"devicesTableViewCell" owner:self options:nil];
        if (indexPath.row == 0) {
            tableView.rowHeight = 206;
            cell = [array objectAtIndex:indexPath.row];
            cell._bgView.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1];
            
//            cell._kd_view.backgroundColor = [UIColor redColor];
            [cell.freshButton addActionHandler:^(NSInteger tag) {
               //点击同步
                //判断是否当前为睡眠控制器
                if ([self.img_name isEqualToString:@"home_sleep"]) {//睡眠控制器
                    
                    //同步睡眠信息
                    [self _syncSleepInfo];
                    
                }else{//运动步数控制器
                    //同步运动相关信息
                    [self _syncMotionSteps];
                    
                }

            }];
            
//            cell._kd_view.witch = 100;
//            [cell._kd_view setPercent:50 witch:100 animated:YES];
            if (self.view_tag == 1) {
                cell._midel_img.image = [UIImage imageNamed:self.img_name];
//                cell._midel_img.bounds = CGRectMake(0, 0, 65, 100);
//                cell._kd_view.witch = 200;
//                [cell._kd_view setPercent:50 witch:200 animated:YES];
                
                
            }
            //配置cell中的图片动画
            [self _conFigureCellProgressAnimationWithCell:cell];
            
        }else if (indexPath.row == 1){
            tableView.rowHeight = 103;
            cell = [array objectAtIndex:indexPath.row];
            if ([self.img_name isEqualToString:@"home_sleep"]) {//睡眠控制器
                
                cell.peCentLabel.hidden = YES;
                
            }else{//运动步数控制器
               
                cell.peCentLabel.hidden = NO;
            }

            
            if (self.view_tag == 1) {
                cell._left_name_lab.text = [_midel_name_array objectAtIndex:0];
                [cell._left_btn setBackgroundImage:[UIImage imageNamed:@"home_sleep02"] forState:UIControlStateNormal];
                cell._midel_name_lab.text = [_midel_name_array objectAtIndex:1];
                [cell._midel_btn setBackgroundImage:[UIImage imageNamed:@"home_deep_sleep"] forState:UIControlStateNormal];
                cell._right_name_lab.text = [_midel_name_array objectAtIndex:2];
                [cell._right_btn setBackgroundImage:[UIImage imageNamed:@"home_sha_sleep"] forState:UIControlStateNormal];
            }
            
            cell._left_lab.text = [_midel_array objectAtIndex:0];
            cell._midel_lab.text = [_midel_array objectAtIndex:1];
            cell._right_lab.text = [_midel_array objectAtIndex:2];
        }else if (indexPath.row == 2){
            tableView.rowHeight = 10;
            cell = [array objectAtIndex:2];
            cell.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1];
            cell._left_img.hidden = YES;
            cell._name_lab.hidden = YES;
        }else{
            tableView.rowHeight = 44;
            cell = [array objectAtIndex:2];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            if (indexPath.row == 4) {
                cell._left_img.image = [UIImage imageNamed:@"home_share"];
                cell._name_lab.text = @"分享";
            }
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float  height = 0;
    switch (indexPath.row) {
        case 0:
        {
             height = 206;
        }
            break;
        case 1:
        {
             height = 103;
        }
            break;
        case 2:
        {
            height = 10;
        }
            break;
            
        default:
        {
            height = 44;
        }
            break;
    }
    return height;
}


#pragma mark - 配置动画
-(void)_conFigureCellProgressAnimationWithCell:(devicesTableViewCell *)cell{
    
    NSArray *animationImgArr = nil;
    //判断是否当前为睡眠控制器
    if ([self.img_name isEqualToString:@"home_sleep"]) {//睡眠控制器
        
        
        animationImgArr = @[[UIImage imageNamed:@"home_sleep.png"],
                            [UIImage imageNamed:@"home_sleep01.png"]];
        
        
        
    }else{//运动步数控制器
        
        animationImgArr = @[[UIImage imageNamed:@"home_steps.png"],
                            [UIImage imageNamed:@"home_steps-one.png"]];
        
        
    }
    
    cell._midel_img.animationImages = animationImgArr;
    [cell._midel_img setAnimationDuration:0.5f];
    [cell._midel_img setAnimationRepeatCount:HUGE_VAL];
    
    
}




-(void)viewDidLayoutSubviews
{
    if ([_mytableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_mytableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([_mytableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_mytableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 4) {//分享
//        _viewforshare.hidden = NO;
//        [UIView animateWithDuration:0.3 animations:^{
//            share_view.frame = CGRectMake(0, __MainScreen_Height-300, __MainScreen_Width, 200);
//            
//        } completion:^(BOOL finished) {
//        }];
//        if ([_img_name isEqualToString:@"home_sleep"]) {
//
//        }else{
//
//        }
#pragma mark - 分享修改的
        [self.shareView show];
    }else if (indexPath.row == 3){//历史记录
        historyViewController * historyVc = [[historyViewController alloc]init];
        if ([_img_name isEqualToString:@"home_sleep"]) {
            historyVc.histoyeType = SleepHistory_Type;
        }else{
            historyVc.histoyeType = StepHistory_Type;
        }
        [self.navigationController pushViewController:historyVc animated:YES];
    }
    
}

-(JGShareView *)shareView {
    NSInteger month = [[NSDate date] month];
    NSInteger day = [[NSDate date] day];
    NSString *shareTitle = @"";
    NSString *shareContent = @"";
    NSString *totalTime = [self getTimeByMinutes:_jgBlueManager.userBodySyncModel.totalSleepTime];
    NSString *deepTime = [self getTimeByMinutes:_jgBlueManager.userBodySyncModel.deepSleepTime];
    NSString *slightTime = [self getTimeByMinutes:_jgBlueManager.userBodySyncModel.lightSleepTime];
    totalTime = [self getHourAndMinuteStrWithStr:totalTime];
    deepTime = [self getHourAndMinuteStrWithStr:deepTime];
    slightTime = [self getHourAndMinuteStrWithStr:slightTime];

    //判断是否当前为睡眠控制器
    if ([self.img_name isEqualToString:@"home_sleep"]) {//睡眠控制器
        shareTitle = @"邀你一起动起来~";
        shareContent = [NSString stringWithFormat:@"+昨晚睡了%@，深睡%@，浅睡%@。云e生手环，帮你睡得还好.",totalTime,deepTime,slightTime];
    }else{//运动步数控制器
        shareTitle = @"它让你睡得更好了~";
        shareContent = [NSString stringWithFormat:@"+%ld月%ld日，我一共行走了%.1f公里，%ld步，消耗热量%.1f卡路里，云e生手环，健康运动！",month,day,_jgBlueManager.userBodySyncModel.licheng,_jgBlueManager.userBodySyncModel.steps,_jgBlueManager.userBodySyncModel.kaluoli];

    }
    NSString *shareUrl = kInvitationCodeShareUrlCode([[kUserDefaults objectForKey:userInfoKey] objectForKey:@"invitationCode"]);
    if (!_shareView) {
          _shareView = [JGShareView shareViewWithTitle:shareTitle content:shareContent imgUrlStr:k_ShareImage ulrStr:shareUrl contentView:self.view.window shareImagePath:nil];
    }
    _shareView.wxFriendShareModle.shareTitle = shareContent;
    return _shareView;
}

-(NSString *)getHourAndMinuteStrWithStr:(NSString *)sleepStr {

    NSInteger hour = [[sleepStr substringWithRange:NSMakeRange(0, 2)] integerValue];
    NSInteger minute = [[sleepStr substringWithRange:NSMakeRange(3, 2)] integerValue];
    return [NSString stringWithFormat:@"%ld小时%ld分",hour,minute];
}


- (void)viewforshareBtn:(communitBtn *)btn
{
    [UIView animateWithDuration:0.5 animations:^{
        share_view.frame = CGRectMake(0, __MainScreen_Height, __MainScreen_Width, 200);
    } completion:^(BOOL finished) {
        _viewforshare.hidden = YES;
    }];
}

- (void)bangBtnClick
{
    mydevieseViewController * vc = [[mydevieseViewController alloc]init];
    vc.keyStr = @"oneVc";
    vc.deviceChindVC = self;
    [self.navigationController pushViewController:vc animated:YES];

}


#pragma mark - uialert view delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex == 0) {
        if (self.backBlock) {//返回
//            self.backBlock();
        }
    }
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
