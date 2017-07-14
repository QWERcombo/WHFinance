//
//  YXUtil.h
//  YouXiBanLv
//
//  Created by 265G on 14-7-22.
//  Copyright (c) 2014年 WuHanYouXi. All rights reserved.
//

typedef void(^ImageComplete)(void);

#import <Foundation/Foundation.h>

@interface YXPUtil : NSObject

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithNameWithOutCache:(NSString *)name;

//UI helper
+ (UITextField *)creatUITextField:(NSString *)placeText Font:(UIFont *)font TextBordStyle:(UITextBorderStyle)bordStyle TextColor:(UIColor *)textColor;

+ (UILabel *)creatUILable:(NSString *)text Font:(UIFont *)font TextColor:(UIColor *)textColor;

+ (UIView *)creatUIView:(UIColor *)bgColor;

+ (UIButton *)creatUIButton:(NSString *)title NomalImageName:(NSString *)nomalImageName SelectedImage:(NSString *)selectedImageName Action:(SEL)action Target:(id)targt;

+ (UIButton *)creatUIButton:(NSString *)title NomalImageColor:(UIColor *)nomalImageColor SelectedImageColor:(UIColor *)selectedImageColor Action:(SEL)action Target:(id)targt;

+ (UIButton *)creatUIButtonWithBG:(NSString *)nomalIconName selectedIconName:(NSString *)selectedIconName Action:(SEL)action Target:(id)targt;

+ (UIImageView *)creatUIImageView:(NSString *)imageName;


@end










