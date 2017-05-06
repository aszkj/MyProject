//
//  BaiduMapViewController.h
//  WeimiSP
//
//  Created by thinker on 16/2/25.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface BaiduMapViewController : UIViewController

@property (nonatomic, assign) CLLocationCoordinate2D currentCoordinate;
@property (nonatomic, strong) NSString *annotationTitle;

@property (nonatomic, strong) BMKMapView *mapView;

@end
