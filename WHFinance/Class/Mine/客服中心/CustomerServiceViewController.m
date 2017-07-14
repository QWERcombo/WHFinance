//
//  CustomerServiceViewController.m
//  WHFinance
//
//  Created by wanhong on 2017/6/29.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "CustomerServiceViewController.h"
#import "FAQViewController.h"

@interface CustomerServiceViewController ()
@property (nonatomic, strong) NSArray *nameArray;

@end

@implementation CustomerServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"客服中心";
    self.nameArray = @[@[@"",@"客服电话"],@[@"",@"QQ客服"],@[@"",@"常见问题"]];
    
    
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
    return 3;
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
        [[UtilsData sharedInstance] showAlertControllerWithTitle:@"" detail:@"客服电话:18585858585" doneTitle:@"呼叫" cancelTitle:@"取消" haveCancel:YES doneAction:^{
            NSLog(@"2222");
        } controller:self];
    }
    if (indexPath.row==1) {
        // 判断手机是否安装QQ
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
            UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
            // 提供uin, 你所要联系人的QQ号码
            NSString *qqstr = [NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",@"763740400"];
            NSURL *url = [NSURL URLWithString:qqstr];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [webView loadRequest:request];
            [self.view addSubview:webView];
        }else{
            [[UtilsData sharedInstance] showAlertControllerWithTitle:@"您尚未安装QQ" detail:nil doneTitle:@"确定" cancelTitle:nil haveCancel:NO doneAction:^{
                
            } controller:self];
        }
    }
    if (indexPath.row==2) {
        FAQViewController *faq = [FAQViewController new];
        [self.navigationController pushViewController:faq animated:YES];
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
