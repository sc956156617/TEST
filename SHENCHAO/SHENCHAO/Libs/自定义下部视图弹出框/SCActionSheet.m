
//
//  SCActionSheet.m
//  SCActionSheet
//
//  Created by 刘松 on 16/11/17.
//  Copyright © 2016年 liusong. All rights reserved.
//

#import "SCActionSheet.h"

//字体
#define  SCActionSheetCancelButtonFont  [UIFont systemFontOfSize:16]
#define  SCActionSheetDestructiveButtonFont  [UIFont systemFontOfSize:16]
#define  SCActionSheetOtherButtonFont  [UIFont systemFontOfSize:16]
#define  SCActionSheetTitleLabelFont  [UIFont systemFontOfSize:13]

//颜色

//sheet 背景颜色
#define  SCActionSheetButtonBackgroundColor [UIColor colorWithRed:251/255.0 green:251/255.0 blue:253/255.0 alpha:1]
//遮挡背景颜色
#define  SCActionSheetBackgroundColor [UIColor colorWithRed:129/255.0 green:129/255.0 blue:129/255.0 alpha:0.5]
//提示信息颜色。第一行
#define  SCActionSheetTitleLabelColor  SCThemeColor

//取消按钮颜色
#define  SCActionSheetCancelButtonColor [UIColor redColor]
//SCActionSheetCancelButtonColor
#define  SCActionSheetDestructiveButtonColor   [UIColor redColor]
#define  SCActionSheetDestructiveButtonColor   [UIColor redColor]
#define  SCActionSheetOtherButtonColor  [UIColor blackColor]
#define  SCActionSheetContentViewBackgroundColor [UIColor colorWithRed:251/255.0 green:251/255.0 blue:253/255.0 alpha:0.5]
#define  SCActionSheetButtonHighlightedColor [UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:0.5]

//高度
#define  SCActionSheetCancelButtonHeight 50
#define  SCActionSheetDestructiveButtonHeight 50
#define  SCActionSheetOtherButtonHeight 50
#define  SCActionSheetLineHeight 1.0/[UIScreen mainScreen].scale

//底部取消按钮距离上面按钮距离

#define  SCActionSheetTopMargin 20

#define  SCActionSheetBottomMargin 5

#define  SCActionSheetLeftMargin 20


#define  SCActionSheetAnimationTime 0.25




#define  SCActionSheetScreenWidth [UIScreen mainScreen].bounds.size.width
#define  SCActionSheetScreenHeight [UIScreen mainScreen].bounds.size.height



@interface SCActionSheet ()

@property (nonatomic,weak) UIView *contentView;

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *destructiveTitle;
@property(nonatomic,strong) NSArray *otherTitles;


@property (nonatomic,copy) SCActionSheetBlock  block;


@end

@implementation SCActionSheet

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor=SCActionSheetBackgroundColor;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]init];
        [tap addTarget:self action:@selector(handleGesture:)];
        [self addGestureRecognizer:tap];
        
        
    }
    return self;
}
-(void)handleGesture:(UITapGestureRecognizer*)tap
{
    if ([tap locationInView:tap.view].y<self.frame.size.height -self.contentView.frame.size.height) {
        [self cancel];
    }
}

+(void)showWithTitle:(NSString *)title  destructiveTitle:(NSString *)destructiveTitle otherTitles:(NSArray *)otherTitles block:(SCActionSheetBlock)block
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    SCActionSheet *sheet=[[SCActionSheet alloc]init];
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    sheet.frame=window.bounds;
    sheet.title=title;
    sheet.destructiveTitle=destructiveTitle;
    sheet.otherTitles=otherTitles;
    sheet.block=block;
    [sheet show];
    [window addSubview:sheet];
}

-(void)show
{
    
    UIView *contentView=[[UIView alloc]init];
    contentView.backgroundColor=[UIColor whiteColor];
    self.contentView=contentView;
    
    CGFloat y=0;
    NSInteger tag=0;
    if (self.title) {
        UILabel *titleLabel=[[UILabel alloc]init];
        titleLabel.font=SCActionSheetTitleLabelFont;
        titleLabel.textColor=SCActionSheetTitleLabelColor;
        titleLabel.numberOfLines=0;
        titleLabel.textAlignment=NSTextAlignmentCenter;
        titleLabel.text=self.title;
        titleLabel.tag=tag;
       CGSize size= [self.title boundingRectWithSize:CGSizeMake(SCActionSheetScreenWidth-2*SCActionSheetLeftMargin, MAXFLOAT)
                           options:NSStringDrawingUsesLineFragmentOrigin
                              attributes:@{NSFontAttributeName:titleLabel.font}
                           context:nil]
        .size;
        
        titleLabel.frame=CGRectMake(SCActionSheetLeftMargin, SCActionSheetTopMargin,SCActionSheetScreenWidth-2*SCActionSheetLeftMargin ,size.height );
        UIView *view=[[UIView alloc]init];
        view.backgroundColor=SCActionSheetButtonBackgroundColor;
        view.frame=CGRectMake(0, 0, SCActionSheetScreenWidth, size.height+2*SCActionSheetTopMargin);
        [contentView addSubview:view];
        [contentView addSubview:titleLabel];
        y=size.height+2*SCActionSheetTopMargin+SCActionSheetLineHeight;

    }
    
    for (int i=0; i<self.otherTitles.count; i++) {
        UIButton *button=[self createButtonWithTitle:self.otherTitles[i] color:SCActionSheetOtherButtonColor font:SCActionSheetOtherButtonFont height:SCActionSheetOtherButtonHeight y:y+(SCActionSheetOtherButtonHeight+SCActionSheetLineHeight)*i];
        [contentView addSubview:button];
        if (i==self.otherTitles.count-1) {
            y=y+(SCActionSheetOtherButtonHeight+SCActionSheetLineHeight)*i+SCActionSheetOtherButtonHeight;
        }
        button.tag=tag;
        tag++;
    }
    if (self.destructiveTitle) {
        UIButton *button=[self createButtonWithTitle:self.destructiveTitle color:SCActionSheetDestructiveButtonColor font:SCActionSheetDestructiveButtonFont height:SCActionSheetDestructiveButtonHeight y:y+SCActionSheetLineHeight];
        button.tag=tag;
        [contentView addSubview:button];
        y+=(SCActionSheetDestructiveButtonHeight+SCActionSheetBottomMargin);
        tag++;
        
    }else{
        y+=SCActionSheetBottomMargin;
    }

    
    UIButton *cancel=[self  createButtonWithTitle:@"取消" color:SCActionSheetCancelButtonColor font:SCActionSheetCancelButtonFont height:SCActionSheetCancelButtonHeight y:y];
    cancel.tag=tag;
    [contentView addSubview:cancel];
    
    
    contentView.backgroundColor=SCActionSheetContentViewBackgroundColor;
    CGFloat maxY= CGRectGetMaxY(contentView.subviews.lastObject.frame);
    contentView.frame=CGRectMake(0, self.frame.size.height-maxY, SCActionSheetScreenWidth, maxY) ;
    [self addSubview:contentView];
    
    
    CGRect frame= self.contentView.frame;

    CGRect newframe= frame;
    self.alpha=0.1;
    newframe.origin.y=self.frame.size.height;
    contentView.frame=newframe;
    [UIView animateWithDuration:SCActionSheetAnimationTime animations:^{
        self.contentView.frame=frame;
        self.alpha=1;

    }completion:^(BOOL finished) {

    }];
    
    
}
-(UIButton*)createButtonWithTitle:(NSString*)title  color:(UIColor*)color font:(UIFont*)font height:(CGFloat)height y:(CGFloat)y
{
    
    UIButton *button=[[UIButton alloc]init];
    button.backgroundColor=SCActionSheetButtonBackgroundColor;
    [button setBackgroundImage:[self imageWithColor:SCActionSheetButtonHighlightedColor] forState:UIControlStateHighlighted];
    button.titleLabel.font=font;
    button.titleLabel.textAlignment=NSTextAlignmentCenter;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.frame=CGRectMake(0, y, SCActionSheetScreenWidth, height);
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

-(void)click:(UIButton*)button
{
    
    if (self.block) {
        self.block((int)button.tag);
    }
    [self cancel];
}
#pragma mark - 取消
-(void)cancel
{
    
    CGRect frame= self.contentView.frame;
    frame.origin.y+=frame.size.height;
    [UIView animateWithDuration:SCActionSheetAnimationTime animations:^{
        self.contentView.frame=frame;
        self.alpha=0.1;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

-(UIImage*)imageWithColor:(UIColor*)color
{
    UIGraphicsBeginImageContext(CGSizeMake(1, 1));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddRect(context, CGRectMake(0, 0, 1, 1));
    [color set];
    CGContextFillPath(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}



@end
