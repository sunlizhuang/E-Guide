//
//  LLSameCityViewController.m
//  LLRiseTabBarDemo
//
//  Created by Meilbn on 10/18/15.
//  Copyright © 2015 meilbn. All rights reserved.
//

#import "LLSameCityViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"
#import "Danmu.h"
@interface LLSameCityViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property(nonatomic,strong)CLLocationManager *mgr;
@property(nonatomic,strong)UITapGestureRecognizer *mTap ;
@property(nonatomic)NSInteger taped ;
@end

@implementation LLSameCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.taped = 0 ;
    self.mgr = [CLLocationManager new];
    if([self.mgr respondsToSelector:@selector(requestAlwaysAuthorization)]){
        [self.mgr requestAlwaysAuthorization];
        
    }
    self.mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
    self.mapView.delegate = self;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
//    UIButton * btn = [[UIButton alloc]init] ;
//    btn.frame = CGRectMake(100, 200, 50, 50) ;
//    btn.backgroundColor = [UIColor blueColor] ;
//    [btn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside] ;
//    [self.view addSubview:btn] ;
    
    

    
}
-(void)push {
    //地图触摸事件
    if (self.taped == 0) {
        AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
        myDelegate.coo = [[NSMutableArray alloc]init] ;
        _mTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPress:)];
        [self.mapView addGestureRecognizer:_mTap] ;
        self.taped = 1 ;
    }else {
        
        [self.mapView removeGestureRecognizer:_mTap] ;
        
        
        [self hanshu] ;
        
        self.taped = 0 ;
    }
   
}
//地图覆盖物的代理方法
-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
    
    renderer.strokeColor = [UIColor redColor];
    
    renderer.lineWidth = 4.0;
    
    return  renderer;
}
//标注的代理方法
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    MKPinAnnotationView * view= [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"anno"];
    view.canShowCallout=YES;
    return view;
}
-(void)hanshu {
    //导航设置
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    
    CLLocation * from  = myDelegate.coo[0] ;
    CLLocation * to = myDelegate.coo[1] ;
    CLLocationCoordinate2D fromcoor=CLLocationCoordinate2DMake(from.coordinate.latitude, from.coordinate.longitude);
    CLLocationCoordinate2D tocoor = CLLocationCoordinate2DMake(to.coordinate.latitude, to.coordinate.longitude);
    //创建出发点和目的点信息
    MKPlacemark *fromPlace = [[MKPlacemark alloc] initWithCoordinate:fromcoor
                                                   addressDictionary:nil];
    MKPlacemark *toPlace = [[MKPlacemark alloc]initWithCoordinate:tocoor addressDictionary:nil];
    //创建出发节点和目的地节点
    MKMapItem * fromItem = [[MKMapItem alloc]initWithPlacemark:fromPlace];
    MKMapItem * toItem = [[MKMapItem alloc]initWithPlacemark:toPlace];
    //初始化导航搜索请求
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc]init];
    request.source=fromItem;
    request.destination=toItem;
    
    request.requestsAlternateRoutes=YES;
    //初始化请求检索
    MKDirections *directions = [[MKDirections alloc]initWithRequest:request];
    //开始检索，结果会返回在block中
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        if (error) {
            NSLog(@"error:%@",error);
        }else{
            //提取导航线路结果中的一条线路
            MKRoute *route =response.routes[0];
            //将线路中的每一步详情提取出来
            NSArray * stepArray = [NSArray arrayWithArray:route.steps];
            //进行遍历
            for (int i=0; i<stepArray.count; i++) {
                //线路的详情节点
                MKRouteStep * step = stepArray[i];
                //在此节点处添加一个大头针
                MKPointAnnotation * point = [[MKPointAnnotation alloc]init];
                point.coordinate=step.polyline.coordinate;
                point.title=step.instructions;
                point.subtitle=step.notice;
                [_mapView addAnnotation:point];
                //将此段线路添加到地图上
                [_mapView addOverlay:step.polyline];
            }
        }
    }];
}

- (void)tapPress:(UIGestureRecognizer*)gestureRecognizer {
    
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];//这里touchPoint是点击的某点在地图控件中的位置
    CLLocationCoordinate2D touchMapCoordinate =
    [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];//这里touchMapCoordinate就是该点的经纬度了
    
    NSLog(@"touching %f,%f",touchMapCoordinate.latitude,touchMapCoordinate.longitude);
    MKPointAnnotation * point = [[MKPointAnnotation alloc]init];
    point.coordinate=touchMapCoordinate ;
    [_mapView addAnnotation:point];
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    
    
    CLLocation * loc = [[CLLocation alloc]initWithLatitude:touchMapCoordinate.latitude longitude:touchMapCoordinate.longitude] ;
    [myDelegate.coo addObject:loc] ;
    
    

    
}


-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    userLocation.title = @"我的位置";
    userLocation.subtitle = @"浙江大学(海宁国际校区)";
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)canting:(UIButton *)sender {
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = @"美食";
    request.region = self.mapView.region;
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            for (MKMapItem *mapItem in response.mapItems) {
                //打印出周围 名字 经度 纬度
                NSLog(@"%@ %g %g", mapItem.name,mapItem.placemark.location.coordinate.latitude,mapItem.placemark.location.coordinate.longitude);
                MKPointAnnotation * point = [[MKPointAnnotation alloc]init];
                point.coordinate=mapItem.placemark.location.coordinate;
                point.title=mapItem.name;
                
                [_mapView addAnnotation:point];
            }
            
        }
    }];
    
}
- (IBAction)zhusu:(UIButton *)sender {
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = @"住宿";
    request.region = self.mapView.region;
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            for (MKMapItem *mapItem in response.mapItems) {
                //打印出周围 名字 经度 纬度
                NSLog(@"%@ %g %g", mapItem.name,mapItem.placemark.location.coordinate.latitude,mapItem.placemark.location.coordinate.longitude);
                MKPointAnnotation * point = [[MKPointAnnotation alloc]init];
                point.coordinate=mapItem.placemark.location.coordinate;
                point.title=mapItem.name;
                
                [_mapView addAnnotation:point];
            }
            
        }
    }];
}

- (IBAction)gouwu:(UIButton *)sender {
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = @"购物";
    request.region = self.mapView.region;
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            for (MKMapItem *mapItem in response.mapItems) {
                //打印出周围 名字 经度 纬度
                NSLog(@"%@ %g %g", mapItem.name,mapItem.placemark.location.coordinate.latitude,mapItem.placemark.location.coordinate.longitude);
                MKPointAnnotation * point = [[MKPointAnnotation alloc]init];
                point.coordinate=mapItem.placemark.location.coordinate;
                point.title=mapItem.name;
                
                [_mapView addAnnotation:point];
            }
            
        }
    }];
}

- (IBAction)cesuo:(UIButton *)sender {
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = @"厕所";
    request.region = self.mapView.region;
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            for (MKMapItem *mapItem in response.mapItems) {
                //打印出周围 名字 经度 纬度
                NSLog(@"%@ %g %g", mapItem.name,mapItem.placemark.location.coordinate.latitude,mapItem.placemark.location.coordinate.longitude);
                MKPointAnnotation * point = [[MKPointAnnotation alloc]init];
                point.coordinate=mapItem.placemark.location.coordinate;
                point.title=mapItem.name;
                
                [_mapView addAnnotation:point];
            }
            
        }
    }];
}

- (IBAction)tingchewei:(UIButton *)sender {
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = @"停车";
    request.region = self.mapView.region;
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            for (MKMapItem *mapItem in response.mapItems) {
                //打印出周围 名字 经度 纬度
                NSLog(@"%@ %g %g", mapItem.name,mapItem.placemark.location.coordinate.latitude,mapItem.placemark.location.coordinate.longitude);
                MKPointAnnotation * point = [[MKPointAnnotation alloc]init];
                point.coordinate=mapItem.placemark.location.coordinate;
                point.title=mapItem.name;
                
                [_mapView addAnnotation:point];
            }
            
        }
    }];
}

- (IBAction)chongdingwei:(UIButton *)sender {
    NSLog(@"");
    //地图触摸事件
    if (self.taped == 0) {
        AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
        myDelegate.coo = [[NSMutableArray alloc]init] ;
        _mTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPress:)];
        [self.mapView addGestureRecognizer:_mTap] ;
        self.taped = 1 ;
    }else {
        
        [self.mapView removeGestureRecognizer:_mTap] ;
        
        
        [self hanshu] ;
        
        self.taped = 0 ;
    }
}

- (IBAction)LIuyan:(UIButton *)sender {
    Danmu *dm = [[Danmu alloc]init];
     [self presentViewController:dm animated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
