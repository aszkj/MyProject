//
//  DLLocationViewController.m
//  YilidiSeller
//
//  Created by 曾勇兵 on 16/6/23.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLLocationViewController.h"
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import "GlobeMaco.h"
#import "GlobleConst.h"
@interface DLLocationViewController ()<BMKLocationServiceDelegate>
{
    int a;
}
@property (nonatomic, strong) BMKLocationService *locationService;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation DLLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _init];
    self.nameLabel.text = self.name;
    self.addressLabel.text = self.address;
}

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    self.navigationController.navigationBar.hidden = YES;
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)_init {

    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    
    
    if ( [self beginLocationUpdate]==YES) {
        _mapView.showsUserLocation = YES;
        _mapView.delegate = self;
        self.locationService = [[BMKLocationService alloc]init];
        _locationService.delegate=self;
        
        _mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
        _mapView.zoomLevel =19;
        
        BMKLocationViewDisplayParam *displayParam = [[BMKLocationViewDisplayParam alloc]init];
        displayParam.isRotateAngleValid = true;//跟随态旋转角度是否生效
        displayParam.isAccuracyCircleShow = false;//精度圈是否显示
//        displayParam.locationViewImgName= @"热门搜索";//定位图标名称
        displayParam.locationViewOffsetX = 0;//定位偏移量(经度)
        displayParam.locationViewOffsetY = 0;//定位偏移量（纬度）
        [_mapView updateLocationViewWithParam:displayParam];
        //显示定位的蓝点儿必须先开启定位服务
        
        [_locationService startUserLocationService];
        
    }
    
    
    NSDictionary *dic = [kUserDefaults objectForKey:HomeResponeData];
   
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = [dic[@"latitude"] floatValue];
    coor.longitude = [dic[@"longitude"] floatValue];
    NSLog(@"longitude:%f",[dic[@"longitude"] floatValue]);
    annotation.coordinate = coor;
    annotation.title = @"商家";
    
//    BMKPointAnnotation* annotation2 = [[BMKPointAnnotation alloc]init];
//    CLLocationCoordinate2D coor2;
//    coor2.latitude = 22.521860;
//    coor2.longitude = 113.929480;
//    annotation2.coordinate = coor2;
//    annotation2.title = @"微商";
    
    BMKPointAnnotation* annotation3 = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor3;
    coor3.latitude = _customerLatitude;
    coor3.longitude = _customerLongtitude;
    annotation3.coordinate = coor3;
    annotation3.title = @"用户";
    
    NSArray *array = @[annotation,annotation3];
    [_mapView addAnnotations:array];

}


- (BOOL)beginLocationUpdate
{
    
    // 判断定位操作是否被允许
    if([CLLocationManager locationServicesEnabled])
    
    {
    
        CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
        
        if (kCLAuthorizationStatusDenied == status || kCLAuthorizationStatusRestricted == status) {
            
            [self showSimplyAlertWithTitle:@"提示" message:@"请允许您的APP进行定位!" sureAction:^(UIAlertAction *action) {
                [self.navigationController popViewControllerAnimated:YES];
                NSURL *url = [NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"];
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL:url];
                }
                
            } cancelAction:^(UIAlertAction *action) {
                
                
            }];
            
            return NO;
        }
        
        
    
    }else {
        
        //提示用户无法进行定位操作
        [self showSimplyAlertWithTitle:@"提示" message:@"定位功能不可用" sureAction:^(UIAlertAction *action) {
            [self.navigationController popViewControllerAnimated:YES];
            NSURL *url = [NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
            
            
        } cancelAction:^(UIAlertAction *action) {
          
            
        }];
        
        return NO;
    }

    return YES;

}




- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation

{
    
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        
            BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
            
            newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
            
            newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
            
            newAnnotationView.annotation=annotation;

        if (a==0) {
            
            newAnnotationView.image = [UIImage imageNamed:@"storeLocation"];   //把大头针换成别的图片
            
        }else {
            newAnnotationView.image = [UIImage imageNamed:@"userLocation"];   //把大头针换成别的图片
        }
        
        a++;
        
       return newAnnotationView;
        
    }
   
    
    
    return nil;
    
}


/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    
    [_mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
     NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
//    //展示定位
//    _mapView.showsUserLocation = YES;
//    //获取用户的坐标
//    _mapView.centerCoordinate = userLocation.location.coordinate;
//    _mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
//    _mapView.zoomLevel =18;
    
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}


- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}




- (IBAction)goBackPageClick:(id)sender {
    
    [self goBack];
}


@end
