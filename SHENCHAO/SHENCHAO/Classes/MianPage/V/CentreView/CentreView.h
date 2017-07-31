//
//  CentreView.h
//  QiPeiMagazine
//
//  Created by iOS Developer 2 on 16/1/11.
//  Copyright © 2016年 Laughing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CentreViewDelegate <NSObject>

- (void)centreViewDidScroll;
- (void)centreViewDidScroll:(CGFloat)offsetY and:(CGFloat)contentSizeH;

- (void)shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)centreViewDidSelectpage;

@end

@interface CentreView : UICollectionView

@property (nonatomic, weak) id<CentreViewDelegate> centreViewDelegate;
@property (nonatomic, strong) NSArray        *data;

@end
