//
//  UIColor+YXP.m
//  YouXiPartner
//
//  Created by 265G on 15-1-26.
//  Copyright (c) 2015年 YXP. All rights reserved.
//

#import "UIColor+YXP.h"

@implementation UIColor (YXP)
//http://www.jianshu.com/p/79e4dd8a44bc
+ (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

+ (UIColor *)colorWithR:(CGFloat)R G:(CGFloat)G B:(CGFloat)B A:(CGFloat)A
{
    return [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A];
}

+ (UIColor *)YXPBlueColor
{
    return [UIColor colorWithR:0 G:128 B:255 A:1];
}
+ (UIColor *)Black_WordColor{
    return [UIColor colorWithHexString:@"#27293b"];
}

+ (UIColor *)Black_BlackColor
{
    return [UIColor colorWithR:41 G:39 B:54 A:1];
}

+ (UIColor *)Grey_BackColor//深
{
    return [UIColor colorWithR:153 G:153 B:153 A:1];
}
+ (UIColor *)Grey_BackColor1//浅
{
    return [UIColor colorWithR:245 G:245 B:245 A:1];
}
+ (UIColor *)Grey_LineColor
{
    return [UIColor colorWithR:221 G:221 B:221 A:1];
}

+ (UIColor *)Grey_WordColor
{
    return [UIColor colorWithR:51 G:51 B:51 A:1];
}

+ (UIColor *)YXPYellowColor
{
    return [UIColor colorWithR:250 G:150 B:4 A:1];
}

+ (UIColor *)Grey_OrangeColor {//橙
//    return [UIColor colorWithR:0xf7 G:0x94 B:0x1d A:1];
    return [UIColor colorWithR:243 G:152 B:0 A:1];
}

+ (UIColor *)Grey_NameColor {
    return [UIColor colorWithR:0x6b G:0x79 B:0x9d A:1];
}

+ (UIColor *)Grey_CommentColor {
    return [UIColor colorWithR:0x93 G:0x94 B:0x9d A:1];
}

+ (UIColor *)Grey_ContentColor {
    return [UIColor colorWithR:0x27 G:0x29 B:0x3b A:1];
}

+ (UIColor *)Grey_LikeColor {
    return [UIColor colorWithR:235 G:51 B:15 A:1];
}

+ (UIColor *)Grey_PurColor {
    return [UIColor colorWithR:0x82 G:0x51 B:0xff A:1];
}

+ (UIColor *)Grey_BlankColor {
    return [UIColor colorWithR:0xed G:0xed B:0xed A:1];
}

+ (UIColor *)mianColor:(colorTypes)type
{
    if (type == 1) {
        return  [UIColor colorWithR:235 G:73 B:73 A:1];
    } else if(type==2) {
        return  [UIColor colorWithR:102 G:102 B:102 A:1];
    } else {
        return [UIColor colorWithR:253 G:183 B:173 A:1];
    }
}
//+ (UIColor *)mianColor:(colorTypes)type
//{
//    switch ([[UserData currentUser].theme integerValue]) {
//        case 1:
//        {
//            if (type == 0) {
//                return  [UIColor colorWithRed:((CGFloat)0x1e/255.0) green:((CGFloat)0xa1/255.0) blue:((CGFloat)0xf3/255.0) alpha:1];//天蓝#1ea1f3
//            }else if (type == 1){
//                return [UIColor colorWithRed:((CGFloat)0xff/255.0) green:((CGFloat)0xff/255.0) blue:((CGFloat)0xff/255.0) alpha:1];//纯净白#ffffff
//                
//            }else if (type == 2){
//                return  [UIColor colorWithRed:((CGFloat)0x1e/255.0) green:((CGFloat)0xa1/255.0) blue:((CGFloat)0xf3/255.0) alpha:1];//天蓝#1ea1f3
//            }else{
//                return  [UIColor colorWithRed:((CGFloat)0x1e/255.0) green:((CGFloat)0xa1/255.0) blue:((CGFloat)0xf3/255.0) alpha:1];//天蓝#1ea1f3
//            }
//            
//        }
//            break;
//        case 2:
//        {
//            if (type == 0) {
//                return [UIColor colorWithRed:((CGFloat)0xd4/255.0) green:((CGFloat)0x3b/255.0) blue:((CGFloat)0x33/255.0) alpha:1];//朱砂红#d43b33;
//            }else if (type == 1){
//                return [UIColor colorWithRed:((CGFloat)0xff/255.0) green:((CGFloat)0xff/255.0) blue:((CGFloat)0xff/255.0) alpha:1];//纯净白#ffffff
//                
//            }else if (type == 2){
//                return [UIColor colorWithRed:((CGFloat)0xd4/255.0) green:((CGFloat)0x3b/255.0) blue:((CGFloat)0x33/255.0) alpha:1];//朱砂红#d43b33;
//            }else{
//                return [UIColor colorWithRed:((CGFloat)0xd4/255.0) green:((CGFloat)0x3b/255.0) blue:((CGFloat)0x33/255.0) alpha:1];//朱砂红#d43b33;
//            }
//        }
//            break;
//        case 3:
//        {
//            if (type == 0) {
//                return [UIColor colorWithRed:((CGFloat)0x37/255.0) green:((CGFloat)0xb6/255.0) blue:((CGFloat)0x6d/255.0) alpha:1];//杨柳绿#37b66d;
//            }else if (type == 1){
//                return [UIColor colorWithRed:((CGFloat)0xff/255.0) green:((CGFloat)0xff/255.0) blue:((CGFloat)0xff/255.0) alpha:1];//纯净白#ffffff
//                
//            }else if (type == 2){
//                return [UIColor colorWithRed:((CGFloat)0x37/255.0) green:((CGFloat)0xb6/255.0) blue:((CGFloat)0x6d/255.0) alpha:1];//杨柳绿#37b66d;
//            }else{
//                return [UIColor colorWithRed:((CGFloat)0x37/255.0) green:((CGFloat)0xb6/255.0) blue:((CGFloat)0x6d/255.0) alpha:1];//杨柳绿#37b66d;
//            }
//            
//        }
//            break;
//        case 4:
//        {
//            if (type == 0) {
//                return [UIColor colorWithRed:((CGFloat)0xeb/255.0) green:((CGFloat)0x81/255.0) blue:((CGFloat)0x10/255.0) alpha:1];//橙黄#eb8110;
//            }else if (type == 1){
//                return [UIColor colorWithRed:((CGFloat)0xff/255.0) green:((CGFloat)0xff/255.0) blue:((CGFloat)0xff/255.0) alpha:1];//纯净白#ffffff
//                
//            }else if (type == 2){
//                return [UIColor colorWithRed:((CGFloat)0xeb/255.0) green:((CGFloat)0x81/255.0) blue:((CGFloat)0x10/255.0) alpha:1];//橙黄#eb8110;
//            }else{
//                return [UIColor colorWithRed:((CGFloat)0xeb/255.0) green:((CGFloat)0x81/255.0) blue:((CGFloat)0x10/255.0) alpha:1];//橙黄#eb8110;
//            }
//            
//        }
//            break;
//        case 5:
//        {
//            if (type == 0) {
//                return [UIColor colorWithRed:((CGFloat)0xf7/255.0) green:((CGFloat)0x58/255.0) blue:((CGFloat)0x6e/255.0) alpha:1];//胭脂粉#f7586e ;
//            }else if (type == 1){
//                return [UIColor colorWithRed:((CGFloat)0xff/255.0) green:((CGFloat)0xff/255.0) blue:((CGFloat)0xff/255.0) alpha:1];//纯净白#ffffff
//                
//            }else if (type == 2){
//                return [UIColor colorWithRed:((CGFloat)0xf7/255.0) green:((CGFloat)0x58/255.0) blue:((CGFloat)0x6e/255.0) alpha:1];//胭脂粉#f7586e ;
//            }else{
//                return [UIColor colorWithRed:((CGFloat)0xf7/255.0) green:((CGFloat)0x58/255.0) blue:((CGFloat)0x6e/255.0) alpha:1];//胭脂粉#f7586e ;
//            }
//            
//        }
//            break;
//        case 6:
//        {
//            if (type == 0) {
//                return [UIColor colorWithRed:((CGFloat)0xff/255.0) green:((CGFloat)0xd9/255.0) blue:((CGFloat)0x46/255.0) alpha:1];//暖黄#ffd946;
//            }else if (type == 1){
//                return [UIColor colorWithRed:((CGFloat)0x33/255.0) green:((CGFloat)0x33/255.0) blue:((CGFloat)0x33/255.0) alpha:1];//文字#333333;
//            }else if (type == 2){
//                return [UIColor colorWithRed:((CGFloat)0xff/255.0) green:((CGFloat)0xb7/255.0) blue:((CGFloat)0x46/255.0) alpha:1];//可操作文字#ffb746 ;
//            }else{
//                return [UIColor colorWithRed:((CGFloat)0xff/255.0) green:((CGFloat)0xd9/255.0) blue:((CGFloat)0x46/255.0) alpha:1];//暖黄#ffd946;
//            }
//            
//        }
//            break;
//        case 7:
//        {
//            if (type == 0) {
//                return [UIColor colorWithRed:((CGFloat)0x23/255.0) green:((CGFloat)0x24/255.0) blue:((CGFloat)0x28/255.0) alpha:1];//经典黑#232428;
//                
//            }else if (type == 1){
//                return [UIColor colorWithRed:((CGFloat)0xff/255.0) green:((CGFloat)0xff/255.0) blue:((CGFloat)0xff/255.0) alpha:1];//文字#ffffff;
//                
//            }else if (type == 2){
//                return [UIColor colorWithRed:((CGFloat)0x06/255.0) green:((CGFloat)0x9f/255.0) blue:((CGFloat)0x9c/255.0) alpha:1];//色值#069f9c;
//                
//            }else{
//                return [UIColor colorWithRed:((CGFloat)0x06/255.0) green:((CGFloat)0x9f/255.0) blue:((CGFloat)0x9c/255.0) alpha:1];//色值#069f9c;
//                
//            }
//        }
//            break;
//        case 8:
//        {
//            if (type == 0) {
//                return  [UIColor colorWithRed:((CGFloat)0x39/255.0) green:((CGFloat)0x3a/255.0) blue:((CGFloat)0x4e/255.0) alpha:1];//深沉灰#393a4e;
//                
//            }else if (type == 1){
//                return [UIColor colorWithRed:((CGFloat)0xff/255.0) green:((CGFloat)0xff/255.0) blue:((CGFloat)0xff/255.0) alpha:1];//文字#ffffff;
//                
//            }else if (type == 2){
//                return [UIColor colorWithRed:((CGFloat)0x46/255.0) green:((CGFloat)0x86/255.0) blue:((CGFloat)0xc0/255.0) alpha:1];//色值#4686c0;
//                
//            }else{
//                return [UIColor colorWithRed:((CGFloat)0x46/255.0) green:((CGFloat)0x86/255.0) blue:((CGFloat)0xc0/255.0) alpha:1];//色值#4686c0;
//            }
//        }
//            break;
//        case 9:
//        {
//            if (type == 0) {
//                return [UIColor colorWithRed:((CGFloat)0xff/255.0) green:((CGFloat)0xff/255.0) blue:((CGFloat)0xff/255.0) alpha:1];//纯净白#ffffff
//            }else if (type == 1){
//                return [UIColor colorWithRed:((CGFloat)0x33/255.0) green:((CGFloat)0x33/255.0) blue:((CGFloat)0x33/255.0) alpha:1];//文字#333333 ;
//                
//            }else if (type == 2){
//                return [UIColor colorWithRed:((CGFloat)0xff/255.0) green:((CGFloat)0xae/255.0) blue:((CGFloat)0x00/255.0) alpha:1];//色值#ffae00;
//            }else{
//                return [UIColor colorWithRed:((CGFloat)0xff/255.0) green:((CGFloat)0xae/255.0) blue:((CGFloat)0x00/255.0) alpha:1];//色值#ffae00;
//            }
//            
//        }
//            break;
//        case 10:
//        {
//            if (type == 0) {
//                return [UIColor colorWithRed:((CGFloat)0xff/255.0) green:((CGFloat)0xff/255.0) blue:((CGFloat)0xff/255.0) alpha:1];//纯净白#ffffff
//            }else if (type == 1){
//                return [UIColor colorWithRed:((CGFloat)0x33/255.0) green:((CGFloat)0x33/255.0) blue:((CGFloat)0x33/255.0) alpha:1];//文字#333333 ;
//                
//            }else if (type == 2){
//                return [UIColor colorWithRed:((CGFloat)0x00/255.0) green:((CGFloat)0x7c/255.0) blue:((CGFloat)0xf0/255.0) alpha:1];//色值#007cf0;
//            }else{
//                return [UIColor colorWithRed:((CGFloat)0x00/255.0) green:((CGFloat)0x7c/255.0) blue:((CGFloat)0xf0/255.0) alpha:1];//色值#007cf0;
//            }
//            
//        }
//            break;
//        case 11:
//        {
//            if (type == 0) {
//                return [UIColor colorWithRed:((CGFloat)0xff/255.0) green:((CGFloat)0xff/255.0) blue:((CGFloat)0xff/255.0) alpha:1];//纯净白#ffffff ;
//            }else if (type == 1){
//                return [UIColor colorWithRed:((CGFloat)0x33/255.0) green:((CGFloat)0x33/255.0) blue:((CGFloat)0x33/255.0) alpha:1];//文字#333333 ;
//                
//            }else if (type == 2){
//                return [UIColor colorWithRed:((CGFloat)0xe1/255.0) green:((CGFloat)0x15/255.0) blue:((CGFloat)0x38/255.0) alpha:1];//色值#e11538;
//            }else{
//                return [UIColor colorWithRed:((CGFloat)0xe1/255.0) green:((CGFloat)0x15/255.0) blue:((CGFloat)0x38/255.0) alpha:1];//色值#e11538;
//            }
//            
//        }
//            break;
//        case 12:
//        {
//            if (type == 0) {
//                return [UIColor colorWithRed:((CGFloat)0x61/255.0) green:((CGFloat)0x19/255.0) blue:((CGFloat)0x87/255.0) alpha:1];//神秘紫#611987;
//            }else if (type == 1){
//                return [UIColor colorWithRed:((CGFloat)0xff/255.0) green:((CGFloat)0xff/255.0) blue:((CGFloat)0xff/255.0) alpha:1];//纯净白#ffffff
//                
//            }else if (type == 2){
//                return [UIColor colorWithRed:((CGFloat)0x61/255.0) green:((CGFloat)0x19/255.0) blue:((CGFloat)0x87/255.0) alpha:1];//神秘紫#611987;
//            }else{
//                return [UIColor colorWithRed:((CGFloat)0x61/255.0) green:((CGFloat)0x19/255.0) blue:((CGFloat)0x87/255.0) alpha:1];//神秘紫#611987;
//            }
//        }
//            break;
//        default:
//            break;
//    }
//    
//
//    if (type == 0) {
//        return [UIColor colorWithRed:((CGFloat)0x61/255.0) green:((CGFloat)0x19/255.0) blue:((CGFloat)0x87/255.0) alpha:1];//神秘紫#611987;
//    }else if (type == 1){
//        return [UIColor colorWithRed:((CGFloat)0xff/255.0) green:((CGFloat)0xff/255.0) blue:((CGFloat)0xff/255.0) alpha:1];//纯净白#ffffff
//        
//    }else if (type == 2){
//        return [UIColor colorWithRed:((CGFloat)0x61/255.0) green:((CGFloat)0x19/255.0) blue:((CGFloat)0x87/255.0) alpha:1];//神秘紫#611987;
//    }else{
//        return [UIColor colorWithRed:((CGFloat)0x61/255.0) green:((CGFloat)0x19/255.0) blue:((CGFloat)0x87/255.0) alpha:1];//神秘紫#611987;
//    }
//    
//}


@end
