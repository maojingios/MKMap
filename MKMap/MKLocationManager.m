//
//  MKLocationManager.m
//  MKMap
//
//  Created by gw on 2017/6/5.
//  Copyright © 2017年 VS. All rights reserved.
//

#import "MKLocationManager.h"

@interface MKLocationManager ()

@property (nonatomic , readwrite ,strong) CLLocationManager * locationManager;
@property (nonatomic , readwrite ,strong) MKMapView * mapView;
@property (nonatomic , readwrite ,strong) CLGeocoder * geoCoder;

@end


@implementation MKLocationManager

static MKLocationManager * _manager = nil;

+(MKLocationManager *)manager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[super allocWithZone:NULL] init];
    });
    return _manager;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    return [MKLocationManager manager];
}

-(id)copyWithZone:(struct _NSZone *)zone{
    return [MKLocationManager manager];
}

#pragma mark - Lazy Load

-(CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc]init];
    }
    return _locationManager;
}
-(MKMapView *)mapView{
    if (!_mapView) {
        _mapView = [[MKMapView alloc]init];
    }
    return _mapView;
}

-(CLGeocoder *)geoCoder{
    if (!_geoCoder) {
        _geoCoder = [[CLGeocoder alloc]init];
    }
    return _geoCoder;
}

-(void)whereAmI{
    
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"please open location service");
    }
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusAuthorizedWhenInUse){
        
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        CLLocationDistance distance = 0.5;
        self.locationManager.distanceFilter = distance;
        [self.locationManager startUpdatingLocation];
    }
}

#pragma mark - LocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    CLLocation *location=[locations firstObject];//取出第一个位置
    CLLocationCoordinate2D coordinate=location.coordinate;//位置坐标
    
    MKLocationManager * m = [MKLocationManager manager];
    m.mkLongtitude = coordinate.longitude;
    m.mkLatitude = coordinate.latitude;
    m.mkSpeed = location.speed;
    
    [self.geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        self.placeMarkArray = placemarks;
        self.mkFirstPlaceMark = [placemarks firstObject];
        self.addressDictionary = [placemarks firstObject].addressDictionary;
        
        self.mkCity = self.mkFirstPlaceMark.locality;
        self.mkProvince = self.mkFirstPlaceMark.name;
        
        NSLog(@"%@--%@--%@",[NSThread currentThread],[MKLocationManager manager].mkProvince,[MKLocationManager manager].mkCity);
    }];
    
    [_locationManager stopUpdatingLocation];//关闭定位
    
    NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
    
}

/*placemark.name;//地名
 placemark.thoroughfare;//街道
 placemark.subThoroughfare; //街道相关信息，例如门牌等
 placemark.locality; // 城市
 placemark.subLocality; // 城市相关信息，例如标志性建筑
 placemark.administrativeArea; // 州
 placemark.subAdministrativeArea; //其他行政区域信息
 placemark.postalCode; //邮编
 placemark.ISOcountryCode; //国家编码
 placemark.country; //国家
 placemark.inlandWater; //水源、湖泊
 placemark.ocean; // 海洋
 <NSArray *>placemark.areasOfInterest; //关联的或利益相关的地标*/



@end
