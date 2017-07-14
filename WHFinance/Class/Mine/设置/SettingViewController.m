//
//  SettingViewController.m
//  WHFinance
//
//  Created by wanhong on 2017/6/29.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "SettingViewController.h"
#import "AboutUsViewController.h"
#import "ChangeCodeViewController.h"
#import "PushSettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置";
    
    [self setupSubViews];
}

- (void)setupSubViews {
    [self.view addSubview:self.tabView];
    self.tabView.backgroundColor = [UIColor Grey_BackColor1];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 3;
    } else {
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.font = FONT_ArialMT(18);
    cell.textLabel.textColor = [UIColor Grey_WordColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row==0) {
        cell.textLabel.text = @"修改密码";
        cell.imageView.image = IMG(@"setting_0");
    } else if (indexPath.row==1) {
        cell.textLabel.text = @"关于我们";
        cell.imageView.image = IMG(@"setting_1");
    } else {
        cell.textLabel.text = @"推送通知";
        cell.imageView.image = IMG(@"setting_2");
    }
    
    UIView *line = [UIView new];
    [cell.contentView addSubview:line];
    line.backgroundColor = [UIColor Grey_LineColor];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.contentView.mas_left).offset(15);
        make.right.equalTo(cell.contentView.mas_right).offset(15);
        make.bottom.equalTo(cell.contentView.mas_bottom);
        make.height.equalTo(@(1));
    }];
    if (indexPath.row==2) {
        [line removeFromSuperview];
    }
    
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section==0) {
        UIView *vvv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 10)];
        vvv.backgroundColor = [UIColor Grey_BackColor1];
        return vvv;
    } else {
        return [self createMainView];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return 10;
    } else {
        return 60;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        ChangeCodeViewController *change = [ChangeCodeViewController new];
        [self.navigationController pushViewController:change animated:YES];
    } else if (indexPath.row==1) {
        AboutUsViewController *about = [AboutUsViewController new];
        [self.navigationController pushViewController:about animated:YES];
    } else {
        PushSettingViewController *push = [PushSettingViewController new];
        [self.navigationController pushViewController:push animated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UIView *)createMainView {
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 60)];
    mainView.backgroundColor = [UIColor Grey_BackColor1];
    
    UIButton *button = [UIButton buttonWithTitle:@"退出登录" andFont:FONT_ArialMT(18) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:IMG(@"") andHighlightedImage:IMG(@"")];
    button.backgroundColor = [UIColor mianColor:1];
    button.layer.cornerRadius = 5;
    button.clipsToBounds = YES;
    [mainView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(40));
        make.left.equalTo(mainView.mas_left).offset(12.5);
        make.right.equalTo(mainView.mas_right).offset(-12.5);
        make.top.equalTo(mainView.mas_top).offset(20);
    }];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return mainView;
}

- (void)buttonAction:(UIButton *)sender {
    NSLog(@"退出登录");
    [[UserData currentUser] removeMe];
    [[UtilsData sharedInstance] postLogoutNotice];
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
