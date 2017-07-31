//
//  CentreViewCell.m
//  QiPeiMagazine
//
//  Created by iOS Developer 2 on 16/1/11.
//  Copyright © 2016年 Laughing. All rights reserved.
//

#import "CentreViewCell.h"
#import "BrandModel.h"

@implementation CentreViewCell

- (void)awakeFromNib {
    
    self.layer.borderColor =[UIColor colorWithHexString:@"ffffff"].CGColor;
    
    self.backgroundColor =[UIColor lightGrayColor];
    self.layer.borderWidth = 1.f;
    self.layer.cornerRadius = 5.f;//圆角半径
    self.layer.masksToBounds = YES;
}

- (void)setModel:(BrandModel *)model {

    if (_model != model) {
        _model = model;
    }
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:_model.thumbnail] placeholderImage:[UIImage imageNamed:@"111"] options:SDWebImageRetryFailed];
//    self.centerLabel.text = _model.name;
}

@end
