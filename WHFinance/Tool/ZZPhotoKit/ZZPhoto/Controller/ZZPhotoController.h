//
//  ZZPhotoController.h
//  ZZFramework
//
//  Created by Yuan on 15/12/16.
//  Copyright © 2015年 zzl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZResourceConfig.h"
typedef enum
{
    ZZPhotoHeader       = 0,//头像
    ZZPhotoHomePage     = 1,//主页封面
    ZZPhotoCircle       = 2,//动态
    ZZPhotoHomePage_photo       = 3,//主页相册
}ZZPhotoTypes;
/*
 *    设置Block
 */
typedef void (^ZZPhotoResult)(id responseObject);


@interface ZZPhotoController : NSObject
/*
 *    设置圆点颜色
 */
@property(strong,nonatomic) UIColor *roundColor;
/*
 *    选择照片的最多张数
 */
@property(assign,nonatomic) NSInteger selectPhotoOfMax;
/*
 *    设置回调方法
 */
-(void)showIn:(UIViewController *)controller withType:(ZZPhotoTypes)type result:(ZZPhotoResult)result;

@end
