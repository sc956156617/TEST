//
//  SCQipeiListDispalyViewController.h
//  汽车配件
//
//  Created by cb on 2017/4/18.
//  Copyright © 2017年 lxw. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SelectedItem)(NSString *item);

@interface SCQipeiListDispalyViewController : UITableViewController
@property (strong, nonatomic) SelectedItem block;

- (void)didSelectedItem:(SelectedItem)block;
@end
