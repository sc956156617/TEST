

//
//  LoginIconView.m
//  SHENCHAO
//
//  Created by cb on 2017/6/23.
//  Copyright © 2017年 SC. All rights reserved.
//

#import "LoginIconView.h"
#import "NerdyUI.h"

@implementation LoginIconView {
    UIButton *_iconView;
    UILabel     *_phoneLabel;
    UILabel     *_titleLabel;
    UILabel     *_NOLoginLabel;
}
- (void)updateWithApp:(NSDictionary *)app index:(NSInteger)index {
    
    app =@{
           @"iconName"  : @"3",
           @"title"     : @"有聊——123455",
           @"category"  : @"15833299885",
           @"commentCount" : @"登录／注册"
           };
    _iconView.img(app[@"iconName"]);
    _titleLabel.text = app[@"title"];
    _phoneLabel.text = app[@"category"];
    _NOLoginLabel.text = Str(@"(%@)", app[@"commentCount"]);
}

- (void)setupUI {
    _phoneLabel = Label.fnt(17).color(@"darkGray").fixWidth(150).leftAlignment;
    _iconView = Button.fixWH(64, 64).borderRadius(10).border(Screen.onePixel*3, @"#CCCCCC").onClick(@"iconClick");
//    [_iconView addTarget:self action:@selector(iconClick) forControlEvents:UIControlEventTouchUpInside];
    //Setting preferWidth here will improve performance.
    _titleLabel = Label.fnt(15).lines(2).preferWidth(Screen.width - 205);
    _NOLoginLabel = Label.fnt(13).color(@"darkGray");
    
    //.gap() will add spacing between all items.
    
    
    id rightStack = VerStack(_titleLabel, _phoneLabel).gap(10);

    id mianStack = HorStack(_iconView, rightStack).gap(10).centerAlignment;
//    id actionStack = VerStack(_actionButton, _iapLabel).gap(4).centerAlignment;
    
     VerStack(
              @300,
             mianStack,
             NERSpring,     //Using spring to ensure actionStack stay in the right most position.
             ).embedIn(self.contentView, 0, 0, 50, 0).centerAlignment;   //insetEdge    下 右 上 左
}


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self setupUI];
    return self;
}
-(void)iconClick{
    
    
    if ([self.delegate respondsToSelector:@selector(IconClick)]) {
        [self.delegate IconClick];
    }
//    self.block();
//    [self clickWithBlock:self.block()];
}

@end

