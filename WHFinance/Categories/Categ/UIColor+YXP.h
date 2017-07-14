//
//  UIColor+YXP.h
//  YouXiPartner
//
//  Created by 265G on 15-1-26.
//  Copyright (c) 2015年 YXP. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    mianType   = 0,//主题色
    titleType  = 1,//文字颜色
    oTitleType = 2,//操作文字颜色
    iconType   = 3,//icon颜色
}
colorTypes;

@interface UIColor (YXP)

+ (UIColor *)colorWithR:(CGFloat)R G:(CGFloat)G B:(CGFloat)B A:(CGFloat)A;

+ (UIColor *)YXPBlueColor;

+ (UIColor *)Black_BlackColor;

+ (UIColor *)Black_WordColor;

+ (UIColor *)Grey_BackColor;

+ (UIColor *)Grey_BackColor1;

+ (UIColor *)Grey_LineColor;

+ (UIColor *)Grey_WordColor;

+ (UIColor *)YXPYellowColor;

+ (UIColor *)Grey_OrangeColor;

+ (UIColor *)Grey_NameColor;

+ (UIColor *)Grey_LikeColor;

+ (UIColor *)Grey_ContentColor;

+ (UIColor *)Grey_CommentColor;

+ (UIColor *)Grey_PurColor;

+ (UIColor *)Grey_BlankColor;

+ (UIColor *)mianColor:(colorTypes)type;//主题色

// 颜色转换：iOS中（以#开头）十六进制的颜色转换为UIColor(RGB)
+ (UIColor *) colorWithHexString: (NSString *)color;

@end
