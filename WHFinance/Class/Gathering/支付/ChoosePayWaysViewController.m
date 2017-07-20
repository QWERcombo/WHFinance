//
//  ChoosePayWaysViewController.m
//  WHFinance
//
//  Created by wanhong on 2017/7/7.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "ChoosePayWaysViewController.h"
#import "PayWaysViewController.h"
#import "WebViewController.h"
#import "NoCardPayViewController.h"

@interface ChoosePayWaysViewController ()
@property (nonatomic, strong) NSArray *imageArray;
@end

@implementation ChoosePayWaysViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"选择通道";
    
    
    [self setUpSubviews];
    [self getDataSource];
}

- (void)setUpSubviews {
    [self.view addSubview:self.tabView];
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

- (UIView *)createMainView  {
    UIView *mainView = [[UIView alloc] initWithFrame:self.view.bounds];
    mainView.backgroundColor = [UIColor Grey_BackColor1];
    
    UILabel *label = [UILabel lableWithText:@"支付金额" Font:FONT_ArialMT(14) TextColor:[UIColor Grey_WordColor]];
    [mainView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mainView.mas_left).offset(20);
        make.top.equalTo(mainView.mas_top).offset(27);
        make.height.equalTo(@(14));
    }];
    UILabel *countLab = [UILabel lableWithText:[NSString pointTailTwo:self.cashCount] Font:FONT_ArialMT(24) TextColor:[UIColor colorWithR:235 G:73 B:73 A:1]];
    [mainView addSubview:countLab];
    [countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(mainView.mas_right).offset(-20);
        make.centerY.equalTo(label.mas_centerY);
        make.height.equalTo(@(25));
    }];
    
    UIView *content = [[UIView alloc] init];
    [mainView addSubview:content];
    content.layer.cornerRadius = 3*self.dataMuArr.count;
    content.clipsToBounds = YES;
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(SCREEN_WIGHT-60));
        make.top.equalTo(mainView.mas_top).offset(65);
        make.centerX.equalTo(mainView.mas_centerX);
        make.height.equalTo(@(70+45*self.dataMuArr.count));
    }];
    UIView *topView = [UIView new];
    topView.backgroundColor = [UIColor colorWithR:221 G:221 B:221 A:1];
    [content addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(35));
        make.top.left.right.equalTo(content);
    }];
    UILabel *hint = [UILabel lableWithText:@"请选择支付通道" Font:FONT_BoldMT(12) TextColor:[UIColor mianColor:2]];
    [topView addSubview:hint];
    [hint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(12));
        make.centerX.equalTo(topView.mas_centerX);
        make.centerY.equalTo(topView.mas_centerY);
    }];
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor colorWithR:221 G:221 B:221 A:1];
    [content addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(35));
        make.bottom.left.right.equalTo(content);
    }];
    
    for (NSInteger i=0; i<self.dataMuArr.count; i++) {
        
        PayModeModel *model = [self.dataMuArr objectAtIndex:i];
        
        UIView *blank = [[UIView alloc] initWithFrame:CGRectMake(0, 35+45*i, SCREEN_WIGHT-60, 45)];
        blank.backgroundColor = [UIColor whiteColor];
        blank.tag = 1000+i;
        
        UIView *line = [[UIView alloc] init];
        [blank addSubview:line];
        line.backgroundColor = [UIColor Grey_LineColor];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(1));
            make.bottom.equalTo(blank.mas_bottom);
            make.left.equalTo(blank.mas_left).offset(13);
            make.right.equalTo(blank.mas_right).offset(-13);
        }];
        
        UIImageView *imgv = [[UIImageView alloc] init];
        [imgv sd_setImageWithURL:URL_STRING(model.icon)];
        [blank addSubview:imgv];
        [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@(30));
            make.left.equalTo(blank.mas_left).offset(17);
            make.centerY.equalTo(blank.mas_centerY);
        }];
        
        UILabel *topLab = [UILabel lableWithText:[NSString stringWithFormat:@"%@", model.productTitle] Font:FONT_ArialMT(11) TextColor:[UIColor mianColor:2]];
        [blank addSubview:topLab];
        [topLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(15));
            make.left.equalTo(imgv.mas_right).offset(10);
            make.right.equalTo(blank.mas_right).offset(-30);
            make.top.equalTo(imgv.mas_top);
        }];
        UILabel *bottomLab = [UILabel lableWithText:[NSString stringWithFormat:@"%@", model.productContext] Font:FONT_ArialMT(11) TextColor:[UIColor mianColor:2]];
        [blank addSubview:bottomLab];
        [bottomLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(15));
            make.left.equalTo(imgv.mas_right).offset(10);
            make.right.equalTo(blank.mas_right).offset(-30);
            make.top.equalTo(topLab.mas_bottom);
        }];
        
        UIImageView *more = [UIImageView new];
        more.image = IMG(@"right_more");
        [blank addSubview:more];
        [more mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.equalTo(@(20));
            make.right.equalTo(blank.mas_right).offset(-5);
            make.centerY.equalTo(blank.mas_centerY);
        }];
        
        UITapGestureRecognizer *payWayTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(payWayTapAction:)];
        [blank addGestureRecognizer:payWayTap];
        
        [content addSubview:blank];
    }
    
    return mainView;
}



- (void)payWayTapAction:(UITapGestureRecognizer *)sender {
    PayModeModel *model = [self.dataMuArr objectAtIndex:sender.view.tag-1000];
    NSString *type = [model.productType substringToIndex:2];
    PayWaysViewController *pay = [PayWaysViewController new];
    if ([type isEqualToString:@"00"]) {//微信
        pay.mainColor = [UIColor colorWithR:77 G:168 B:65 A:1];
        pay.payWay = @"0";
    } else
    if ([type isEqualToString:@"01"]) {//QQ
        pay.mainColor = [UIColor colorWithR:77 G:168 B:65 A:1];
        pay.payWay = @"1";
    } else
    if ([type isEqualToString:@"02"]) {//支付宝
        pay.mainColor = [UIColor colorWithR:85 G:166 B:229 A:1];
        pay.payWay = @"2";
    } else
    if ([type isEqualToString:@"80"]) {//银联
        NoCardPayViewController *no = [NoCardPayViewController new];
        no.cashCount = self.cashCount;
        no.proudctDetailId = model.proudctDetailId;
        [self.navigationController pushViewController:no animated:YES];
        return;
    }
    else if ([type isEqualToString:@"90"]) {//url
        WebViewController *web = [WebViewController new];
        web.urlStr = @"http://api.wanhongpay.com/trans-api/demos/b2c/B2CPaymentTransRequest.jsp";
        [self.navigationController pushViewController:web animated:YES];
        return;
    } else {
        
    }
    
    pay.moneyStr = self.cashCount;
    pay.navIMG = [UIImage imageWithColor:pay.mainColor];
    pay.proudctDetailId = model.tid;
    [self.navigationController pushViewController:pay animated:YES];
}


- (void) getDataSource {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"userToken":[UserData currentUser].userToken,@"productId":self.productId}] forKey:@"transc.getSubProduct"];
    NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
    [dict setObject:json forKey:@"key"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"%@", resultDic);
        NSArray *dataArr = resultDic[@"resultData"];
        for (NSDictionary *dict in dataArr) {
            PayModeModel *model = [[PayModeModel alloc] initWithDictionary:dict error:nil];
            [self.dataMuArr addObject:model];
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
