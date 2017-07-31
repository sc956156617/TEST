//
//  AnotherSearchViewController.h
//  HCSortAndSearchDemo
//
//  Created by Caoyq on 16/3/29.
//  Copyright (c) 2016年 Caoyq. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void(^SelectedItem)(NSString *item);
typedef void(^CallBackBlock)(NSArray *arrString);




@interface AnotherSearchViewController : UIViewController

@property(nonatomic,copy)CallBackBlock callBackBlok;

-(void)cellback:(CallBackBlock)callBackBlok;



//@property (strong, nonatomic) SelectedItem block;
//
//- (void)didSelectedItem:(SelectedItem)block;
@end
