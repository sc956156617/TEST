//
//  LoginIconView.h
//  SHENCHAO
//
//  Created by cb on 2017/6/23.
//  Copyright © 2017年 SC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginIconViewDelegate <NSObject>

-(void)IconClick;

@end



typedef void (^clickBlock) ();
@interface LoginIconView : UITableViewHeaderFooterView

@property(nonatomic,weak)id <LoginIconViewDelegate>delegate;
@property(nonatomic,assign)clickBlock block;
- (void)updateWithApp:(NSDictionary *)app index:(NSInteger)index;
@end
