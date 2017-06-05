//
//  MKAnotation.h
//  MKMap
//
//  Created by gw on 2017/6/2.
//  Copyright © 2017年 VS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MKinAnnotation : NSObject<MKAnnotation>

@property (nonatomic ,assign) CLLocationCoordinate2D coordinate;
@property (nonatomic ,copy)NSString * title;
@property (nonatomic ,copy)NSString * subtitle;
@property (nonatomic ,strong)UIImage * image;

@end
