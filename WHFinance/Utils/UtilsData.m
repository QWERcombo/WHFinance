
//  UtilsData.m
//  XiYouPartner
//
//  Created by 265G on 15/8/13.
//  Copyright (c) 2015年 YXCompanion. All rights reserved.
//

#import "UtilsData.h"
#import "MainLoginViewController.h"
#import <Photos/Photos.h>
#import "CertificateListViewController.h"

@interface UtilsData ()
@property(nonatomic,assign)BOOL isFinish;//动画是否完成
@end

@implementation UtilsData
DEF_SINGLETON(UtilsData);

- (id)init
{
    if(self=[super init]){
        self.isFinish = YES;
    }
    return self;
}

-(MJRefreshGifHeader *)MJRefreshNormalHeaderTarget:(id)target table:(UIScrollView *)scrollView actionSelector:(SEL)action
{
    //http://www.jianshu.com/p/80f0a274de23
    MJRefreshGifHeader *header = [MJRefreshGifHeader  headerWithRefreshingTarget:target refreshingAction:action];
    scrollView.mj_header = header;
    NSArray *idleImages = @[IMG(@"Refres_up0"),IMG(@"Refres_up1"),IMG(@"Refres_up2"),IMG(@"Refres_up3"),IMG(@"Refres_up4"),IMG(@"Refres_up5"),IMG(@"Refres_up6"),IMG(@"Refres_up7")];
    //NSArray *idleImages = @[IMG(@"Refres_down0"),IMG(@"Refres_down1"),IMG(@"Refres_down2")];
    //设置普通状态的动画图片
//    [header setImages:idleImages forState:MJRefreshStateIdle];
    //设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [header setImages:idleImages forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [header setImages:idleImages forState:MJRefreshStateRefreshing];
       [header setTitle:@"" forState:MJRefreshStateIdle];
    [header setTitle:@"" forState:MJRefreshStateRefreshing];
    header.lastUpdatedTimeLabel.hidden= YES;//如果不隐藏这个会默认 图片在最左边不是在中间
    header.stateLabel.hidden = YES;
    return header;
}

-(MJRefreshAutoGifFooter *)MJRefreshAutoNormalFooterTarget:(id)target table:(UIScrollView *)scrollView actionSelector:(SEL)action
{
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:target refreshingAction:action];
    scrollView.mj_footer = footer;
    NSArray *idleImages = @[IMG(@"Refres_down0"),IMG(@"Refres_down1"),IMG(@"Refres_down2")];

    // 设置普通状态的动画图片
    // [footer setImages:idleImages forState:MJRefreshStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    // 设置正在刷新状态的动画图片
    [footer setImages:idleImages forState:MJRefreshStateRefreshing];
    
//    [footer setTitle:@"" forState:MJRefreshStateIdle];
//    [footer setTitle:@"" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"no more" forState:MJRefreshStateNoMoreData];
    footer.refreshingTitleHidden = YES;
    footer.stateLabel.hidden = YES;
    return footer;
}

-(void)MJRefreshAutoNormalCollectionViewFooterTarget:(id)target table:(UICollectionView *)collectionView actionSelector:(SEL)action
{
    collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
}
-(void)MJRefreshAutoNormalCollectionViewHeaderTarget:(id)target table:(UICollectionView *)collectionView actionSelector:(SEL)action{
    
}

-(void)hideAlert
{
    [MBProgressHUD hideHUDForView:MY_WINDOW animated:YES];
}
-(void)showAlertTitle:(NSString *)titleString detailsText:(NSString *)detailsString time:(float)time aboutType:(MBProgressHUDMode)mode  state:(BOOL)isSuccess
{
    [self hideAlert];
    MBProgressHUD *hud =[MBProgressHUD showHUDAddedTo:MY_WINDOW animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    hud.bezelView.color = [UIColor whiteColor];
    
    if (mode == MBProgressHUDModeCustomView) {
        if (isSuccess) {
            hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Success_Out"]];
        }else{
            hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Failure_Out"]];
        }
    }
    if (mode)hud.mode = mode;
    if (titleString)hud.label.text = titleString;
    if (detailsString)hud.detailsLabel.text = detailsString;
    hud.label.font = FONT_ArialMT(13);
    hud.label.textColor = [UIColor Grey_WordColor];
    hud.detailsLabel.font = FONT_ArialMT(14);
    hud.detailsLabel.textColor = [UIColor Grey_WordColor];
    if (time > 0){
        [hud hideAnimated:YES afterDelay:time];
    }else{
        [hud hideAnimated:YES afterDelay:20.0];
    }
}

-(NSString *)getVersions//Versions
{
//    NSString * version = [NSString stringWithFormat:@"%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey]];
   NSString * version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    return version;
}


//实名认证通知
- (void)postCertificateNotice {
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_USER_Certificate object:nil];
}
//登入通知
- (void)postLoginNotice
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_USER_LOGIN object:nil];
}
//登出通知
- (void)postLogoutNotice
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_USER_LOGOUT object:nil];
}

//实名认证
- (void)certificateController:(UIViewController *)delegate success:(GoCertificateBlock)success {
    _goCertificateBlock = success;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTICE_USER_Certificate object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CertificateNotice) name:NOTICE_USER_Certificate object:nil];//实名认证
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"userToken":[UserData currentUser].userToken}] forKey:@"user.getRealName"];
    NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
    [dict setObject:json forKey:@"key"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"---real---%@", resultDic);
        if ([resultDic[@"resultData"][@"status"] integerValue]>0) {
             _goCertificateBlock();
        } else {
            [self showAlertControllerWithTitle:@"提示" detail:@"请先进行实名认证" doneTitle:@"确定" cancelTitle:@"取消" haveCancel:YES doneAction:^{
                CertificateListViewController *cer = [CertificateListViewController new];
                [delegate.navigationController pushViewController:cer animated:YES];
            } controller:delegate];
        }
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
    
}

//登录登出
- (void)loginPlan:(UIViewController *)delegate success:(LoginSuccessBlock)success failure:(LoginFailureBlock)failure
{
    __loginSuccessBlock = success;
    __loginFailureBlock = failure;
    
    if ([UserData currentUser].userName.length) {
        __loginSuccessBlock([UserData currentUser]);
        
    }else{
        MainLoginViewController *loginVC = [[MainLoginViewController alloc] init];
        TBNavigationController *navigat = [[TBNavigationController alloc] initWithRootViewController:loginVC];
        MY_WINDOW.rootViewController = navigat;
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTICE_USER_LOGIN object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LogInTorefresh) name:NOTICE_USER_LOGIN object:nil];//登入
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTICE_USER_LOGOUT object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LoginDismiss) name:NOTICE_USER_LOGOUT object:nil];//登出
}

-(void)CertificateNotice{
    _goCertificateBlock();
}
-(void)LoginDismiss{
    __loginFailureBlock([UserData currentUser]);
}

-(void)LogInTorefresh
{
    __loginSuccessBlock([UserData currentUser]);
}

- (void)refreshSelf:(RefreshSuccessBlock)success
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:@"" showAnimation:NO success:^(NSDictionary *resultDic,NSString *msg) {
        NSDictionary *dic = [resultDic objectForKey:@"data"];
        [[UserData currentUser] giveData:dic];
        success([UserData currentUser]);
    } failure:^(NSString *error, NSInteger errorCode) {
        if (errorCode == 2000) {
            [[UtilsData sharedInstance]  loginPlan:nil success:^(UserData *user) {
            } failure:^(UserData *user) {
            }];
        }
    }];
}



- (void)showAlertControllerWithTitle:(NSString *)title detail:(NSString *)detail doneTitle:(NSString *)donet cancelTitle:(NSString *)cancelt haveCancel:(BOOL)have doneAction:(AlertControllerDoneBlock)done controller:(UIViewController *)viewc {
    _doneBlock = done;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:detail preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:donet style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _doneBlock();
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelt style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
//    [cancel setValue:[UIColor Grey_WordColor] forKey:@"titleTextColor"];
    if (have) {
        [alert addAction:confirm];
        [alert addAction:cancel];
    } else {
        [alert addAction:confirm];
    }
    
    //修改标题
//    NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:title];
//    [alertControllerStr addAttribute:NSForegroundColorAttributeName value:[UIColor Grey_WordColor] range:NSMakeRange(0, title.length)];
//    [alertControllerStr addAttribute:NSFontAttributeName value:FONT_ArialMT(19) range:NSMakeRange(0, title.length)];
//    if (title.length) {
//        [alert setValue:alertControllerStr forKey:@"attributedTitle"];
//    }
    //修改提示
//    NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:detail];
//    [alertControllerMessageStr addAttribute:NSForegroundColorAttributeName value:[UIColor Grey_WordColor] range:NSMakeRange(0, detail.length)];
//    [alertControllerMessageStr addAttribute:NSFontAttributeName value:FONT_ArialMT(14) range:NSMakeRange(0, detail.length)];
//    if (detail.length) {
//        [alert setValue:alertControllerMessageStr forKey:@"attributedMessage"];
//    }
    [viewc presentViewController:alert animated:YES completion:nil];
}


//保存图片
- (void)saveImage:(UIImage *)image andBlock:(ClikBlock)club {
    _clikBlock = club;
    NSMutableArray *imageIds = [NSMutableArray array];
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        //写入图片到相册
        PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        //记录本地标识，等待完成后取到相册中的图片对象
        [imageIds addObject:req.placeholderForCreatedAsset.localIdentifier];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        NSLog(@"success = %d, error = %@", success, error);
        if (success)
        {
            _clikBlock(@"1");
//            NSLog(@"++++++");
//            //成功后取相册中的图片对象
//            __block PHAsset *imageAsset = nil;
//            PHFetchResult *result = [PHAsset fetchAssetsWithLocalIdentifiers:imageIds options:nil];
//            [result enumerateObjectsUsingBlock:^(PHAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                imageAsset = obj;
//                *stop = YES;
//            }];
//            if (imageAsset)
//            {
//                //加载图片数据
//                [[PHImageManager defaultManager] requestImageDataForAsset:imageAsset
//                                                                  options:nil
//                                                            resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
//                                                                NSLog(@"imagedata = %@", imageData);
//                                                            }];
//            }
        }
    }];
}


-(UIImage *)scaleAndRotateImage:(UIImage *)image resolution:(int)kMaxResolution maxSizeWithKB:(CGFloat) maxSize{
    CGImageRef imgRef = image.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = bounds.size.width / ratio;
        } else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = bounds.size.height * ratio;
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
        case UIImageOrientationUp:
            transform = CGAffineTransformIdentity;
            break;
        case UIImageOrientationUpMirrored:
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
        case UIImageOrientationDown:
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
        case UIImageOrientationLeftMirrored:
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationLeft:
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationRightMirrored:
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        case UIImageOrientationRight:
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
    }
    
    //每次绘制的尺寸 size，要把宽 width 和 高 height 转换为整数，防止绘制出的图片有白边
    UIGraphicsBeginImageContext(CGSizeMake((NSUInteger)(floorf(bounds.size.width)), (NSUInteger)(floorf(bounds.size.height))));
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    } else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, floorf(width), floorf(height)), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //调整大小
    NSData *imageData = UIImageJPEGRepresentation(imageCopy,1.0);
    CGFloat sizeOriginKB = imageData.length / 1024.0;
    
    CGFloat resizeRate = 0.9;
    while (sizeOriginKB > maxSize && resizeRate > 0.1) {
        imageData = UIImageJPEGRepresentation(imageCopy,resizeRate);
        sizeOriginKB = imageData.length / 1024.0;
        resizeRate -= 0.1;
    }
    return imageCopy;
}


- (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:target action:(SEL)action {
    UIButton *button = [[UIButton alloc] init];
    // 设置按钮的背景图片
    [button setBackgroundImage:IMG(imageName) forState:UIControlStateNormal];
    if (highImageName != nil) {
        [button setBackgroundImage:IMG(highImageName) forState:UIControlStateHighlighted];
    }
    // 设置按钮的尺寸为背景图片的尺寸
    button.size = button.currentBackgroundImage.size;
    button.adjustsImageWhenHighlighted = NO;
    //监听按钮的点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
