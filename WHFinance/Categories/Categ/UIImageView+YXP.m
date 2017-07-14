//
//  UIImageView+YXP.m
//  YouXiPartner
//
//  Created by 265G on 15-1-27.
//  Copyright (c) 2015年 YXP. All rights reserved.
//

#import "UIImageView+YXP.h"

@implementation UIImageView (YXP)

+ (UIImageView *)imageViewWithImageName:(NSString *)imageName
{
    UIImageView * imageView = [UIImageView new];
    if([imageName length] >0)imageView.image=[UIImage imageNamed:imageName];
    [imageView setUserInteractionEnabled:YES];
    return imageView;
}

@end
