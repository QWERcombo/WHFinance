//
//  ChooseView.m
//  WHFinance
//
//  Created by wanhong on 2017/6/29.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "ChooseView.h"

@implementation ChooseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    UIView *backg = [[UIView alloc] initWithFrame:MY_WINDOW.bounds];
    backg.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    UITapGestureRecognizer *backgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgTapAction:)];
    [backg addGestureRecognizer:backgTap];
    [self addSubview:backg];
    
    UIView *contentView = [[UIView alloc] init];
    [backg addSubview:contentView];
    contentView.layer.cornerRadius = 20;
    contentView.clipsToBounds = YES;
    contentView.backgroundColor = [UIColor whiteColor];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(backg);
        make.width.equalTo(@(250));
        make.height.equalTo(@(270));
    }];
    
    UILabel *titleLab = [UILabel lableWithText:@"筛选" Font:FONT_ArialMT(19) TextColor:[UIColor Grey_WordColor]];
    [contentView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(20));
        make.top.equalTo(contentView.mas_top).offset(11);
        make.centerX.equalTo(contentView.mas_centerX);
    }];
    
    UILabel *tradeStatus = [UILabel lableWithText:@"交易结果" Font:FONT_ArialMT(14) TextColor:[UIColor Grey_WordColor]];
    [contentView addSubview:tradeStatus];
    [tradeStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(14));
        make.top.equalTo(titleLab.mas_bottom).offset(13);
        make.left.equalTo(contentView.mas_left).offset(12.5);
    }];
    
    NSArray *statusArr = @[@"全部",@"成功",@"失败"];
    NSArray *typeArr = @[@"全部",@"微信",@"支付宝",@"银联二维码",@"银联快捷",@""];
    UIView *lastView = nil;
    for (NSInteger i=0; i<3; i++) {
        UIButton *statusBtn = [UIButton buttonWithTitle:[statusArr objectAtIndex:i] andFont:FONT_ArialMT(12) andtitleNormaColor:[UIColor Grey_WordColor] andHighlightedTitle:nil andNormaImage:nil andHighlightedImage:nil];
        statusBtn.tag = 1000+i;
        statusBtn.backgroundColor = [UIColor Grey_BackColor1];
        statusBtn.layer.cornerRadius = 5;
        statusBtn.clipsToBounds = YES;
        [statusBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [statusBtn addObserver:self forKeyPath:@"selected" options:NSKeyValueObservingOptionNew||NSKeyValueChangeOldKey context:nil];
        if (i==0) {
            statusBtn.selected = YES;
        } else {
            statusBtn.selected = NO;
        }
        self.tradeNum = 1000;
        [contentView addSubview:statusBtn];
        [statusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(70));
            make.height.equalTo(@(30));
            make.top.equalTo(tradeStatus.mas_bottom).offset(10);
            if (lastView) {
                make.left.equalTo(lastView.mas_right).offset(15/2);
            } else {
                make.left.equalTo(contentView.mas_left).offset(12.5);
            }
        }];
        lastView = statusBtn;
    }
    
    
    UILabel *tradeType = [UILabel lableWithText:@"交易方式" Font:FONT_ArialMT(14) TextColor:[UIColor Grey_WordColor]];
    [contentView addSubview:tradeType];
    [tradeType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(14));
        make.top.equalTo(titleLab.mas_bottom).offset(13+74);
        make.left.equalTo(contentView.mas_left).offset(12.5);
    }];
    
    for (NSInteger j=0; j<2; j++) {
        for (NSInteger i=0; i<3; i++) {
            UIButton *statusBtn = [UIButton buttonWithTitle:[typeArr objectAtIndex:3*j+i] andFont:FONT_ArialMT(12) andtitleNormaColor:[UIColor Grey_WordColor] andHighlightedTitle:nil andNormaImage:nil andHighlightedImage:nil];
            statusBtn.tag = 2000+(3*j+i);
            statusBtn.backgroundColor = [UIColor Grey_BackColor1];
            statusBtn.layer.cornerRadius = 5;
            statusBtn.clipsToBounds = YES;
            [statusBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [statusBtn addObserver:self forKeyPath:@"selected" options:NSKeyValueObservingOptionNew||NSKeyValueChangeOldKey context:nil];
            if (i==0&&j==0) {
                statusBtn.selected = YES;
            } else {
                statusBtn.selected = NO;
            }
            self.typeNum = 2000;
            if (j==1&&i==2) {
                statusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                statusBtn.backgroundColor = [UIColor whiteColor];
                statusBtn.userInteractionEnabled = YES;
            } else {
                statusBtn.frame = CGRectMake(12.5+77.5*i, 132+37.5*j+10, 70, 30);
            }
            
            [contentView addSubview:statusBtn];
        }
    }
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor Grey_LineColor];
    [contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(1));
        make.left.right.equalTo(contentView);
        make.bottom.equalTo(contentView.mas_bottom).offset(-40);
    }];
    
    UIButton *cancelBtn = [UIButton buttonWithTitle:@"取消" andFont:FONT_ArialMT(14) andtitleNormaColor:[UIColor mianColor:2] andHighlightedTitle:[UIColor mianColor:2] andNormaImage:nil andHighlightedImage:nil];
    [cancelBtn addTarget:self action:@selector(backgTapAction:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(contentView);
        make.top.equalTo(line.mas_bottom);
        make.width.equalTo(@(250/2));
    }];
    
    UIButton *doneBtn = [UIButton buttonWithTitle:@"确定" andFont:FONT_ArialMT(14) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:nil andHighlightedImage:nil];
    doneBtn.backgroundColor = [UIColor mianColor:1];
    [contentView addSubview:doneBtn];
    [doneBtn addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
    [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(contentView);
        make.top.equalTo(line.mas_bottom);
        make.width.equalTo(@(125));
    }];
    
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    UIButton *button = (UIButton *)object;
    if ([keyPath isEqualToString:@"selected"]) {
        if (button.selected) {
            [button setBackgroundColor:[UIColor mianColor:1]];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        } else {
            [button setBackgroundColor:[UIColor Grey_BackColor1]];
            [button setTitleColor:[UIColor Grey_WordColor] forState:UIControlStateNormal];
        }
    }
}
- (void)doneAction:(UIButton *)sender {//确定
    if (!self.tradeStr.length) {
        self.tradeStr = @"全部";
    }
    if (!self.typeStr.length) {
        self.tradeStr = @"全部";
    }
    _clikBlock([NSString stringWithFormat:@"%@%-@", self.tradeStr, self.typeStr]);
}
- (void)backgTapAction:(id)sender {//移除
    [self removeFromSuperview];
}
- (void)buttonClick:(UIButton *)btn {
    UIButton *tradeBtn = [self viewWithTag:self.tradeNum];
    UIButton *typeBtn = [self viewWithTag:self.typeNum];
    if (btn.selected) {
        return;
    } else {
        btn.selected = YES;
        if (btn.tag>1999) {
            typeBtn.selected = NO;
            self.typeNum = btn.tag;
            self.typeStr = btn.currentTitle;
        } else {
            tradeBtn.selected = NO;
            self.tradeNum = btn.tag;
            self.tradeStr = btn.currentTitle;
        }
        
    }
}

+ (void)showChooseView:(BaseModel *)model WithBlock:(ClikBlock)clik inRootViewController:(BaseViewController *)delegate {
    ChooseView *choose = [[ChooseView alloc] initWithFrame:MY_WINDOW.bounds];
    choose.clikBlock = clik;
    
    
    
    
    [MY_WINDOW addSubview:choose];
}


@end
