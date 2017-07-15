
//
//  AppDelegate.m
//  WHFinance
//
//  Created by wanhong on 2017/6/22.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "AppDelegate.h"
#import "MainLoginViewController.h"
#import "ViewController.h"


@interface AppDelegate ()
@property(nonatomic,strong)UIImageView *splashImageView;//闪屏页
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self theSplashScreen];//加载闪屏页
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1 animations:^{
            self.window.rootViewController.view.alpha = 1.0;
        } completion:^(BOOL finished) {
            [self.splashImageView removeFromSuperview];
            
            [[UtilsData sharedInstance] loginPlan:nil success:^(UserData *user) {//登入
                TBTabBarController *tabBarC = [[TBTabBarController alloc] init];
                [tabBarC setupchildVc:nil];
                self.window.rootViewController = tabBarC;
            } failure:^(UserData *user) {//登出
                MainLoginViewController *loginVC = [[MainLoginViewController alloc] init];
                TBNavigationController *navigat = [[TBNavigationController alloc] initWithRootViewController:loginVC];
                self.window.rootViewController = navigat;
            }];
            
            [self showGuideView];//加载引导图
            
        }];
    });
    
    [self addUmengSocial];//配置友盟
    
    
    return YES;
}

- (void)addUmengSocial {
    [[UMSocialManager defaultManager] openLog:YES];
    [[UMSocialManager defaultManager] setUmSocialAppkey:UmengAppkey];
    
    /* 设置微信的appKey和appSecret */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxdc1e388c3822c80b" appSecret:@"3baf1193c85774b3fd9d18447d76cab0" redirectURL:@"http://mobile.umeng.com/social"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx81c026b3f00ca9c1" appSecret:@"43898ddcbf7279214319a47d20f9957f" redirectURL:@"http://mobile.umeng.com/social"];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105821097"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3921700954"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    
}

//#define __IPHONE_10_0    100000
#if __IPHONE_OS_VERSION_MAX_ALLOWED > 100000
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响。
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

#endif

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}


- (void)theSplashScreen//闪屏
{
    self.window.rootViewController.view.alpha = 0;
    self.splashImageView = [[UIImageView alloc]initWithImage:IMG(@"Default")];
    self.splashImageView.frame = [UIScreen mainScreen].bounds;
    [self.window addSubview:self.splashImageView];
    
}
-(void)showGuideView{//加载引导图
    NSMutableArray *images = [NSMutableArray new];
    for (int i = 0; i < 3; i ++) {
        NSString *imgStr  = [NSString stringWithFormat:@"guide_%d",i];
        UIImage *IMG = IMG(imgStr);
        if (IMG) {
            [images addObject:IMG];
        }
    }
    if (images.count > 0) {
        [[TBGuideViewManager sharedInstance] showGuideViewWithImages:images andButtonTitle:@"立即进入" andButtonTitleColor:[UIColor whiteColor] andButtonBGColor:[UIColor mianColor:1] andButtonBorderColor:[UIColor whiteColor]];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSString *randomStr = [NSString return32LetterAndNumber];
    NSLog(@"%@", randomStr);
    NSString *passValue = @"";
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//    [dic setObject:randomStr forKey:@"Random_Key"];
    [[NSUserDefaults standardUserDefaults] setObject:randomStr forKey:@"secret_key"];
//    [[PublicFuntionTool sharedInstance] setValue:randomStr forKey:@"secret_key"];
//    [[UserData currentUser] giveData:dic];
//    NSLog(@"%@", [UserData currentUser].Random_Key);
    NSString *public_key_path = [[NSBundle mainBundle] pathForResource:@"rsa_public_key.der" ofType:nil];
    NSString *secret_key = [[NSUserDefaults standardUserDefaults] objectForKey:@"request_head"];
    
    if (secret_key.length) {
        NSLog(@"%@", secret_key);
        NSString *secret = [NSString stringWithFormat:@"%@%@", secret_key, randomStr];
        passValue = [RSAEncryptor encryptString:secret publicKey:public_key_path];
        
    } else {
        passValue = [RSAEncryptor encryptString:randomStr publicKeyWithContentsOfFile:public_key_path];
    }
    [dict setObject:passValue forKey:@"key"];
    
    [DataSend sendPostRequestToHandShakeWithBaseURL:base_ii Dictionary:dict WithType:@"" showAnimation:NO success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"-----%@", resultDic);
//        NSLog(@"***%@", [UserData currentUser].Random_Key);
        NSString *head = [NEUSecurityUtil neu_decryptAESData:resultDic[@"head"]];
        NSLog(@"+++++%@", head);
        [[NSUserDefaults standardUserDefaults] setObject:head forKey:@"request_head"];
        NSLog(@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"request_head"]);
        
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"WHFinance"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
