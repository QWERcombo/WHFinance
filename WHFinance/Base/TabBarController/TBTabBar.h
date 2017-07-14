//
//  TBTabBar.h
//  GoGoTree
//
//  Created by youqin on 16/8/30.
//  Copyright © 2016年 t_b. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBTabBar : UITabBar
@property(nonatomic,weak)UIButton *centerBtn;

@property(nonatomic,assign)BOOL showMiddleBTN;//是否增添中间按钮

- (void)showBadgeOnItemIndex:(int)index;   //显示小红点

- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点
@end
