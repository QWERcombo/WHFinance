//
//  UIButton+YXP.m
//  YouXiPartner
//
//  Created by 265G on 15-1-26.
//  Copyright (c) 2015年 YXP. All rights reserved.
//

#import "UIButton+YXP.h"

#import <objc/runtime.h>
#define PADDING     5
static void *DragEnableKey = &DragEnableKey;
static void *AdsorbEnableKey = &AdsorbEnableKey;
@implementation UIButton (YXP)

+ (UIButton *)buttonForGamePackWithTitle:(NSString *)title andNormalColor:(UIColor *)normalColor
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.clipsToBounds=YES;
    button.layer.cornerRadius=5.0;
    button.titleLabel.font=[UIFont fontWithSize:18.0];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor: normalColor forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor Grey_LineColor] forState:UIControlStateDisabled];
    [button setBackgroundImage:[UIImage imageWithColor:normalColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
    return button;
    
}
+ (UIButton *)buttonWithTitle:(NSString *)title andFont:(UIFont *)font andtitleNormaColor:(UIColor *)normalColor andHighlightedTitle:(UIColor *)lightedTitle andNormaImage:(UIImage *)normalImage andHighlightedImage:(UIImage *)lightedImage
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (font)button.titleLabel.font = font;
    if (title)[button setTitle:title forState:UIControlStateNormal];
    if (normalColor) [button setTitleColor: normalColor forState:UIControlStateNormal];
    if (lightedTitle) [button setTitleColor:lightedTitle forState:UIControlStateHighlighted];
    if (normalImage) [button setBackgroundImage:normalImage forState:UIControlStateNormal];
    if (lightedImage) [button setBackgroundImage:lightedImage forState:UIControlStateHighlighted];
    return button;
}

+ (UIButton *)buttonForUserHeadWithAvatarPath:(NSString *)avatarPath
{
    UIButton * button =[UIButton new];
    button.layer.cornerRadius=35/2;
    button.clipsToBounds=YES;
    [button setBackgroundImage:[UIImage imageNamed:@"nav_avatar"] forState:UIControlStateNormal];
    
    [button setImageWithURLPath:avatarPath];
    UIImageView * coverImage=[UIImageView new];
    coverImage.userInteractionEnabled=YES;
    [button addSubview:coverImage];
    coverImage.backgroundColor=[UIColor clearColor];
    [coverImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(button);
    }];
    
    return button;
    
}

+ (UIButton *)buttonWithImage:(NSString *)imageName text:(NSString *)titleText TextColor:(UIColor *)color Font:(UIFont *)font redNumber:(int)number showRed:(BOOL)isShowRed
{
    UIButton * button =[UIButton buttonWithType:UIButtonTypeSystem];
    UIImage * image =[UIImage imageNamed:imageName];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    
    if (titleText) {
        UILabel * lb =[UILabel lableWithText:titleText Font:font TextColor:color];
        lb.textAlignment=NSTextAlignmentCenter;
        [button addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(button.mas_bottom).with.offset(5);
            make.centerX.equalTo(button.mas_centerX);
            make.height.equalTo(@(13));
        }];
    }
    
    if (isShowRed == YES) {
        NSString *redNumber = SINT(number);
        if (number == 0) {
            redNumber = @"";
        }
        float height = SCREEN_WIGHT/30;
        UILabel *redLab = [UILabel lableWithText:redNumber Font:[UIFont fontWithName:@"Helvetica-Bold" size:height-2] TextColor:[UIColor whiteColor]];
        redLab.backgroundColor = [UIColor redColor];
        redLab.clipsToBounds = YES;
        redLab.layer.cornerRadius = height/2;
        redLab.textAlignment = NSTextAlignmentCenter;
        [button addSubview:redLab];
        CGSize labelsize1 = [UILabel getSizeWithText:redNumber andFont:redLab.font andSize:CGSizeMake(height*8, height)];
        float windth = [redNumber length] > 0?labelsize1.width + SCREEN_WIGHT/64:0 ;
        [redLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(button.mas_top);
            make.left.equalTo(button.mas_right).with.offset(- SCREEN_WIGHT/30);
            make.height.equalTo(@(height));
            make.width.equalTo(@(windth));
        }];
    }
    return button;
}

- (void)setImageWithURLPath:(NSString *)urlPath
{
//#warning 添加图片
}


@end
