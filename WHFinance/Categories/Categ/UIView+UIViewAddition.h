//
//  UIView+UIViewAddition.h
//  XiYouPartner
//
//  Created by 265G on 15/8/10.
//  Copyright (c) 2015年 YXCompanion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UIViewAddition)

@property(nonatomic) CGFloat left;
@property(nonatomic) CGFloat right;
@property(nonatomic) CGFloat top;
@property(nonatomic) CGFloat bottom;
@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property(nonatomic) CGFloat x;
@property(nonatomic) CGFloat y;


- (void)showFrame;

- (CAGradientLayer *)shadowAsInverseDown;//渐变
- (CAGradientLayer *)shadowAsInverseUp;//渐变
//获取当前正在现实VC
//- (UIViewController *)getCurrentVC;

//view画边与圆角弧度
-(id)setCheekWithColor:(UIColor*)color borderWidth:(float)width roundedRect:(float)radian;

+ (id)viewWithBackgroudColor:(UIColor *)backgroudColor;

- (void)addTarget:(id)target action:(SEL)action;

+ (UIView *)showNothingViewWith:(NSInteger)type;

+ (UIView *)joinUsWithStatus:(BOOL)status;

@end
