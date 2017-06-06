//
//  ViewController.m
//  MKMap
//
//  Created by gw on 2017/6/2.
//  Copyright © 2017年 VS. All rights reserved.
//

/** 物理屏幕宽高**/
#define SCREENW [UIScreen mainScreen].bounds.size.width
#define SCREENH [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "MKinAnnotation.h"
#import "MKLocationManager.h"

@interface ViewController ()<CLLocationManagerDelegate,MKMapViewDelegate>
{

    CLLocationManager * _locationManager;
    MKMapView * _mapView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self mkMapView];
    
//    [[MKLocationManager manager] whereAmI];
    

    
    
}
-(void)mkMapView{

    //地图
    _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH)];
    [self.view addSubview:_mapView];
    _mapView.delegate = self;
    
    //添加点击手势
    UILongPressGestureRecognizer * longTap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(tapAddAnnotation:)];
    [_mapView addGestureRecognizer:longTap];
    
    _locationManager = [[CLLocationManager alloc] init];
    
    //判断定位是否可用
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"please open location service");
    }
    
    //用户授权
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        
        [_locationManager requestWhenInUseAuthorization];
    }
    else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusAuthorizedWhenInUse){
        
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        CLLocationDistance distance = 0.5;
        _locationManager.distanceFilter = distance;
        [_locationManager startUpdatingLocation];
    }
    
    //用户位置追踪
    _mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    //地图类型
    _mapView.mapType = MKMapTypeStandard;
    
    //添加大头针
    [self addAnnotationToMap];

}
-(void)addAnnotationToMap{

    //location1
    CLLocationCoordinate2D location1 = CLLocationCoordinate2DMake(23.1, 113.29);
    MKinAnnotation * annotation1 = [[MKinAnnotation alloc]init];
    annotation1.title = @"彬彬哥";
    annotation1.subtitle = @"😄，我在这里！";
    annotation1.coordinate = location1;
    annotation1.image = [UIImage imageNamed:@"binImage"];
    [_mapView addAnnotation:annotation1];

    //location2
    CLLocationCoordinate2D location2 = CLLocationCoordinate2DMake(23.05, 113.28);
    MKinAnnotation * annotation2 = [[MKinAnnotation alloc] init];
    annotation2.title = @"昌哥";
    annotation2.subtitle = @"😭我在河里！";
    annotation2.coordinate = location2;
    annotation2.image = [UIImage imageNamed:@"cangImage"];
    [_mapView addAnnotation:annotation2];
    
}

#pragma mark - <点击手势，添加大头针>
-(void)tapAddAnnotation:(UITapGestureRecognizer *)sender{

    CGPoint point = [(UITapGestureRecognizer *)sender locationInView:_mapView];
    
    CLLocationCoordinate2D location3 = [_mapView convertPoint:point toCoordinateFromView:_mapView];
    
    //location2
    MKinAnnotation * annotation3 = [[MKinAnnotation alloc] init];
    annotation3.title = @"昌哥";
    annotation3.subtitle = @"😭我在河里！";
    annotation3.coordinate = location3;
    annotation3.image = [UIImage imageNamed:@"cangImage"];
    [_mapView addAnnotation:annotation3];
    
    
    
}
#pragma mark - LocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    CLLocation *location=[locations firstObject];//取出第一个位置
    CLLocationCoordinate2D coordinate=location.coordinate;//位置坐标
    NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
    //如果不需要实时定位，使用完即使关闭定位服务
//    [_locationManager stopUpdatingLocation];

}
-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading{
    NSLog(@"---%@",newHeading);

}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{


}
#pragma mark - 自定义大头针
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{

    //区别当前玩家位置
    if ([annotation isKindOfClass:[MKinAnnotation class]]) {
        
        static NSString * identify = @"annotation";
        
        MKAnnotationView * annotationView = [_mapView dequeueReusableAnnotationViewWithIdentifier:identify];
        if (!annotationView) {
            
            annotationView = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:identify];
            annotationView.canShowCallout = true;
            annotationView.calloutOffset = CGPointMake(0, 0);
            annotationView.leftCalloutAccessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"coffe"]];
        }
        
        annotationView.annotation = annotation;
        annotationView.image = ((MKinAnnotation *)annotation).image;
        
        return annotationView;
        
    }else return nil;
 

}

#pragma mark - 显示区域发生变化时调用
-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{

    //内存优化
    [_mapView removeFromSuperview];
    [self.view addSubview:_mapView];
}

#pragma mark - 添加大头针时调用
-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views{


}

@end
