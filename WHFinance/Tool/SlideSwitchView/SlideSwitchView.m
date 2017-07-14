//
//  SlideSwitchView.m
//  FileTransport
//
//  Created by yumingde45 on 15-4-16.
//  Copyright (c) 2015年 yumingde45. All rights reserved.
//

#import "SlideSwitchView.h"

@interface SlideSwitchView ()
{
    BOOL doSomething;
    // 开始滚动时的offset的x
    int startOffsetX;
    //_topScrollView的高度
    CGFloat kHeightOfTopScrollView;
    NSInteger spacing;
}
@end
static const CGFloat kFontSizeOfTabButton = 15.0f;
static const NSUInteger kTagOfRightSideButton = 999;

@implementation SlideSwitchView

#pragma mark - 初始化参数

- (void)initValues
{
    kHeightOfTopScrollView = 30.0f;
    spacing = 30;
    UIView *topView = [UIView viewWithBackgroudColor:[UIColor clearColor]];
    [topView setUserInteractionEnabled:YES];
    [self addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.height.equalTo(@(kHeightOfTopScrollView));
    }];
    //创建顶部可滑动的tab
    _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, kHeightOfTopScrollView)];
    _topScrollView.bounces = NO;
    _topScrollView.delegate = self;
    _topScrollView.scrollEnabled = YES;
    _topScrollView.pagingEnabled = NO;
    _topScrollView.alwaysBounceVertical = NO;
    _topScrollView.userInteractionEnabled = YES;
    _topScrollView.showsVerticalScrollIndicator = NO;
    _topScrollView.showsHorizontalScrollIndicator = NO;
    _topScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:_topScrollView];
    
    _userSelectedChannelID = 100;
    
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(0, _topScrollView.bottom -1.3, self.width, 1.5)];
    [_topScrollView addSubview:_line];
    
    //创建主滚动视图
    _rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,_topScrollView.bottom,self.width,self.height - kHeightOfTopScrollView)];
    _rootScrollView.delegate = self;
    _rootScrollView.pagingEnabled = YES;
    _rootScrollView.userInteractionEnabled = YES;
    _rootScrollView.bounces = NO;
    _rootScrollView.showsHorizontalScrollIndicator = NO;
    _rootScrollView.showsVerticalScrollIndicator = NO;
    _rootScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    _userContentOffsetX = 0;
    [_rootScrollView.panGestureRecognizer addTarget:self action:@selector(scrollHandlePan:)];
    [self addSubview:_rootScrollView];
    
    _viewArray = [[NSMutableArray alloc] init];
    
    _isBuildUI = NO;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initValues];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initValues];
    }
    return self;
}

#pragma mark getter/setter

- (void)setRigthSideButton:(UIButton *)rigthSideButton
{
    UIButton *button = (UIButton *)[self viewWithTag:kTagOfRightSideButton];
    [button removeFromSuperview];
    rigthSideButton.tag = kTagOfRightSideButton;
    _rigthSideButton = rigthSideButton;
    [self addSubview:_rigthSideButton];
}

#pragma mark - 创建控件

//当横竖屏切换时可通过此方法调整布局
- (void)layoutSubviews
{
    NSInteger hh = self.openTitle > 0 ? 0:10;
    if (_topScrollView.hidden) {
        _rootScrollView.frame = CGRectMake(0,0,self.width,self.height);
    }else {
        _topScrollView.frame = CGRectMake(0,hh, self.width, kHeightOfTopScrollView);
        _line.frame = CGRectMake(0, _topScrollView.bottom -1.3, self.width, 1.5);
        _rootScrollView.frame = CGRectMake(0,_topScrollView.bottom,self.width,self.height - kHeightOfTopScrollView - hh);
        [_line setImage:[self imageWithColor:self.tabItemBannerNormalColor size:_line.size]];
    }
    
    //创建完子视图UI才需要调整布局
    if (_isBuildUI) {
        //更新主视图的总宽度
        _rootScrollView.contentSize = CGSizeMake(self.width * [_viewArray count], 0);
        //更新主视图各个子视图的宽度
        for (int i = 0; i < [_viewArray count]; i++) {
            UIViewController *listVC = _viewArray[i];
            listVC.view.frame = CGRectMake(_rootScrollView.width*i, 0, _rootScrollView.width, _rootScrollView.height);
        }
        //滚动到选中的视图
        [_rootScrollView setContentOffset:CGPointMake((_userSelectedChannelID - 100)*self.width, 0) animated:NO];
        // 调整顶部滚动视图选中按钮位置
        UIButton *button = (UIButton *)[_topScrollView viewWithTag:_userSelectedChannelID];
        [self adjustScrollViewContentX:button];
    }
}

/*
 * @method 创建子视图UI
 * @abstract
 * @discussion
 * @param
 * @result
 */
- (void)buildUIWithViews:(NSArray *)views andClikBlock:(ClikBlock)clikBlock
{
    _clikBlock = clikBlock;
    NSUInteger number = views.count;
    for (int i=0; i<number; i++) {
        UIViewController *vc = [views objectAtIndex:i];
        [_viewArray addObject:vc];
        [_rootScrollView addSubview:vc.view];
        float width = [UILabel getSizeWithText:vc.title andFont:FONT_ArialMT(kFontSizeOfTabButton) andSize:CGSizeMake(100,MAXFLOAT)].width + spacing;
        _width = width + _width;
    }
    if (_width < SCREEN_WIGHT) {
        spacing = (SCREEN_WIGHT - _width)/number + spacing;
        _width = SCREEN_WIGHT;
    }
    [self createNameButtonsWithNumber:number];
    //选中第一个view
    if (self.slideSwitchViewDelegate && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:didselectTab:)]) {
        [self.slideSwitchViewDelegate slideSwitchView:self didselectTab:_userSelectedChannelID - 100];
    }
    
    _isBuildUI = YES;
    
    //创建完子视图UI才需要调整布局
    [self setNeedsLayout];
}


/*
 * @method 初始化顶部tab的各个按钮
 * @abstract
 * @discussion
 * @param
 * @result
 */
- (void)createNameButtonsWithNumber:(NSInteger)number
{
    _shadowView = [[UIView alloc] init];
    _shadowView.backgroundColor = self.tabItemBannerSelectedColor;
    [_topScrollView addSubview:_shadowView];
    
    //每个tab偏移量
    CGFloat xOffset = 0;
    for (int i = 0; i < _viewArray.count; i++) {
        UIViewController *vc = _viewArray[i];
        float width = [UILabel getSizeWithText:vc.title andFont:FONT_ArialMT(kFontSizeOfTabButton) andSize:CGSizeMake(100,MAXFLOAT)].width + spacing;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_topScrollView addSubview:button];
        //设置按钮尺寸
        button.frame = CGRectMake(xOffset, 0, width, kHeightOfTopScrollView);
        //计算下一个tab的x偏移量
        xOffset += width;
        
        [button setTag:i + 100];
        
        if (i == 0) {
            _shadowView.frame = CGRectMake(0, _topScrollView.bottom -1.2, width, 1.2);
            button.selected = YES;
            button.titleLabel.font = [UIFont systemFontOfSize:15];
        }else{
            button.titleLabel.font = [UIFont systemFontOfSize:kFontSizeOfTabButton];
        }
        
        [button setTitle:vc.title forState:UIControlStateNormal];
        [button setTitleColor:self.tabItemNormalColor forState:UIControlStateNormal];
        [button setTitleColor:self.tabItemSelectedColor forState:UIControlStateSelected];
        [button setBackgroundImage:self.tabItemNormalBackgroundImage forState:UIControlStateNormal];
        [button setBackgroundImage:self.tabItemSelectedBackgroundImage forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectNameButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    //设置顶部滚动视图的内容总尺寸
    _topScrollView.contentSize = CGSizeMake(_width,0);
}

#pragma mark - 顶部滚动视图逻辑方法
/*
 * @method 选中tab时间
 * @abstract
 * @discussion
 * @param 按钮
 * @result
 */
- (void)selectNameButton:(UIButton *)sender
{
    UIButton *button = [self viewWithTag:sender.tag];
    for (int i = 0; i < [_viewArray count]; i++) {
        UIButton *btn = [self viewWithTag:100 +i];
        if (btn.tag == sender.tag) {
            btn.titleLabel.font = [UIFont systemFontOfSize:20];
            
        }else{
            btn.titleLabel.font = [UIFont systemFontOfSize:kFontSizeOfTabButton];
            
        }
    }
    //如果更换按钮
    if (button.tag != _userSelectedChannelID) {
        //取之前的按钮
        UIButton *lastButton = (UIButton *)[_topScrollView viewWithTag:_userSelectedChannelID];
        lastButton.selected = NO;
        //赋值按钮ID
        _userSelectedChannelID = button.tag;
    }
    //按钮选中状态
    if (!button.selected) {
        button.selected = YES;
        [UIView animateWithDuration:0.25 animations:^{
            
            _shadowView.backgroundColor = self.tabItemBannerSelectedColor;
            [_shadowView setFrame:CGRectMake(button.x,_topScrollView.bottom -1.2, button.width, 1.2)];
            
            CGFloat offsetX = 0;
            float width = [UILabel getSizeWithText:button.titleLabel.text andFont:FONT_ArialMT(kFontSizeOfTabButton) andSize:CGSizeMake(100,MAXFLOAT)].width + 30;
            if (button.x + width > SCREEN_WIGHT) {
                if (_width - button.x <= SCREEN_WIGHT) {
                    offsetX = _width - SCREEN_WIGHT;
                }else{
                    offsetX = button.x + width - SCREEN_WIGHT;
                }
            }
            _topScrollView.contentOffset = CGPointMake(offsetX, 0);
        } completion:^(BOOL finished) {
            if (finished) {
                //设置新页出现 (不用动画)
                if (!_isRootScroll) {
                    [_rootScrollView setContentOffset:CGPointMake((button.tag - 100)*self.width, 0) animated:NO];
                }
                _isRootScroll = NO;
                
                if (self.slideSwitchViewDelegate && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:didselectTab:)]) {
                    [self.slideSwitchViewDelegate slideSwitchView:self didselectTab:_userSelectedChannelID - 100];
                }
            }
        }];
    }else{
        //重复点击选中按钮
    }
}

- (void) setScrollViewSelectedWithIndex:(NSInteger)index
{
    _userSelectedChannelID = index + 100;
    //设置新页出现
    [_rootScrollView setContentOffset:CGPointMake(index * self.width, 0) animated:YES];
    _isRootScroll = NO;
    if (self.slideSwitchViewDelegate && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:didselectTab:)]) {
        [self.slideSwitchViewDelegate slideSwitchView:self didselectTab:_userSelectedChannelID - 100];
    }
}

/*
 * @method 调整顶部滚动视图x位置
 * @abstract
 * @discussion
 * @param
 * @result
 */
- (void)adjustScrollViewContentX:(UIButton *)sender
{
    //如果 当前显示的最后一个tab文字超出右边界
    if (sender.x - _topScrollView.contentOffset.x > self.width - (sender.width)) {
        //向左滚动视图，显示完整tab文字
        [_topScrollView setContentOffset:CGPointMake(sender.x - (_topScrollView.width- (sender.width)), 0)  animated:YES];
    }
    
    //如果 （tab的文字坐标 - 当前滚动视图左边界所在整个视图的x坐标） < 按钮的隔间 ，代表tab文字已超出边界
    if (sender.x - _topScrollView.contentOffset.x < 0) {
        //向右滚动视图（tab文字的x坐标 - 按钮间隔 = 新的滚动视图左边界在整个视图的x坐标），使文字显示完整
        [_topScrollView setContentOffset:CGPointMake(sender.x, 0)  animated:YES];
    }
    
}

#pragma mark - 主视图逻辑方法

//滚动视图开始时
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    startOffsetX = scrollView.contentOffset.x;
    // 一开始在最左边时,暂时是不做任何事情;因为当它向右划时,不需做任何事;仅当它向左划时,才需要切换tabItem的状态
    if (startOffsetX == 0) {
        doSomething = NO;
    }
    // 一开始在最左边时,暂时是不做任何事情;因为当它向右划时,不需做任何事;仅当它向左划时,才需要切换tabItem的状态
    // 960
    if (startOffsetX == _rootScrollView.contentSize.width - _rootScrollView.width) {
        doSomething = NO;
    }
    //**********************************
    
    if (scrollView == _rootScrollView) {
        _userContentOffsetX = scrollView.contentOffset.x;
    }
}

//滚动视图进行中
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _rootScrollView) {
        //判断用户是否左滚动还是右滚动
        if (_userContentOffsetX < scrollView.contentOffset.x) {
            _isLeftScroll = YES;
        }
        else {
            _isLeftScroll = NO;
        }
    }
    // **************************
    // 如果最开始在最左边,但是是往左滑,仍需要调整顶部的tabItem状态
    if(startOffsetX == 0 && _isLeftScroll){
        doSomething = YES;
    }
    // 如果最开始在最右边,但是是往右滑,也需要调整顶部的tabItem状态
    if(startOffsetX == _rootScrollView.contentSize.width - _rootScrollView.width && !_isLeftScroll){
        doSomething = YES;
    }
}

//滚动视图 结束滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (!doSomething) {
        return;
    }
    
    //**********************************
    if (scrollView == _rootScrollView) {
        _isRootScroll = YES;
        //调整顶部滑条按钮状态
        int tag = (int)scrollView.contentOffset.x/self.width +100;
        
        
        if (self.slideSwitchViewDelegate && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:didselectTab:)]) {
            [self.slideSwitchViewDelegate slideSwitchView:self didselectTab:tag - 100];
        }
        
        UIButton *button = (UIButton *)[_topScrollView viewWithTag:tag];
        // 顶部的tabItem按钮点击
        [self selectNameButton:button];
        self.clikBlock(SINT(button.tag - 100));
        
        
        
    }
}

//传递滑动事件给下一层
-(void)scrollHandlePan:(UIPanGestureRecognizer*) panParam
{
    //	BXLog(@"_userSelectedChannelID ===== %f", _rootScrollView.contentOffset.x);
    
    //当滑道左边界时，传递滑动事件给代理
    if(_rootScrollView.contentOffset.x <= 0) {
        if (self.slideSwitchViewDelegate
            && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:panLeftEdge:)]) {
            [self.slideSwitchViewDelegate slideSwitchView:self panLeftEdge:panParam];
        }
    } else if(_rootScrollView.contentOffset.x >= _rootScrollView.contentSize.width - _rootScrollView.width) {
        if (self.slideSwitchViewDelegate
            && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:panRightEdge:)]) {
            [self.slideSwitchViewDelegate slideSwitchView:self panRightEdge:panParam];
        }
    }
    
}


- (void) setHideTopView:(BOOL)hide
{
    _line.hidden = hide;
    _topScrollView.hidden = hide;
    //创建完子视图UI才需要调整布局
    [self setNeedsLayout];
}

#pragma mark - 工具方法
#pragma mark - 工具方法
// 从颜色 转成 图片
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    //Create a context of the appropriate size
    UIGraphicsBeginImageContext(size);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    //Build a rect of appropriate size at origin 0,0
    CGRect fillRect = CGRectMake(0, 0, size.width, size.height);
    
    //Set the fill color
    CGContextSetFillColorWithColor(currentContext, color.CGColor);
    
    //Fill the color
    CGContextFillRect(currentContext, fillRect);
    
    //Snap the picture and close the context
    UIImage *colorImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return colorImage;
}


@end
