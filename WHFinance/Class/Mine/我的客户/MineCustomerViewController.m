//
//  MineCustomerViewController.m
//  WHFinance
//
//  Created by wanhong on 2017/6/28.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "MineCustomerViewController.h"
#import "MineCustomerListViewController.h"
#import "JoinParterViewController.h"

@interface MineCustomerViewController ()
@property (nonatomic, strong) ZLDashboardView *dashboardView;
@property (nonatomic, strong) NSString *todayAddNew;//今日新增
@property (nonatomic, strong) NSString *totalAddNew;//累计总数
@end

@implementation MineCustomerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的客户";
    [self setUpSubviews];
    if ([[UserData currentUser].isPartner integerValue]!=1) {
        [self setUpBarItems];
    }
    
    for (NSInteger i=0; i<3; i++) {
        [self.dataMuArr addObject:@"1"];
    }
    [self getProfitWithdraw];
}

- (void)setUpSubviews {
    [self.view addSubview:self.tabView];
    self.tabView.backgroundColor = [UIColor Grey_BackColor1];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
}
- (void)setUpBarItems {
    UIButton *right_f = [UIButton buttonWithTitle:@"加入合伙人" andFont:FONT_ArialMT(13) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:nil andHighlightedImage:nil];
    right_f.frame = CGRectMake(0, 0, 75, 30);
    [right_f setImage:IMG(@"mine_join") forState:UIControlStateNormal];
    right_f.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    right_f.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [right_f addTarget:self action:@selector(right_f_Action:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right_first = [[UIBarButtonItem alloc] initWithCustomView:right_f];
    self.navigationItem.rightBarButtonItems = @[right_first];
    
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 0;
    } else {
        return self.dataMuArr.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineCustomerCell *cell = (MineCustomerCell *)[UtilsMold creatCell:@"MineCustomerCell" table:tableView deledate:self model:nil data:SINT(indexPath.row) andCliker:^(NSDictionary *clueDic) {
        
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold getCellHight:@"MineCustomerCell" data:nil model:nil indexPath:indexPath];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return [self createMainView];
    } else {
        UIView *blank = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 30)];
        UILabel *label = [UILabel lableWithText:@"客户明细" Font:FONT_ArialMT(12) TextColor:[UIColor mianColor:2]];
        [blank addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(12));
            make.centerY.equalTo(blank.mas_centerY);
            make.left.equalTo(blank.mas_left).offset(15);
        }];
        return blank;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return 215;
    } else {
        return 30;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MineCustomerListViewController *list = [MineCustomerListViewController new];
    [self.navigationController pushViewController:list animated:YES];
}


- (UIView *)createMainView {
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 215)];
    mainView.backgroundColor = [UIColor mianColor:1];
    self.dashboardView = [[ZLDashboardView alloc] initWithFrame:CGRectMake((SCREEN_WIGHT-150)/2, 10, 150, 150) WithUnit:@"个" andStatus:NO andData:nil];
    self.dashboardView.bgImage = IMG(@"dial_index");
    [mainView addSubview:self.dashboardView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.dashboardView refreshJumpNOFromNO:@"0" toNO:self.totalAddNew];
    });
    
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor mianColor:3];
    [mainView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(1));
        make.centerX.equalTo(mainView.mas_centerX);
        make.top.equalTo(self.dashboardView.mas_bottom).offset(10);
        make.width.equalTo(@(SCREEN_WIGHT-50));
    }];
    
    UILabel *newLab = [UILabel lableWithText:[NSString stringWithFormat:@"今日累计新增%@个客户", self.todayAddNew] Font:FONT_ArialMT(14) TextColor:[UIColor whiteColor]];
    newLab.attributedText = [UILabel labGetAttributedStringFrom:6 toEnd:self.todayAddNew.length WithColor:[UIColor Grey_OrangeColor] andFont:FONT_ArialMT(14) allFullText:newLab.text];
    [mainView addSubview:newLab];
    [newLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(15));
        make.left.equalTo(mainView.mas_left).offset(25);
        make.bottom.equalTo(mainView.mas_bottom).offset(-15);
    }];
    
    
    return mainView;
}


#pragma mark - Action
- (void)right_f_Action:(UIButton *)sender {
    JoinParterViewController *join = [JoinParterViewController new];
    [self.navigationController pushViewController:join animated:YES];
}

- (void)getProfitWithdraw {//获取我的客户表盘数据
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"userToken":[UserData currentUser].userToken}] forKey:@"user.getCusStatistic"];
    NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
    [dict setObject:json forKey:@"key"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"----%@", resultDic);
        NSInteger todaynew = [resultDic[@"resultData"][@"firstCusAddNum"] integerValue]+[resultDic[@"resultData"][@"seconedCusAddNum"] integerValue]+[resultDic[@"resultData"][@"thirdCusAddNum"] integerValue];
        NSInteger totalnew = [resultDic[@"resultData"][@"firstCustomersNum"] integerValue]+[resultDic[@"resultData"][@"seconedCustomersNum"] integerValue]+[resultDic[@"resultData"][@"thirdCustomersNum"] integerValue];
        self.todayAddNew = SINT(todaynew);
        self.totalAddNew = SINT(totalnew);
        
        
        [self.tabView reloadData];
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
