//
//  UIImage+YXP.h
//  YouXiPartner
//
//  Created by 265G on 15-1-27.
//  Copyright (c) 2015年 YXP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YXP)

+ (UIImage *)imageWithColor:(UIColor *)color;//颜色转图片
+ (UIImage *)imageMaskedWithColor:(UIColor *)color strokeColor:(UIColor *)strokeColor andImageName:(NSString *)name;//染色+图形描边
//+ (UIImage *)imageWithRenderColor:(UIColor *)color withImage:(UIImage *)image;//染色
+ (UIImage *)imageWithNameWithOutCache:(NSString *)name;
// 图片等比例压缩
+ (UIImage *)oldImage:(UIImage *)oldImage toSize:(CGSize)size;

+(UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;//通用模糊效果

+(UIImage *)extensionTheImage:(UIImage *)img andTop:(CGFloat)top andBottom:(CGFloat)bottom andLeft:(CGFloat)left andRight:(CGFloat)right;//图片拉伸

//生成二维码图片
+ (UIImage *)createQRCodeImageWithSourceData:(NSString *)sourceData;

//获取图片的大小kb
+ (NSUInteger)getImageKBSize:(UIImage *)image;

@end
