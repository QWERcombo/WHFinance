//
//  TBTabBar.m
//  GoGoTree
//
//  Created by youqin on 16/8/30.
//  Copyright © 2016年 t_b. All rights reserved.
//

#import "TBTabBar.h"
#import "TBNavigationController.h"
#define TabbarItemNums 4.0    //tabbar的数量 如果是5个设置为5.0
@implementation TBTabBar

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        //添加发布按钮
        UIButton *centerBtn=[UIButton buttonWithType:0];
        [centerBtn setBackgroundImage:IMG(@"tabBar_publish_icon") forState:UIControlStateNormal];
        [centerBtn setBackgroundImage:IMG(@"tabBar_publish_click_icon") forState:UIControlStateHighlighted];
        [centerBtn sizeToFit];
        [centerBtn addTarget:self action:@selector(pushSomething) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:centerBtn];
        self.centerBtn=centerBtn;
    }
    return self;
}
-(void)pushSomething
{
//    TestViewController *vc = [[TestViewController alloc] init];
//    TBNavigationController *nav = [[TBNavigationController alloc] initWithRootViewController:vc];
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
    
    NSLog(@"lalalala");
}
/**
 *  布局子控件 重写 layoutSubviews
 *
 *
 */
-(void)layoutSubviews
{
    [super layoutSubviews];
    if (self.showMiddleBTN) {
        CGFloat width=self.width;
        CGFloat hight=self.height;
        self.centerBtn.center=CGPointMake(width*0.5, hight*0.5);
        int index = 0;
        CGFloat btnWidth = width*0.2;
        CGFloat btnHight = hight;
        for (UIView *tabbarBtn in self.subviews) {
            if ([NSStringFromClass(tabbarBtn.class) isEqualToString:@"UITabBarButton"]) {
                CGFloat tabBarButtonX = index * btnWidth;
                if (index>=2) {
                    tabBarButtonX+=btnWidth;
                }
                tabbarBtn.frame=CGRectMake(tabBarButtonX, 0, btnWidth, btnHight);
                index++;
            }
        }
        
    }else{
        self.centerBtn.hidden = YES;
    }
}

//显示小红点
- (void)showBadgeOnItemIndex:(int)index{
    //移除之前的小红点
    [self removeBadgeOnItemIndex:index];
    
    //新建小红点
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 888 + index;
    badgeView.layer.cornerRadius = 5;//圆形
    badgeView.backgroundColor = [UIColor redColor];//颜色：红色
    CGRect tabFrame = self.frame;
    
    //确定小红点的位置
    float percentX = (index +0.6) / TabbarItemNums;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, 10, 10);//圆形大小为10
    [self addSubview:badgeView];
}
//隐藏小红点
- (void)hideBadgeOnItemIndex:(int)index{
    //移除小红点
    [self removeBadgeOnItemIndex:index];
}
//移除小红点
- (void)removeBadgeOnItemIndex:(int)index{
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}
@end
