//
//  LLUtils+Popover.m
//  LLWeChat
//
//  Created by GYJZH on 9/11/16.
//  Copyright © 2016 GYJZH. All rights reserved.
//

#import "LLUtils+Popover.h"
#import "UIKit+LLExt.h"

@implementation LLUtils (Popover)

+ (UIViewController *)mostFrontViewController {
    UIViewController *vc = [self rootViewController];
    while (vc.presentedViewController) {
        vc = vc.presentedViewController;
    }
    return vc;
}


+ (void)showMessageAlertWithTitle:(NSString *)title message:(NSString *)message {
    [self showMessageAlertWithTitle:title message:message actionTitle:@"确定" actionHandler:nil];
}

+ (void)showMessageAlertWithTitle:(NSString *)title message:(NSString *)message actionTitle:(NSString *)actionTitle {
    [self showMessageAlertWithTitle:title message:message actionTitle:actionTitle actionHandler:nil];
}

+ (void)showMessageAlertWithTitle:(NSString *)title message:(NSString *)message actionTitle:(NSString *)actionTitle actionHandler:(void (^ __nullable)())actionHandler {
    //IOS8.0及以后，采用UIAlertController
    if ([LLUtils systemVersion] >= 8.0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action;
        if (actionHandler) {
            action = [UIAlertAction actionWithTitle:actionTitle
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction *action){
                                                actionHandler();
                                            }];
        }else {
            action = [UIAlertAction actionWithTitle:actionTitle
                                              style:UIAlertActionStyleCancel
                                            handler:nil];
        }
        
        [alertController addAction:action];
        
        [[self mostFrontViewController] presentViewController:alertController animated:YES completion:nil];
        
    }
    
}

+ (void)showConfirmAlertWithTitle:(NSString *)title message:(NSString *)message yesTitle:(NSString *)yesTitle yesAction:(void (^ __nullable)())yesAction {
    [self showConfirmAlertWithTitle:title message:message yesTitle:yesTitle yesAction:yesAction cancelTitle:@"取消" cancelAction:nil];
}

+ (void)showConfirmAlertWithTitle:(NSString *)title message:(NSString *)message yesTitle:(NSString *)yesTitle yesAction:(void (^ __nullable)())yesAction cancelTitle:(NSString *)cancelTitle cancelAction:(void (^ __nullable)())cancelAction {
    [self showConfirmAlertWithTitle:title message:message firstActionTitle:yesTitle firstAction:yesAction secondActionTitle:cancelTitle secondAction:cancelAction];
}

+ (void)showConfirmAlertWithTitle:(NSString *)title message:(NSString *)message firstActionTitle:(NSString *)firstActionTitle firstAction:(void (^ __nullable)())firstAction secondActionTitle:(NSString *)secondActionTitle secondAction:(void (^ __nullable)())secondAction {
    //IOS8.0及以后，采用UIAlertController
    if ([LLUtils systemVersion] >= 8.0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:firstActionTitle
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action){
                                                           if (firstAction)
                                                               firstAction();
                                                       }];
        
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:secondActionTitle
                                                          style:UIAlertActionStyleCancel
                                                        handler:^(UIAlertAction *action) {
                                                            if (secondAction)
                                                                secondAction();
                                                        }];
        
        [alertController addAction:action];
        [alertController addAction:action2];
        
        [[self mostFrontViewController] presentViewController:alertController animated:YES completion:nil];
        
    }
}


+ (void)showTipView:(UIView<LLTipDelegate> *)view {
    [LLTipView showTipView:view];
}

+ (void)hideTipView:(UIView<LLTipDelegate> *)tipView {
    [LLTipView hideTipView:tipView];
}

#pragma mark - HUD -

+ (UIView *)defaultHUDView {
    static UIView *containerView;
    if (!containerView) {
        containerView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    
    return containerView;
}


+ (SCProgressHUD *)progressHUDInView:(UIView *)view {
    UIView *hudView = view;
    if (!hudView) {
        hudView = [self defaultHUDView];
        if (!hudView.superview) {
            [LLUtils addViewToPopOverWindow:hudView];
        }
        hudView.frame = [UIScreen mainScreen].bounds;
        [hudView.superview bringSubviewToFront:hudView];
    }
    
    SCProgressHUD *HUD = [[SCProgressHUD alloc] initWithView:hudView];
    [hudView addSubview:HUD];
    HUD.removeFromSuperViewOnHide = YES;
    HUD.delegate = [self sharedUtils];
       
    return HUD;
}

+ (SCProgressHUD *)showActionSuccessHUD:(NSString *)title {
    return [self showActionSuccessHUD:title inView:nil];
}

+ (SCProgressHUD *)showActionSuccessHUD:(NSString *)title inView:(UIView *)view {
    SCProgressHUD *HUD = [self progressHUDInView:view];
    
    HUD.mode = SCProgressHUDModeCustomView;
    UIImage *image = [UIImage imageNamed:@"operationbox_successful"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    HUD.customView = [[UIImageView alloc] initWithImage:image];
    HUD.square = YES;
    HUD.margin = 8;
    HUD.minSize = CGSizeMake(120, 120);
    
    HUD.bezelView.style = SCProgressHUDBackgroundStyleSolidColor;
    HUD.bezelView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    HUD.label.text = title;
    HUD.label.font = [UIFont systemFontOfSize:14];
    HUD.contentColor = [UIColor colorWithWhite:1 alpha:1];
    
    [HUD layoutIfNeeded];
    HUD.label.top_LL += 10;
    
    [HUD showAnimated:YES];
    [HUD hideAnimated:YES afterDelay:2];
    
    return HUD;
    
}

+ (SCProgressHUD *)showTextHUD:(NSString *)text {
    return [self showTextHUD:text inView:nil];
}

+ (SCProgressHUD *)showTextHUD:(NSString *)text inView:(nullable UIView *)view {
    SCProgressHUD *HUD = [self progressHUDInView:view];
    
    HUD.mode = SCProgressHUDModeText;
    HUD.margin = 8;
    HUD.minSize = CGSizeMake(120, 30);
    
    HUD.bezelView.style = SCProgressHUDBackgroundStyleSolidColor;
    HUD.bezelView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    HUD.contentColor = [UIColor colorWithWhite:1 alpha:1];
    
    HUD.label.text = text;
    HUD.label.font = [UIFont systemFontOfSize:15];
    
    [HUD layoutIfNeeded];
    HUD.bezelView.bottom_LL = CGRectGetHeight(HUD.superview.bounds) - 60;
    
    [HUD showAnimated:YES];
    [HUD hideAnimated:YES afterDelay:2];
    
    return HUD;
}

+ (SCProgressHUD *)showCircleProgressHUDInView:(UIView *)view {
    SCProgressHUD *HUD = [self progressHUDInView:view];
    
    HUD.mode = SCProgressHUDModeDeterminate;
    HUD.margin = 8;
    HUD.square = YES;
    HUD.minSize = CGSizeMake(120, 120);
    
    [HUD showAnimated:YES];
    
    return HUD;
}

+ (SCProgressHUD *)showActivityIndicatiorHUDWithTitle:(NSString *)title {
    return [self showActivityIndicatiorHUDWithTitle:title inView:nil];
}

+ (SCProgressHUD *)showActivityIndicatiorHUDWithTitle:(NSString *)title inView:(UIView *)view {
    SCProgressHUD *HUD = [self progressHUDInView:view];
    
    HUD.mode = SCProgressHUDModeIndeterminate;
    HUD.margin = 8;
    HUD.minSize = CGSizeMake(120, 120);
    
    HUD.bezelView.style = SCProgressHUDBackgroundStyleSolidColor;
    HUD.bezelView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    HUD.label.text = title;
    HUD.label.font = [UIFont systemFontOfSize:14];
    HUD.contentColor = [UIColor colorWithWhite:1 alpha:1];
    
    [HUD layoutIfNeeded];
    HUD.label.top_LL += 10;
    
    [HUD showAnimated:YES];
    
    return HUD;
}

+ (void)hideHUD:(SCProgressHUD *)HUD animated:(BOOL)animated {
    HUD.removeFromSuperViewOnHide = YES;
    if (!HUD.delegate)
        HUD.delegate = [self sharedUtils];
    [HUD hideAnimated:animated];
}

- (void)hudWasHidden:(SCProgressHUD *)hud {
    UIView *hudView = [LLUtils defaultHUDView];
    
    if (hudView.subviews.count == 0) {
        if (hudView.window == [LLUtils popOverWindow]) {
            [LLUtils removeViewFromPopOverWindow:hudView];
        }else {
            [hudView removeFromSuperview];
        }
    }
}

@end
