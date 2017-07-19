//
//  MyProfitViewController.m
//  WHFinance
//
//  Created by wanhong on 2017/7/5.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "MyProfitViewController.h"
#import "CardInformationViewController.h"
#import "JoinParterViewController.h"
#import "WithdrawViewController.h"
#import "MyProfitDetailViewController.h"

@interface MyProfitViewController ()
@property (nonatomic, strong) UISegmentedControl *segment;
@property (nonatomic, strong) ZLDashboardView *dashboardView;
@property (nonatomic, strong) NSString *totalBalance;//账户累计利润
@property (nonatomic, strong) NSString *todayBalance;//今日新增利润
@property (nonatomic, strong) NSString *balance;//可提现利润
@end

@implementation MyProfitViewController

- (UISegmentedControl *)segment {
    if (!_segment) {
        _segment = [[UISegmentedControl alloc] initWithItems:@[@"代理分润",@"三级分润"]];
        _segment.selectedSegmentIndex = 0;
        _segment.tintColor = [UIColor whiteColor];
        [_segment addTarget:self action:@selector(bill_segmentAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _segment;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self getProfitWithdraw];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.titleName;
    [self setUpSubviews];
    if ([[UserData currentUser].isPartner integerValue]!=1) {
        [self setUpBarItems];
    }
    
    if ([self.titleName isEqualToString:@"代理分润"]) {
        [self getProfitDataListWithStatus:NO];// NO代理分润(代理商) YES三级分润(合伙人)
    } else if ([self.titleName isEqualToString:@"三级分润"]) {
        [self getProfitDataListWithStatus:YES];// NO代理分润 YES三级分润
    } else {
        [self getProfitDataListWithStatus:NO];// NO代理分润 YES三级分润
    }
}

- (void)setUpSubviews {
    [self.view addSubview:self.tabView];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
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
    MyProfitModel *model = [self.dataMuArr objectAtIndex:indexPath.row];
    return [UtilsMold creatCell:@"MyProfitDetailCell" table:tableView deledate:self model:model data:nil andCliker:^(NSDictionary *clueDic) {
        
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold getCellHight:@"MyProfitDetailCell" data:nil model:nil indexPath:indexPath];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return [self createMainView];
    } else {
        if (self.dataMuArr.count) {
            return nil;
        } else {
            return [UIView showNothingViewWith:1];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return self.isShow>0?276:246;
    } else {
        if (self.dataMuArr.count) {
            return 0;
        } else {
            return self.isShow>0?self.view.size.height-276:self.view.size.height-246;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MyProfitModel *model = [self.dataMuArr objectAtIndex:indexPath.row];
    MyProfitDetailViewController *detail = [MyProfitDetailViewController new];
    detail.orderID = model.orderId;
    [self.navigationController pushViewController:detail animated:YES];
}

- (UIView *)createMainView {
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, self.isShow>0?276:246)];
    mainView.backgroundColor = [UIColor Grey_BackColor1];
    
    UIView *content = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, self.isShow>0?251:221)];
    content.backgroundColor = [UIColor mianColor:1];
    [mainView addSubview:content];
    if (self.isShow) {
        [content addSubview:self.segment];
        [self.segment mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(content.mas_top).offset(10);
            make.width.equalTo(@(230));
            make.height.equalTo(@(30));
            make.centerX.equalTo(content.mas_centerX);
        }];
    }
    
    
    
    self.dashboardView = [[ZLDashboardView alloc] initWithFrame:CGRectMake((SCREEN_WIGHT-150)/2, self.isShow>0?50:20, 150, 150) WithUnit:@"元" andStatus:YES andData:@[self.balance.length>0?self.balance:@"0.00"]];
    self.dashboardView.bgImage = [UIImage imageNamed:@"dial_index"];
    [content addSubview:self.dashboardView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        if ([self.todayBalance integerValue]>10000) {
//            [self.dashboardView refreshJumpNOFromNO:@"0" toNO:@"99"];
//        } else {
//        }
//            [self.dashboardView refreshJumpNOFromNO:@"0" toNO:[self.todayBalance handleDataSourceTail]];
    });
    
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor mianColor:3];
    [content addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(1));
        make.centerX.equalTo(mainView.mas_centerX);
        make.top.equalTo(self.dashboardView.mas_bottom).offset(11);
        make.width.equalTo(@(SCREEN_WIGHT-50));
    }];
    
    
    UILabel *totalCount = [UILabel lableWithText:[NSString stringWithFormat:@"账户累计利润 ￥%@", [[NSString stringWithFormat:@"%@",self.balance] handleDataSourceTail]] Font:FONT_ArialMT(14) TextColor:[UIColor whiteColor]];
    [content addSubview:totalCount];
    [totalCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(20));
        make.top.equalTo(line.mas_bottom).offset(10);
        make.left.equalTo(line.mas_left);
    }];
    
    
    UIButton *cashBtn = [UIButton buttonWithTitle:@"利润提现" andFont:FONT_ArialMT(14) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:nil andHighlightedImage:nil];
    CGSize size = [UILabel getSizeWithText:@"利润提现" andFont:FONT_ArialMT(14) andSize:CGSizeMake(0, 20)];
    [content addSubview:cashBtn];
    [cashBtn addTarget:self action:@selector(caskBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    cashBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    cashBtn.layer.cornerRadius = 5;
    cashBtn.layer.borderWidth = 1;
    cashBtn.clipsToBounds = YES;
    [cashBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(25));
        make.top.equalTo(line.mas_bottom).offset(7.5);
        make.right.equalTo(line.mas_right);
        make.width.equalTo(@(20+size.width));
    }];
    
    
    
    
    UILabel *hint = [UILabel lableWithText:@"利润明细" Font:FONT_ArialMT(12) TextColor:[UIColor mianColor:2]];
    [mainView addSubview:hint];
    [hint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(12));
        make.left.equalTo(mainView.mas_left).offset(15);
        make.bottom.equalTo(mainView.mas_bottom).offset(-6.5);
    }];
    
    return mainView;
}

- (void)right_f_Action:(UIButton *)sender {
    JoinParterViewController *join = [JoinParterViewController new];
    [self.navigationController pushViewController:join animated:YES];
}

//切换数据源
- (void)bill_segmentAction:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex==0) {
        [self getProfitDataListWithStatus:NO];
    } else {
        [self getProfitDataListWithStatus:YES];
    }
}

- (void)caskBtnAction:(UIButton *)sender {
    WithdrawViewController *card = [WithdrawViewController new];
    [self.navigationController pushViewController:card animated:YES];
}

#pragma mark - getDataSource
- (void)getProfitDataListWithStatus:(BOOL)status {//获取分润数据列表
    NSString *url_key = @"";
    if (status) {
        url_key = @"transqury.selectProfitaccountDetailList";
    } else {
        url_key = @"transqury.selectAgentAccountDetailList";
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    //    [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"userToken":[UserData currentUser].userToken,@"aa":@"bb"}] forKey:@"transqury.test"];
    [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"userToken":[UserData currentUser].userToken,@"pageNumber":@"1"}] forKey:url_key];
    NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
    [dict setObject:json forKey:@"key"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
//        NSLog(@"%@", resultDic);
        
        NSArray *dataSourceArr = resultDic[@"resultData"];
        for (NSDictionary *dataDic in dataSourceArr) {
            MyProfitModel *model = [[MyProfitModel alloc] initWithDictionary:dataDic error:nil];
            [self.dataMuArr addObject:model];
        }
        [self.tabView reloadData];
    } failure:^(NSString *error, NSInteger code) {
        
    }];
}

- (void)getProfitWithdraw {//获取分润可提现数据(代理商)
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"userToken":[UserData currentUser].userToken}] forKey:@"transqury.queryUserBalance"];
    NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
    [dict setObject:json forKey:@"key"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"----%@", resultDic);
        NSDictionary *data = resultDic[@"resultData"];
        self.balance = [NSString stringWithFormat:@"%@",data[@"balance"]];
        self.todayBalance = [NSString stringWithFormat:@"%@",data[@"todayBalance"]];
        self.totalBalance = [NSString stringWithFormat:@"%@",data[@"totalBalance"]];
        
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
