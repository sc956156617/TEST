//
//  UIViewController+SCExtension.m
//  SHENCHAO
//
//  Created by cb on 2017/7/11.
//  Copyright © 2017年 SC. All rights reserved.
//

#import "UIViewController+SCExtension.h"
#import <objc/runtime.h>

@implementation UIViewController (SCExtension)

//
//+ (void)load{
//#ifdef DEBUG
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        //获取这个类的viewDidLoad方法，它的类型是一个objc_method结构体的指针
//        Method viewDidLoad = class_getInstanceMethod(self, @selector(viewDidLoad));
//        
//        Method viewDidLoaded = class_getInstanceMethod(self, @selector(viewDidLoaded));
//            BOOL didAddMethod = class_addMethod(self,@selector(viewDidLoad), method_getImplementation(viewDidLoaded), method_getTypeEncoding(viewDidLoaded));
//        if (didAddMethod) {
//            class_replaceMethod(self, @selector(viewDidLoaded), method_getImplementation(viewDidLoaded), method_getTypeEncoding(viewDidLoad));
//        }else{
//            method_exchangeImplementations(viewDidLoaded, viewDidLoad);
//        }
//        
//    });
//#endif
//}
//
//- (void)viewDidLoaded{
//    //调用自己原有的方法
//    self.view.backgroundColor = [UIColor whiteColor];
//    NSLog(@"%@ did load",self);
//    [self viewDidLoaded];
//    
//}

@end
