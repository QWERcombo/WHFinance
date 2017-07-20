//
//  PublicFuntionTool.m
//  WHFinance
//
//  Created by wanhong on 2017/7/7.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "PublicFuntionTool.h"
#import "TransOrder.h"


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
            _clikBlock(resultDic[@"resultData"]);
        }
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
}


- (void)uMengShareWithObject:(UMSocialPlatformType)dataType andBaseController:(BaseViewController *)controller {
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
//    NSString* thumbURL =  IMG(@"");
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"e万呗" descr:@"这是e万呗这是e万呗这是e万呗这是e万呗" thumImage:IMG(@"icon")];
    //设置网页地址
//    shareObject.webpageUrl = @"http://www.wanhongpay.com";
    shareObject.webpageUrl = @"http://115.182.112.97:10001/evolution-merchant-service/app_regin.jsp";
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

- (void)getRealName:(PassRealStatusBlock)block {//获取实名认证
    _statusBlock = block;
    //status  0待审核 1成功 2审核中
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"userToken":[UserData currentUser].userToken}] forKey:@"user.getRealName"];
    NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
    [dict setObject:json forKey:@"key"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:nil showAnimation:NO success:^(NSDictionary *resultDic, NSString *msg) {
//        NSLog(@"---real---%@", resultDic);
        NSString *statusNo = resultDic[@"resultData"][@"status"];
        _statusBlock(statusNo);
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
}

- (void)hangShake {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSString *randomStr = [NSString return32LetterAndNumber];
    //    NSLog(@"random---%@", randomStr);
    NSString *passValue = @"";
    [[NSUserDefaults standardUserDefaults] setObject:randomStr forKey:@"secret_key"];
    NSString *public_key_path = [[NSBundle mainBundle] pathForResource:@"rsa_public_key.der" ofType:nil];
    NSString *secret_key = [[NSUserDefaults standardUserDefaults] objectForKey:@"request_head"];
    
    if (secret_key.length) {
        NSString *random = [RSAEncryptor encryptString:randomStr publicKeyWithContentsOfFile:public_key_path];
        passValue = [NSString stringWithFormat:@"%@%@", secret_key, random];
        
    } else {
        passValue = [RSAEncryptor encryptString:randomStr publicKeyWithContentsOfFile:public_key_path];
        
    }
    [dict setObject:passValue forKey:@"key"];
    
    [DataSend sendPostRequestToHandShakeWithBaseURL:base_ii Dictionary:dict WithType:@"" showAnimation:NO success:^(NSDictionary *resultDic, NSString *msg) {
        
        //        NSLog(@"-----%@", resultDic);
        NSString *sss = [NSString stringWithFormat:@"%@",resultDic[@"head"]];
        NSString *head = [NEUSecurityUtil neu_decryptAESData:sss];
        //        NSLog(@"+++++%@", head);
        [[NSUserDefaults standardUserDefaults] setObject:head forKey:@"request_head"];
        //        NSLog(@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"request_head"]);
        
    } failure:^(NSString *error, NSInteger code) {
        
    }];
}

//查询订单状态
- (void)getOrderStatus:(PassOrderStatusBlock)order byOrderID:(NSString *)orderid {
    _orderBlock = order;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"userToken":[UserData currentUser].userToken,@"orderId":orderid}] forKey:@"transc.queryOrder"];
    NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
    [dict setObject:json forKey:@"key"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"++++%@", resultDic);
        TransOrder *order = [[TransOrder alloc] initWithDictionary:resultDic[@"resultData"] error:nil];
        _orderBlock(order);
    } failure:^(NSString *error, NSInteger code) {
        
    }];
}


//获取支付手续费
- (void)getOrderRate:(PassPayRateBlock)payRate WithCashAmount:(NSString *)cashA andSubProductId:(NSString *)subProID  {
    _rateBlock = payRate;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"userToken":[UserData currentUser].userToken,@"transAmount":cashA,@"subProductId":subProID}] forKey:@"transqury.queryOrderFee"];
    NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
    [dict setObject:json forKey:@"key"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSArray *dataArr = resultDic[@"resultData"];
        NSLog(@"%@0", dataArr);
        NSString *normal = [NSString stringWithFormat:@"%@", dataArr.firstObject];
        NSString *partner = [NSString stringWithFormat:@"%@", dataArr.lastObject];
        _rateBlock([normal handleDataSourceTail],[partner handleDataSourceTail]);
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
}


@end
