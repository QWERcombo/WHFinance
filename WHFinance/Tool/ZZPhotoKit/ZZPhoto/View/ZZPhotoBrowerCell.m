//
//  ZZPhotoBrowerCell.m
//  ZZPhotoKit
//
//  Created by 袁亮 on 16/10/19.
//  Copyright © 2016年 Ace. All rights reserved.
//

#import "ZZPhotoBrowerCell.h"
//#import "PhotoSaveView.h"
#import "ZZPhotoAlert.h"
#import "ZZPhotoDatas.h"

@interface ZZPhotoBrowerCell()<UIScrollViewDelegate, UIGestureRecognizerDelegate>
{
    CGFloat _browser_width;
    CGFloat _browser_height;
}
@property (nonatomic, strong) UIScrollView *scaleView;
@property (nonatomic, assign) BOOL isShow;
//@property (nonatomic, strong) UIImageView *photo_image_view;
@property (nonatomic, assign) BOOL isHide;
@property (nonatomic, strong) ZZPhotoDatas                *datas;
@end

@implementation ZZPhotoBrowerCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _browser_width = frame.size.width;
        _browser_height = frame.size.height;
        
        _scaleView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _browser_width, _browser_height)];
        _scaleView.delegate = self;
        _scaleView.maximumZoomScale = 2.5;
        _scaleView.minimumZoomScale = 1.0;
        _scaleView.bouncesZoom = YES;
        _scaleView.multipleTouchEnabled = YES;
        _scaleView.delegate = self;
        _scaleView.scrollsToTop = NO;
        _scaleView.showsHorizontalScrollIndicator = NO;
        _scaleView.showsVerticalScrollIndicator = NO;
        _scaleView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _scaleView.delaysContentTouches = NO;
        _scaleView.canCancelContentTouches = YES;
        _scaleView.alwaysBounceVertical = NO;
        _scaleView.userInteractionEnabled = YES;
        [self.contentView addSubview:_scaleView];
        
        _photo_image_view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, SCREEN_HEIGHT)];
        _photo_image_view.userInteractionEnabled = YES;
        _photo_image_view.contentMode = UIViewContentModeScaleAspectFit;
        [_scaleView addSubview:_photo_image_view];
        
        UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleFingerEvent:)];
        singleFingerOne.delegate = self;
        singleFingerOne.numberOfTapsRequired = 1;
        [_photo_image_view addGestureRecognizer:singleFingerOne];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [_photo_image_view addGestureRecognizer:longPress];
        
        UITapGestureRecognizer *singleFingerTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleFingerEvent:)];
        singleFingerTwo.delegate = self;
        singleFingerTwo.numberOfTapsRequired = 2;
        [_photo_image_view addGestureRecognizer:singleFingerTwo];
        
    }
    return self;
}
- (ZZPhotoDatas *)datas{
    if (!_datas) {
        _datas = [[ZZPhotoDatas alloc]init];
        
    }
    return _datas;
}
-(void)loadPHAssetItemForPics:(PHAsset *)assetItem
{
    __weak typeof (self) weakSelf = self;
    PHAsset *phAsset = (PHAsset *)assetItem;
    CGFloat photoWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat aspectRatio = phAsset.pixelWidth / (CGFloat)phAsset.pixelHeight;
    CGFloat multiple = [UIScreen mainScreen].scale;
    CGFloat pixelWidth = photoWidth * multiple;
    CGFloat pixelHeight = pixelWidth / aspectRatio;
    
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    option.resizeMode = PHImageRequestOptionsResizeModeFast;
    
    if ([self.datas CheckIsiCloudAsset:phAsset]==YES) {
        [[ZZPhotoAlert sharedAlert] showPhotoAlert];
    } else {
        [[PHImageManager defaultManager] requestImageForAsset:phAsset targetSize:CGSizeMake(pixelWidth, pixelHeight) contentMode:PHImageContentModeAspectFit options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            
            BOOL downloadFinined = ![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey] && ![[info objectForKey:PHImageResultIsDegradedKey] boolValue];
            
            if (downloadFinined) {
                if (result != nil) {
                    [weakSelf changeFrameWithImage:result];
                    weakSelf.photo_image_view.image = result;
                }
            }
            
        }];
    }
}

-(void)changeFrameWithImage:(UIImage *)image
{
    CGFloat height = image.size.height / image.size.width * _browser_width;
    self.photo_image_view.frame = CGRectMake(0, 0, _browser_width, height);
    self.photo_image_view.center = CGPointMake(_browser_width / 2, _browser_height / 2);
    _scaleView.contentSize = CGSizeMake(_browser_width, MAX(self.photo_image_view.frame.size.height, _browser_height));
}

-(void)recoverSubview
{
    [_scaleView setZoomScale:1.0 animated:NO];
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _photo_image_view;
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    _photo_image_view.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                               scrollView.contentSize.height * 0.5 + offsetY);
}


- (void)handleSingleFingerEvent:(UITapGestureRecognizer *)sender
{
       if(sender.numberOfTapsRequired == 2){//双击放大
        if (_scaleView.zoomScale > 1.0) {
            [_scaleView setZoomScale:1.0 animated:YES];
        } else {
            CGPoint touchPoint = [sender locationInView:self.photo_image_view];
            CGFloat maxScale = _scaleView.maximumZoomScale;
            CGFloat xsize = self.frame.size.width / maxScale;
            CGFloat ysize = self.frame.size.height / maxScale;
            [_scaleView zoomToRect:CGRectMake(touchPoint.x - xsize/2, touchPoint.y - ysize/2, xsize, ysize) animated:YES];
        }
    }
}
- (void)longPress:(UILongPressGestureRecognizer *)sender {
    if (self.isShow) {
    } else {
//        [PhotoSaveView showPhotoSaveView:nil delegate:self andCliker:^(NSString *clueStr) {
//            if ([clueStr isEqualToString:@"0"]) {
//                self.isShow = NO;
//            }
//            if ([clueStr isEqualToString:@"1"]) {
//                NSURL *url = [NSURL URLWithString:self.imgurl];
//                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
//                [[PayManager sharedInstance] saveImage:image andBlock:^(NSString *clueStr) {
//                    if ([clueStr isEqualToString:@"1"]) {
//                        [self showWith:@"保存成功" andAnnimation:YES];
//                    } else {
//                        [self showWith:@"保存失败" andAnnimation:NO];
//                    }
//                }];
//            }
//        }];
//        self.isShow = YES;
    }
}
- (void)showWith:(NSString *)text andAnnimation:(BOOL)anni {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UtilsData sharedInstance] showAlertTitle:nil detailsText:text time:1.5 aboutType:MBProgressHUDModeText state:anni];
//        for (UIView *sub in MY_WINDOW.subviews) {
//            if ([sub isKindOfClass:[PhotoSaveView class]]) {
//                [sub removeFromSuperview];
//                self.isShow = NO;
//            }
//        }
    });
}
@end
