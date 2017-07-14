//
//  ZZPhotoListViewController.h
//  ZZFramework
//
//  Created by Yuan on 15/12/17.
//  Copyright © 2015年 zzl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZResourceConfig.h"
//typedef enum
//{
//    ZZPhotoHeader       = 0,//头像
//    ZZPhotoHomePage     = 1,//主页封面
//    ZZPhotoCircle       = 2,//动态
//    ZZPhotoHomePage_photo       = 3,//主页相册
//}ZZPhotoTypes;
@interface ZZPhotoListViewController : UIViewController
@property (nonatomic, assign) NSInteger selectNum;
@property (nonatomic,   copy) void (^photoResult)(id responseObject);
@property (nonatomic, assign) NSString *nameTpye;
@end
