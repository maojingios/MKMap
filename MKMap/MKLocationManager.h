//
//  MKLocationManager.h
//  MKMap
//
//  Created by gw on 2017/6/5.
//  Copyright © 2017年 VS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MKLocationManager : NSObject<CLLocationManagerDelegate>


@property (nonatomic,readwrite,assign) float mkLongtitude;
@property (nonatomic,readwrite,assign) float mkLatitude;
@property (nonatomic,readwrite,assign) float mkSpeed;

@property (nonatomic,readwrite,copy) NSString * mkCity;
@property (nonatomic,readwrite,copy) NSString * mkProvince;
@property (nonatomic,readwrite,copy) NSString * mkDetaiAddress;

@property (nonatomic,readwrite,strong) NSArray <CLPlacemark *> * placeMarkArray;
@property (nonatomic,readwrite,strong) CLPlacemark * mkFirstPlaceMark;
@property (nonatomic,readwrite,strong) NSDictionary * addressDictionary;

+( __kindof MKLocationManager *)manager;

-(void)whereAmI;

@end
