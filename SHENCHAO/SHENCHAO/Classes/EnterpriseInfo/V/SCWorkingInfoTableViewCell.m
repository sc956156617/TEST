

//
//  SCWorkingInfoTableViewCell.m
//  汽车配件
//
//  Created by cb on 2017/3/31.
//  Copyright © 2017年 lxw. All rights reserved.
//

#import "SCWorkingInfoTableViewCell.h"
#import "UIImageView+WebCache.h"



@implementation SCWorkingInfoTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
      
        UIView *contentView =[[UIView alloc]init];
        [self addSubview:contentView];
        
        UIImageView *image = [[UIImageView alloc]init];
        image.image = [UIImage imageNamed:@"BoAssetsCamera"];
        image.layer.masksToBounds =YES;
        image.layer.cornerRadius = 5;
        self.iconV = image;
        [self addSubview: image];
        
        
        UILabel * nameL =[[UILabel alloc]init];
        nameL.font =  [UIFont systemFontOfSize:AdapationLabelFont(16)];
        nameL.textColor = SCBlackColor;
        self.nameL =nameL;
        [self addSubview:nameL];
        
        UILabel * typeL =[[UILabel alloc]init];
        typeL.font =  [UIFont systemFontOfSize:AdapationLabelFont(14)];
        typeL.textColor = [UIColor whiteColor];
        self.typeL =typeL;
        typeL.textAlignment = NSTextAlignmentCenter;
        typeL.layer.masksToBounds =YES;
        typeL.layer.cornerRadius = 2;
        [self addSubview:typeL];

    }
    return self;

}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self =  [super initWithFrame:frame]) {
        UIView *contentView =[[UIView alloc]initWithFrame:frame];
        [self addSubview:contentView];
        
        UIImageView *image = [[UIImageView alloc]init];
        image.image = [UIImage imageNamed:@"BoAssetsCamera"];
        image.layer.masksToBounds =YES;
        image.layer.cornerRadius = 5;
        self.iconV = image;
        [self addSubview: image];
        
        
        UILabel * nameL =[[UILabel alloc]init];
        nameL.font =  [UIFont systemFontOfSize:AdapationLabelFont(16)];
        nameL.textColor = SCBlackColor;
        self.nameL =nameL;
        [self addSubview:nameL];
        
        UILabel * typeL =[[UILabel alloc]init];
        typeL.font =  [UIFont systemFontOfSize:AdapationLabelFont(14)];
        typeL.textColor = [UIColor whiteColor];
        typeL.textAlignment = NSTextAlignmentCenter;
        typeL.layer.masksToBounds =YES;
        typeL.layer.cornerRadius = 5;
        self.typeL =typeL;
        [self addSubview:typeL];
    }
    return self;
}
-(void)setModel:(SCWorkerModel *)model{
    
    if (model.iconUrl) {
        [self.iconV sd_setImageWithURL:[NSURL URLWithString:model.iconUrl] placeholderImage:[UIImage imageNamed:@"114"]];
    }
    if (model.name) {
        self.nameL.text = model.name;
    }
    if (model.type) {
        self.typeL.text = model.type;
//        self.typeL.textColor =[UIColor redColor];
        if ([model.type isEqualToString:@"管理员"]) {
            self.typeL.backgroundColor = [UIColor colorWithRed:172/255 green:207/255 blue:242/255 alpha:1];
        }else{
         self.typeL.backgroundColor = SCThemeColor;
        }
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.iconV.frame =CGRectMake(10, 10, 40, 40);
    self.nameL.frame = CGRectMake(CGRectGetMaxX(self.iconV.frame) +5, 20, kScreenW, 20) ;
//    self.nameL.centerY = self.centerY;
    [self.nameL sizeToFit];
    self.typeL.frame = CGRectMake(CGRectGetMaxX( self.nameL.frame)+20, 20, 50, 20);
//    self.typeL.centerY = self.nameL.centerY;

}
@end
