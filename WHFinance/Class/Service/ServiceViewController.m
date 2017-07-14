//
//  ServiceViewController.m
//  WHFinance
//
//  Created by wanhong on 2017/6/26.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "ServiceViewController.h"
#import "MyProfitViewController.h"
#import "MineCustomerViewController.h"
#import "ServiceDetailViewController.h"
#import "ShareViewController.h"
#import "JoinParterViewController.h"

@interface ServiceViewController ()
@property (nonatomic, strong) NSArray *nameArr;

@end

#define BTN_Margin (((SCREEN_WIGHT-240)/2)+60)
#define BTN_Width  ((SCREEN_WIGHT-2)/3)
#define BTN_Height 75
@implementation ServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.dataMuArr addObjectsFromArray:@[@"兴业信用卡",@"信而富贷款",@"贷嘛贷款",@"更多信用卡",@"更多贷款",@"信用卡还款",@"境外交易提额",@"在线商城",@"征信查询",@"新手指引",[[UserData currentUser].isPartner integerValue]==1?@"已是合伙人":@"加入合伙人",@"推广政策"]];
    self.nameArr = @[@"我的利润",@"我的客户",@"推广赚钱"];
    
    [self setUpSubviews];
}

- (void)setUpSubviews {
    self.tabView.backgroundColor = [UIColor Grey_BackColor1];
    [self.view addSubview:self.tabView];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return [self createMainViewSectionOne];
    } else {
        return [self createMainViewSectionTwo];
    }
    return [UIView showNothingViewWith:1];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return 108;
    } else {
        return self.dataMuArr.count%3==0?(self.dataMuArr.count/3)*75:(self.dataMuArr.count/3)*75+75;
    }
}

- (UIView *)createMainViewSectionOne {
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 108)];
    mainView.backgroundColor = [UIColor mianColor:1];
    
    for (NSInteger i=0; i<3; i++) {
        JXButton *btn = [[JXButton alloc] initWithFrame:CGRectMake(BTN_Margin*i+30, 32, 60, 60) withTitleFont:FONT_ArialMT(15)];
        [btn addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:[self.nameArr objectAtIndex:i] forState:0];
        NSString *img = [NSString stringWithFormat:@"service_top_%ld",i];
        [btn setImage:IMG(img) forState:0];
        [mainView addSubview:btn];
    }
    
    return mainView;
}
- (UIView *)createMainViewSectionTwo {
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, self.dataMuArr.count%3==0?(self.dataMuArr.count/3)*75:(self.dataMuArr.count/3)*75+75)];
    mainView.backgroundColor = [UIColor Grey_BackColor1];
    NSInteger X = self.dataMuArr.count%3==0?(self.dataMuArr.count/3):(self.dataMuArr.count/3)+1;
    
    for (NSInteger i=0; i<X; i++) {
        for (NSInteger j=0; j<3; j++) {
            if (i*3+j>self.dataMuArr.count-1) {
                break;
            }
            UIView *blank = [[UIView alloc] initWithFrame:CGRectMake((BTN_Width+1)*j, (BTN_Height+1)*i, BTN_Width, BTN_Height)];
            blank.backgroundColor = [UIColor whiteColor];
            
            JXButton *button = [[JXButton alloc] initWithFrame:CGRectZero withTitleFont:FONT_ArialMT(12)];
            [button setTitle:[self.dataMuArr objectAtIndex:i*3+j] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor mianColor:2] forState:UIControlStateNormal];
            NSString *img = [NSString stringWithFormat:@"service_item_%ld", i*3+j];
            [button setImage:IMG(img) forState:UIControlStateNormal];
            [button addTarget:self action:@selector(itemButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [blank addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@(54));
                make.center.equalTo(blank);
            }];
            
            [mainView addSubview:blank];
        }
    }
    
    return mainView;
}

#pragma mark - Action
- (void)titleButtonClick:(UIButton *)sender {
    if ([sender.currentTitle isEqualToString:@"我的利润"]) {
        [self getProfitAuthority];
    }
    if ([sender.currentTitle isEqualToString:@"我的客户"]) {
        MineCustomerViewController *cus = [MineCustomerViewController new];
        [self.navigationController pushViewController:cus animated:YES];
    }
    if ([sender.currentTitle isEqualToString:@"推广赚钱"]) {
        ShareViewController *share = [ShareViewController new];
        [self.navigationController pushViewController:share animated:YES];
    }
    
}
- (void)itemButtonClick:(UIButton *)sender {
//    NSLog(@"%@", sender.currentTitle);
    ServiceDetailViewController *detail = [ServiceDetailViewController new];
    JoinParterViewController *join = [JoinParterViewController new];
    detail.titleName = sender.currentTitle;
    if ([sender.currentTitle isEqualToString:@"加入合伙人"]) {
        [self.navigationController pushViewController:join animated:YES];
    } else {
        [self.navigationController pushViewController:detail animated:YES];
    }
    
    
    
}


- (void)getProfitAuthority {//获取分润权限
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"userToken":[UserData currentUser].userToken}] forKey:@"transqury.queryUserLeve"];
    NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
    [dict setObject:json forKey:@"key"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
//        NSLog(@"%@", resultDic);
        MyProfitViewController *profit = [MyProfitViewController new];
        // 前一个表示三级分润    后一个表示代理分润
        NSArray *dataArr = resultDic[@"resultData"];
        if ([[dataArr firstObject] integerValue]==0&&[[dataArr lastObject] integerValue]==1) {
            profit.titleName = @"代理分润";
        }
        if ([[dataArr firstObject] integerValue]==1&&[[dataArr lastObject] integerValue]==0) {
            profit.titleName = @"三级分润";
        }
        if ([[dataArr firstObject] integerValue]==1&&[[dataArr lastObject] integerValue]==1) {
            profit.titleName = @"我的分润";
            profit.isShow = YES;
        }
        if ([[dataArr firstObject] integerValue]==0&&[[dataArr lastObject] integerValue]==0) {
            [[UtilsData sharedInstance] showAlertControllerWithTitle:@"提示" detail:@"您还未成为合伙人或代理商" doneTitle:@"确定" cancelTitle:@"" haveCancel:NO doneAction:^{
                
            } controller:self];
            return ;
        }
        [self.navigationController pushViewController:profit animated:YES];
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
