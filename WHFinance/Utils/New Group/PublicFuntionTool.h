//
//  PublicFuntionTool.h
//  WHFinance
//
//  Created by wanhong on 2017/7/7.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMSocialCore/UMSocialCore.h>


@interface PublicFuntionTool : NSObject

AS_SINGLETON(PublicFuntionTool);

//发送验证码
- (void)getSmsCodeByPhoneString:(NSString *)phone;

//调用分享
- (void)uMengShareWithObject:(UMSocialPlatformType)dataType andBaseController:(BaseViewController *)controller;

//获取星期几
- (NSString *) getweekDayStringWithDate;

//图片转base64字符串
- (NSString *)getBase64StringFrom:(UIImage *)image;

//获取实名认证的状态 YES是NO否
- (BOOL)getRealName;


@end
