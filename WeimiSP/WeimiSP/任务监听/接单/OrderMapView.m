//
//  OrderMapView.m
//  WeimiSP
//
//  Created by thinker on 16/2/24.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "OrderMapView.h"
#import "BaiduLocationManage.h"

@interface OrderMapView ()<BMKMapViewDelegate>


@property (nonatomic, strong) UILabel *xiangxia;

@end

@implementation OrderMapView

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
//    self.longitude = 113.9489392953087;
//    self.latitude = 22.554713823883489;


    [self addSubview:self.mapView];
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.left.equalTo(@0);
    }];
    [self addSubview:self.topView];
    
//    self.pointAnnotation.coordinate = CLLocationCoordinate2DMake(self.latitude, self.longitude);
//    self.pointAnnotation.title = @"科苑站";
    
//    _mapView.userInteractionEnabled = YES;
//    UIPanGestureRecognizer *tap = [[UIPanGestureRecognizer alloc ]initWithTarget:self action:@selector(tapAction:)];
//    [_mapView addGestureRecognizer:tap];
}

#pragma mark - getter

-(UIView *)topView
{
    if (!_topView) {
        _topView = [[UIView alloc ]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50)];
        _topView.backgroundColor = UIColorFromRGB(0Xf0f0f0);
        
        [_topView addSubview:self.xiangxia];
        [_xiangxia mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@-10);
            make.centerX.equalTo(@0);
        }];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AcceptOrde_bottom"]];
        [_topView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_xiangxia.mas_top).with.offset(0);
            make.centerX.equalTo(@0);
        }];
    }
    return _topView;
}
-(UILabel *)xiangxia
{
    if (!_xiangxia) {
        _xiangxia = [[UILabel alloc] init];
        _xiangxia.text = @"向下滑动查看地图";
        _xiangxia.textAlignment = NSTextAlignmentCenter;
        _xiangxia.textColor = UIColorFromRGB(0X999999);
    }
    return _xiangxia;
}


-(BMKMapView *)mapView
{
    if (!_mapView ) {
        _mapView = [[BMKMapView alloc] initWithFrame:self.frame];
        _mapView.zoomLevel = 15;
//        _mapView.delegate = self;
//        _mapView.centerCoordinate = CLLocationCoordinate2DMake(self.latitude, self.longitude);
    }
    return _mapView;
    
}

-(BMKPointAnnotation *)pointAnnotation
{
    if (!_pointAnnotation) {
        _pointAnnotation = [[BMKPointAnnotation alloc] init];
        [_mapView addAnnotation:_pointAnnotation];
    }
    return _pointAnnotation;
}

//#pragma mark - BMKMapViewDelegate
//
//- (void)mapViewDidFinishLoading:(BMKMapView *)mapView {
////    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"BMKMapView控件初始化完成" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
////    [alert show];
////    alert = nil;
//}
//
//- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate {
//    NSLog(@"map view: click blank");
//}
//
//- (void)mapview:(BMKMapView *)mapView onDoubleClick:(CLLocationCoordinate2D)coordinate {
//    NSLog(@"map view: double click");
//}
//-(void)tapAction:(UIGestureRecognizer *)ges
//{
//    
//}


@end
