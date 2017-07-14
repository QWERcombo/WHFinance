//
//  ABBannerView.m
//  XiYouPartner
//
//  Created by 265G on 15/9/9.
//  Copyright (c) 2015年 YXCompanion. All rights reserved.
//

#import "ABBannerView.h"
#import "BannerPageControl.h"
#define   PAGE_H  20

@interface ABBannerView ()<UIScrollViewDelegate>

@property (nonatomic ,strong) UIScrollView *scrollView;
@property (nonatomic ,strong) BannerPageControl *pageControl;
@property (nonatomic ,strong) NSTimer *timer;
@property (nonatomic ,copy)  void(^action)(NSInteger index );
@property (nonatomic ,assign) BOOL isWebImage;
@property (nonatomic, strong) NSArray * imageArray;
@property (nonatomic,strong ) NSArray * shorttitleArr;
@property (strong, nonatomic) UILabel *bnameLab;

@end


@implementation ABBannerView
-(instancetype)initPageViewFrame:(CGRect)frame webImageStr:(NSArray *)webimages titleStr:(NSArray *)titles didSelectPageViewAction:( void(^)(NSInteger index))action
{
    self = [super initWithFrame:frame];
    if (self) {
        self.action = action;
        self.imageArray = webimages;
        self.shorttitleArr = titles;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pageViewClick:)];
        [self addGestureRecognizer:tap];
        
        if (self.shorttitleArr.count > 0) {
            self.bnameLab.text = [self.shorttitleArr objectAtIndex:0];
        }
        
    }
    return self;
}
//手势点击

- (void)pageViewClick:(UITapGestureRecognizer *)tap
{
    if (self.action) {
        self.action(self.pageControl.currentPage);
    }
}


- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

-(void)setImageArray:(NSArray *)imageArray
{
    _imageArray = imageArray;
    
    [self setUpScrollView:imageArray];
    [self setUpImage:imageArray];
    [self setUpPageControl:imageArray];
    //保证不管先设置图片来源还是时间，都可以start
    [self.timer invalidate];
    [self startTimer];
}

-(void)setDuration:(NSTimeInterval)duration
{
    _duration = duration;
    [self.timer invalidate];
    [self startTimer];
}

/**
 *  设置scrollView
 */
-(void)setUpScrollView:(NSArray *)array
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pageViewClick:)];
    [scrollView addGestureRecognizer:tapGesture];
    
    [self addSubview:scrollView];
    
    self.scrollView = scrollView;
}


-(void)setUpImage:(NSArray *)array
{
    CGSize contentSize = CGSizeZero ;
    CGPoint startPoint = CGPointZero ;
    NSLog(@"%d",_isWebImage);
    if (array.count > 1) {     //多张图片
        for (int i = 0 ; i < array.count + 2; i++) {
//            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height - PAGE_H)];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
            imageView.backgroundColor = [UIColor lightGrayColor];
            [self.scrollView addSubview:imageView];
            if (i == 0) {
                [imageView sd_setImageWithURL:[NSURL URLWithString:array[array.count - 1]] placeholderImage:[UIImage imageWithColor:[UIColor Grey_BlankColor]]];
            }else if(i == array.count + 1){
                [imageView sd_setImageWithURL:[NSURL URLWithString:array[0]] placeholderImage:[UIImage imageWithColor:[UIColor Grey_BlankColor]]];
            }else{
                [imageView sd_setImageWithURL:[NSURL URLWithString:array[i - 1]] placeholderImage:[UIImage imageWithColor:[UIColor Grey_BlankColor]]];
            }
            contentSize = CGSizeMake((array.count + 2) * self.frame.size.width,0);
            startPoint = CGPointMake(self.frame.size.width, 0);
        }
    }else{ //1张图片
        for (int i = 0; i < array.count; i ++) {
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height - PAGE_H)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:array[i]] placeholderImage:[UIImage imageWithColor:[UIColor Grey_BlankColor]]];
            [self addSubview:imageView];
        }
        contentSize = CGSizeMake(self.frame.size.width, 0);
        startPoint = CGPointZero;
    }
    
    //开始的偏移量跟内容尺寸
    self.scrollView.contentOffset = startPoint;
    self.scrollView.contentSize = contentSize;
}


-(void)setUpPageControl:(NSArray *)array
{
//    UIView *blackView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_scrollView.frame) - 25, CGRectGetWidth(self.frame), 25)];
//    blackView.backgroundColor = [UIColor blackColor];
//    blackView.alpha = 0.7;
//    [self addSubview:blackView];
//    self.bnameLab = [UILabel lableWithText:@"" Font:[UIFont systemFontOfSize:12.0] TextColor:[UIColor whiteColor]];
//    [blackView addSubview:self.bnameLab];
//    self.bnameLab.frame = CGRectMake(10, 0, CGRectGetWidth(self.frame) - 50, 25);
//    
//    self.pageControl = [[UIPageControl alloc] init];
//    self.pageControl .superview.backgroundColor = [UIColor redColor];
//    self.pageControl .numberOfPages = array.count;
//    //默认是0
//    self.pageControl .currentPage = 0;
//    self.pageControl.center = CGPointMake(CGRectGetWidth(_scrollView.frame)*0.9, CGRectGetHeight(_scrollView.frame) - 12.);
//    [self.pageControl  addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventValueChanged];
//    [self addSubview:self.pageControl ];
    
//    UIView *blackView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_scrollView.frame) - 45- PAGE_H, CGRectGetWidth(self.frame), 45)];
//    blackView.backgroundColor = [UIColor clearColor];
//    [blackView.layer addSublayer:[self shadowAsInverseUp]];
    //blackView.alpha = 0.7;
//    [self addSubview:blackView];
    self.bnameLab = [UILabel lableWithText:@"" Font:[UIFont systemFontOfSize:18.0] TextColor:[UIColor whiteColor]];
    self.bnameLab.numberOfLines = 0;
//    [blackView addSubview:self.bnameLab];
    self.bnameLab.frame = CGRectMake(10, 0, CGRectGetWidth(self.frame) - 20, 45);
    
    self.pageControl = [[BannerPageControl alloc] init];
    self.pageControl .superview.backgroundColor = [UIColor redColor];
    self.pageControl .numberOfPages = array.count;
    //默认是0
    self.pageControl .currentPage = 0;
    //设置圆点背景图
    [self.pageControl setValue:IMG(@"banner_no") forKeyPath:@"_pageImage"];
    [self.pageControl setValue:IMG(@"banner_yes") forKeyPath:@"_currentPageImage"];
//    [self.pageControl setTransform:CGAffineTransformMakeScale(1.1, 1.1)];
    //居中是否
//    self.pageControl.center = CGPointMake(CGRectGetWidth(_scrollView.frame)*0.5, CGRectGetHeight(_scrollView.frame) - 8);
    [self.pageControl  addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.pageControl];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-20);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
}

-(void)pageChange:(UIPageControl *)page
{
    NSLog(@"%zd  & %f",page.currentPage,self.bounds.size.width);
    //获取当前页面的宽度
    CGFloat x = page.currentPage * self.bounds.size.width;
    //通过设置scrollView的偏移量来滚动图像
    [self.scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
}

#pragma mark - Timer时间方法
-(void)startTimer
{
    if (!_duration) {
        self.timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    }else{
        self.timer = [NSTimer timerWithTimeInterval:_duration target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    }
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)updateTimer
{
    CGPoint newOffset = CGPointMake(self.scrollView.contentOffset.x  + CGRectGetWidth(self.scrollView.frame), 0);
    [self.scrollView setContentOffset:newOffset animated:YES];
}


#pragma mark - scrollView代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView.contentOffset.x < self.frame.size.width) {
        [self.scrollView setContentOffset:CGPointMake(self.frame.size.width * (self.imageArray.count + 1), 0) animated:NO];
    }
    //偏移超过
    if (scrollView.contentOffset.x > self.frame.size.width * (self.imageArray.count + 1)) {
        [self.scrollView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
    }
    int pageCount = scrollView.contentOffset.x / self.frame.size.width;
    
    if (pageCount > self.imageArray.count) {
        pageCount = 0;
    }else if (pageCount == 0){
        pageCount = (int)self.imageArray.count - 1;
    }else{
        pageCount--;
    }
    self.pageControl.currentPage = pageCount;
    if (self.shorttitleArr.count > 0) {
        self.bnameLab.text = [self.shorttitleArr objectAtIndex:pageCount];
    }
}
//停止滚动时
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
}
//开始拖动时
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
}
//结束拖动时
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}

- (void)setPageBackgroundColor:(UIColor *)pageBackgroundColor
{
    if (pageBackgroundColor) {
        self.pageControl .backgroundColor = pageBackgroundColor;
    }
}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor
{
    if (pageIndicatorTintColor) {
        self.pageControl .pageIndicatorTintColor = pageIndicatorTintColor;
    }
}
- (void)setCurrentPageColor:(UIColor *)currentPageColor
{
    if (currentPageColor) {
        self.pageControl .currentPageIndicatorTintColor = currentPageColor;
    }
}
-(void)setSelfBackgroundColor:(UIColor *)selfBackgroundColor
{
    if (selfBackgroundColor) {
        self.backgroundColor = selfBackgroundColor;
    }
}
@end
