//
//  BankSearchViewController.m
//  WHFinance
//
//  Created by wanhong on 2017/7/11.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "BankSearchViewController.h"

@interface BankSearchViewController ()<UISearchBarDelegate>{
    UISearchBar * bar;
}
@property (nonatomic, strong) UISearchBar * bar;
@property (nonatomic, assign) NSInteger pageNum;
@property (nonatomic, strong) NSString *keyWord;
@end

@implementation BankSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"支行搜索";
    self.pageNum = 1;
    
    [self setUpSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpSubviews {
    [self.view addSubview:self.tabView];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
    
    [[UtilsData sharedInstance]MJRefreshAutoNormalFooterTarget:self table: self.tabView actionSelector:@selector(loadFooterNewData)];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataMuArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    BankModel *model = [self.dataMuArr objectAtIndex:indexPath.row];
    cell.textLabel.text = model.bankName;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self createMainView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BankModel *model = [self.dataMuArr objectAtIndex:indexPath.row];
    self.PassBankNameBlock(model.bankName);
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView *)createMainView  {
    UIView *mainView = [[UIView alloc] initWithFrame:self.view.bounds];
    bar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 45)];
    [self.view addSubview:bar];
    bar.placeholder = @"搜索支行";
    bar.showsCancelButton = YES;
    bar.delegate = self;
    bar.returnKeyType = UIReturnKeySearch;
    bar.spellCheckingType = UITextSpellCheckingTypeNo;
    bar.translucent = YES;
    [bar setBackgroundImage:[UIImage imageWithColor:[UIColor Grey_BackColor1]]];
    UITextField * searchField = [bar valueForKey:@"_searchField"];
    [searchField setValue:[UIColor mianColor:2] forKeyPath:@"_placeholderLabel.textColor"];
    [searchField setValue:FONT_ArialMT(13) forKeyPath:@"_placeholderLabel.font"];
    
    //找到取消按钮
    UIButton *cancleBtn = [bar valueForKey:@"cancelButton"];
    //修改标题和标题颜色
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancleBtn.titleLabel.font = FONT_ArialMT(14);
    
    cancleBtn.backgroundColor = [UIColor yellowColor];
    
    
    
    return mainView;
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    self.keyWord = searchBar.text;
    [self.view endEditing:YES];
    [self searchBrandBank];
    
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [bar resignFirstResponder];
}
//- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
//    self.keyWord = searchBar.text;
//    [self searchBrandBank];
//}

- (void)loadFooterNewData {
    if (self.dataMuArr.count) {
        self.pageNum += 1;
        [self searchBrandBank];
    } else {
        [self.tabView.mj_footer endRefreshingWithNoMoreData];
    }
}

- (void)searchBrandBank {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"userToken":[UserData currentUser].userToken,@"pageNumber":SINT(self.pageNum),@"bankName":self.keyWord}] forKey:@"transc.queryBankNo"];
    NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
    [dict setObject:json forKey:@"key"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSArray *dataSource = resultDic[@"resultData"];
        if (dataSource.count) {
            [self.dataMuArr removeAllObjects];
            for (NSDictionary *dataDic in dataSource) {
                BankModel *model = [[BankModel alloc] initWithDictionary:dataDic error:nil];
                [self.dataMuArr addObject:model];
            }
        } else {
            
            [self.tabView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.tabView.mj_footer endRefreshing];
        [self.tabView reloadData];
    } failure:^(NSString *error, NSInteger code) {
        
    }];    
    
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
