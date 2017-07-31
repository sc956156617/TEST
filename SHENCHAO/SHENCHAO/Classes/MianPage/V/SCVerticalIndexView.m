
//  SCVerticalIndexView.m
//  SCVerticalIndexView
//
//  Created by SC on 2017/3/21.
//  Copyright © 2017年 SC. All rights reserved.
//

#import "SCVerticalIndexView.h"

#define CELL_HEIGHT 150.f
#define CELL_SPACE  5.0f

#import "NSString+SCTool.h"
#import "UIColor+SCExtension.h"
@interface SCVerticalIndexView ()

@property (nonatomic, strong) NSArray   *titleArr;

@property (nonatomic, strong) UIView    *btnBgView;
@end

@implementation SCVerticalIndexView

- (instancetype)initWithTitleArray:(NSArray *)titleArr{
    if (self = [super init]) {
        
        self.frame =  CGRectMake(0, 0, kScreenW, kScreenH-64);
        self.titleArr  = titleArr;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureRecognizer)];
        [self addGestureRecognizer:tap];
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0f];
    
    // 按钮背景
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    CGFloat bgHeight  = 0;
    self.btnBgView.frame = CGRectMake(0, size.height, size.width ,bgHeight);
    self.btnBgView.backgroundColor =[UIColor grayColor];
    self.btnBgView.alpha = 0.5;
    [self addSubview:self.btnBgView];
    
    // 按钮
    for (int i = 0 ; i < self.titleArr.count; i++) {
        
        CGFloat btnX = 0;
        CGFloat btnY = bgHeight;
        
        NSString * name =self.titleArr[i];
        CGFloat btnH = [name sizeWithFont:[UIFont systemFontOfSize:20] maxSize:CGSizeMake(IndicatorSlideLength, 100000)].height +5;
        bgHeight = bgHeight +btnH;
        
        UIButton  *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:self.titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.textAlignment = NSTextAlignmentLeft;
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.titleLabel.lineBreakMode = UILineBreakModeWordWrap;//换行模式自动换行
        btn.titleLabel.numberOfLines = 0;
        btn.frame = CGRectMake(btnX, btnY, 50, btnH);
        btn.tag   = i+1;
        [btn addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.btnBgView addSubview:btn];
        UIView *line =[[UIView alloc]initWithFrame:CGRectMake(btnX,btnY+btnH-2, 50, 1)];
        line.backgroundColor = [UIColor  randomColor];
        [self.btnBgView addSubview:line];
    }
    
    self.contentSize = CGSizeMake(kScreenW, bgHeight);
    self.btnBgView.frame = CGRectMake(kScreenW-50, kScreenH/2-32, 50, 50);
    //    self.btnBgView.centerY = kScreenH/2;
    // 显示
    [UIView animateWithDuration:0.3 animations:^{
        self.btnBgView.frame  = CGRectMake(kScreenW-50, 0, 50, kScreenH-kNavigationheightAll);
    }];
    
}

- (void)btnClickAction:(UIButton *)btn{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(actionSheet:clickButtonAtIndex:)]) {
        [self.delegate actionSheet:self clickButtonAtIndex:btn.tag];
    }
    if (self.ClickIndex) {
        self.ClickIndex(btn.tag);
    }
    [self hiddenSheet];
    
}
-(void)TapGestureRecognizer{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(actionSheet:clickButtonAtIndex:)]) {
        [self.delegate actionSheet:self clickButtonAtIndex:1000];
    }
    [self hiddenSheet];
    
}

- (void)hiddenSheet {
    
    [UIView animateWithDuration:0.3 animations:^{
        //        CGRect frame = self.btnBgView.frame;
        //        frame.origin.y = [UIScreen mainScreen].bounds.size.height;
        self.btnBgView.frame = CGRectMake(kScreenW, 0, IndicatorSlideLength, kScreenH);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}


- (UIView *)btnBgView{
    if (!_btnBgView) {
        _btnBgView = [[UIView alloc]init];
        _btnBgView.backgroundColor = [UIColor colorWithRed:223.0f/255.0f green:226.0f/255.f blue:236.0f/255.0f alpha:1];
    }
    return _btnBgView;
}

@end
