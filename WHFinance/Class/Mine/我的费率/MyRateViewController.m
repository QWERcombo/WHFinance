//
//  MyRateViewController.m
//  WHFinance
//
//  Created by wanhong on 2017/7/6.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "MyRateViewController.h"
#import "JoinParterViewController.h"

@interface MyRateViewController ()

@end

@implementation MyRateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的费率";
    
    [self setUpSubviews];
}

- (void)setUpSubviews {
    [self.view addSubview:self.tabView];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataMuArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self createMainView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.view.size.height;
}

- (UIView *)createMainView {
    UIView *mainView = [[UIView alloc] initWithFrame:self.view.bounds];
    mainView.backgroundColor = [UIColor whiteColor];
    UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 25, SCREEN_WIGHT, self.view.size.height-100)];
    if ([[UserData currentUser].isPartner integerValue]==1) {
        imgv.image = IMG(@"mine_rate_1");
    } else {
        imgv.image = IMG(@"mine_rate_0");
    }
    imgv.contentMode = UIViewContentModeCenter;
    [mainView addSubview:imgv];
    UIView *vvv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 25)];
    vvv.backgroundColor = [UIColor Grey_BackColor1];
    [mainView addSubview:vvv];
    UILabel *label1 = [UILabel lableWithText:@"您当前收款费率" Font:FONT_ArialMT(12) TextColor:[UIColor Grey_OrangeColor]];
    [vvv addSubview:label1];
    label1.frame = CGRectMake(10, 6.5, 100, 12);
    
    
    UIButton *join = [UIButton buttonWithTitle:@"更多利润返佣？快速加入创业合伙人 >>" andFont:FONT_ArialMT(12) andtitleNormaColor:[UIColor Grey_OrangeColor] andHighlightedTitle:[UIColor Grey_OrangeColor] andNormaImage:nil andHighlightedImage:nil];
    if ([[UserData currentUser].isPartner integerValue]==1) {
        [join addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [join setTitle:@"已是合伙人" forState:UIControlStateNormal];
    }
    [mainView addSubview:join];
    [join mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgv.mas_bottom);
        make.centerX.equalTo(mainView.mas_centerX);
        if ([[UserData currentUser].isPartner integerValue]!=1) {
            make.height.equalTo(@(12));
        } else {
            make.height.equalTo(@(0));
        }
        
    }];
    
    
    UILabel *label = [UILabel lableWithText:@"如果每月交易五万，预计一年可节省1020元" Font:FONT_ArialMT(12) TextColor:[UIColor Grey_WordColor]];
    [mainView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(mainView.mas_centerX);
        make.height.equalTo(@(12));
        make.top.equalTo(join.mas_bottom).offset(10);
    }];
    
    return mainView;
}

- (void)buttonClick:(UIButton *)sender {
    JoinParterViewController *join = [JoinParterViewController new];
    [self.navigationController pushViewController:join animated:YES];
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
