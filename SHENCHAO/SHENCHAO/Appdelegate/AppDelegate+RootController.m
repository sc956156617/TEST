
//
//  AppDelegate+RootController.m
//  Magazine
//
//  Created by cb on 2017/6/13.
//  Copyright © 2017年 SC. All rights reserved.
//

#import "AppDelegate+RootController.h"
#import "AppDelegate+APPService.h"

#import "RDVTabBarController.h"  //公共tabbar
#import "RDVTabBarItem.h"

#import "MainPageViewController.h" //侧滑主界面
#import "LeftSortsViewController.h" //侧滑左侧界面


#import "MyCollectViewController.h"

@implementation AppDelegate (RootController)



-(void)debugRootwith:(id)VC{
    self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:VC];
}


- (void)setRootViewControllerWithType:(SCRootControllerType) type
{
    if ([SCUserDefaults objectForKey:FIRST_LOGIN])
    {//不是第一次安装
        [self checkBlack];
        [self setRootWithType:type];
    }
    else
    { //第一次安装
        UIViewController *emptyView = [[ UIViewController alloc ]init ];
        self.window.rootViewController = emptyView;
        [self createLoadingScrollView];
    }
}
//  下面的方法只是定义一下rootViewController即可。自定义tababr集成于 viewcontroller所以可以
- (void)setRootWithType:(SCRootControllerType)type
{
    switch (type) {
        case SCRootControllerTabar:
        {
            SCNavigationViewController * navc = [[SCNavigationViewController alloc] initWithRootViewController:self.rootViewController];
            self.window.rootViewController = navc;
        }
            break;
        case SCRootControllerEdgeSlide:
        {
//            UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:self.rootViewController];
            self.window.rootViewController = self.rootViewController;
        }
            break;
        case SCRootControllerViewControlelr:
        {
            self.window.rootViewController = self.rootViewController;
        }
            break;
        default:
            break;
    }
}
#pragma mark - 侧滑sliderviewcontroller
-(void)setSliderViewControlelr{

    MainPageViewController *mainVC = [[MainPageViewController alloc] init];
    self.mainNavigationController = [[UINavigationController alloc] initWithRootViewController:mainVC];
    LeftSortsViewController *leftVC = [[LeftSortsViewController alloc] init];
//    UINavigationController * left = [[UINavigationController alloc] initWithRootViewController:leftVC];
    self.LeftSlideVC = [[LeftSlideViewController alloc] initWithLeftView:leftVC andMainView:self.mainNavigationController];
    self.rootViewController = self.LeftSlideVC;
}



#pragma mark - TabbarViewController
- (void)setTabbarControllerWith:(NSArray *)controllers
{

//    NSMutableArray * naviRoots=[NSMutableArray array];
    for (UIViewController *controller in controllers) {
//        SCNavigationViewController *chidNav = [[SCNavigationViewController alloc]initWithRootViewController:controller];
        controller.title = @"wefedf";
//        [naviRoots addObject:chidNav];
    }
    
    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
//    tabBarController.delegate = self;
    [tabBarController setViewControllers:controllers];
    [self customizeTabBarForController:tabBarController];
     self.rootViewController = tabBarController;
    
}
-(void)colseLeftView{
    [self.LeftSlideVC  closeLeftView];
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"first", @"second", @"third"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        index++;
    }
}
- (void)customizeInterface {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    
    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        backgroundImage = [UIImage imageNamed:@"navigationbar_background_tall"];
        
        textAttributes = @{
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
                           NSForegroundColorAttributeName: [UIColor blackColor],
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        backgroundImage = [UIImage imageNamed:@"navigationbar_background"];
        
        textAttributes = @{
                           UITextAttributeFont: [UIFont boldSystemFontOfSize:18],
                           UITextAttributeTextColor: [UIColor blackColor],
                           UITextAttributeTextShadowColor: [UIColor clearColor],
                           UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    
    [navigationBarAppearance setBackgroundImage:backgroundImage
                                  forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}



#pragma mark window
- (void)setAppWindowsWithTpe:(SCRootControllerType)type
{
    
//    self.type = 2;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    switch (type) {
        case SCRootControllerTabar:
        {
            UIViewController * first = [UIViewController new];
            UIViewController * second = [UIViewController new];
            UIViewController * third = [UIViewController new];
            [self setTabbarControllerWith:@[first,second,third]];

        }
            break;
        case SCRootControllerEdgeSlide:
        {
            [self setSliderViewControlelr];
            
        }
            break;
        case SCRootControllerViewControlelr:
        {
            
            
        }
          break;
        default:
            break;
    }
    
    [self setRootViewControllerWithType:type];

}
#pragma mark - 引导页
- (void)createLoadingScrollView
{//引导页
    UIScrollView *sc = [[UIScrollView alloc]initWithFrame:self.window.bounds];
    sc.pagingEnabled = YES;
    sc.delegate = self;
    sc.showsHorizontalScrollIndicator = NO;
    sc.showsVerticalScrollIndicator = NO;
    [self.window.rootViewController.view addSubview:sc];
    
    NSArray *arr = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg"];
    for (NSInteger i = 0; i<arr.count; i++)
    {
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenW*i, 0, kScreenW, self.window.frame.size.height)];
        img.image = [UIImage imageNamed:arr[i]];
        [sc addSubview:img];
        img.userInteractionEnabled = YES;
        if (i == arr.count - 1)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            btn.frame = CGRectMake((self.window.frame.size.width/2)-50, kScreenH-110, 100, 40);
            btn.backgroundColor = Main_Color;
            [btn setTitle:@"开始体验" forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(goToMain) forControlEvents:UIControlEventTouchUpInside];
            [img addSubview:btn];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = Main_Color.CGColor;
        }
    }
    sc.contentSize = CGSizeMake(kScreenW*arr.count, self.window.frame.size.height);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x>kScreenW *4+30)
    {
        [self goToMain];
    }
}

- (void)goToMain
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:@"isOne" forKey:FIRST_LOGIN];
    [user synchronize];
    [self setRootWithType:SCRootControllerEdgeSlide];
}





@end
