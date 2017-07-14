//
//  ABBannerView.h
//  XiYouPartner
//
//  Created by 265G on 15/9/9.
//  Copyright (c) 2015年 YXCompanion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABBannerView : UIView
/**
 * 时间time
 */
@property (nonatomic ,assign) NSTimeInterval duration;
/**
 * self 的背景颜色
 */
@property (nonatomic,strong) UIColor *selfBackgroundColor;
/**
 * PageControl 的背景颜色
 */
@property (nonatomic,strong) UIColor *pageBackgroundColor;
/**
 * PageControl 在普通状态下的颜色
 */
@property (nonatomic,strong) UIColor *pageIndicatorTintColor;
/**
 * PageControl 选中状态的颜色
 */
@property (nonatomic,strong) UIColor *currentPageColor;


/**
 *  frame 尺寸 webimages网络图片http链接arr action 点击了xx页的的回调blocks
 */
-(instancetype)initPageViewFrame:(CGRect)frame webImageStr:(NSArray *)webimages titleStr:(NSArray *)titles didSelectPageViewAction:( void(^)(NSInteger index ))action;
@end
