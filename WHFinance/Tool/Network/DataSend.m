//
//  DataSend.m
//  XiYouPartner
//
//  Created by 265G on 15/8/10.
//  Copyright (c) 2015年 YXCompanion. All rights reserved.
//

#import "DataSend.h"

static NSOperationQueue *queue;

@implementation DataSend

#pragma mark - POST

+(void)verdictResponseString:(id)response
{
    [[UtilsData sharedInstance]hideAlert];
    if (response == nil) {
        NSLog(@"WARNING:数据为空");
        [[UtilsData sharedInstance]showAlertTitle:@"数据返回异常" detailsText:nil time:1.5 aboutType:MBProgressHUDModeCustomView state:NO];
        return;
    }else{
        NSLog(@"访问成功~~~~~~~ ✔️✔️✔️ ");
    }
}

+(NSString *)getPostByWithType:(NSString*)type
{
    NSString *httpStr = [NSString stringWithFormat:@"%@/%@",BASE_URL,type];
    return httpStr;
}

+(NSMutableDictionary *)getPostByParameters:(NSMutableDictionary*)params
{
    [DataSend addBasicParameters:params];
    NSArray *aryKeys = [params allKeys];
    //排序
    aryKeys = [aryKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *number1 = obj1 ;
        NSString *number2 = obj2 ;
        NSComparisonResult result = [number1 compare:number2];
        return result == NSOrderedDescending; // 升序
        //return result == NSOrderedAscending;  // 降序
    }];
    NSMutableString *paramsStr = [NSMutableString stringWithCapacity:100];
    
    for (NSString *str in aryKeys ){
        //        if ([params objectForKey:str]!=[NSNull null]&&[[params objectForKey:str] length]>0){
        if ([params objectForKey:str]!=[NSNull null]){
            
            if (paramsStr.length==0){
                [paramsStr appendFormat:@"%@=%@",str,[params objectForKey:str]];
            }
            else{
                [paramsStr appendFormat:@"&%@=%@",str,[params objectForKey:str]];
            }
        }
    }
    [paramsStr replaceOccurrencesOfString:@"+" withString:@" " options:NSLiteralSearch range:NSMakeRange(0, [paramsStr length])];
    return params;
}

+(void)sendPostWastedRequestWithBaseURL:(NSString *)baseUrl valueDictionary:(NSMutableDictionary*)dict imageArray:(NSArray *)imgArr WithType:(NSString*)type andCookie:(NSString *)cookie showAnimation:(BOOL)animation success:(SuccessBlock)success failure:(FailureBlock)failure{
//    NSDictionary *valueDic = [DataSend getPostByParameters:dict];
    NSMutableDictionary *valueDic = [[NSMutableDictionary alloc] init];
    NSString *httpStr = [NSString stringWithFormat:@"%@/%@",baseUrl,type];
//    NSLog(@"链接 🔗🔗 == %@>>&cookie:%@,参数 == %@",httpStr,cookie,dict);
    //加密
    NSString *jsonValueStr = dict[@"key"];
    NSString *head = [[NSUserDefaults standardUserDefaults] valueForKey:@"request_head"];
//    NSLog(@"%@", head);
    NSString *value = [NSString stringWithFormat:@"%@%@", head, [NEUSecurityUtil neu_encryptAESData:jsonValueStr]];
//    NSLog(@"%@",value);
    [valueDic setValue:value forKey:@"key"];
    [DataSend AFHTTPRequestWithURL:httpStr valueDictionary:valueDic imageArray:imgArr andCookie:cookie showAnimation:animation success:success failure:failure];
    
}

+(void)sendPostRequestToHandShakeWithBaseURL:(NSString *)baseUrl Dictionary:(NSMutableDictionary*)dict  WithType:(NSString*)type showAnimation:(BOOL)animation success:(SuccessBlock)success failure:(FailureBlock)failure {
    NSString *httpStr = [NSString stringWithFormat:@"%@/%@",baseUrl,type];
    NSLog(@"链接 🔗🔗 == %@>>参数 == %@",httpStr,dict);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.requestSerializer.timeoutInterval = 20.f;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json", nil];
        
        [manager POST:baseUrl parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            //打印下上传进度
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //请求成功
            [DataSend verdictResponseString:responseObject];
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            
            NSString *code = [NSString stringWithFormat:@"%@", [resultDic objectForKey:@"resultCode"]];//0为成功
            NSString *msg = [NSString stringWithFormat:@"%@", [resultDic objectForKey:@"resultMsg"]];//返回信息
            if ([code integerValue]==0){
                //NSLog(@" 🍺🍺 %@",resultDic);
                success(resultDic,msg);
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                });
            }
            else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    failure(msg,[code integerValue]);
                    if (animation == YES) {
                        if (msg) {
                            [[UtilsData sharedInstance]showAlertTitle:msg detailsText:nil time:1.5 aboutType:MBProgressHUDModeText state:NO];
                        }
                    }
                });
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //请求失败
            failure(error.localizedFailureReason,1);
            [[UtilsData sharedInstance]showAlertTitle:@"加载失败，请检查网络是否通畅" detailsText:nil time:2.5 aboutType:MBProgressHUDModeCustomView state:NO];
            NSLog(@"failure about error~%@",error);
        }];
    });
    if (animation == YES) {
        [[UtilsData sharedInstance]showAlertTitle:@"加载中..." detailsText:nil time:0 aboutType:MBProgressHUDModeIndeterminate state:NO];
    }
}

+(void)AFHTTPRequestWithURL:(NSString *)URLString valueDictionary:(NSDictionary *)valueDic imageArray:(NSArray *)imgArr andCookie:(NSString *)cookie showAnimation:(BOOL)animation success:(SuccessBlock)success failure:(FailureBlock)failure
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        if (cookie)[manager.requestSerializer setValue:cookie forHTTPHeaderField:@"cookie"];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.requestSerializer.timeoutInterval = 20.f;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json", nil];
        
        
        [manager POST:URLString parameters:valueDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            //上传文件参数
            for (UIImage *img in imgArr ) {
                NSData *imageData = UIImageJPEGRepresentation([[UtilsData sharedInstance] scaleAndRotateImage:img resolution:800 maxSizeWithKB:600], 1.0);
//                NSString *imageBase64Str = [NEUSecurityUtil encodeBase64Data:imageData];
//                NSData *imageData = UIImageJPEGRepresentation(img, 1.0);
                [formData appendPartWithFileData:imageData name:@"ufile" fileName:@"image.jpg" mimeType:@"image/jpeg"];
            }
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            //打印下上传进度
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //请求成功
            [DataSend verdictResponseString:responseObject];
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
//            NSLog(@"=+++++%@", result);
            NSString *value = [NEUSecurityUtil neu_decryptAESData:result[@"head"]];//获取数据字符串
            NSDictionary *resultDic = [NEUSecurityUtil dictionaryWithJsonString:value];//字符串转字典
//            NSLog(@" 🍔🍔 %@",resultDic);
            NSString *code = [NSString stringWithFormat:@"%@", [result objectForKey:@"resultCode"]];//0为成功
            NSString *msg = [NSString stringWithFormat:@"%@", [result objectForKey:@"resultMsg"]];//返回信息
//            NSLog(@"%@-----%@", code, msg);
            if ([code integerValue]==0){      //请求成功
//                NSLog(@" 🍺🍺 %@",resultDic);
                success(resultDic,msg);
//                success(result,msg);
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                });
            } else {                          //请求失败
                dispatch_async(dispatch_get_main_queue(), ^{
                    failure(msg,[code integerValue]);
                    if (animation == YES) {
                        if (msg) {
                            [[UtilsData sharedInstance]showAlertTitle:msg detailsText:nil time:1.5 aboutType:MBProgressHUDModeText state:NO];
                        }
                    }
                    if ([code integerValue]==36866) {//重新登录
                        [[UtilsData sharedInstance] postLogoutNotice];
                    }
                    if ([code integerValue]==36865) {//重新握手
                        [[PublicFuntionTool sharedInstance] hangShake];
                    }
                });
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //请求失败
            failure(error.localizedFailureReason,1);
            [[UtilsData sharedInstance]showAlertTitle:@"加载失败，请检查网络是否通畅" detailsText:nil time:2.5 aboutType:MBProgressHUDModeCustomView state:NO];
            NSLog(@"failure about error~%@",error);
        }];
    });
    if (animation == YES) {
        
        [[UtilsData sharedInstance]showAlertTitle:@"加载中..." detailsText:nil time:30.0 aboutType:MBProgressHUDModeIndeterminate state:NO];
    }
}


+(void)cancelAllRequest{
    [queue cancelAllOperations];
    [[UtilsData sharedInstance]hideAlert];
}

#pragma mark  版本信息
+ (void)addBasicParameters:(NSMutableDictionary *)aParameters
{
    if(aParameters){
//        NSString * version = [[UtilsData sharedInstance] getVersions];
//        [aParameters safeSetObject:version forKey:REQ_KEY_VERSION];
//        [aParameters safeSetObject:@"IOS" forKey:REQ_KEY_PLATFORM];
//        [aParameters safeSetObject:APP_ID forKey:@"appId"];
        
    }
}

@end

