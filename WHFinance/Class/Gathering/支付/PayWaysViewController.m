//
//  PayWaysViewController.m
//  WHFinance
//
//  Created by 赵越 on 2017/7/2.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "PayWaysViewController.h"
#import "JoinParterViewController.h"
#import "TradeResultViewController.h"



@interface PayWaysViewController ()
@property (nonatomic, strong) UIView *payWayImgv;
@property (nonatomic, strong) UILabel *detailLab;
@property (nonatomic, strong) UILabel *moneyLab;//金额
@property (nonatomic, strong) UIImageView *QRCodeImgv;//二维码图片
@property (nonatomic, strong) NSString *QRCodeDataSorceStr;//生成二维码信息
@property (nonatomic, strong) NSString *orderID;//查询订单状态的ID
@property (nonatomic, strong) NSTimer *timer;//定时器
@property (nonatomic, strong) NSString *normal, *pratnner;
@end

@implementation PayWaysViewController

- (void)viewWillDisappear:(BOOL)animated {//关闭定时器
    [super viewWillDisappear:YES];
    if (self.timer) {
        [self.timer setFireDate:[NSDate distantFuture]];
        [self.timer invalidate];
        self.timer = nil;
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self changeRateINfomation];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"收款";
    
    [self setUpSubviews];
    [self getDataSource];
    
}

- (void)setUpSubviews {
    self.tabView.backgroundColor = self.mainColor;
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
    return SCREEN_HEIGHT;
}

- (UIView *)createMainView {
    UIView *mainView = [[UIView alloc] init];
    mainView.backgroundColor = self.mainColor;
    
    UIView *content = [UIView new];
    content.backgroundColor = [UIColor whiteColor];
    //设置偏移阴影
    content.layer.shadowColor = [UIColor blackColor].CGColor;
    content.layer.shadowOpacity = 0.8;
    content.layer.shadowRadius = 15;
    content.layer.shadowOffset = CGSizeMake(0, 0);
    content.layer.cornerRadius=15;
    
    [mainView addSubview:content];
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(mainView.mas_centerX);
        make.top.equalTo(mainView.mas_top).offset((SCREEN_HEIGHT-430)/2-64);
        make.width.equalTo(@(SCREEN_WIGHT-25));
        make.height.equalTo(@(430));
    }];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 75, SCREEN_WIGHT-25, 1)];
    line.backgroundColor = [UIColor Grey_LineColor];
    [content addSubview:line];
    
    self.payWayImgv = [UIView new];
    [content addSubview:self.payWayImgv];
    [self.payWayImgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(30));
        make.centerX.equalTo(content.mas_centerX);
        make.top.equalTo(content.mas_top).offset(22.5);
    }];
    UIImageView *payLogo = [UIImageView new];
    [self.payWayImgv addSubview:payLogo];
    NSString *img = [NSString stringWithFormat:@"pay_way_%@", self.payWay];
    payLogo.image = IMG(img);
    [payLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(30));
        make.left.equalTo(self.payWayImgv.mas_left);
        make.centerY.equalTo(self.payWayImgv.mas_centerY);
    }];
    NSArray *arr = @[@"微信支付",@"QQ钱包支付",@"支付宝支付",@"银联支付"];
    UILabel *payLab = [UILabel lableWithText:[arr objectAtIndex:[self.payWay integerValue]] Font:FONT_BoldMT(20) TextColor:[UIColor Grey_WordColor]];
    [self.payWayImgv addSubview:payLab];
    [payLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.payWayImgv.mas_centerY);
        make.left.equalTo(payLogo.mas_right).offset(10);
        make.height.equalTo(@(20));
        make.right.equalTo(self.payWayImgv.mas_right);
    }];
    
    
    
    self.moneyLab = [UILabel lableWithText:[NSString pointTailTwo:self.moneyStr] Font:FONT_ArialMT(24) TextColor:[UIColor colorWithR:235 G:73 B:73 A:1]];
    [content addSubview:self.moneyLab];
    [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(content.mas_centerX);
        make.height.equalTo(@(24));
        make.top.equalTo(line.mas_bottom).offset(13);
    }];
    
    self.detailLab = [UILabel lableWithText:@"" Font:FONT_ArialMT(11) TextColor:[UIColor mianColor:2]];
    if (self.normal.length) {
        self.detailLab.text = [NSString stringWithFormat:@"普通级会员手续费%@元\n创业合伙人手续费%@元", self.normal, self.pratnner];
    } else {
        self.detailLab.text = [NSString stringWithFormat:@"普通级会员手续费      元\n创业合伙人手续费      元"];
    }
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
    para.lineSpacing = 5;
    NSRange rang = NSMakeRange(self.detailLab.text.length/2, self.detailLab.text.length/2+1);
    NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc] initWithString:self.detailLab.text];
    [attstr addAttribute:NSFontAttributeName value:FONT_ArialMT(11) range:rang];
    [attstr addAttribute:NSForegroundColorAttributeName value:[UIColor Grey_OrangeColor] range:rang];
    [attstr addAttribute:NSParagraphStyleAttributeName value:para range:NSMakeRange(0, self.detailLab.text.length)];
    self.detailLab.attributedText = attstr;
    [content addSubview:self.detailLab];
    self.detailLab.numberOfLines = 2;
    self.detailLab.textAlignment = NSTextAlignmentCenter;
    [self.detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(150));
        make.centerX.equalTo(content.mas_centerX);
        make.top.equalTo(self.moneyLab.mas_bottom).offset(14);
    }];
    
    
    UIView *tempView = [UIView new];
    tempView.backgroundColor = [UIColor Grey_BackColor1];
    [content addSubview:tempView];
    [tempView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(25));
        make.left.right.equalTo(content);
        make.top.equalTo(self.detailLab.mas_bottom).offset(15);
    }];
    UILabel *llll = [UILabel lableWithText:@"降低费率？加入合伙人>>" Font:FONT_ArialMT(11) TextColor:[UIColor colorWithR:255 G:141 B:19 A:1]];
    [tempView addSubview:llll];
    [llll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(tempView.mas_centerX);
        make.height.equalTo(@(11));
        make.centerY.equalTo(tempView.mas_centerY);
    }];
    UIImageView *mmmm = [UIImageView new];
    [tempView addSubview:mmmm];
    mmmm.image = IMG(@"join");
    [mmmm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(20));
        make.right.equalTo(llll.mas_left).offset(-10);
        make.centerY.equalTo(tempView.mas_centerY);
    }];
    
    UITapGestureRecognizer *joinTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(joinTapAction:)];
    [tempView addGestureRecognizer:joinTap];
    
    
    self.QRCodeImgv = [UIImageView new];
    self.QRCodeImgv.image = [UIImage createQRCodeImageWithSourceData:self.QRCodeDataSorceStr];
    [content addSubview:self.QRCodeImgv];
    [_QRCodeImgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(140));
        make.centerX.equalTo(content.mas_centerX);
        make.top.equalTo(tempView.mas_bottom).offset(12);
    }];
    
    
    UILabel *hint = [UILabel lableWithText:@"请在十分钟内扫码支付" Font:FONT_ArialMT(18) TextColor:[UIColor whiteColor]];
    hint.textAlignment = NSTextAlignmentCenter;
    hint.backgroundColor = self.mainColor;
    [content addSubview:hint];
    [hint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(35));
        make.top.equalTo(self.QRCodeImgv.mas_bottom).offset(12);
        make.left.right.equalTo(content);
    }];
    
    
    return mainView;
}


- (void)joinTapAction:(UITapGestureRecognizer *)sender {
    JoinParterViewController *part = [JoinParterViewController new];
    [self.navigationController pushViewController:part animated:YES];
}

- (void)getDataSource {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"userToken":[UserData currentUser].userToken,@"transAmount":self.moneyStr,@"subProductId":self.proudctDetailId}] forKey:@"transc.doScanCode"];
    NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
    [dict setObject:json forKey:@"key"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"****%@", resultDic);
        self.QRCodeDataSorceStr = resultDic[@"resultData"][@"payQRCode"];
        self.orderID = resultDic[@"resultData"][@"transOrderId"];
        
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(checkStatus:) userInfo:nil repeats:YES];
        [self.timer setFireDate:[NSDate distantPast]];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];//加入主循环池中
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(300 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.timer setFireDate:[NSDate distantFuture]];
            [self.timer invalidate];
            self.timer = nil;
        });
        
        [self.tabView reloadData];
    } failure:^(NSString *error, NSInteger code) {
        
    }];
}


- (void)checkStatus:(NSTimer *)timer {//查询订单状态 2秒一次
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"userToken":[UserData currentUser].userToken,@"orderId":self.orderID}] forKey:@"transc.queryOrder"];
    NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
    [dict setObject:json forKey:@"key"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:nil showAnimation:NO success:^(NSDictionary *resultDic, NSString *msg) {
        NSString *statusStr = resultDic[@"resultData"][@"orderStatus"];
        NSLog(@"-----%@", statusStr);
        //status  0等待支付 1支付中 2支付成功 3支付失败
        if ([statusStr integerValue]==2) {
            [self.timer setFireDate:[NSDate distantFuture]];
            [self.timer invalidate];
            self.timer = nil;
            
            TradeResultViewController *result = [TradeResultViewController new];
            result.cashStr = self.moneyStr;
            result.orderID = self.orderID;
            [self.navigationController pushViewController:result animated:YES];
            
            //更改本地合伙人状态
            if ([self.isParter isEqualToString:@"yes"]) {
                NSMutableDictionary *partDic = [[NSMutableDictionary alloc] init];
                [partDic setObject:@"1" forKey:@"isPartner"];
                [[UserData currentUser] giveData:partDic];
            }
        }
        if ([statusStr integerValue]==3) {
            [self.timer setFireDate:[NSDate distantFuture]];
            [self.timer invalidate];
            self.timer = nil;
            [[UtilsData sharedInstance] showAlertTitle:@"提示" detailsText:@"支付失败" time:2.0 aboutType:MBProgressHUDModeCustomView state:NO];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        
        
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
}

- (void)changeRateINfomation {
    [[PublicFuntionTool sharedInstance] getOrderRate:^(NSString *normalRate, NSString *partnerRate) {
        self.normal = normalRate;
        self.pratnner = partnerRate;
    } WithCashAmount:self.moneyStr andSubProductId:self.proudctDetailId];
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
