//
//  UIButton+YXP.h
//  YouXiPartner
//
//  Created by 265G on 15-1-26.
//  Copyright (c) 2015年 YXP. All rights reserved.
//

#import <UIKit/UIKit.h>


//@protocol UIbuttonDelegate <NSObject>
//
//-(void)touchesMoveTheView:(NSSet *)touches withEvent:(UIEvent *)event;
//
//@end

@interface UIButton (YXP)


//右侧按钮
+ (UIButton *)buttonForGamePackWithTitle:(NSString *)title andNormalColor:(UIColor *)normalColor;


//用户头像
+ (UIButton *)buttonForUserHeadWithAvatarPath:(NSString *)avatarPath;

//上图标下文本的button
+ (UIButton *)buttonWithImage:(NSString *)imageName text:(NSString *)titleText TextColor:(UIColor *)color Font:(UIFont *)font redNumber:(int)number showRed:(BOOL)isShowRed;
//
- (void)setImageWithURLPath:(NSString *)urlPath;
//自定义高亮按钮
+ (UIButton *)buttonWithTitle:(NSString *)title andFont:(UIFont *)font andtitleNormaColor:(UIColor *)normalColor andHighlightedTitle:(UIColor *)lightedTitle andNormaImage:(UIImage *)normalImage andHighlightedImage:(UIImage *)lightedImage;
@end

