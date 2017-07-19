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
    [self.dataMuArr addObjectsFromArray:@[@[@"setting_0",@"修改密码"],@[@"setting_1",@"关于我们"],@[@"setting_2",@"推送通知"]]];
    
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
        return self.dataMuArr.count;
    } else {
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *namestr = [self.dataMuArr objectAtIndex:indexPath.row];
    MineListCell *cell = (MineListCell *)[UtilsMold creatCell:@"MineListCell" table:tableView deledate:self model:namestr data:nil andCliker:^(NSDictionary *clueDic) {
        
    }];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.contentView.mas_left).offset(12.5);
        make.bottom.equalTo(cell.contentView.mas_bottom);
        make.right.equalTo(cell.contentView.mas_right).offset(17.5);
        make.centerX.equalTo(cell.contentView.mas_centerX);
    }];
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
//    [[UserData currentUser] removeMe];
//    [[UtilsData sharedInstance] postLogoutNotice];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"userToken":[UserData currentUser].userToken}] forKey:@"user.loginOut"];
    NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
    [dict setObject:json forKey:@"key"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
//        NSLog(@"%@", resultDic);
        if (resultDic) {
            [[UserData currentUser] removeMe];
            [[UtilsData sharedInstance] postLogoutNotice];
            [[PublicFuntionTool sharedInstance] hangShake];//握手
        }
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
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
