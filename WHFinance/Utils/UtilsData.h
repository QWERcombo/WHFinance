//
//  UtilsData.h
//  XiYouPartner
//
//  Created by 265G on 15/8/13.
//  Copyright (c) 2015年 YXCompanion. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <AssetsLibrary/AssetsLibrary.h>
typedef enum
{
  types = 1
}
Types;
typedef void(^parameterBlcok)(void);

@interface UtilsData : NSObject<UIAlertViewDelegate, UIActionSheetDelegate>

typedef void (^ClikBlock)(NSString *clueStr);
@property (nonatomic, copy) ClikBlock clikBlock;
typedef void (^GoCertificateBlock)(void);
typedef void (^LoginSuccessBlock)(UserData *user);
typedef void (^LoginFailureBlock)(UserData *user);
typedef void (^RefreshSuccessBlock)(UserData *user);
typedef void (^PassSuccessBlock)(NSString *msg, NSString *message);
typedef void (^AlertControllerDoneBlock)(void);
@property (nonatomic, copy) LoginFailureBlock _loginFailureBlock;
@property (nonatomic, copy) LoginSuccessBlock _loginSuccessBlock;
@property (nonatomic, copy) parameterBlcok parameterBlock;
@property (nonatomic, copy) GoCertificateBlock goCertificateBlock;
@property (nonatomic, copy) AlertControllerDoneBlock doneBlock;
@property (nonatomic, strong) BaseViewController *parameterController;

AS_SINGLETON(UtilsData);

-(MJRefreshGifHeader *)MJRefreshNormalHeaderTarget:(id)target table:(UIScrollView *)scrollView actionSelector:(SEL)action;//下拉刷新

-(MJRefreshAutoGifFooter *)MJRefreshAutoNormalFooterTarget:(id)target table:(UIScrollView *)scrollView actionSelector:(SEL)action;//上拉加载

//UICollectionView上拉加载
-(void)MJRefreshAutoNormalCollectionViewFooterTarget:(id)target table:(UICollectionView *)collectionView actionSelector:(SEL)action;
//UICollectionView下拉更新
-(void)MJRefreshAutoNormalCollectionViewHeaderTarget:(id)target table:(UICollectionView *)collectionView actionSelector:(SEL)action;


//提示框
-(void)showAlertTitle:(NSString *)titleString detailsText:(NSString *)detailsString time:(float)time aboutType:(MBProgressHUDMode)mode  state:(BOOL)isSuccess
;
//隐藏提示框
-(void)hideAlert;
//获得版本号
-(NSString *)getVersions;

//实名认证通知
- (void)postCertificateNotice;
//登入通知
- (void)postLoginNotice;
//登出通知
- (void)postLogoutNotice;

//登录进入
- (void)loginPlan:(UIViewController *)delegate success:(LoginSuccessBlock)success failure:(LoginFailureBlock)failure;
//实名认证回调
- (void)certificateController:(UIViewController *)delegate success:(GoCertificateBlock)success;

//刷新用户数据
- (void)refreshSelf:(RefreshSuccessBlock)success;

- (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:target action:(SEL)action;

//AlertController
- (void)showAlertControllerWithTitle:(NSString *)title detail:(NSString *)detail doneTitle:(NSString *)donet cancelTitle:(NSString *)cancelt haveCancel:(BOOL)have doneAction:(AlertControllerDoneBlock)done controller:(UIViewController *)viewc;

//保存图片
- (void)saveImage:(UIImage *)image andBlock:(ClikBlock)club;

//压缩图片上传
-(UIImage *)scaleAndRotateImage:(UIImage *)image resolution:(int)kMaxResolution maxSizeWithKB:(CGFloat) maxSize;


@end
