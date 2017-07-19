//
//  ShareDetailViewController.m
//  WHFinance
//
//  Created by wanhong on 2017/7/6.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "ShareDetailViewController.h"

@interface ShareDetailViewController ()

@end

@implementation ShareDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([self.type isEqualToString:@"1"]) {
        self.title = @"分享二维码";
        
        UIButton *button = [UIButton buttonWithTitle:@"分享" andFont:FONT_ArialMT(13) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:nil andHighlightedImage:nil];
        button.frame = CGRectMake(0, 0, 30, 30);
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
    } else {
        self.title = @"分享注册信息";
    }
    
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
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.view.size.height;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([self.type isEqualToString:@"1"]) {
        return [self createMainView];
    } else {
        return [self createMainView2];
    }
}

- (UIView *)createMainView {
    UIView *mainView = [[UIView alloc] initWithFrame:self.view.bounds];
    UIImageView *imgv = [UIImageView new];
    imgv.image = IMG(@"service_spread_1");
    [mainView addSubview:imgv];
    [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(mainView);
    }];
    
    return mainView;
}

- (UIView *)createMainView2 {
    UIView *mainView = [[UIView alloc] initWithFrame:self.view.bounds];
    UIImageView *imgv = [UIImageView new];
    imgv.image = IMG(@"service_spread");
    [mainView addSubview:imgv];
    [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(mainView);
        make.bottom.equalTo(mainView.mas_bottom).offset(-50);
    }];
    
    UIButton *button = [UIButton buttonWithTitle:@"我要推广" andFont:FONT_BoldMT(18) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:nil andHighlightedImage:nil];
    [mainView addSubview:button];
    button.backgroundColor = [UIColor mianColor:1];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(mainView);
        make.top.equalTo(imgv.mas_bottom);
    }];
    
    
    return mainView;
}

- (void)buttonClick:(UIButton *)sender {
    [SharePopView addSharePopViewTo:self];
    
    
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
