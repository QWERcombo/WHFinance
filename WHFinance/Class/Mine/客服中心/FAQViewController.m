//
//  FAQViewController.m
//  WHFinance
//
//  Created by wanhong on 2017/6/29.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "FAQViewController.h"
#import "FAQDetailViewController.h"


@interface FAQViewController ()

@end

@implementation FAQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"常见问题";
    for (NSInteger i=0; i<10; i++) {
        [self.dataMuArr addObject:@"怎样进行收款?"];
    }
    [self setupSubViews];
}


- (void)setupSubViews {
    self.tabView.backgroundColor = [UIColor Grey_BackColor1];
    [self.view addSubview:self.tabView];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataMuArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[BaseCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.textLabel.text = [self.dataMuArr objectAtIndex:indexPath.row];
    cell.textLabel.font = FONT_ArialMT(14);
    cell.textLabel.textColor = [UIColor Grey_WordColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.contentView.mas_left).offset(12.5);
        make.bottom.equalTo(cell.contentView.mas_bottom);
        make.height.equalTo(@(1));
        make.right.equalTo(cell.contentView.mas_right).offset(17.5);
    }];
    
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FAQDetailViewController *detail = [FAQDetailViewController new];
    [self.navigationController pushViewController:detail animated:YES];
}

- (UIView *)createMainView {
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 60)];
    mainView.backgroundColor = [UIColor Grey_BackColor1];
    
//    UIButton *button = [UIButton buttonWithTitle:@"客服电话: 4000-000-000" andFont:FONT_ArialMT(18) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:IMG(@"register_btn") andHighlightedImage:IMG(@"register_btn")];
//    [mainView addSubview:button];
//    [button setImage:IMG(@"login_check_y") forState:UIControlStateNormal];
//    button.imageEdgeInsets = UIEdgeInsetsMake(0.0, -10.0, 0.0, 0.0);
//    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//
//    [button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(@(40));
//        make.left.equalTo(mainView.mas_left).offset(12.5);
//        make.right.equalTo(mainView.mas_right).offset(-12.5);
//        make.top.equalTo(mainView.mas_top).offset(10);
//    }];
//    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return mainView;
}

- (void)buttonAction:(UIButton *)sender {
    NSLog(@"客服电话");
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://10086"]]];
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
