//
//  YXUtil.m
//  YouXiBanLv
//
//  Created by 265G on 14-7-22.
//  Copyright (c) 2014年 WuHanYouXi. All rights reserved.
//

#import "YXPUtil.h"

@implementation YXPUtil

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageWithNameWithOutCache:(NSString *)name
{
    return [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath],name]];
}
+(void)setSubViewToAutolayout:(UIView *)autoView
{
    [autoView setTranslatesAutoresizingMaskIntoConstraints:YES];
}
+ (UITextField *)creatUITextField:(NSString *)placeText Font:(UIFont *)font TextBordStyle:(UITextBorderStyle)bordStyle TextColor:(UIColor *)textColor
{
    UITextField * textField =[UITextField new];
    textField.textColor=textColor;
    textField.placeholder=placeText;
    textField.borderStyle=bordStyle;
    textField.font=font;
    [textField setValue:textColor forKeyPath:@"_placeholderLabel.textColor"];
    [self setSubViewToAutolayout:textField];
    return textField;
}
+ (UILabel *)creatUILable:(NSString *)text Font:(UIFont *)font TextColor:(UIColor *)textColor
{
    UILabel * lable = [UILabel new];
    lable.text=text;
    lable.font=font;
    lable.textColor=textColor;
    [self setSubViewToAutolayout:lable];
    return lable;
}
+ (UIView *)creatUIView:(UIColor *)bgColor
{
    UIView * view = [UIView new];
    view.backgroundColor=bgColor;
    [self setSubViewToAutolayout:view];
    return view;
}
+ (UIButton *)creatUIButtonWithBG:(NSString *)nomalIconName selectedIconName:(NSString *)selectedIconName Action:(SEL)action Target:(id)targt
{
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    if(nomalIconName) [button setImage:[self imageWithNameWithOutCache:nomalIconName] forState:UIControlStateNormal];
    if(selectedIconName) [button setImage:[self imageWithNameWithOutCache:selectedIconName] forState:UIControlStateHighlighted];
    if(selectedIconName) [button setImage:[self imageWithNameWithOutCache:selectedIconName] forState:UIControlStateSelected];
    [button addTarget:targt action:action forControlEvents:UIControlEventTouchUpInside];
    [self setSubViewToAutolayout:button];
    return button;
}
+(UIButton *)creatUIButton:(NSString *)title NomalImageName:(NSString *)nomalImageName SelectedImage:(NSString *)selectedImageName Action:(SEL)action Target:(id)targt
{
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundImage:[self imageWithNameWithOutCache:nomalImageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[self imageWithNameWithOutCache:selectedImageName] forState:UIControlStateSelected];
    [button setBackgroundImage:[self imageWithNameWithOutCache:selectedImageName] forState:UIControlStateHighlighted];
    [button addTarget:targt action:action forControlEvents:UIControlEventTouchUpInside];
    [self setSubViewToAutolayout:button];
    return button;
}
+ (UIButton *)creatUIButton:(NSString *)title NomalImageColor:(UIColor *)nomalImageColor SelectedImageColor:(UIColor *)selectedImageColor Action:(SEL)action Target:(id)targt
{
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    if(nomalImageColor)[button setBackgroundImage:[self imageWithColor:nomalImageColor] forState:UIControlStateNormal];
    if(selectedImageColor)[button setBackgroundImage:[self imageWithColor:selectedImageColor] forState:UIControlStateSelected];
    if(selectedImageColor)[button setBackgroundImage:[self imageWithColor:selectedImageColor] forState:UIControlStateHighlighted];
    [button addTarget:targt action:action forControlEvents:UIControlEventTouchUpInside];
    [self setSubViewToAutolayout:button];
    return button;
}
+ (UIImageView *)creatUIImageView:(NSString *)imageName
{
    UIImageView * imageView = [UIImageView new];
    imageView.image=[self imageWithNameWithOutCache:imageName];
    imageView.userInteractionEnabled=YES;
    [self setSubViewToAutolayout:imageView];
    return imageView;
}
@end


