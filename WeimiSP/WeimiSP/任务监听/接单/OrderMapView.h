
//
//  OrderMapView.h
//  WeimiSP
//
//  Created by thinker on 16/2/24.
//  Copyright © 2016年 XKJH. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface OrderMapView : UIView

@property (nonatomic, strong) UIScrollView *scrollView;

//大头针
@property (nonatomic, strong) BMKPointAnnotation *pointAnnotation;
@property (nonatomic, strong) BMKMapView *mapView;

@property (nonatomic, strong) UIView *topView;

@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;

@end
