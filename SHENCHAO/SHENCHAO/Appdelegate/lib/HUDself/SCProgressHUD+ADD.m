//
//  SCProgressHUD+ADD.m
//  CCPAFNNetworking
//
//  Created by DR on 16/9/9.
//  Copyright © 2016年 CCP. All rights reserved.
//

#import "SCProgressHUD+ADD.h"

@implementation SCProgressHUD (ADD)

+ (SCProgressHUD *)showInformation:(NSString *)information toView:(UIView *)view andAfterDelay:(float)afterDelay{
    
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
 
    SCProgressHUD *hud = [self showHUDAddedTo:view animated:YES];
    ;

    hud.mode = SCProgressHUDModeText;
    
    hud.label.text = information;
    
    hud.label.numberOfLines = 0;
    
    hud.offset = CGPointMake(0.f, SCProgressMaxOffset);
    
    [hud hideAnimated:YES afterDelay:afterDelay];
    
   return hud;
    
}

+ (void)showCustomview:(UIView *)customview andTextString:(NSString *)textString toView:(UIView *)view andAfterDelay:(float)afterDelay{
    
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    
    SCProgressHUD *hud = [self showHUDAddedTo:view animated:YES];
    
    hud.mode = SCProgressHUDModeCustomView;
    
    hud.bezelView.style = SCProgressHUDBackgroundStyleSolidColor;
    
    hud.bezelView.color = [UIColor clearColor];
    
    hud.customView = customview;

    hud.square = YES;

    hud.label.text = textString;
    
    [hud hideAnimated:YES afterDelay:afterDelay];
    
}


@end
