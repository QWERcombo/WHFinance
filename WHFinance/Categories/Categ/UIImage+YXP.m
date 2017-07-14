//
//  UIImage+YXP.m
//  YouXiPartner
//
//  Created by 265G on 15-1-27.
//  Copyright (c) 2015年 YXP. All rights reserved.
//

#import "UIImage+YXP.h"
#import <Accelerate/Accelerate.h>
@implementation UIImage (YXP)

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

//+ (UIImage *)imageWithRenderColor:(UIColor *)color withImage:(UIImage *)image
//{
//    UIImage *cIMG = image;
//    UIGraphicsBeginImageContextWithOptions(cIMG.size, NO, cIMG.scale);
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    
//    CGContextTranslateCTM(ctx, 0, cIMG.size.height);
//    CGContextScaleCTM(ctx, 1.0, -1.0);
//    CGContextSetBlendMode(ctx, kCGBlendModeNormal);
//    CGRect rect = CGRectMake(0, 0, cIMG.size.width, cIMG.size.height);
//    CGContextClipToMask(ctx, rect, cIMG.CGImage);
//    [color setFill];
//    CGContextFillRect(ctx, rect);
//    cIMG = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    return cIMG;
//}

+ (UIImage *)imageMaskedWithColor:(UIColor *)color strokeColor:(UIColor *)strokeColor andImageName:(NSString *)name
{
    UIImage *bubbleImage = [UIImage imageNamed:name];
    UIImage *strokeImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_stroke",name]];
    CGRect imageRect = CGRectMake(0.0f, 0.0f, bubbleImage.size.width, bubbleImage.size.height);
    UIImage *newImage = nil;
    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, bubbleImage.scale);
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(context, 1.0f, -1.0f);
        CGContextTranslateCTM(context, 0.0f, -(imageRect.size.height));
        CGContextSetBlendMode(context, kCGBlendModeNormal);
        if (color) {
            // 设置底色
            CGContextClipToMask(context, imageRect, bubbleImage.CGImage);
            CGContextSetFillColorWithColor(context, color.CGColor);	CGContextFillRect(context, imageRect);
            [color setFill];
        }
        if (strokeColor) {
            // 设置描边色
            CGContextClipToMask(context, imageRect, strokeImage.CGImage);
            CGContextSetFillColorWithColor(context, strokeColor.CGColor);
        }
        
        CGContextFillRect(context, imageRect);
        newImage = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();
    return newImage;
}


+ (UIImage *)oldImage:(UIImage *)oldImage toSize:(CGSize)size{
    
    UIImage *newImage = nil;//新照片对象
    CGSize theSize = oldImage.size;//压缩前图片size
    
    CGFloat width = theSize.width; //压缩前图片width
    CGFloat height = theSize.height;//压缩前图片height
    
    CGFloat newWidth = size.width; //压缩后图片width
    CGFloat newHeight = size.height;//压缩后图片height
    
    CGFloat scaleFactor = 0.0;//初值
    
    CGFloat toWidth = newWidth;//压缩后图片width
    CGFloat toHeight = newHeight;//压缩后图片height
    
    CGPoint thumnailPoint = CGPointMake(0.0, 0.0);//给初值
    
    if (CGSizeEqualToSize(theSize, size) == NO) {
        //判断是不是已经满足 theSize = size 要求
        
        CGFloat widthFac = newWidth/width;
        CGFloat heithrFac = newHeight/height;
        if (widthFac > heithrFac) {
            scaleFactor = widthFac;
        }else {
            scaleFactor = heithrFac;
        }
        //不满足做等比例缩小处理
        toWidth = width *scaleFactor;
        toHeight = height *scaleFactor;
        
        if (widthFac > heithrFac) {
            thumnailPoint.y = (newHeight - toHeight)* 0.5;
        }else if (widthFac < heithrFac){
            thumnailPoint.x = (newWidth - toWidth)* 0.5;
        }
    }
    
    //创建context,并将其设置为正在使用的context
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect  = CGRectZero;
    thumbnailRect.origin = thumnailPoint;
    thumbnailRect.size.width = toWidth;
    thumbnailRect.size.height = toHeight;
    
    //绘制出图片(大小已经改变)
    [oldImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //结果判断
    if (newImage == nil) {
        [NSException exceptionWithName:@"提示" reason:@"Error:image scale fail" userInfo:nil];
    }
    UIGraphicsEndImageContext();
    return newImage;
}

// 添加通用模糊效果
// image是图片，blur是模糊度
+(UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur
{
    if (image==nil)
    {
        NSLog(@"error:为图片添加模糊效果时，未能获取原始图片");
        return nil;
    }
    //模糊度,
    if (blur < 0.025f) {
        blur = 0.025f;
    } else if (blur > 1.0f) {
        blur = 1.0f;
    }
    
    //boxSize必须大于0
    int boxSize = (int)(blur * 100);
    boxSize -= (boxSize % 2) + 1;
    NSLog(@"boxSize:%i",boxSize);
    //图像处理
    CGImageRef img = image.CGImage;
    //需要引入#import <Accelerate/Accelerate.h>
    
    //图像缓存,输入缓存，输出缓存
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    //像素缓存
    void *pixelBuffer;
    
    //数据源提供者，Defines an opaque type that supplies Quartz with data.
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    // provider’s data.
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    //宽，高，字节/行，data
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    //像数缓存，字节行*图片高
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    // 第三个中间的缓存区,抗锯齿的效果
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outBuffer2;
    outBuffer2.data = pixelBuffer2;
    outBuffer2.width = CGImageGetWidth(img);
    outBuffer2.height = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    //Convolves a region of interest within an ARGB8888 source image by an implicit M x N kernel that has the effect of a box filter.
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    //    NSLog(@"字节组成部分：%zu",CGImageGetBitsPerComponent(img));
    //颜色空间DeviceRGB
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //用图片创建上下文,CGImageGetBitsPerComponent(img),7,8
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             CGImageGetBitmapInfo(image.CGImage));
    
    //根据上下文，处理过的图片，重新组件
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    free(pixelBuffer2);
    CFRelease(inBitmapData);
    //CGColorSpaceRelease(colorSpace);   //多余的释放
    CGImageRelease(imageRef);
    return returnImage;
}

+(UIImage *)extensionTheImage:(UIImage *)img andTop:(CGFloat)top andBottom:(CGFloat)bottom andLeft:(CGFloat)left andRight:(CGFloat)right {
    UIImage *image = img;
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    return image;
}


+ (UIImage *)createQRCodeImageWithSourceData:(NSString *)sourceData {
    // 1.创建滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 2.恢复默认设置
    [filter setDefaults];
    
    // 3.设置数据
    NSString *info = sourceData;
    NSData *infoData = [info dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:infoData forKeyPath:@"inputMessage"];
    
    // 4.生成二维码
    CIImage *outputImage = [filter outputImage];
    return [outputImage createNonInterpolatedWithSize:200];
}


+ (NSUInteger)getImageKBSize:(UIImage *)image {
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    return imageData.length/1024;
}

@end
