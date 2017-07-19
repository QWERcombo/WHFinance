//
//  NEUSecurityUtil.h
//  Smile
//
//  Created by apple on 15/8/25.
//  Copyright (c) 2015年 Weconex. All rights reserved.
//

#import "NEUSecurityUtil.h"
#import "NEUBase64.h"
#import "NSData+NEUAES.h"

#define Iv          @"" //偏移量,可自行修改
#define KEY         @"12345678901234567890123456789012" //key，可自行修改
//#define KEY      [UserData currentUser].Random_Key


@implementation NEUSecurityUtil

#pragma mark - base64
+ (NSString*)encodeBase64String:(NSString * )input { 
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]; 
    data = [NEUBase64 encodeData:data];
    
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	return base64String;
    
}

+ (NSString*)decodeBase64String:(NSString * )input { 
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]; 
    data = [NEUBase64 decodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	return base64String;
} 

+ (NSString*)encodeBase64Data:(NSData *)data {
	data = [NEUBase64 encodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	return base64String;
}

+ (NSString*)decodeBase64Data:(NSData *)data {
	data = [NEUBase64 decodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	return base64String;
}

#pragma mark - AES加密
//将string转成带密码的data
+(NSString*)neu_encryptAESData:(NSString*)string
{
    //将nsstring转化为nsdata
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    //使用密码对nsdata进行加密
//    NSData *encryptedData = [data AES128EncryptWithKey:KEY gIv:Iv];
//    NSLog(@"6*******%@", [[NSUserDefaults standardUserDefaults] valueForKey:@"secret_key"]);
//    NSData *encryptedData = [data AES256EncryptWithKey:KEY];
    NSData *encryptedData = [data AES256EncryptWithKey:[[NSUserDefaults standardUserDefaults] valueForKey:@"secret_key"]];
    
    //返回进行base64进行转码的加密字符串
    return [self encodeBase64Data:encryptedData];
}

#pragma mark - AES解密
//将带密码的data转成string
+(NSString*)neu_decryptAESData:(NSString *)string
{
    //base64解密
    NSData *decodeBase64Data=nil;
    decodeBase64Data=[NEUBase64 decodeString:string];
    
    //使用密码对data进行解密
//    NSData *decryData = [decodeBase64Data AES128DecryptWithKey:KEY gIv:Iv];
    
//    NSLog(@"7*******%@", [[NSUserDefaults standardUserDefaults] valueForKey:@"secret_key"]);
    
    //256解密
//    NSData *decryData = [decodeBase64Data AES256DecryptWithKey:KEY];
    NSData *decryData = [decodeBase64Data AES256DecryptWithKey:[[NSUserDefaults standardUserDefaults] valueForKey:@"secret_key"]];
    
    //将解了密码的nsdata转化为nsstring
    NSString *str = [[NSString alloc] initWithData:decryData encoding:NSUTF8StringEncoding];
//    ret = [[NSString alloc]initWithData:responseData encoding:enc];
//    NSString *str = [decryData utf8String];
    
//    NSLog(@"wwwwww%@", [[PublicFuntionTool sharedInstance] valueForKey:@"secret_key"]);
    return str;
}
#pragma  mark - RSA加密


#pragma  mark - Json字符串
+ (NSString *)FormatJSONString:(id)ob {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:ob options:NSJSONWritingPrettyPrinted error:nil];
    NSString *JSONString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return JSONString;
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


@end
