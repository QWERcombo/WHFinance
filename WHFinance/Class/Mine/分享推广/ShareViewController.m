//
//  ShareViewController.m
//  WHFinance
//
//  Created by wanhong on 2017/7/3.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "ShareViewController.h"
#import "ShareRegisterViewController.h"

@interface ShareViewController ()
@property (nonatomic, strong) NSArray *nameArray;
@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"推广赚钱";
    self.nameArray = @[@[@"spread_0",@"分享二维码图片和链接"],@[@"spread_1",@"H5分享注册页面链接"],@[@"spread_2",@"帮助朋友开通账号"]];
    
    [self setUpSubviews];
}

- (void)setUpSubviews {
    [self.view addSubview:self.tabView];
    self.tabView.backgroundColor = [UIColor Grey_BackColor1];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.nameArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineListCell *cell = (MineListCell *)[UtilsMold creatCell:@"MineListCell" table:tableView deledate:self model:[self.nameArray objectAtIndex:indexPath.row] data:nil andCliker:^(NSDictionary *clueDic) {
        
    }];
    [cell.contentView addSubview:cell.line];
    [cell.line mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(1));
        make.left.equalTo(cell.contentView.mas_left).offset(15);
        make.right.equalTo(cell.contentView.mas_right).offset(15);
        make.bottom.equalTo(cell.contentView.mas_bottom);
    }];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row==2) {
        [cell.line removeFromSuperview];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 10)];
    view.backgroundColor = [UIColor Grey_BackColor1];
    return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==0) {
        
    }
    if (indexPath.row==1) {
        
    }
    if (indexPath.row==2) {
        
    }
    if (indexPath.row==3) {
        ShareRegisterViewController *regi = [ShareRegisterViewController new];
        [self.navigationController pushViewController:regi animated:YES];
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
