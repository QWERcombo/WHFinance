//
//  ZLDashboardView.m
//  ZLDashboard
//
//  Created by qtx on 16/9/19.
//  Copyright © 2016年 ZL. All rights reserved.
//

#import "ZLDashboardView.h"
//#import "UIView+Extensions.h"

#define degreesToRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式
static const CGFloat kMarkerRadius = 5.f; // 光标直径
static const CGFloat kTimerInterval = 0.03;
static const CGFloat kFastProportion = 0.9;

static const NSInteger MaxNumber = 1000;

@interface ZLDashboardView () {
    CGFloat animationTime;
    NSInteger beginNO;
    NSInteger jumpCurrentNO;
    NSInteger endNO;
}

// 百分比 0 - 100 根据跃动数字设置
@property (nonatomic, assign) CGFloat percent;

@property (nonatomic, strong) CAShapeLayer *bottomLayer; // 进度条底色
@property (nonatomic, assign) CGFloat lineWidth; // 弧线宽度

@property (nonatomic, strong) UIImageView *markerImageView; // 光标

@property (nonatomic, strong) UIImageView *bgImageView; // 背景图片

@property (nonatomic, assign) CGFloat circelRadius; //圆直径
@property (nonatomic, assign) CGFloat startAngle; // 开始角度
@property (nonatomic, assign) CGFloat endAngle; // 结束角度

@property (nonatomic, strong) UILabel *showLable; // 跳跃数字
@property (nonatomic, strong) UILabel *markedLabel; // 提示语
@property (nonatomic, strong) NSTimer *fastTimer;
@property (nonatomic, strong) NSTimer *slowTimer;

@property (nonatomic, assign) NSInteger intervalNum;

@property (nonatomic, strong) NSString *unitStr;//单位
@property (nonatomic, assign) BOOL isStatus;// yes利润 no客户
//@property (nonatomic, strong) NSString *todayNew;//今日新增利润
@property (nonatomic, strong) NSString *balance;//可提现利润
@end

@implementation ZLDashboardView

#pragma mark - Life cycle

- (instancetype)initWithFrame:(CGRect)frame WithUnit:(NSString *)unit andStatus:(BOOL)status andData:(NSArray *)data {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.circelRadius = self.frame.size.width - 10.f;
        self.lineWidth = 2.f;
        self.startAngle = -230.f;
        self.endAngle = 50.f;
        self.unitStr = unit;
        self.isStatus = status;
        self.balance = [data lastObject];
//        self.todayNew = [data firstObject];
        
        // 尺寸需根据图片进行调整
        self.bgImageView.frame = CGRectMake(6, 6, self.circelRadius, self.circelRadius);
        self.bgImageView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.bgImageView];
        
        //添加圆框
//        [self setupCircleBg];
        
        //光标
        [self setupMarkerImageView];
        
        //添加跃动数字 及 提示语
        [self setupJumpNOView];
    }
    return self;
}


- (void)setupCircleBg {
    
    // 圆形路径
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 2, self.height / 2)
                                                        radius:(self.circelRadius - self.lineWidth) / 2
                                                    startAngle:degreesToRadians(self.startAngle)
                                                      endAngle:degreesToRadians(self.endAngle)
                                                     clockwise:YES];
    
    // 底色
    self.bottomLayer = [CAShapeLayer layer];
    self.bottomLayer.frame = self.bounds;
    self.bottomLayer.fillColor = [[UIColor clearColor] CGColor];
    self.bottomLayer.strokeColor = [[UIColor  colorWithRed:206.f / 256.f green:241.f / 256.f blue:227.f alpha:1.f] CGColor];
//    self.bottomLayer.strokeColor = [[UIColor  redColor] CGColor];
    self.bottomLayer.opacity = 0.5;
    self.bottomLayer.lineCap = kCALineCapRound;
    self.bottomLayer.lineWidth = self.lineWidth;
    self.bottomLayer.path = [path CGPath];
    [self.layer addSublayer:self.bottomLayer];
    
    // 240 是用整个弧度的角度之和 |-200| + 20 = 220
    //    [self createAnimationWithStartAngle:degreesToRadians(self.startAngle)
    //                               endAngle:degreesToRadians(self.startAngle + 220 * 1)];
}

- (void)setupMarkerImageView {
    if (_markerImageView) {
        return;
    }
    _markerImageView = [[UIImageView alloc] init];
//    _markerImageView.image = IMG(@"dial_point");
    _markerImageView.backgroundColor = [UIColor clearColor];
    _markerImageView.layer.backgroundColor = [UIColor whiteColor].CGColor;
    _markerImageView.layer.shadowColor = [UIColor whiteColor].CGColor;
    _markerImageView.layer.shadowOffset = CGSizeMake(0, 0);
    _markerImageView.layer.shadowRadius = kMarkerRadius*0.5;
    _markerImageView.layer.shadowOpacity = 1;
    _markerImageView.layer.masksToBounds = NO;
    self.markerImageView.layer.cornerRadius = self.markerImageView.frame.size.height / 2;
    [self addSubview:self.markerImageView];
    _markerImageView.frame = CGRectMake(-SCREEN_WIGHT, self.height, kMarkerRadius, kMarkerRadius);
}

- (void)setupJumpNOView {
    if (_showLable) {
        return;
    }
    CGFloat width = self.circelRadius / 2 + 20;
    CGFloat height = self.circelRadius / 2 - 40;
    CGFloat xPixel = self.bgImageView.left + (self.bgImageView.width - width)*0.5;//self.circelRadius / 4;
    CGFloat yPixel = self.circelRadius / 4 * 2;
    CGRect labelFrame = CGRectMake(xPixel, yPixel, width, height);
    if (self.isStatus) {
        _showLable = [[UILabel alloc] initWithFrame:CGRectMake(xPixel, yPixel-20, width, 20)];
        _showLable.backgroundColor = [UIColor clearColor];
        _showLable.textColor = [UIColor whiteColor];
        _showLable.textAlignment = NSTextAlignmentCenter;
        _showLable.font = FONT_ArialMT(20);
        _showLable.text = [NSString stringWithFormat:@"%ld",jumpCurrentNO];
        [self addSubview:_showLable];
        
        // TODO:提示语
        _markedLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPixel, CGRectGetMinY(_showLable.frame)-20, width, 15)];
        _markedLabel.textColor = [UIColor colorWithR:253 G:183 B:173 A:1];
        _markedLabel.textAlignment = NSTextAlignmentCenter;
        _markedLabel.font = FONT_ArialMT(12);
        _markedLabel.text = @"今日新增利润";
        [self addSubview:_markedLabel];
        
        UILabel *hintLab = [UILabel lableWithText:@"可提现利润" Font:FONT_ArialMT(12) TextColor:[UIColor mianColor:3]];
        hintLab.frame = CGRectMake(xPixel, CGRectGetMaxY(_showLable.frame)+10, width, 15);
        hintLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:hintLab];
        UILabel *countLab = [UILabel lableWithText:[self.balance handleDataSourceTail] Font:FONT_ArialMT(20) TextColor:[UIColor whiteColor]];
        countLab.frame = CGRectMake(xPixel, CGRectGetMaxY(hintLab.frame)+5, width, 20);
        countLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:countLab];
        
        
    } else {
        _showLable = [[UILabel alloc] initWithFrame:labelFrame];
        _showLable.backgroundColor = [UIColor clearColor];
        _showLable.textColor = [UIColor whiteColor];
        _showLable.textAlignment = NSTextAlignmentCenter;
        _showLable.font = FONT_ArialMT(35);
        _showLable.text = [NSString stringWithFormat:@"%ld",jumpCurrentNO];
        [self addSubview:_showLable];
        
        // TODO:提示语
        _markedLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPixel, CGRectGetMinY(_showLable.frame)-30, width, 20)];
        _markedLabel.numberOfLines = 0;
        _markedLabel.textColor = [UIColor colorWithR:253 G:183 B:173 A:1];
        _markedLabel.textAlignment = NSTextAlignmentCenter;
        _markedLabel.font = [UIFont systemFontOfSize:14.f];
        _markedLabel.text = @"累计客户数";
        [self addSubview:_markedLabel];
    }
    
    
    //单位
    UILabel *hintLab = [UILabel lableWithText:[NSString stringWithFormat:@"单位: %@",self.unitStr] Font:FONT_ArialMT(12) TextColor:[UIColor colorWithR:253 G:183 B:173 A:1]];
    hintLab.textAlignment = NSTextAlignmentCenter;
    hintLab.frame = CGRectMake(self.circelRadius/2-19, self.circelRadius-15, 50, 12);
    [self addSubview:hintLab];
    
    
}

#pragma mark - Animation

- (void)createAnimationWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle { // 光标动画
    
    //启动定时器
    [_fastTimer setFireDate:[NSDate distantPast]];
    // 设置动画属性
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = _percent * kTimerInterval;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    pathAnimation.repeatCount = 1;
    
    // 设置动画路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, NULL, self.width / 2, self.height / 2, (self.circelRadius - kMarkerRadius / 2) / 2, startAngle, endAngle, 0);
    pathAnimation.path = path;
    CGPathRelease(path);
    
    [self.markerImageView.layer addAnimation:pathAnimation forKey:@"moveMarker"];
    
}

#pragma mark - Setters / Getters


/**
 *  开始动画  确定百分比
 *
 */
- (void)refreshJumpNOFromNO:(NSString *)startNO toNO:(NSString *)toNO {
//    NSLog(@"---====%@", toNO);
    beginNO = 0; // [startNO integerValue];
    jumpCurrentNO = 0; // [startNO integerValue];
    if (self.isStatus) {
        endNO = [toNO integerValue]*10;
    } else {
        endNO = [toNO integerValue]*10;
    }
    _percent = endNO * 100 / MaxNumber;
    
    NSInteger diffNum = endNO - beginNO;
    if (diffNum <= 0) {
        return;
    }
    if (diffNum < 100) {
        _intervalNum = 5;
    } else if (diffNum < 300) {
        _intervalNum = 15;
    } else if (diffNum <= MaxNumber) {
        _intervalNum = 10;
    }
    NSLog(@"数字间隔：%ld",_intervalNum);
    
    //数字
    [self setupJumpThings];
    
    // 设置角度
    NSInteger angle = 0;
    NSInteger num = [toNO floatValue]*10 - [startNO floatValue]*10;
    if (num < 200) {
       angle = self.startAngle + 220 * (num / 200.0) / 5.0;
    } else if (num < 350) {
        angle = self.startAngle + 220 / 5.0 + (3 / 5.0 * 220) * (num - 200) / 150.0;
    } else {
        angle = self.startAngle + 220 / 5.0 * 4 + (220 / 5.0) * (num - 350) / 250.0;
    }
    //光标
    [self createAnimationWithStartAngle:degreesToRadians(self.startAngle)
                               endAngle:degreesToRadians(angle)];
}

- (void)setBgImage:(UIImage *)bgImage {
    
    _bgImage = bgImage;
    self.bgImageView.image = bgImage;
}

- (UIImageView *)bgImageView {
    
    if (nil == _bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
    }
    return _bgImageView;
}

#pragma mark - 跃动数字

- (void)setupJumpThings {
    
    animationTime = _percent * kTimerInterval;
    
    self.fastTimer = [NSTimer timerWithTimeInterval:kTimerInterval*kFastProportion
                                             target:self
                                           selector:@selector(fastTimerAction)
                                           userInfo:nil
                                            repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_fastTimer forMode:NSRunLoopCommonModes];
    
    //时间间隔 = （总时间 - 快时间间隔*变化次数）/ 再次需要变化的次数
    //快时间
    NSInteger fastEndNO = endNO * kFastProportion;
    
    NSInteger fastJump = fastEndNO/_intervalNum;
    if (fastJump % _intervalNum) {
        fastJump++;
        fastEndNO += _intervalNum;
    }
    CGFloat fastTTime = fastJump*kTimerInterval*kFastProportion;
    
    //剩余应跳动次数
    NSInteger changNO = endNO - fastEndNO;
    NSInteger endJump = changNO / _intervalNum + changNO % _intervalNum;
    //慢时间间隔
    NSTimeInterval slowInterval = (animationTime - fastTTime) / endJump;
    
    self.slowTimer = [NSTimer timerWithTimeInterval:slowInterval
                                             target:self
                                           selector:@selector(slowTimerAction)
                                           userInfo:nil
                                            repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_slowTimer forMode:NSRunLoopCommonModes];
    [_fastTimer setFireDate:[NSDate distantFuture]];
    [_slowTimer setFireDate:[NSDate distantFuture]];
}

#pragma mark 加速定时器触发事件
- (void)fastTimerAction {
    if (jumpCurrentNO >= endNO) {
        [self.fastTimer invalidate];
        return;
    }
    if (jumpCurrentNO >= endNO * kFastProportion) {
        [self.fastTimer invalidate];
        [self.slowTimer setFireDate:[NSDate distantPast]];
        return;
    }
    [self commonTimerAction];
}

#pragma mark 减速定时器触发事件
- (void)slowTimerAction {
    if (jumpCurrentNO >= endNO) {
        [self.slowTimer invalidate];
        return;
    }
    [self commonTimerAction];
}

#pragma mark 计时器共性事件 - lable赋值 背景颜色变化
- (void)commonTimerAction {
    
    if (jumpCurrentNO % 100 == 0 && jumpCurrentNO != 0) {
        NSInteger colorIndex = jumpCurrentNO / 100;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.TimerBlock) {
                self.TimerBlock(colorIndex);
            }
        });
    }
    NSInteger changeValueBy = endNO - jumpCurrentNO;
    
    if (changeValueBy/10 < 1) {
        jumpCurrentNO++;
    } else {
//        NSInteger changeBy = changeValueBy / 10;
        jumpCurrentNO += _intervalNum;
    }
//    NSLog(@"%ld", (long)jumpCurrentNO);
    if (self.isStatus) {
        double temp = jumpCurrentNO;
        _showLable.text = [NSString stringWithFormat:@"%.2lf",temp/10.00];//显示的数字
    } else {
        _showLable.text = [NSString stringWithFormat:@"%ld",jumpCurrentNO/10];//显示的数字
    }

}


@end
