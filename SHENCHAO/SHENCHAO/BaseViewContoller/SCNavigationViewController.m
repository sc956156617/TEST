//
//  SCNavigationViewController.m
//  SHENCHAO
//
//  Created by cb on 2017/6/15.
//  Copyright © 2017年 SC. All rights reserved.
//

#import "SCNavigationViewController.h"
#import "UIBarButtonItem+Item.h"

@interface SCNavigationViewController ()<UIGestureRecognizerDelegate>

@end

@implementation SCNavigationViewController
+ (void)initialize
{
//        UIImage *bgImage = [self imageWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64) alphe:1.0];
//        [self setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
    
    [UINavigationBar appearance].barTintColor = [UIColor  whiteColor];;
    [UINavigationBar appearance].translucent = NO;
    [UINavigationBar appearance].shadowImage = [[UIImage alloc] init];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    //return    UIStatusBarStyleDefault;
    return  UIStatusBarStyleDefault;// 黑色
    //    return   UIStatusBarStyleLightContent;// 白色
    
}
- (BOOL)prefersStatusBarHidden {
    return false;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //再定义一个imageview来等同于这个黑线
    //    UIImageView *navBarHairlineImageView;
    //    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationBar];
    //
    
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationBar.translucent = NO;
    //    self.interactivePopGestureRecognizer.delegate = self;
    ////    self.navigationBar.tintColor = [UIColor darkGrayColor];
    self.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:SCThemeColor, NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:AdapationLabelFont(18)],NSFontAttributeName,nil];
    //
    ////    self.navigationBar.backgroundColor = kThemeColor;
    
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) { // 如果viewController不是最早push进来的子控制器
        // 左上角
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"icon-return"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backButton sizeToFit];
        // 这句代码放在sizeToFit后面
        backButton.frame = CGRectMake(15, 19, 30, 26);
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
        // 隐藏底部的工具条
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    // 所有设置搞定后, 再push控制器
    [super pushViewController:viewController animated:animated];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <UIGestureRecognizerDelegate>

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //    if (self.childViewControllers.count == 1) { // 导航控制器中只有1个子控制器
    //        return NO;
    //    }
    //    return YES;
    
    // 手势何时有效 : 当导航控制器的子控制器个数 > 1就有效
    return self.childViewControllers.count > 1;
}




////解决导航栏颜色变浅问题
//- (UIImage *) imageWithFrame:(CGRect)frame alphe:(CGFloat)alphe {
//    frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
//    UIColor *redColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:alphe];
//    UIGraphicsBeginImageContext(frame.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, [redColor CGColor]);
//    CGContextFillRect(context, frame);
//    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return theImage;
//}
#pragma mark 导航栏下方的黑线改变样式
//通过一个方法来找到这个黑线(findHairlineImageViewUnder):
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        view.backgroundColor =SCThemeColor;
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            imageView.backgroundColor =SCThemeColor;
            return imageView;
        }
    }
    return nil;
}

@end
