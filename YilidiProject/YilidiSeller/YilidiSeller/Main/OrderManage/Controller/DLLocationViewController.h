//
//  DLLocationViewController.h
//  YilidiSeller
//
//  Created by 曾勇兵 on 16/6/23.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLSellerBaseController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>

@interface DLLocationViewController : DLSellerBaseController<BMKMapViewDelegate,BMKLocationServiceDelegate>
{
    
    IBOutlet BMKMapView *_mapView;
    BMKLocationService* _locService;
}

@property (nonatomic,assign)CGFloat customerLatitude;
@property (nonatomic,assign)CGFloat customerLongtitude;

@property (nonatomic,strong)NSString*name;
@property (nonatomic,strong)NSString*address;


@end
