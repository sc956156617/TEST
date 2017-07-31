//
//  CentreViewCell.h
//  QiPeiMagazine
//
//  Created by iOS Developer 2 on 16/1/11.
//  Copyright © 2016年 Laughing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BrandModel;
@interface CentreViewCell : UICollectionViewCell

@property (nonatomic, strong) BrandModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *centerLabel;

@end
