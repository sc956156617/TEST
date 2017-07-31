

//
//  SCEnterpriseOneIconView.m
//  汽车配件
//
//  Created by cb on 2017/3/28.
//  Copyright © 2017年 lxw. All rights reserved.
//

#import "SCEnterpriseOneIconView.h"

@implementation SCEnterpriseOneIconView


-(instancetype)initWithFrame:(CGRect)frame{

    if ([super initWithFrame:frame]) {
     
        
        
        UIView *bgView =[[UIView alloc]initWithFrame:frame];
        bgView.backgroundColor =[UIColor whiteColor];
        [self addSubview:bgView];
        
        self.backgroundColor = [UIColor whiteColor];
        //完善下您的资料吧？
        UILabel *titleL=[[UILabel alloc]initWithFrame:CGRectMake(kScreenW/4, 0, 2000,50 )];
        titleL.text=@"完善下您的资料吧？";
        titleL.textAlignment = NSTextAlignmentCenter;
        titleL.font=[UIFont boldSystemFontOfSize:AdapationLabelFont(20)];
        titleL.textColor  = SCThemeColor;
        [titleL sizeToFit];
        titleL.centerX = self.centerX;
        [bgView addSubview:titleL];
        
        //icon头像按钮
        UIButton *iconB=[UIButton buttonWithType:UIButtonTypeCustom];
        [iconB setImage:[UIImage imageNamed:@"touxiang"] forState:UIControlStateNormal];
        [iconB setFrame:CGRectMake(0, CGRectGetMaxY(titleL.frame)+30, 80, 80)];
        iconB.backgroundColor = [UIColor grayColor];
        iconB.centerX = self.centerX;
        [iconB addTarget:self action:@selector(iconSelect:) forControlEvents:UIControlEventTouchUpInside];
        iconB.layer.masksToBounds = YES;
        iconB.layer.cornerRadius = 6;
        iconB.layer.borderColor = [UIColor lightGrayColor].CGColor;
        iconB.layer.borderWidth = 1.0f;
        [bgView addSubview:iconB];
        //完善下您的资料吧？
        UILabel *iconL=[[UILabel alloc]initWithFrame:CGRectMake(kScreenW/4, CGRectGetMaxY(iconB.frame)+30, 2000,50 )];
        iconL.text=@"上传头像";
        iconL.textAlignment = NSTextAlignmentCenter;
        iconL.font=[UIFont boldSystemFontOfSize:AdapationLabelFont(20)];
        iconL.textColor  = SCThemeColor;
        [iconL sizeToFit];
        iconL.centerX = self.centerX;
        [bgView addSubview:iconL];
    }
    return self;
}

-(void)iconSelect:(UIButton *)btn{

    if ([self.delegegate respondsToSelector:@selector(passIconmclick:)]) {
        [self.delegegate  passIconmclick:btn];
    }

}
@end
