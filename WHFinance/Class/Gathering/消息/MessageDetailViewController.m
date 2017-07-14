//
//  MessageDetailViewController.m
//  WHFinance
//
//  Created by wanhong on 2017/6/30.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "MessageDetailViewController.h"

@interface MessageDetailViewController ()
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UILabel *contentLab;

@end

@implementation MessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"消息详情";
    
    [self setupSubviews];
}


- (void)setupSubviews {
    self.view.backgroundColor = [UIColor Grey_BackColor1];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, SCREEN_HEIGHT/2)];
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    
    self.titleLab = [UILabel lableWithText:self.dataModel.title Font:FONT_ArialMT(20) TextColor:[UIColor Grey_WordColor]];
    [scrollView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(20));
        make.centerX.equalTo(scrollView.mas_centerX);
        make.top.equalTo(scrollView.mas_top).offset(20);
    }];
    
    self.timeLab = [UILabel lableWithText:[self.dataModel.createTime NSTimeIntervalTransToYear_Month_Day] Font:FONT_ArialMT(15) TextColor:[UIColor Grey_BackColor]];
    [scrollView addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(15));
        make.centerX.equalTo(self.titleLab.mas_centerX);
        make.top.equalTo(self.titleLab.mas_bottom).offset(12);
    }];
    
    self.contentLab = [UILabel lableWithText:self.dataModel.context Font:FONT_ArialMT(15) TextColor:[UIColor mianColor:2]];
    self.contentLab.numberOfLines = 0;
    [scrollView addSubview:self.contentLab];
    CGSize size = [UILabel getSizeWithText:self.contentLab.text andFont:FONT_ArialMT(15) andSize:CGSizeMake(SCREEN_WIGHT-40, 0)];
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLab.mas_bottom).offset(20);
        make.width.equalTo(@(SCREEN_WIGHT-40));
        make.height.equalTo(@(size.height));
        make.centerX.equalTo(self.timeLab.mas_centerX);
    }];
    
    [scrollView setContentSize:CGSizeMake(SCREEN_WIGHT-40, 87+size.height+10)];
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
