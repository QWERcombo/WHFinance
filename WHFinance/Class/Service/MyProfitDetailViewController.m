//
//  MyProfitDetailViewController.m
//  WHFinance
//
//  Created by wanhong on 2017/7/14.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "MyProfitDetailViewController.h"

@interface MyProfitDetailViewController ()
@property (nonatomic, strong) MyProfitDetailModel *dataModel;
@end

@implementation MyProfitDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"分润详情";
    
    [self setUpSubviews];
    [self getDataSource];
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
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self createMainView];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.view.size.height;
}

- (UIView *)createMainView {
    UIView *mainview = [[UIView alloc] initWithFrame:self.view.bounds];
    mainview.backgroundColor = [UIColor Grey_BackColor1];
    
    UILabel *left = [UILabel lableWithText:@"分润详情" Font:FONT_ArialMT(12) TextColor:[UIColor Grey_OrangeColor]];
    left.frame = CGRectMake(20, 6.5, 50, 12);
    [mainview addSubview:left];
    
    
    UIView *content = [[UIView alloc] initWithFrame:CGRectMake(0, 25, SCREEN_WIGHT, 147)];
    content.backgroundColor = [UIColor whiteColor];
    [mainview addSubview:content];
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 1)];
    line1.backgroundColor = [UIColor Grey_LineColor];
    [content addSubview:line1];
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 146, SCREEN_WIGHT, 1)];
    line2.backgroundColor = [UIColor Grey_LineColor];
    [content addSubview:line2];
    
    
    for (NSInteger i=0; i<6; i++) {
        
        UIView *blank = [[UIView alloc] initWithFrame:CGRectMake(0, 19.5*i+45, SCREEN_WIGHT, 12)];
        blank.backgroundColor = [UIColor whiteColor];
        [mainview addSubview:blank];
        
        
        NSArray *nameArr = @[@"交易时间: ",@"商户名称: ",@"交易方式: ",@"交易金额: ",@"手  续  费: ",@"我的分润: "];
        UILabel *nameLab = [UILabel lableWithText:[nameArr objectAtIndex:i] Font:FONT_ArialMT(12) TextColor:[UIColor Grey_WordColor]];
        [blank addSubview:nameLab];
        [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(blank.mas_left).offset(15);
            make.height.equalTo(@(12));
            make.centerY.equalTo(blank.mas_centerY);
        }];
        
        
        if (self.dataModel) {
            
            UILabel *detailLab = [UILabel lableWithText:[self.dataMuArr objectAtIndex:i] Font:FONT_ArialMT(12) TextColor:[UIColor mianColor:2]];
            [blank addSubview:detailLab];
            [detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(blank.mas_right).offset(-12.5);
                make.height.equalTo(@(12));
                make.centerY.equalTo(blank.mas_centerY);
                make.left.equalTo(nameLab.mas_right).offset(5);
            }];
            
        }
        
        
    }
    
    return mainview;
}

- (void)getDataSource {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"userToken":[UserData currentUser].userToken,@"orderId":self.orderID}] forKey:@"transqury.selectAgentProfitDetail"];
    NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
    [dict setObject:json forKey:@"key"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"---++%@", resultDic);
        self.dataModel = [[MyProfitDetailModel alloc] initWithDictionary:resultDic[@"resultData"] error:nil];
        [self.dataMuArr addObjectsFromArray:@[[self.dataModel.createTime NSTimeIntervalTransToYear_Month_Day],self.dataModel.merchantName,self.dataModel.transTypeCn,[NSString stringWithFormat:@"￥%@",[self.dataModel.transAmount handleDataSourceTail]],[NSString stringWithFormat:@"￥%@",[self.dataModel.transFee handleDataSourceTail]],[NSString stringWithFormat:@"￥%@", [self.dataModel.profitFee handleDataSourceTail]]]];
        
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
