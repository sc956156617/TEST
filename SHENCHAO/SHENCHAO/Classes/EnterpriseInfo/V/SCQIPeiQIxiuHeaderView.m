//
//  SCQIPeiQIxiuHeaderView.m
//  汽车配件
//
//  Created by cb on 2017/3/29.
//  Copyright © 2017年 lxw. All rights reserved.
//

#import "SCQIPeiQIxiuHeaderView.h"

@implementation SCQIPeiQIxiuHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        
        UIView *bgView =[[UIView alloc]initWithFrame:frame];
        bgView.backgroundColor =[UIColor whiteColor];
        [self addSubview:bgView];
        
        UIView *line =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 1)];
        line.backgroundColor =SCLineGrayColor;
        [bgView addSubview:line];
        
        //icon头像按钮
        UIButton *iconB=[UIButton buttonWithType:UIButtonTypeCustom];
        [iconB setImage:[UIImage imageNamed:@"tjzp"] forState:UIControlStateNormal];
        [iconB setFrame:CGRectMake(0, 10, 80, 80)];
        iconB.backgroundColor = [UIColor grayColor];
        iconB.centerX = self.centerX;
        [iconB addTarget:self action:@selector(iconSelect:) forControlEvents:UIControlEventTouchUpInside];
        iconB.layer.masksToBounds = YES;
        iconB.layer.cornerRadius = 6;
        [bgView addSubview:iconB];
        //完善下您的资料吧？
        UILabel *iconL=[[UILabel alloc]initWithFrame:CGRectMake(kScreenW/4, CGRectGetMaxY(iconB.frame)+10, 2000,50 )];
        iconL.text=@"上传图片";
        iconL.textAlignment = NSTextAlignmentCenter;
        iconL.font=[UIFont boldSystemFontOfSize:AdapationLabelFont(20)];
        iconL.textColor  = SCThemeColor;
        [iconL sizeToFit];
        iconL.centerX = self.centerX;
        [bgView addSubview:iconL];
        
        
        UIButton *IDcard=[UIButton buttonWithType:UIButtonTypeCustom];
        [IDcard setImage:[UIImage imageNamed:@"mingpian"] forState:UIControlStateNormal];
        [IDcard setFrame:CGRectMake(20, 100, 64, 20)];
        IDcard.centerX = kScreenW-32-10;
        [IDcard addTarget:self action:@selector(CardSelect:) forControlEvents:UIControlEventTouchUpInside];
        IDcard.layer.masksToBounds = YES;
        IDcard.layer.cornerRadius = 6;
        [bgView addSubview:IDcard];
        
        
    }
    return self;
}
-(void)iconSelect:(UIButton *)btn{
    
    if ([self.delegegate respondsToSelector:@selector(passIconmclick:)]) {
        [self.delegegate  passIconmclick:btn];
    }
    
}
-(void)CardSelect:(UIButton *)btn{
    
    if ([self.delegegate respondsToSelector:@selector(IDcardClick:)]) {
        [self.delegegate  IDcardClick:btn];
    }
}
@end
