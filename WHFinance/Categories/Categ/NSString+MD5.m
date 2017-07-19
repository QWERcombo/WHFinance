//
//  NSString+MD5.m
//  MD5hash
//
//  Created by Web on 10/27/12.
//  Copyright (c) 2012 HappTech. All rights reserved.
//

#import "NSString+MD5.h"
//#import "YGTMBase64.h"
#import "NEUBase64.h"
#define gIv             @"01234567"
#define URLKEY      @"D3029C73406221B02026B684BB00579C"

@implementation NSString (MD5)
- (id)MD5
{
    const char *cStr = [self UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest ); // This is the md5 call

    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];

    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];

    return  output;
}
+ (NSMutableAttributedString *)changeFont:(NSArray *)changeArr content:(NSString *)contentStr andColor:(NSArray*)colorArr andFont:(NSArray *)fontArr
{
    NSMutableAttributedString * sString =[[NSMutableAttributedString alloc] initWithString:contentStr];
    for (int i= 0; i < changeArr.count; i ++) {
        NSLog(@"%@~~~%@~~~~%@",[colorArr objectAtIndex:i],[changeArr objectAtIndex:i],[fontArr objectAtIndex:i]);
        [sString addAttribute:NSForegroundColorAttributeName value:[colorArr objectAtIndex:i] range:[contentStr rangeOfString:[changeArr objectAtIndex:i]]];
        [sString addAttribute:NSFontAttributeName value:[fontArr objectAtIndex:i] range:[contentStr rangeOfString:[changeArr objectAtIndex:i]]];
    }
    return sString;
}
+(int)getTextHeightWithText:(NSString*)text andFont:(UIFont *)font andWidth:(float)width
{
    if (!text) {
        return 0;
    }
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    CGSize size = CGSizeMake(width, MAXFLOAT);
    size =[text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    
    return size.height;
}
+(CGSize)getSizeWithText:(NSString*)text andFont:(UIFont *)font andSize:(CGSize)size
{
    if (!text) {
        return CGSizeMake(0, 0);
    }
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    size =[text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    
    return size;
}
//转化为UTF-8
- (NSString*)configeUTF8
{
    NSString *codeStr = [NSString stringWithCString:[self UTF8String] encoding:NSUnicodeStringEncoding];
    return codeStr;
}
//分钟转换
- (NSString*)configeTimeWithMinute
{
    int mins = [self intValue];
    if (mins>60)
    {
        if (mins%60==0)
        {
            int hour = mins/60;
            return  [NSString stringWithFormat:@"%d小时",hour];
        }
        else{
            int hour = mins/60;
            int min = mins%60;
            return  [NSString stringWithFormat:@"%d小时%d分钟",hour,min];
        }
    }
    else
    {
        return  [NSString stringWithFormat:@"%d分钟",mins];
    }
}

//距离米转换
-(NSString*)configeTimeWithMeters
{
    int meter = [self intValue];
    if (meter<1000)
    {
        return [NSString stringWithFormat:@"%dm",meter];
    }
    else{
        float meters = meter/1000.0;
        return [NSString stringWithFormat:@"%0.1fkm",meters];
    }
}
//时间转换
+(NSString *)getUTCFormateDate:(NSString *)DateStr
{
    DateStr =[DateStr stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *newsDateFormatted = [dateFormatter dateFromString:DateStr];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    
    NSDate* current_date = [[NSDate alloc] init];
    
    NSTimeInterval time=[current_date timeIntervalSinceDate:newsDateFormatted];//间隔的秒数
    int month=((int)time)/(3600*24*30);
    int days=((int)time)/(3600*24);
    int hours=((int)time)%(3600*24)/3600;
    int minute=((int)time)%(3600*24)/60;
    
    NSString *dateContent;
    
    if(month!=0){
        
        dateContent = [NSString stringWithFormat:@"%i%@",month,@"个月前"];
        
    }else if(days!=0){
        
        dateContent = [NSString stringWithFormat:@"%i%@",days,@"天前"];
    }else if(hours!=0){
        
        dateContent = [NSString stringWithFormat:@"%i%@",hours,@"小时前"];
    }
    else
    {
        if (minute<3)
        {
            dateContent = [NSString stringWithFormat:@"   刚刚"];
        }
        else
        {
            dateContent = [NSString stringWithFormat:@"%@%i%@",@"   ",minute,@"分钟前"];
        }
    }
    return dateContent;
    
}

//年月转换
-(NSString*)configeTimeWithMonth
{
    int months = [self intValue];
    if (months<12) {
        return [NSString stringWithFormat:@"%d个月",months];
    }
    else{
        int years = months/12;
        int month = months%12;
        return [NSString stringWithFormat:@"%d年%d个月",years,month];
    }
}

//千分符
- (NSString *)money
{
    NSNumberFormatter *numFormat = [[NSNumberFormatter alloc] init];
    [numFormat setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *num = [NSNumber numberWithDouble:[self doubleValue]];
    
    return [numFormat stringFromNumber:num];
}
-(NSString *)configeMiriade{
    float num = [self floatValue];
    if (num > 6000) {
        NSString *numStr;
        if (num >10000) {
            NSArray *array = [SFLOAT(num/10000) componentsSeparatedByString:@"."];
            numStr =  [NSString stringWithFormat:@"%@万",[array objectAtIndex:0]];
        }else{
            numStr =  [NSString stringWithFormat:@"%@万",[SFLOAT(num/10000) substringToIndex:3]];
        }
        return numStr;
    }else{
        return self;
    }
}

/*手机号码验证 MODIFIED BY HELENSONG*/
-(BOOL)isValidateMobile
{
//    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^(1)\\d{10}$"] evaluateWithObject:self];
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^(13[0-9]|15[0|1|2|3|5|6|7|8|9]|18[0-9]|17[0|6|7]|14[5])\\d{8}$"] evaluateWithObject:self];
}

/*8-12数字与字母组合密码验证*/
-(BOOL)judgePassWordLegal{
    BOOL result = false;
    if ([self length] >= 8){
        // 判断长度大于8位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:self];
    }
    return result;
}

/*验证身份证号码*/
- (BOOL)judgeIdentityStringValid {
    
    if (self.length != 18) return NO;
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
    //  NSString *regex = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:self]) return NO;
    
    //** 开始进行校验 *//
    
    //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex = [[self substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum+= subStrIndex * idCardWiIndex;
    }
    
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [self substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2) {
        if(![idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    }
    else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            return NO;
        }
    }
    return YES;
}


// 加密方法
+ (NSString*)encrypt:(NSString*)plainText
{
    NSString *key = URLKEY;
    while (key.length<24)
    {
        key = [NSString stringWithFormat:@"%@%@",key,key];
    }
    key = [key stringByPaddingToLength:24 withString:key startingAtIndex:0];
    NSLog(@"======%@",key);
    
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    size_t plainTextBufferSize = [data length];
    const void *vplainText = (const void *)[data bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [key UTF8String];
    const void *vinitVec = (const void *) [gIv UTF8String];
    
    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    NSString *result = [NEUBase64 stringByEncodingData:myData];
    return result;
}

// 解密方法
+ (NSString*)decrypt:(NSString*)encryptText
{
    NSString *key = URLKEY;
    while (key.length<24)
    {
        key = [NSString stringWithFormat:@"%@%@",key,key];
        NSLog(@"%@",key);
    }
    key = [key stringByPaddingToLength:24 withString:key startingAtIndex:0];
    NSLog(@"======%@",key);
    
    NSData *encryptData = [NEUBase64 decodeData:[encryptText dataUsingEncoding:NSUTF8StringEncoding]];
    size_t plainTextBufferSize = [encryptData length];
    const void *vplainText = [encryptData bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [key UTF8String];
    const void *vinitVec = (const void *) [gIv UTF8String];
    
    ccStatus = CCCrypt(kCCDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSString *result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                                     length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding];
    return result;
}

+ (NSString*)stringFromFomate:(NSDate*)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *str = [formatter stringFromDate:date];
    return str;
}

+ (NSMutableDictionary*)queryStringToDictionary:(NSString*)string {
    NSMutableArray *elements = (NSMutableArray*)[string componentsSeparatedByString:@"&"];
    [elements removeObjectAtIndex:0];
    NSMutableDictionary *retval = [NSMutableDictionary dictionaryWithCapacity:[elements count]];
    for(NSString *e in elements) {
        NSArray *pair = [e componentsSeparatedByString:@"="];
        [retval setObject:[pair objectAtIndex:1] forKey:[pair objectAtIndex:0]];
    }
    return retval;
}

-(NSUInteger)textLength{
    
    int strlength = 0;
    
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    
    for (int i=0 ; i<[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        
        if (*p) {
            
            p++;
            
            strlength++;
            
        }
        
        else {
            
            p++;
            
        }
        
    }
    
    return (strlength+1)/2;
}


//----------------------------------------------------
//32位全大写字符串
+(NSString *)return32BigString{
    
    char data[32];
    
    for (int x=0;x<32;data[x++] = (char)('A'+ (arc4random_uniform(26))));
    
    return [[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
}
//32位全小写字符串
+(NSString *)return32LittleString{
    
    char data[32];
    
    for (int x=0;x<32;data[x++] = (char)('a'+ (arc4random_uniform(26))));
    
    return [[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
}

//返回16位大小写字母和数字
+(NSString *)return16LetterAndNumber{
    //定义一个包含数字，大小写字母的字符串
    NSString * strAll = @"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    //定义一个结果
    NSString * result = [[NSMutableString alloc]initWithCapacity:16];
    for (int i = 0; i < 16; i++)
    {
        //获取随机数
        NSInteger index = arc4random() % (strAll.length-1);
        char tempStr = [strAll characterAtIndex:index];
        result = (NSMutableString *)[result stringByAppendingString:[NSString stringWithFormat:@"%c",tempStr]];
    }
    
    return result;
}
//返回32位大小写字母和数字
+(NSString *)return32LetterAndNumber{
    //定义一个包含数字，大小写字母的字符串
    NSString * strAll = @"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    //定义一个结果
    NSString * result = [[NSMutableString alloc]initWithCapacity:32];
    for (int i = 0; i < 32; i++)
    {
        //获取随机数
        NSInteger index = arc4random() % (strAll.length-1);
        char tempStr = [strAll characterAtIndex:index];
        result = (NSMutableString *)[result stringByAppendingString:[NSString stringWithFormat:@"%c",tempStr]];
    }
    
    return result;
}



//小数点后两位
+ (NSString *)pointTailTwo:(NSString *)showStr {
    double temp_float = [showStr doubleValue];
    NSString *tempStr = [NSString stringWithFormat:@"￥%0.2lf",temp_float];
    return tempStr;
}

//除以100
- (NSString *)handleDataSourceTail {
    double temp = [self doubleValue]/100.0;
    NSString *tempss = [NSString stringWithFormat:@"%.2lf", temp];
    NSString *dataStr = [[NSString pointTailTwo:tempss] substringFromIndex:1];
    return dataStr;
}


- (NSString *)NSTimeIntervalTransToYear_Month_Day {
    NSTimeInterval tempMilli = [self doubleValue];
    
    NSTimeInterval seconds = tempMilli/1000.0;//这里的.0一定要加上，不然除下来的数据会被截断导致时间不一致
    
//    NSLog(@"传入的时间戳=%f",seconds);
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:seconds];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];//@"yyyy-MM-dd-HHMMss"
    
    return [formatter stringFromDate:date];
}



- (BOOL)checkBankCardNumber:(NSString* )cardNo
{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}



-(BOOL)IsChinese
{
    NSInteger count = self.length;
    NSInteger result = 0;
    for(int i=0; i< [self length];i++)
    {
        int a = [self characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)//判断输入的是否是中文
        {
            result++;
        }
    }
    if (count == result) {//当字符长度和中文字符长度相等的时候
        return YES;
    }
    return NO;
}





@end
