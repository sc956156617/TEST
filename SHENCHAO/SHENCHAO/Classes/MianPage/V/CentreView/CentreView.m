//
//  CentreView.m
//  QiPeiMagazine
//
//  Created by iOS Developer 2 on 16/1/11.
//  Copyright © 2016年 Laughing. All rights reserved.
//

#import "CentreView.h"
#import "CentreViewCell.h"
//#import "ShopController.h"
#import "ShowCardView.h"
#import "WebViewController.h"
#import "BrandModel.h"

@interface CentreView ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>
{
    BrandModel *_selectedModel;
}
@property (nonatomic, strong) ShowCardView *showCardView;

@end

static NSString * CentreViewCellID = @"CentreViewCellID";
@implementation CentreView

#pragma mark - LazyLoads
- (ShowCardView *)showCardView {

    if (!_showCardView) {
        _showCardView = [[[NSBundle mainBundle] loadNibNamed:@"ShowCardView" owner:nil options:nil] lastObject];
        _showCardView.frame = CGRectMake(0, 0, kScreenW, kScreenH);
        _showCardView.alpha = 0.f;
        [_showCardView.clickButton addTarget:self action:@selector(clickButtonAction) forControlEvents:UIControlEventTouchUpInside];
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap)];
        [_showCardView addGestureRecognizer:singleTap];
        
       
    }
    return _showCardView;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {

    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.dataSource = self;
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        [self registerNib:[UINib nibWithNibName:NSStringFromClass([CentreViewCell class]) bundle:nil] forCellWithReuseIdentifier:CentreViewCellID];
        [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];

    }
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   
    CentreViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CentreViewCellID forIndexPath:indexPath];
    
    if (self.data.count == 0) {
        return cell;
    }
    BrandModel * model =self.data[indexPath.row];
    cell.model = model;
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (NSIndexPath *)curIndexPath {
    NSArray *indexPaths = [self indexPathsForVisibleItems];
    NSIndexPath *curIndexPath = nil;
    NSInteger curzIndex = 0;
    for (NSIndexPath *path in indexPaths.objectEnumerator) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:path];
        if (!curIndexPath) {
            curIndexPath = path;
            curzIndex = attributes.zIndex;
            continue;
        }
        if (attributes.zIndex > curzIndex) {
            curIndexPath = path;
            curzIndex = attributes.zIndex;
        }
    }
    return curIndexPath;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *curIndexPath = [self curIndexPath];
    if (indexPath.item == curIndexPath.item) {
        return YES;
    }
    
    if ([self.centreViewDelegate respondsToSelector:@selector(shouldSelectItemAtIndexPath:)]) {
        [self.centreViewDelegate shouldSelectItemAtIndexPath:indexPath];  //滑动
    }
    
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.data.count == 0) {
        return ;
    }
    
    BrandModel *model = self.data[indexPath.item];
    NSInteger detailType = [model.detailtype integerValue];
    switch (detailType) {
        case 0:{
            //图片
            self.showCardView.showImageView.hidden = NO;
            
            NSLog(@"%@",model.detailurl);
            [self.showCardView.showImageView sd_setImageWithURL:[NSURL URLWithString:model.detailurl] placeholderImage:[UIImage imageNamed:@"img_nopic"] options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                NSLog(@"%@",error);
            }];
        } break;
        case 1:{
            //gif
            self.showCardView.showImageView.hidden = NO;
            [self.showCardView.showImageView sd_setImageWithURL:[NSURL URLWithString:model.detailurl] placeholderImage:[UIImage imageNamed:@"img_nopic"] options:SDWebImageRetryFailed];
        } break;
        case 2:{
            self.showCardView.showWebView.hidden = NO;
            [self.showCardView.showWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:model.detailurl]]];
        } break;
        default:    break;
    }

    _selectedModel = model;
    [[UIApplication sharedApplication].keyWindow addSubview:self.showCardView];
    [UIView animateWithDuration:0.2f animations:^{
        self.showCardView.alpha = 1.f;
    }];

}

#pragma mark - Action Methods
- (void)singleTap {

    [self hiddenShowCardView];
}

- (void)clickButtonAction {
    
//    WebViewController *vc = [[WebViewController alloc] init];
//    vc.isPush = NO;
//    vc.urlString = _selectedModel.h5url;
//    vc.tel = _selectedModel.tel;
//    vc.im = _selectedModel.im;
//    QPNavgationController *QPNavgationVC = [[QPNavgationController alloc]initWithRootViewController:vc];
//    [self.ViewController presentViewController:QPNavgationVC animated:YES completion:nil];
    

    [self.centreViewDelegate  centreViewDidSelectpage];
    [self hiddenShowCardView];
}


//创建CollectionView
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void *)context {
    
    if (object == self) {
        //计算屏幕偏移比例
        CGPoint  point  =  [((NSValue *)[self  valueForKey:@"contentOffset"]) CGPointValue];
        CGSize   size  =  [((NSValue *)[self  valueForKey:@"contentSize"]) CGSizeValue];
        //取出当前聚焦的cell数据源
        if ([self.centreViewDelegate respondsToSelector:@selector(centreViewDidScroll:and:)]) {
            [self.centreViewDelegate centreViewDidScroll:point.y and:size.height];
        }
    }
}

//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    
        // 先计算当期的page/index
//        CGFloat index = scrollView.contentOffset.x/self.screenWidth;
        //再四舍五入推算本该减速时的scrollView的contentOffset。即：roundf(index)*self.screenWidth
//}
#pragma mark - showCardView Methods
//隐藏showCardView
- (void)hiddenShowCardView {
    [_showCardView removeFromSuperview];
    _showCardView = nil;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    NSLog(@"%f",scrollView.contentOffset.y);

    if ([self.centreViewDelegate respondsToSelector:@selector(centreViewDidScroll)]) {
        [self.centreViewDelegate centreViewDidScroll];
    }
}


@end
