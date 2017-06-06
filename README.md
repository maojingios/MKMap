# 情景
* 项目中需要获取玩家的定位信息，上传给服务器，用于计算玩家之间的距离。一开始，让我联想起滴滴约车的场景，地图上显示一辆很cute的小车，慢慢向你靠近，还是蛮有意思的。<br> 再向策划确定我们的业务后，基本可以确定，只用获取用户定位信息即可，不用实时显示用户位置信息（理由是：怕用户之间相互拉仇恨后，直接冲到对方家里😀）！功能目前已经是稳定接入，得空还是把定位、编码、点击添加自定义大头针（包括从天而降的效果）实现，在这里跟大家分享，不足之处，望指正！😀

# 内容
* iOS从6.0开始地图数据不再由谷歌驱动，而是改用自家地图，在国内它的数据是由高德地图提供的。这样一来，如果在iOS6.0之前进行地图开发的话使用方法会有所不同，基于目前的情况其实使用iOS6.0之前版本的系统基本已经寥寥无几了，所有在接下来的内容中不会再针对iOS5及之前版本的地图开发进行介绍。在iOS中进行地图开发主要有两种方式，一种是直接利用MapKit框架进行地图开发，利用这种方式可以对地图进行精准的控制；另一种方式是直接调用苹果官方自带的地图应用，主要用于一些简单的地图应用（例如：进行导航覆盖物填充等），无法进行精确的控制。这里使用的是MapKit框架进行开发。


### 效果图
    ![](https://github.com/maojingios/MKMap/blob/master/MKMap/MKMapLocation.gif)


### 1.配置info.plist

      可以通过配置NSLocationAlwaysUsageDescription或者NSLocationWhenInUseUsageDescription来告诉用户使用定位服务的目的，并且注意这个配置是必须
      的，如果不进行配置则默认情况下应用无法使用定位服务，打开应用不会给出打开定位服务的提示，除非安装后自己设置此应用的定位服务。
         
### 2.引入头文件

     #import <CoreLocation/CoreLocation.h>
     #import <MapKit/MapKit.h> 
     
### 3.判断

      if (![CLLocationManager locationServicesEnabled]) {//判断定位是否可用
          NSLog(@"please open location service");
      }
      if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {//用户授权
          [_locationManager requestWhenInUseAuthorization];
      }else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusAuthorizedWhenInUse){
          _locationManager.delegate = self;
          _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
          CLLocationDistance distance = 0.5;
          _locationManager.distanceFilter = distance;
          [_locationManager startUpdatingLocation];
      } 
### 4.实现自定义大头针

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
      
      
### 5.优化（使用过程中会发现内存暴增）

      #pragma mark - 显示区域发生变化时调用
      -(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
          //内存优化
          [_mapView removeFromSuperview];
          [self.view addSubview:_mapView];
      }

# 总结

以上是需要注意的几点，涉及权限设置、大头针的复用和自定义（是不是想起了UITableViewCell的复用）、以及内存优化！为比较基础的内容。希望大家多多指教。


