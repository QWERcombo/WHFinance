
//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖镇楼                  BUG辟易
//
//


//  Created by 265G on 15/8/10.
//  Copyright (c) 2015年 YXCompanion. All rights reserved.
//

#ifndef XiYouPartner_Defines_h
#define XiYouPartner_Defines_h

//登入登出通知
#define NOTICE_USER_LOGIN           @"user_login"
#define NOTICE_USER_LOGOUT          @"user_logout"
#define NOTICE_PUSH                 @"user_push"


//*************************************************************⬅️


//**************    地址   ***********************1️⃣

//《测试环境》
//#define  BASE_URL    @"http://192.168.0.113:10100/api/excute"
#define  BASE_URL    @"http://192.168.0.3:10100/api/excute"
//#define  BASE_URL    @"http://s1.gogotree.com"

//《正式环境》
//#define  BASE_URL    @"https://app.gogotree.com"

//***********************   APPID   ***********************2️⃣

#define APP_ID @"101"

//***********************    审核    ***********************3️⃣

#define AUDIT_UP @"0"//审核版
//#define AUDIT_UP @"1"//测试版

//*************************************************************➡️


























#define REQ_KEY_VERSION    @"ver"
#define REQ_KEY_PLATFORM   @"platform"
#define REQ_KEY_USERID     @"uid"

#define APPSTORE_URL    @"itms-apps://itunes.apple.com/cn/app/shou-you-ban-lu-shou-you-wan/id862872084?mt=8"

// 单例
#undef	AS_SINGLETON
#define AS_SINGLETON( __class ) \
+ (__class *)sharedInstance;

#undef	DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}


//所在头高
#define SECTIONHIGHT  [self.tabView rectForHeaderInSection:section].size.height


//设置图片
#define IMG(name) [UIImage imageNamed:name]


//Nsstring
#define SDOUBLE(db) [NSString stringWithFormat:@"%d",(int)db]
#define STRING(str) [NSString stringWithFormat:@"%@",str]//防止空字符串赋值崩溃
#define SINT(int) [NSString stringWithFormat:@"%ld",(long)int]
#define SINTEGER(int) [NSString stringWithFormat:@"%d",[int integerValue]]
#define SFLOAT(float) [NSString stringWithFormat:@"%f",float]
#define SFLOAT1(float) [NSString stringWithFormat:@"%.0f",float]

//默认图片
#define DEDINES_IMAGE [UIImage imageWithColor:[UIColor lightGrayColor]]

//判断屏幕长度
#define IPHONE5 ([[UIScreen mainScreen] bounds].size.height == 568)

//判断ios版本
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

//判断机器类型
#define isPad   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad   ? YES : NO)
#define isPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? YES : NO)
#define isRetina ([[UIScreen mainScreen] scale] > 1 ? YES : NO)
#define IS_NO_IPHONE  [[[UIDevice currentDevice] model] isEqualToString:@"iPad"]
//特别注意，在引用时必须加(SCREENHEIGHT)否则在ios7系统会出现控件坐标赋值失败
#define SCREENHEIGHT IOS7 ? SCREENheight : (SCREENheight-20)

//URL
#define URL_STRING(__urlString) [NSURL URLWithString:[__urlString stringByTrimmingCharactersInSet: [NSCharacterSet  whitespaceAndNewlineCharacterSet]]]

//keyWindow
#define  MY_WINDOW  [UIApplication sharedApplication].keyWindow

//友盟分享 app key
#define  UmengAppkey  @"595c59b775ca350c8a000814"


//极光推送key
//#define  JPAppkey  @"46a25dd3919f4448165eadac"
//#define  JPAppkey  @"e6dfe344d7637244d8ca5331"


/**
 *屏幕尺寸相关
 */
#define SCREEN_BOUNDS  ([[UIScreen mainScreen] bounds])
#define SCREEN_WIGHT   [UIScreen mainScreen].bounds.size.width//屏幕宽度
#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height//屏幕高度
#define NAVBAR_HEIGHT  (IS_IOS7?64:44)
/**
 *简化初始化
 */
#define YXRECT(X,Y,W,H) CGRectMake(X, Y, W, H)

/**
 *颜色
 */
#define COLOR_VALUE(r,g,b,a)   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
//临时替代
#define COLOR_TEMP [UIColor mianColor:1]
/**
 *字体
 */
#define FONT_Helvetica(s)  [UIFont fontWithName:@"Helvetica" size:s]
#define FONT_ArialMT(s)  [UIFont fontWithName:@"ArialMT" size:s]
#define FONT_BoldMT(s)   [UIFont fontWithName:@"Arial-BoldMT" size:s]
/**
 *name.plist
 */
#define READ_CACHE  @"ReadCache"
#define NIGHT_SWITCH  @"NightSwich"
#define HEAD_TOP  @"headTop"

#define ANSWER  @"development"
#define SUPPORT  @"support_Zan"

#define ReloadGiftList_Main @"reloadGiftListmain"
#define ReloadGiftList_Circle @"reloadGiftListcircle"

#endif
