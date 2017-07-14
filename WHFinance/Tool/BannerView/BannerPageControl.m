//
//  BannerPageControl.m
//  BarProgram
//
//  Created by frank on 2017/4/10.
//  Copyright © 2017年 t_b. All rights reserved.
//

#import "BannerPageControl.h"
#define dotW 10
#define magrin 5
@implementation BannerPageControl

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutSubviews];
    }
    return self;
}

- (void)layoutSubviews {
    //    [super layoutSubviews];
    
    //计算圆点间距
    
    CGFloat marginX = dotW + magrin - 1;
    
    //计算整个pageControll的宽度
    
    CGFloat newW = (self.subviews.count - 1) * marginX;
    
    //设置新frame
    self.frame = CGRectMake(SCREEN_WIGHT - newW - 20, self.frame.origin.y, newW, self.frame.size.height);
    
    //遍历subview,设置圆点frame
    for (int i=0; i<[self.subviews count]; i++) {
        
        UIImageView* dot = [self.subviews objectAtIndex:i];
        
        if (i == self.currentPage) {
            
            [dot setFrame:CGRectMake(i * marginX, dot.frame.origin.y, dotW, dotW)];
            
        }else {
            
            [dot setFrame:CGRectMake(i * marginX, dot.frame.origin.y, dotW, dotW)];
            
        }
        
    }
}

@end
