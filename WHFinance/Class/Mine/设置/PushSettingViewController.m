//
//  PushSettingViewController.m
//  WHFinance
//
//  Created by wanhong on 2017/7/6.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "PushSettingViewController.h"

@interface PushSettingViewController ()

@end

@implementation PushSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"推送通知";
    
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
    return [UtilsMold creatCell:@"MyProfitDetailCell" table:tableView deledate:self model:nil data:nil andCliker:^(NSDictionary *clueDic) {
        
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold getCellHight:@"MyProfitDetailCell" data:nil model:nil indexPath:indexPath];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self createMainView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return SCREEN_HEIGHT;
}

- (UIView *)createMainView {
    UIView *mainView = [[UIView alloc] initWithFrame:self.view.bounds];
    mainView.backgroundColor = [UIColor Grey_BackColor1];
    
    UIView *content = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 115)];
    content.backgroundColor = [UIColor whiteColor];
    [mainView addSubview:content];
    
    UILabel *label = [UILabel lableWithText:@"(1)  此功能用于推送消息到手机屏幕显示\n(2)  关闭该功能后将不会推送到手机显示屏\n(3)  建议打开该功能，便于及时收到交易、审核、返润等相关消息" Font:FONT_ArialMT(12) TextColor:[UIColor mianColor:2]];
    label.numberOfLines = 0;
    [content addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(content.mas_top).offset(20);
        make.left.equalTo(content.mas_left).offset(12);
        make.right.equalTo(content.mas_right).offset(-12);
        make.bottom.equalTo(content.mas_bottom).offset(-10);
    }];
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
    para.lineSpacing = 5;
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:label.text attributes:@{NSParagraphStyleAttributeName:para}];
    label.attributedText = attrText;
    
    
    UIButton *button = [UIButton buttonWithTitle:@"打开" andFont:FONT_ArialMT(19) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:IMG(@"") andHighlightedImage:IMG(@"")];
    button.backgroundColor = [UIColor mianColor:1];
    button.layer.cornerRadius = 10;
    button.clipsToBounds = YES;
    [mainView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(40));
        make.left.equalTo(mainView.mas_left).offset(12.5);
        make.right.equalTo(mainView.mas_right).offset(-12.5);
        make.top.equalTo(content.mas_bottom).offset(20);
    }];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return mainView;
}

- (void)buttonAction:(UIButton *)sender {
    if ([sender.currentTitle isEqualToString:@"打开"]) {
        [sender setTitle:@"关闭" forState:UIControlStateNormal];
    } else {
        [sender setTitle:@"打开" forState:UIControlStateNormal];
    }
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
