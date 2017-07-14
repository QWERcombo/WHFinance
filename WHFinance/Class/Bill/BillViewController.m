//
//  BillViewController.m
//  WHFinance
//
//  Created by wanhong on 2017/6/26.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "BillViewController.h"
#import "WithdrawViewController.h"
#import "WithdrawRecordViewController.h"
#import "TradeDetailViewController.h"

@interface BillViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    UIView *tradeView;
    UIView *profitView;
}
@property (nonatomic, strong) UISegmentedControl *bill_segment;
@property (nonatomic, strong) UILabel *moneyLab;//交易总额
@property (nonatomic, strong) UILabel *profitLab;//利润总额
@property (nonatomic, strong) UILabel *restLab;//余额
@property (nonatomic, strong) UIButton *withdrawBtn;//提现
@property (nonatomic, assign) NSInteger pageNumber;
@property (nonatomic, strong) NSMutableArray *preDataSource;
@end

#define Color_Word [UIColor colorWithR:102 G:102 B:102 A:1]
@implementation BillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNumber = 1;
//    self.preDataSource = [NSMutableArray array];
//    self.preDataSource = [NSMutableArray arrayWithArray:@[@"1",@"1",@"1"]];
    
    [self setUpSubviews];
    [self getDataSource];
}

- (void)setUpSubviews {
    [self.view addSubview:self.tabView];
    self.tabView.backgroundColor = [UIColor Grey_BackColor1];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
    [[UtilsData sharedInstance]MJRefreshNormalHeaderTarget:self table:self.tabView actionSelector:@selector(loadHeaderNewData)];
    [[UtilsData sharedInstance]MJRefreshAutoNormalFooterTarget:self table: self.tabView actionSelector:@selector(loadFooterNewData)];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.dataMuArr.count) {
        return 3;
    } else {
        return 2;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataMuArr.count) {
        if (section==0) {
            return 0;
        } else if (section==2) {
            return self.preDataSource.count;
        } else {
            return self.dataMuArr.count;
        }
    } else {
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BillModel *model = nil;
    if (self.dataMuArr.count) {
        if (indexPath.section==1) {//本月
            model = [self.dataMuArr objectAtIndex:indexPath.row];
        } else {//之前月
            model = [self.preDataSource objectAtIndex:indexPath.row];
        }
    }
    return [UtilsMold creatCell:@"BillListCell" table:tableView deledate:self model:model data:nil andCliker:^(NSDictionary *clueDic) {
        
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold getCellHight:@"BillListCell" data:nil model:nil indexPath:indexPath];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return [self createMainViewSectionOne];
    } else if (section==1){
        return [self createMainViewSectionTwoWithSection:section];
    } else {
        if (self.dataMuArr.count) {
            return [self createMainViewSectionTwoWithSection:section];
        } else {
            return [UIView showNothingViewWith:1];
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return 50;
    } else {
        if (self.dataMuArr.count) {
            return 25;
        } else {
            return SCREEN_WIGHT-50-50-64;
        }
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BillModel *bill = [self.dataMuArr objectAtIndex:indexPath.row];
    TradeDetailViewController *detail = [TradeDetailViewController new];
    detail.orderID = bill.tid;
    [self.navigationController pushViewController:detail animated:YES];
}


#pragma mark - subviews
- (UIView *)createMainViewSectionOne {
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 50)];
    mainView.backgroundColor = [UIColor whiteColor];
    
    UILabel *hint = [UILabel lableWithText:@"本日交易总额" Font:FONT_ArialMT(14) TextColor:[UIColor mianColor:1]];
    [mainView addSubview:hint];
    [hint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mainView.mas_left).offset(15);
        make.centerY.equalTo(mainView.mas_centerY);
        make.height.equalTo(@(14));
    }];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateStr = [formatter stringFromDate:date];
    UILabel *dateLab = [UILabel lableWithText:dateStr Font:FONT_Helvetica(14) TextColor:[UIColor mianColor:1]];
    [mainView addSubview:dateLab];
    [dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(mainView.mas_centerX);
        make.centerY.equalTo(mainView.mas_centerY);
        make.height.equalTo(@(14));
    }];
    
    UILabel *totalLab = [UILabel lableWithText:@"30.00" Font:FONT_ArialMT(14) TextColor:[UIColor Grey_OrangeColor]];
    [mainView addSubview:totalLab];
    [totalLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(14));
        make.right.equalTo(mainView.mas_right).offset(-15);
        make.centerY.equalTo(mainView.mas_centerY);
    }];
    
    
    
    return mainView;
}

- (UIView *)createMainViewSectionTwoWithSection:(NSInteger)section {
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 25)];
    mainView.backgroundColor = [UIColor Grey_BackColor1];
    
    NSString *temp = @"";
    if (section==1) {
        temp = @"本月";
    } else if(section==2) {
        temp = @"之前月";
    }
    UILabel *dateLab = [UILabel lableWithText:temp Font:FONT_ArialMT(14) TextColor:[UIColor Grey_WordColor]];
    [mainView addSubview:dateLab];
    [dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mainView.mas_left).offset(15);
        make.centerY.equalTo(mainView.mas_centerY);
        make.height.equalTo(@(14));
    }];
    
    
    return mainView;
}

#pragma mark - UICollectionView
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark - Action
- (void)clearAction:(UIButton *)sender {
    WithdrawRecordViewController *record = [WithdrawRecordViewController new];
    [self.navigationController pushViewController:record animated:YES];
}

- (void)leftAction:(UITapGestureRecognizer *)sender {
    NSLog(@"本月");
}
- (void)rightAction:(UITapGestureRecognizer *)sender {
    [ChooseView showChooseView:nil WithBlock:^(NSString *clueStr) {
        NSLog(@"%@", clueStr);
    } inRootViewController:self];
}
- (void)withdrawAction:(UIButton *)sender {
    WithdrawViewController *with = [WithdrawViewController new];
    [self.navigationController pushViewController:with animated:YES];
}

#pragma mark - dataSource
- (void)loadHeaderNewData {
    self.pageNumber = 1;
    [self getDataSource];
}
- (void)loadFooterNewData {
    self.pageNumber+=1;
    [self getDataSource];
}

- (void)getDataSource {
    // pageNumber 分页数
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"userToken":[UserData currentUser].userToken,@"pageNumber":SINT(self.pageNumber)}] forKey:@"transqury.queryOrders"];
    NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
    [dict setObject:json forKey:@"key"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSArray *dataSourceArr = resultDic[@"resultData"];
        
        if (dataSourceArr.count) {
            if (self.pageNumber==1) {
                [self.dataMuArr removeAllObjects];
            }
            for (NSDictionary *dataDic in dataSourceArr) {
                BillModel *model = [[BillModel alloc] initWithDictionary:dataDic error:nil];
                [self.dataMuArr addObject:model];
            }
            [self.tabView.mj_header endRefreshing];
            [self.tabView.mj_footer endRefreshing];
        } else {
            [self.tabView.mj_footer endRefreshingWithNoMoreData];
            [self.tabView.mj_footer endRefreshing];
        }
        
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
