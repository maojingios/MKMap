# 情景
* 项目中需要获取玩家的定位信息，上传给服务器，用于计算玩家之间的距离。一开始，让我联想起滴滴约车的场景，地图上显示一辆很cute的小车，慢慢向你靠近，还是蛮有意思的。<br> 再向策划确定我们的业务后，基本可以确定，只用获取用户定位信息即可，不用实时显示用户位置信息（理由是：怕用户之间相互拉仇恨后，直接冲到对方家里😀）！功能目前已经是稳定接入，得空还是把定位、编码、点击添加自定义大头针（包括从天而降的效果）实现，在这里跟大家分享，不足之处，望指正！😀

# 内容
* iOS从6.0开始地图数据不再由谷歌驱动，而是改用自家地图，在国内它的数据是由高德地图提供的。这样一来，如果在iOS6.0之前进行地图开发的话使用方法会有所不同，基于目前的情况其实使用iOS6.0之前版本的系统基本已经寥寥无几了，所有在接下来的内容中不会再针对iOS5及之前版本的地图开发进行介绍。在iOS中进行地图开发主要有两种方式，一种是直接利用MapKit框架进行地图开发，利用这种方式可以对地图进行精准的控制；另一种方式是直接调用苹果官方自带的地图应用，主要用于一些简单的地图应用（例如：进行导航覆盖物填充等），无法进行精确的控制。这里使用的是MapKit框架进行开发。


### 效果图
  ![](https://github.com/maojingios/MKMap/blob/master/MKMap/MKMapLocation.gif)



