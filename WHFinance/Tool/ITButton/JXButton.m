//
//  JXButton.m
//  JXButtonDemo
//
//  Created by pconline on 2016/11/28.
//  Copyright © 2016年 pconline. All rights reserved.
//

#import "JXButton.h"

@implementation JXButton

- (instancetype)initWithFrame:(CGRect)frame withTitleFont:(UIFont *)font
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInitWithTitleFont:font];
    }
    return self;
}

- (void)commonInitWithTitleFont:(UIFont *)font{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.titleLabel.font = font;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleX = 0;
    CGFloat titleY = contentRect.size.height *0.75;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
//    CGFloat imageW = CGRectGetWidth(contentRect);
//    CGFloat imageH = contentRect.size.height;
    return CGRectMake((self.frame.size.width-35)/2, 0, 35, 35);
}

@end
