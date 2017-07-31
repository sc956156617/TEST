//
//  MainTableViewCell.m
//  SDAutoLayout-master
//
//  Created by shen on 17/4/15.
//  Copyright © 2017年 shen. All rights reserved.
//

#import "MainTableViewCellX.h"
#import "MainModel.h"


#import "UIView+SDAutoLayout.h"
#import "UITableView+SDAutoTableViewCellHeight.h"


//屏幕的宽和高
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define W(x) kScreenWidth*(x)/320.0
#define H(y) kScreenHeight*(y)/568.0
#define kMarg 2  //上下
#define kspan 10

#define kHeightLabel 30

@implementation MainTableViewCellX{
    UIImageView *_icon;
    UILabel *_name;
    UILabel *_timeLabel;
    UILabel *_contentLabel;
    UIImageView *_imageView;
    UIImageView *_bgview;
//    UILabel *
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor colorWithRed:240.0/255 green:241.0/255 blue:236.0/255 alpha:1];
        self.clipsToBounds=YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubviews];
    }
    return self;
}

-(void)addSubviews{
    
    _icon = [UIImageView new];
    _icon.backgroundColor = [UIColor redColor];
    _icon.layer.masksToBounds=YES;
    _icon.layer.cornerRadius = 5;
    _icon.image = [UIImage imageNamed:@"pic1.jpeg"];
    [self.contentView addSubview:_icon];
    
    
    _name = [UILabel new];
    _name.text = @"清凉一夏 套餐半价";
    [self.contentView addSubview:_name];
    
    
    _bgview = [UIImageView new];
    UIImage *newImage = [UIImage imageNamed:@"xiaomishubg"];
    UIImage *image = [newImage stretchableImageWithLeftCapWidth:20 topCapHeight:20];
    _bgview.image =image ;
    [self.contentView addSubview:_bgview];
    
    
    _timeLabel = [UILabel new];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_timeLabel];
    
    _contentLabel = [UILabel new];
    _contentLabel.textColor = [UIColor colorWithRed:100.0/255 green:100.0/255 blue:100.0/255 alpha:100];
    _contentLabel.font = [UIFont systemFontOfSize:16];
    _contentLabel.numberOfLines = 0;
    [self.contentView addSubview:_contentLabel];
    
    
    _imageView = [UIImageView new];
    _imageView.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_imageView];
    
    //    lineView.sd_layout.widthIs(kScreenWidth).heightIs(kMarg).topSpaceToView(self.contentView,0);
}


-(void)setModel:(MainModel *)model{
    _model = model;
    
    if ([model.image isEqualToString:@""]  ) {
        _icon.sd_layout.xIs(kspan).widthIs(50).heightIs(50).topSpaceToView(self.contentView,kMarg);
        _name.sd_layout.widthIs(kScreenW).heightIs(20).centerYIs(_icon.centerY).leftSpaceToView(_icon, 10);
//        _name.centerY = _icon.centerY;
        _timeLabel.sd_layout.widthIs(100).heightIs(20).topSpaceToView(_name, -20).rightSpaceToView(self.contentView,0);
        _contentLabel.sd_layout.topSpaceToView(_icon, kMarg).rightSpaceToView(self.contentView, kMarg * 2).leftSpaceToView(_icon,kMarg * 2).autoHeightRatio(0);
        _imageView.sd_layout.topSpaceToView(_contentLabel,kMarg).rightSpaceToView(self.contentView, kMarg *10).heightIs(0).leftSpaceToView(_icon, 20);
        _bgview.sd_layout.leftSpaceToView(_icon,0).rightSpaceToView(self.contentView, kMarg*2).topSpaceToView(_icon, 0).bottomSpaceToView(_imageView , -20);
         _name.text = model.title;
        _timeLabel.text = model.time;
        _contentLabel.text = [NSString stringWithFormat:@"%@",model.content];
        _imageView.image = [UIImage imageNamed:model.image];
        //***********************  高度自适应cell设置步骤  ************************
        [self setupAutoHeightWithBottomView:_imageView bottomMargin:30];
    }else{
        _icon.sd_layout.xIs(kspan).widthIs(50).heightIs(50).topSpaceToView(self.contentView,kMarg);
        _name.sd_layout.widthIs(kScreenW).heightIs(20).centerYIs(_icon.centerY).leftSpaceToView(_icon, 10);
//        _name.centerY = _icon.centerY;
        _timeLabel.sd_layout.widthIs(100).heightIs(20).topSpaceToView(_name, -20).rightSpaceToView(self.contentView,0);
        _contentLabel.sd_layout.topSpaceToView(_icon, kMarg).rightSpaceToView(self.contentView, kMarg * 2).leftSpaceToView(_icon,kMarg * 2).autoHeightRatio(0);
        _imageView.sd_layout.topSpaceToView(_contentLabel,kMarg).rightSpaceToView(self.contentView, kMarg *10).heightIs(100).leftSpaceToView(_icon, 20);
        _bgview.sd_layout.leftSpaceToView(_icon,0).rightSpaceToView(self.contentView, kMarg*2).topSpaceToView(_icon, 0).bottomSpaceToView(_imageView , -110);
        _name.text = model.title;
        _timeLabel.text = model.time;
        _contentLabel.text = [NSString stringWithFormat:@"%@",model.content];
        _imageView.image = [UIImage imageNamed:model.image];
        //***********************  高度自适应cell设置步骤  ************************
        [self setupAutoHeightWithBottomView:_imageView bottomMargin:20];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
