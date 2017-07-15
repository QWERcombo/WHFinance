//
//  PublicFuntionTool.m
//  WHFinance
//
//  Created by wanhong on 2017/7/7.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "PublicFuntionTool.h"

@implementation PublicFuntionTool
DEF_SINGLETON(PublicFuntionTool);

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (void)getSmsCodeByPhoneString:(NSString *)phone {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"param":@{@"mobile":phone,@"type":@"register"}}] forKey:@"common.sendMsgCode"];
    NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
    [dict setObject:json forKey:@"key"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        if (resultDic) {
            [[UtilsData sharedInstance] showAlertTitle:@"短信验证码" detailsText:@" 已发送!" time:2 aboutType:MBProgressHUDModeText state:YES];
//            self.codeToken = resultDic[@"resultData"];
        }
        
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
}


- (void)uMengShareWithObject:(UMSocialPlatformType)dataType andBaseController:(BaseViewController *)controller {
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
//    NSString* thumbURL =  IMG(@"");
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"贪财猫" descr:@"贪财猫贪财猫" thumImage:IMG(@"login_logo")];
    //设置网页地址
    shareObject.webpageUrl = @"http://www.wanhongpay.com";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:dataType messageObject:messageObject currentViewController:controller completion:^(id data, NSError *error) {
        
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        
    }];
    
    
}

- (NSString *) getweekDayStringWithDate

{
    
    NSDate *date = [NSDate date];
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]; // 指定日历的算法
    NSDateComponents *comps = [calendar components:NSCalendarUnitWeekday fromDate:date];
    // 1 是周日，2是周一 3.以此类推
    NSNumber * weekNumber = @([comps weekday]);
    NSInteger weekInt = [weekNumber integerValue];
    NSString *weekDayString = @"";
    switch (weekInt) {
        case 1:
        {
            weekDayString = @"周日";
        }
            break;
        case 2:
        {
            weekDayString = @"周一";
        }
            break;
        case 3:
            
        {
            weekDayString = @"周二";
        }
            break;
        case 4:
            
        {
            weekDayString = @"周三";
        }
            break;
        case 5:
        {
            weekDayString = @"周四";
        }
            break;
        case 6:
        {
            weekDayString = @"周五";
        }
            break;
        case 7:
        {
            weekDayString = @"周六";
        }
            break;
        default:
            break;
    }
    
    return weekDayString;
    
}


- (NSString *)getBase64StringFrom:(UIImage *)image {
    NSData *imageData = UIImageJPEGRepresentation([[UtilsData sharedInstance] scaleAndRotateImage:image resolution:800 maxSizeWithKB:600], 0.9);
    NSString *imageBase64Str = [NEUSecurityUtil encodeBase64Data:imageData];
    return imageBase64Str;
}

- (BOOL)getRealName {//获取实名认证
    //status  0待审核 1成功 2审核中
    __block BOOL isReal=NO;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"userToken":[UserData currentUser].userToken}] forKey:@"user.getRealName"];
    NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
    [dict setObject:json forKey:@"key"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:nil showAnimation:NO success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"---real---%@", resultDic);
        if ([resultDic[@"resultData"][@"status"] integerValue]==1) {
            isReal = YES;
        } else {
            isReal = NO;
        }
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
    return isReal;
}



@end
