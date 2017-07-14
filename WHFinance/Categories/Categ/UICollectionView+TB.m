//
//  UICollectionView+TB.m
//  BarProgram
//
//  Created by youqin on 2017/3/27.
//  Copyright © 2017年 t_b. All rights reserved.
//

#import "UICollectionView+TB.h"

@implementation UICollectionView (TB)

-(id)showHeardPopWithNummber:(NSInteger)num{
    
    UILabel *ll = [self viewWithTag:923];
    [ll removeFromSuperview];
    
    UILabel *l = [UILabel lableWithText:@"" Font:FONT_ArialMT(14) TextColor:[UIColor colorWithR:147 G:148 B:151 A:1]];
    l.tag = 923;
    if (num >0) {
        NSString *beforeStr = @"已为你推荐了在场 ";
        NSString *numStr = [NSString stringWithFormat:@"%ld",(long)num];
        NSString *allComment = [NSString stringWithFormat:@"%@%@ 人",beforeStr,numStr];
        l.attributedText = [UILabel labGetAttributedStringFrom:beforeStr.length toEnd:numStr.length WithColor:[UIColor colorWithR:255 G:239 B:54 A:1] andFont:FONT_ArialMT(22) allFullText:allComment];
    }else{
        l.text = @"已经没有更多内容";
    }
    l.textAlignment = NSTextAlignmentCenter;
    l.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    l.frame = CGRectMake(0, 0, SCREEN_WIGHT, 0);
    [self addSubview:l];
    [UIView animateWithDuration:0.5 animations:^{
        l.frame = CGRectMake(0, 0, SCREEN_WIGHT, 30);
        
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.5 animations:^{
                l.alpha = 0;
                l.frame = CGRectMake(0, 0, SCREEN_WIGHT, 0);
            } completion:^(BOOL finished) {
                [l removeFromSuperview];
            }];
        });
    }];
    
    return self;
}

@end
