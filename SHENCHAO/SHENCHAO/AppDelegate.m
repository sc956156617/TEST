//
//  AppDelegate
//  SHENCHAO
//
//  Created by cb on 2017/6/8.
//  Copyright © 2017年 SC. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+APPService.h"
//#import "AppDelegate+AppLIfeCircle.h"
#import "AppDelegate+RootController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>  //坐标城市检索
#import "NSArray+Log.h"
#import "SCUserInfo.h"
#import "CityTools.h"
#import "SCMovieController.h"
#import "WRNavigationBar.h"
UIColor *MainNavBarColor = nil;
UIColor *MainViewColor = nil;
@interface AppDelegate ()<BMKGeneralDelegate, BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate>
{
    BMKMapManager       *_mapManager;
    BMKLocationService  *_locService;
    BMKGeoCodeSearch    *_geocodeSearch;
    CLLocationManager   *_locationManager;
    BOOL                 _isUserLocationEnabled;
}
@end





@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self prepareData];
    [self  setNavBarAppearence];
    [self setAppWindowsWithTpe:SCRootControllerEdgeSlide]; //设置大框架为侧滑模式
//    [self registerBugly]; //搭建日志系统并使用
    [self setChangSkinTheme];  //换肤功能
    [self  setBaiduMapLocation];
    [SCUserDefaults setObject:self.UUID forKey:@USERDEPENDS];   // 保存设备号

    [[NSNotificationCenter defaultCenter]postNotificationName:kNotificationLocation object:nil];

    
//#if defined(DEBUG) && DEBUG
//    SCMovieController * movie = [NSClassFromString(@"SCMovieController") new];
//    [movie initWith:SCMovieStyleImage];
//    [self debugRootwith:movie];
//        [self debugRootwith:[NSClassFromString(@"SCWhichEnterpriseViewController") new]];
    return YES;
//#endif
   
}
-(void)prepareData{
[CityTools share].fromCity = @"北京";
[CityTools share].toCity   = @"北京";
}
- (void)setNavBarAppearence
{
    MainNavBarColor = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
    MainViewColor   = [UIColor colorWithRed:126/255.0 green:126/255.0 blue:126/255.0 alpha:1];
    
    // 设置导航栏默认的背景颜色
    [UIColor wr_setDefaultNavBarBarTintColor:MainNavBarColor];
    // 设置导航栏所有按钮的默认颜色
    [UIColor wr_setDefaultNavBarTintColor:SCThemeColor];
    // 设置导航栏标题默认颜色
    [UIColor wr_setDefaultNavBarTitleColor:[UIColor whiteColor]];
    // 统一设置状态栏样式
    [UIColor wr_setDefaultStatusBarStyle:UIStatusBarStyleLightContent];
    // 如果需要设置导航栏底部分割线隐藏，可以在这里统一设置
     [UIColor wr_setDefaultNavBarShadowImageHidden:YES];
}
- (QPStartModel *)startInfoEntity {
    if (!_startInfoEntity) {
        _startInfoEntity = [[QPStartModel alloc] init];
        
    }
    return _startInfoEntity;
}
#pragma mark - 添加百度地图定位功能BaiduMapAPI
- (void)setBaiduMapLocation {
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationMethod) name:kNotificationLocation object:nil];
    _isUserLocationEnabled = YES;
    if (IOS8_OR_LATER) {
        
        //由于IOS8中定位的授权机制改变 需要进行手动授权
        _locationManager = [[CLLocationManager alloc] init];
        //获取授权认证
        [_locationManager requestWhenInUseAuthorization];
    }
    
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:kBaiduMapKey  generalDelegate:self];
    if (!ret) {
        _isUserLocationEnabled = NO;
        //        DDLogDebug(@"manager start failed!");
    }
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    _locService.distanceFilter = 100.f;
    _locService.delegate = self;
    
}

#pragma mark - BMKGeneralDelegate  网络失败和授权错误
- (void)onGetNetworkState:(int)iError {
    _isUserLocationEnabled = (iError==BMKErrorOk);
}

- (void)onGetPermissionState:(int)iError {
    
    _isUserLocationEnabled = iError ? NO : YES;
    
    if (_isUserLocationEnabled) {
        //启动LocationService
        [_locService startUserLocationService];
    }
}

#pragma mark - BMKLocationServiceDelegate

- (void)willStartLocatingUser{
    self.startInfoEntity.city = @"海淀区";
    self.startInfoEntity.searchCity = @"海淀区";
    [[NSNotificationCenter defaultCenter] postNotificationName:kStartRequestNotification object:nil];
}

- (void)didStopLocatingUser{
    self.startInfoEntity.city = @"海淀区";
    self.startInfoEntity.searchCity = @"海淀区";
    [[NSNotificationCenter defaultCenter] postNotificationName:kStartRequestNotification object:nil];
}

//实现相关delegate 处理位置信息更新
- (void)didFailToLocateUserWithError:(NSError *)error {
    //     关闭定位服务
    [_locService stopUserLocationService];
    //定位失败，默认城市：海淀区
    self.startInfoEntity.city = @"海淀区";
    self.startInfoEntity.searchCity = @"海淀区";
    [[NSNotificationCenter defaultCenter] postNotificationName:kStartRequestNotification object:nil];
}

- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation {
//    DDLogDebug(@"");
//    DDLogDebug(@"heading is %@",userLocation.heading);
}

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    
    [_locService stopUserLocationService];
    CLLocation *location = userLocation.location;
//    DDLogDebug(@"定位: lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    //判断是否有新位置信息
    if (location&&!(location.coordinate.latitude == self.startInfoEntity.latitude && location.coordinate.longitude == self.startInfoEntity.latitude)) {
        
        self.startInfoEntity.latitude = userLocation.location.coordinate.latitude;
        self.startInfoEntity.longitude = userLocation.location.coordinate.longitude;
        
        //位置信息   114.173022,22.310196
        CLLocationCoordinate2D pos = (CLLocationCoordinate2D){userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude};
        if (!_geocodeSearch) {
            
            BMKGeoCodeSearch *geocodeSearch = [[BMKGeoCodeSearch alloc]init];
            //设置代理
            geocodeSearch.delegate = self;
            _geocodeSearch = geocodeSearch;
        }
        //生成检索参数对象
        BMKReverseGeoCodeOption *option = [[BMKReverseGeoCodeOption alloc]init];
        option.reverseGeoPoint = pos;
        [_geocodeSearch reverseGeoCode:option];
    }
    
}

- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    
    if (error == 0) {
        _geocodeSearch.delegate = nil;
        _geocodeSearch = nil;
        if (![result.addressDetail.city isEqualToString:@""]) {
            NSString *address = nil;
            if ([result.address length]) {
                address = result.address;
            }else {
                address = [NSString stringWithFormat:@"%@%@%@%@",result.addressDetail.province,result.addressDetail.city,result.addressDetail.district,result.addressDetail.streetName];
            }
            
            self.startInfoEntity.userAddress = address;
            NSString *city = nil;
            if ([result.addressDetail.city isEqualToString:@"海南省直辖县级行政单位"] || [result.addressDetail.city isEqualToString:@"北京市"] || [result.addressDetail.city isEqualToString:@"上海市"] || [result.addressDetail.city isEqualToString:@"天津市"] || [result.addressDetail.city isEqualToString:@"重庆市"]) {
                city = result.addressDetail.district;
            }else if([result.addressDetail.city isEqualToString:@"香港特别行政区"] || [result.addressDetail.city isEqualToString:@"澳门特别行政区"]) {
                city = [result.addressDetail.city substringToIndex:2];
            } else if ([result.addressDetail.province isEqualToString:@"台湾省"]){
                city = [result.addressDetail.province substringToIndex:2];
            } else if ([result.addressDetail.city isEqualToString:@"三沙市"]){
                city = @"西南中沙";
            } else {
                city = [result.addressDetail.city substringToIndex:result.addressDetail.city.length-1];
            }
            self.startInfoEntity.city = city;
            self.startInfoEntity.searchCity = city;
        }
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kStartRequestNotification object:nil];
}

#pragma mark - NotificationReceive Method
- (void)locationMethod {
    //启动LocationService
    [_locService startUserLocationService];
}- (void)applicationWillResignActive:(UIApplication *)application {
}


- (void)applicationDidEnterBackground:(UIApplication *)application {

}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    //验证换取token
    SCUserInfo * model = [SCUserInfo getUserModel];
    NSLog(@"%@",model.token);
    if (model.token) {
        [CCPNetworking  getOrPostWithType:POST WithUrl:[NSString stringWithFormat:@"%@%@",HTTPHEADER,GETRTOKEMN]
                                   params:@{@"token" : model.token
                                            }
                          loadingImageArr:nil toShowView:nil
                                  success:^(id response) {
                                      if([response[@"code"]  isEqual: @1001]){
                                          NSLog(@"%@",response);
                                          [SCUserDefaults setObject:response[@"info"][@"token"] forKey:@USERTOKEN];
                                      }
                                  } fail:^(NSError *error) {
                                  } showHUD:1];
    }
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
