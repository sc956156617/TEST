//
//  AppDelegate+Location.m
//  SHENCHAO
//
//  Created by cb on 2017/6/23.
//  Copyright © 2017年 SC. All rights reserved.
//

#import "AppDelegate+Location.h"
//#import <UIKit/UIKit.h>
//#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
//#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
//#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>  //坐标城市检索
//@interface AppDelegate ()<BMKGeneralDelegate, BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate>
//
//@property(nonatomic,retain)BMKMapManager *mapManager;
//@property(nonatomic,retain)BMKLocationService      *locService;
//
//@property(nonatomic,retain) BMKGeoCodeSearch        *geocodeSearch;
//
//@property(nonatomic,retain) CLLocationManager       *locationManager;
//@property(nonatomic,assign) BOOL                  isUserLocationEnabled;
//@end
@implementation AppDelegate (Location)
//#pragma mark - 添加百度地图定位功能BaiduMapAPI
//- (void)setBaiduMapLocation {
//    
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationMethod) name:kNotificationLocation object:nil];
//    self.isUserLocationEnabled = YES;
//    if (IOS8_OR_LATER) {
//        
//        //由于IOS8中定位的授权机制改变 需要进行手动授权
//         self.locationManager = [[CLLocationManager alloc] init];
//        //获取授权认证
//        [ self.locationManager requestWhenInUseAuthorization];
//    }
//    
//    // 要使用百度地图，请先启动BaiduMapManager
//     self.mapManager = [[BMKMapManager alloc]init];
//    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
//    BOOL ret = [ self.mapManager start:kBaiduMapKey  generalDelegate:self];
//    if (!ret) {
//         self.isUserLocationEnabled = NO;
//        //        DDLogDebug(@"manager start failed!");
//    }
//    //初始化BMKLocationService
//     self.locService = [[BMKLocationService alloc]init];
//     self.locService.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
//    self.locService.distanceFilter = 100.f;
//     self.locService.delegate = self;
//    
//}
//
//#pragma mark - BMKGeneralDelegate  网络失败和授权错误
//- (void)onGetNetworkState:(int)iError {
//     self.isUserLocationEnabled = (iError==BMKErrorOk);
//}
//
//- (void)onGetPermissionState:(int)iError {
//    
//     self.isUserLocationEnabled = iError ? NO : YES;
//    
//    if ( self.isUserLocationEnabled) {
//        //启动LocationService
//        [ self.locService startUserLocationService];
//    }
//}
//
//#pragma mark - BMKLocationServiceDelegate
//
//- (void)willStartLocatingUser{
//    
//    self.startInfoEntity.city = @"海淀区";
//    self.startInfoEntity.searchCity = @"海淀区";
//    [[NSNotificationCenter defaultCenter] postNotificationName:kStartRequestNotification object:nil];
//}
//
//- (void)didStopLocatingUser{
//    self.startInfoEntity.city = @"海淀区";
//    self.startInfoEntity.searchCity = @"海淀区";
//    [[NSNotificationCenter defaultCenter] postNotificationName:kStartRequestNotification object:nil];
//}
//
////实现相关delegate 处理位置信息更新
//- (void)didFailToLocateUserWithError:(NSError *)error {
//    //     关闭定位服务
//    [ self.locService stopUserLocationService];
//    //定位失败，默认城市：海淀区
//    self.startInfoEntity.city = @"海淀区";
//    self.startInfoEntity.searchCity = @"海淀区";
//    [[NSNotificationCenter defaultCenter] postNotificationName:kStartRequestNotification object:nil];
//}
//
//- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation {
//    //    DDLogDebug(@"");
//    //    DDLogDebug(@"heading is %@",userLocation.heading);
//}
//
////处理位置坐标更新
//- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
//    
//    [ self.locService stopUserLocationService];
//    CLLocation *location = userLocation.location;
//    //    DDLogDebug(@"定位: lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
//    //判断是否有新位置信息
//    if (location&&!(location.coordinate.latitude == self.startInfoEntity.latitude && location.coordinate.longitude == self.startInfoEntity.latitude)) {
//        
//        self.startInfoEntity.latitude = userLocation.location.coordinate.latitude;
//        self.startInfoEntity.longitude = userLocation.location.coordinate.longitude;
//        
//        //位置信息   114.173022,22.310196
//        CLLocationCoordinate2D pos = (CLLocationCoordinate2D){userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude};
//        if (! self.geocodeSearch) {
//            
//            BMKGeoCodeSearch *geocodeSearch = [[BMKGeoCodeSearch alloc]init];
//            //设置代理
//            geocodeSearch.delegate = self;
//             self.geocodeSearch = geocodeSearch;
//        }
//        //生成检索参数对象
//        BMKReverseGeoCodeOption *option = [[BMKReverseGeoCodeOption alloc]init];
//        option.reverseGeoPoint = pos;
//        [ self.geocodeSearch reverseGeoCode:option];
//    }
//}
//
//- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
//    if (error == 0) {
//         self.geocodeSearch.delegate = nil;
//         self.geocodeSearch = nil;
//        if (![result.addressDetail.city isEqualToString:@""]) {
//            NSString *address = nil;
//            if ([result.address length]) {
//                address = result.address;
//            }else {
//                address = [NSString stringWithFormat:@"%@%@%@%@",result.addressDetail.province,result.addressDetail.city,result.addressDetail.district,result.addressDetail.streetName];
//            }
//            
//            self.startInfoEntity.userAddress = address;
//            NSString *city = nil;
//            if ([result.addressDetail.city isEqualToString:@"海南省直辖县级行政单位"] || [result.addressDetail.city isEqualToString:@"北京市"] || [result.addressDetail.city isEqualToString:@"上海市"] || [result.addressDetail.city isEqualToString:@"天津市"] || [result.addressDetail.city isEqualToString:@"重庆市"]) {
//                city = result.addressDetail.district;
//            }else if([result.addressDetail.city isEqualToString:@"香港特别行政区"] || [result.addressDetail.city isEqualToString:@"澳门特别行政区"]) {
//                city = [result.addressDetail.city substringToIndex:2];
//            } else if ([result.addressDetail.province isEqualToString:@"台湾省"]){
//                city = [result.addressDetail.province substringToIndex:2];
//            } else if ([result.addressDetail.city isEqualToString:@"三沙市"]){
//                city = @"西南中沙";
//            } else {
//                city = [result.addressDetail.city substringToIndex:result.addressDetail.city.length-1];
//            }
//            self.startInfoEntity.city = city;
//            self.startInfoEntity.searchCity = city;
//        }
//    }
//    [[NSNotificationCenter defaultCenter] postNotificationName:kStartRequestNotification object:nil];
//}
//
//#pragma mark - NotificationReceive Method
//- (void)locationMethod {
//    
//    //启动LocationService
//    [ self.locService startUserLocationService];
//}
@end
