//
//  SlideSwitchView.h
//  FileTransport
//
//  Created by yumingde45 on 15-4-16.
//  Copyright (c) 2015年 yumingde45. All rights reserved.
//
//https://github.com/HelloYeah/HYTabbarView
#import <UIKit/UIKit.h>
//#import "InitialModel.h"
@protocol SlideSwitchViewDelegate;
@interface SlideSwitchView : UIView<UIScrollViewDelegate>
{
    UIScrollView *_rootScrollView;                  //主视图
    UIScrollView *_topScrollView;                   //顶部页签视图
    UIImageView *_line;
    
    CGFloat _width;
    
    CGFloat _userContentOffsetX;
    BOOL _isLeftScroll;                             //是否左滑动
    BOOL _isRootScroll;                             //是否主视图滑动
    BOOL _isBuildUI;                                //是否建立了ui
    
    NSInteger _userSelectedChannelID;               //点击按钮选择名字ID
    
    UIView *_shadowView;
    
    UIColor *_tabItemNormalColor;                   //正常时tab文字颜色
    UIColor *_tabItemSelectedColor;                 //选中时tab文字颜色
    UIImage *_tabItemNormalBackgroundImage;         //正常时tab的背景
    UIImage *_tabItemSelectedBackgroundImage;       //选中时tab的背景
    NSMutableArray *_viewArray;                     //主视图的子视图数组
    
    UIButton *_rigthSideButton;                     //右侧按钮
    
    __weak id<SlideSwitchViewDelegate> _slideSwitchViewDelegate;
}

typedef void (^ClikBlock)(NSString *clueStr);

@property (nonatomic, copy) ClikBlock clikBlock;


@property (nonatomic, strong) UIScrollView *rootScrollView;
@property (nonatomic, strong) UIScrollView *topScrollView;
@property (nonatomic, assign) CGFloat userContentOffsetX;
@property (nonatomic, assign) NSInteger userSelectedChannelID;
//@property (nonatomic, assign) NSInteger scrollViewSelectedChannelID;
@property (nonatomic, weak)  id<SlideSwitchViewDelegate> slideSwitchViewDelegate;
@property (nonatomic, strong) UIColor *tabItemNormalColor;
@property (nonatomic, strong) UIColor *tabItemSelectedColor;
@property (nonatomic, strong) UIColor *tabItemBannerNormalColor;
@property (nonatomic, strong) UIColor *tabItemBannerSelectedColor;
@property (nonatomic, strong) UIImage *tabItemNormalBackgroundImage;
@property (nonatomic, strong) UIImage *tabItemSelectedBackgroundImage;
@property (nonatomic, assign) NSInteger openTitle;//是否显示导航条


@property (nonatomic, strong) NSMutableArray *viewArray;
@property (nonatomic, strong) UIButton *rigthSideButton;

//@property(nonatomic,strong)Barlist *listModel;



- (void)setHideTopView:(BOOL)hide;

- (void) setScrollViewSelectedWithIndex:(NSInteger)index;

- (void)selectNameButton:(UIButton *)sender;
/*
 * @method 创建子视图UI
 * @abstract
 * @discussion
 * @param
 * @result
 */
- (void)buildUIWithViews:(NSArray *)views andClikBlock:(ClikBlock)clikBlock;

@end

@protocol SlideSwitchViewDelegate <NSObject>

@required

///*
// * @method 顶部tab个数
// * @abstract
// * @discussion
// * @param 本控件
// * @result tab个数
// */
//- (NSUInteger)numberOfTab:(SlideSwitchView *)view;

///*
// * @method 每个tab所属的viewController
// * @abstract
// * @discussion
// * @param tab索引
// * @result viewController
// */
//- (UIViewController *)slideSwitchView:(SlideSwitchView *)view viewOfTab:(NSUInteger)number;

@optional

/*
 * @method 滑动左边界时传递手势
 * @abstract
 * @discussion
 * @param   手势
 * @result
 */
- (void)slideSwitchView:(SlideSwitchView *)view panLeftEdge:(UIPanGestureRecognizer*) panParam;

/*
 * @method 滑动右边界时传递手势
 * @abstract
 * @discussion
 * @param   手势
 * @result
 */
- (void)slideSwitchView:(SlideSwitchView *)view panRightEdge:(UIPanGestureRecognizer*) panParam;

/*
 * @method 点击tab
 * @abstract
 * @discussion
 * @param tab索引
 * @result
 */
- (void)slideSwitchView:(SlideSwitchView *)view didselectTab:(NSUInteger)number;


- (void)scrollViewDidScroll:(SlideSwitchView *)view didselectTab:(NSUInteger)number;



@end
