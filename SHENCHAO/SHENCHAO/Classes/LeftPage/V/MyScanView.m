//
//  MyScanView.m
//  SHENCHAO
//
//  Created by cb on 2017/7/6.
//  Copyright © 2017年 SC. All rights reserved.
//

#import "MyScanView.h"


#define CELL_HEIGHT 150.f
#define CELL_SPACE  5.0f
#define CELL_WIDTH  50.0f

#import "NSString+SCTool.h"
#import "UIColor+SCExtension.h"


@implementation MyScanView

-(instancetype)init{
    if (self = [super init]) {
        
        self.frame =  CGRectMake(0, 0, kScreenW, kScreenH);
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];

        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    // 按钮背景
  UIImageView * image = ImageView.img(@"macbook").embedIn(self).centerMode;
    
//    id hello = Label.str(@"HELLO").fnt(@20).wh(80, 80).centerAlignment;
//    id mac = Label.str(@"MAC").fnt(@20).wh(80, 80).centerAlignment;
//    
//    //In order to use makeCons, the view must be in the view hierarchy.
//    EffectView.darkBlur.fixWH(80, 80).addTo(self).makeCons(^{
//        make.right.equal.superview.centerX.constants(0);
//        make.bottom.equal.superview.centerY.constants(0);
//    }).addVibrancyChild(hello).tg(101);
//    
//    EffectView.extraLightBlur.fixWidth(80).fixHeight(80).addTo(self).makeCons(^{
//        make.left.bottom.equal.view(self).center.constants(0, 0);
//    });
//    
//    EffectView.lightBlur.addTo(self).makeCons(^{
//        make.size.equal.constants(80, 80).And.center.equal.constants(40, 40);
//    }).addVibrancyChild(mac);
//    
    id subImg = Img(@"macbook").subImg(95, 110, 80, 80).blur(10);
    ImageView.img(subImg).addTo(self).makeCons(^{
        make.centerX.top.equal.view([self viewWithTag:101]).centerX.bottom.constants(0);
    });
    
//    image.xywh(self.centerX,self.centerY,1,1);
    // 显示
    [UIView animateWithDuration:0.3 animations:^{
        image.frame  = CGRectMake(kScreenW-CELL_WIDTH, (kScreenH -kScreenW+2*CELL_WIDTH)/2,kScreenW-2*CELL_WIDTH, kScreenW-2*CELL_WIDTH);
    }];
    
}

- (void)btnClickAction:(UIButton *)btn{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didTipBackgroud)]) {
        [self.delegate didTipBackgroud];
    }
    [self hiddenSheet];
    
}
-(void)TapGestureRecognizer{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didTipBackgroud)]) {
        [self.delegate didTipBackgroud];
    }
    [self hiddenSheet];
    
}

- (void)hiddenSheet {
    
    [UIView animateWithDuration:0.3 animations:^{
        //        CGRect frame = self.btnBgView.frame;
        //        frame.origin.y = [UIScreen mainScreen].bounds.size.height;
        self.frame = CGRectMake(kScreenW, 0, IndicatorSlideLength, kScreenH);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}


@end
