//
//  BaiduMapViewController.m
//  WeimiSP
//
//  Created by thinker on 16/2/25.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "BaiduMapViewController.h"

@interface BaiduMapViewController ()

//大头针
@property (nonatomic, strong) BMKPointAnnotation *pointAnnotation;

@end

@implementation BaiduMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}


#pragma mark - 实例化UI
- (void)initUI
{
    self.view.backgroundColor = VCBackgroundColor;
    self.title = @"位置";
    [self.view addSubview:self.mapView];
    [self.mapView addAnnotation:self.pointAnnotation];
    
    self.pointAnnotation.coordinate = self.currentCoordinate;
    self.pointAnnotation.title = self.annotationTitle;
}

#pragma mark - getter


-(BMKMapView *)mapView
{
    if (!_mapView ) {
        _mapView = [[BMKMapView alloc] initWithFrame:self.view.frame];
        _mapView.zoomLevel = 15;
        _mapView.centerCoordinate = _currentCoordinate;
    }
    return _mapView;
    
}
-(BMKPointAnnotation *)pointAnnotation
{
    if (!_pointAnnotation) {
        _pointAnnotation = [[BMKPointAnnotation alloc] init];
    }
    return _pointAnnotation;
}
-(void)dealloc{
    NSLog(@"dealloc ---- BaiduMapViewController");
}



@end
