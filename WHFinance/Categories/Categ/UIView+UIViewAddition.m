//
//  UIView+UIViewAddition.m
//  XiYouPartner
//
//  Created by 265G on 15/8/10.
//  Copyright (c) 2015年 YXCompanion. All rights reserved.
//

#import "UIView+UIViewAddition.h"

@implementation UIView (UIViewAddition)
- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)showFrame
{
    NSLog(@"%f %f %f %f", self.frame.origin.x, self.frame.origin.y, self.width, self.height);
}
#pragma mark Frame Origin

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)newX
{
    CGRect newFrame = self.frame;
    newFrame.origin.x = newX;
    self.frame = newFrame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)newY
{
    CGRect newFrame = self.frame;
    newFrame.origin.y = newY;
    self.frame = newFrame;
}

+ (id)viewWithBackgroudColor:(UIColor *)backgroudColor
{
    UIView * view =[UIView new];
    view.backgroundColor=backgroudColor;
    return view;
}
- (void)setSize:(CGSize)size {
    //    self.width = size.width;
    //    self.height = size.height;
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGSize)size {
    return self.frame.size;
}


- (void)addTarget:(id)target action:(SEL)action;
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target
                                                                         action:action];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}
- (CAGradientLayer *)shadowAsInverseUp{
    CAGradientLayer *newShadow = [[CAGradientLayer alloc] init];
    CGRect newShadowFrame = CGRectMake(0, 0, SCREEN_WIGHT,45 );
    newShadow.frame = newShadowFrame;
    //添加渐变的颜色组合（颜色透明度的改变）
    newShadow.colors = [NSArray arrayWithObjects:
                        (id)[[[UIColor blackColor] colorWithAlphaComponent:0.3] CGColor],
                        (id)[[[UIColor blackColor] colorWithAlphaComponent:0.4] CGColor],
                        (id)[[[UIColor blackColor] colorWithAlphaComponent:0.5] CGColor],
                        (id)[[[UIColor blackColor] colorWithAlphaComponent:0.6] CGColor],
                        (id)[[[UIColor blackColor] colorWithAlphaComponent:0.7] CGColor],
                        (id)[[[UIColor blackColor] colorWithAlphaComponent:0.8] CGColor],
                        nil];
    return newShadow;
}

- (CAGradientLayer *)shadowAsInverseDown
{
    CAGradientLayer *newShadow = [[CAGradientLayer alloc] init];
    CGRect newShadowFrame = CGRectMake(0, 0, SCREEN_WIGHT,20 *3 );
    newShadow.frame = newShadowFrame;
    //添加渐变的颜色组合（颜色透明度的改变）
    newShadow.colors = [NSArray arrayWithObjects:
                        (id)[[[UIColor blackColor] colorWithAlphaComponent:0.5] CGColor],
                        (id)[[[UIColor blackColor] colorWithAlphaComponent:0.4] CGColor],
                        (id)[[[UIColor blackColor] colorWithAlphaComponent:0.3] CGColor],
                        (id)[[[UIColor blackColor] colorWithAlphaComponent:0.2] CGColor],
                        (id)[[[UIColor blackColor] colorWithAlphaComponent:0.1] CGColor],
                        (id)[[[UIColor blackColor] colorWithAlphaComponent:0.0] CGColor],
                        nil];
    return newShadow;
}

-(id)setCheekWithColor:(UIColor*)color borderWidth:(float)width roundedRect:(float)radian
{
    self.clipsToBounds=YES;
    if(radian)self.layer.cornerRadius = radian;
    if(color)self.layer.borderColor = [color CGColor];
    if(width > 0)self.layer.borderWidth = width;
    return self;
}
//获取Window当前显示的ViewController
//+ (UIViewController*)currentViewController{
//     UIWindow* window = [UIApplication sharedApplication].keyWindow;
//
//    UIViewController* vc = window.rootViewController;
//
//    while (1) {
//        if ([vc isKindOfClass:[UITabBarController class]]) {
//            vc = ((UITabBarController*)vc).selectedViewController;
//        }
//
//        if ([vc isKindOfClass:[UINavigationController class]]) {
//            vc = ((UINavigationController*)vc).visibleViewController;
//        }
//
//        if (vc.presentedViewController) {
//            vc = vc.presentedViewController;
//        }else{
//            break;
//        }
//
//    }
//
//    return vc;
//}

//- (UIViewController *)getCurrentVC{
//
//    UIViewController *result = nil;
//    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
//    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
//    if (window.windowLevel != UIWindowLevelNormal)
//    {
//        NSArray *windows = [[UIApplication sharedApplication] windows];
//        for(UIWindow * tmpWin in windows)
//        {
//            if (tmpWin.windowLevel == UIWindowLevelNormal)
//            {
//                window = tmpWin;
//                break;
//            }
//        }
//    }
//    id  nextResponder = nil;
//    UIViewController *appRootVC=window.rootViewController;
//    //    如果是present上来的appRootVC.presentedViewController 不为nil
//    if (appRootVC.presentedViewController) {
//        nextResponder = appRootVC.presentedViewController;
//    }else{
//        UIView *frontView = [[window subviews] objectAtIndex:0];
//        nextResponder = [frontView nextResponder];
////     <span style="font-family: Arial, Helvetica, sans-serif;">//  这方法下面有详解    </span>
//    }
//    if ([nextResponder isKindOfClass:[UITabBarController class]]){
//        UITabBarController * tabbar = (UITabBarController *)nextResponder;
//        TBNavigationController * nav = (TBNavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
//        //TBNavigationController * nav = tabbar.selectedViewController ; 上下两种写法都行
//        result=nav.childViewControllers.lastObject;
//
//    }else if ([nextResponder isKindOfClass:[TBNavigationController class]]){
//        UIViewController * nav = (UIViewController *)nextResponder;
//        result = nav.childViewControllers.lastObject;
//    }else{
//        result = nextResponder;
//    }
    
//    return result;
//}
+ (UIView *)showNothingViewWith:(NSInteger)type{
    UIView *nthing = [UIView viewWithBackgroudColor:[UIColor clearColor]];
    float ww = 284/2;
//    float hh = 302/2;
    UIImageView *nthingImg = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIGHT - ww)/2, 150, ww, 224/2)];
//    nthingImg.backgroundColor = [UIColor mianColor:1];
    [nthing addSubview:nthingImg];
    
    
    UILabel *hintLab = [YXPUtil creatUILable:@"" Font:FONT_ArialMT(14) TextColor:[UIColor Grey_BackColor]];
    [nthing addSubview:hintLab];
    [hintLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nthingImg.mas_bottom).offset(15);
        make.height.equalTo(@(15));
        make.centerX.equalTo(nthingImg.mas_centerX);
    }];
    
    NSString *typeName = [NSString stringWithFormat:@"Nothing_%ld",(long)type];
    NSString *hintStr = @"";
    switch (type) {
        case 1://1.服务
        {
            nthingImg.image = IMG(typeName);
            hintStr = @"暂时无相关数据";
        }
            break;
            
        case 2://2.视频
        {
            nthingImg.image = IMG(typeName);
            hintStr = @"";
        }
            break;
            
        case 3://3.话题
        {
            nthingImg.image = IMG(typeName);
            hintStr = @"";
        }
            break;
            
        case 4://4.帖子
        {
            nthingImg.image = IMG(typeName);
            hintStr = @"";
        }
            break;
            
        case 99://99.没有内容
        {
            nthingImg.image = IMG(typeName);
        }
            break;
            
        default:
            break;
    }
    nthingImg.image = IMG(@"Nothing_NoContent");
    hintLab.text = hintStr;

    return nthing;
}

+ (UIView *)joinUsWithStatus:(BOOL)status {
    UIView *blank = [[UIView alloc] init];
    UIImageView *imgv = [UIImageView new];
    [blank addSubview:imgv];
    imgv.image = IMG(@"join");
    [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(20));
        make.left.equalTo(blank.mas_left);
        make.centerY.equalTo(blank.mas_centerY);
    }];
    NSString *titleStr = @"";
    if (status) {
        titleStr = @"您已是创业合伙人";
    } else {
        titleStr = @"降低费率？ 加入合伙人>>";
    }
    UIButton *label = [UIButton buttonWithTitle:titleStr andFont:FONT_ArialMT(12) andtitleNormaColor:[UIColor colorWithR:255 G:141 B:19 A:1] andHighlightedTitle:[UIColor colorWithR:255 G:141 B:19 A:1] andNormaImage:nil andHighlightedImage:nil];
    label.userInteractionEnabled = NO;
    [blank addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(blank.mas_centerY);
        make.left.equalTo(imgv.mas_right).offset(1);
        make.height.equalTo(@(12));
        make.right.equalTo(blank.mas_right);
    }];
    
    
    return blank;
}
- (void)aaa:(id) sen {
    
    
    
    
}

@end
