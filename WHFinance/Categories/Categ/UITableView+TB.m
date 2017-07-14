//
//  UITableView+TB.m
//  GoGoTree
//
//  Created by youqin on 16/8/17.
//  Copyright © 2016年 t_b. All rights reserved.
//

#import "UITableView+TB.h"

@implementation UITableView (TB)
-(id)showHeardPopWithNum:(NSInteger)num{
    
    UILabel *ll = [self viewWithTag:923];
    [ll removeFromSuperview];
    
    UILabel *l = [UILabel lableWithText:@"" Font:FONT_ArialMT(15) TextColor:[UIColor whiteColor]];
    l.tag = 923;
    if (num >0) {
        l.text = [NSString stringWithFormat:@"为你推荐了%ld条新内容",(long)num];
    }else{
        l.text = @"已经没有更多内容";
    }
    l.textAlignment = NSTextAlignmentCenter;
    l.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    l.frame = CGRectMake(0, 0, SCREEN_WIGHT, 0);
    [self addSubview:l];
    [UIView animateWithDuration:0.5 animations:^{
        l.frame = CGRectMake(0, 0, SCREEN_WIGHT, 25);
        
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
-(void)nightModel{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NIGHT_SWITCH object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nightSwich:) name:NIGHT_SWITCH object:nil];
    
    NSString *str = [[PlistManager sharedInstance] getObjectFormPlist:NIGHT_SWITCH WithKey:@"NightSwich"];
    if ([str integerValue] == 0) {
        self.backgroundColor = [UIColor whiteColor];
        
    }else{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    }

}
-(void)nightSwich:(NSNotification*)noti{
    NSDictionary *dict = noti.userInfo;
    NSString *str = [dict objectForKey:@"NightSwich"];
    if ([str integerValue] == 0) {
        self.backgroundColor = [UIColor whiteColor];
        
    }else{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        
    }
    [self reloadData];
}
@end
