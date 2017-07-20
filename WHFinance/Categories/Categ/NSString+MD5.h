//
//  NSString+MD5.h
//  MD5hash
//
//  Created by Web on 10/27/12.
//  Copyright (c) 2012 HappTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>
@interface NSString (MD5)
//md5加密
- (id)MD5;
//改变字体形态
+ (NSMutableAttributedString *)changeFont:(NSArray *)changeArr content:(NSString *)contentStr andColor:(NSArray*)colorArr andFont:(NSArray *)fontArr;
//获取字符串高度
+(int)getTextHeightWithText:(NSString*)text andFont:(UIFont *)font andWidth:(float)width;

//获取字符串尺寸
+(CGSize)getSizeWithText:(NSString*)text andFont:(UIFont *)font andSize:(CGSize)size;

//转化为UTF-8
- (NSString *)configeUTF8;

//转化为分钟
- (NSString *)configeTimeWithMinute;

//转化为距离米
- (NSString *)configeTimeWithMeters;

//转化为年月
-(NSString *)configeTimeWithMonth;

//转化为俗语时间描述
+(NSString *)getUTCFormateDate:(NSString *)DateStr;

//时间转换
+(NSString *)stringFromFomate:(NSDate*)date;

//千分符
-(NSString *)money;

-(NSString *)configeMiriade;

//是否正确手机格式
-(BOOL)isValidateMobile;

//验证密码
-(BOOL)judgePassWordLegal;

//验证身份证号码
- (BOOL)judgeIdentityStringValid;

// 加密方法
+(NSString *)encrypt:(NSString*)plainText;

// 解密方法
+(NSString *)decrypt:(NSString*)encryptText;

//get参数转字典
+ (NSMutableDictionary*)queryStringToDictionary:(NSString*)string;

//字符长度 2个字母为一个字符 一个汉字为一个字符
-(NSUInteger)textLength;
//小数点后两位
+(NSString *)pointTailTwo:(NSString *)showStr;

//32位全大写字符串
+(NSString *)return32BigString;
//32位全小写字符串
+(NSString *)return32LittleString;
//返回16位大小写字母和数字
+(NSString *)return16LetterAndNumber;
//返回32位大小写字母和数字
+(NSString *)return32LetterAndNumber;

//除以100处理返回数据
- (NSString *)handleDataSourceTail;

//精确到毫秒的时间戳转年月日
- (NSString *)NSTimeIntervalTransToYear_Month_Day;

//检查银行卡
- (BOOL)checkBankCardNumber:(NSString* )cardNo;
//输入的是否都是中文
- (BOOL)IsChinese;
//输入纯数字
- (BOOL)deptNumInputShouldNumber;





@end
