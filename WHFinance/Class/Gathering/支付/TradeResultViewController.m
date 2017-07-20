//
//  TradeResultViewController.m
//  WHFinance
//
//  Created by wanhong on 2017/7/8.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "TradeResultViewController.h"
#import "TradeDetailViewController.h"

@interface TradeResultViewController ()
@property (nonatomic, strong) TransOrder *orderModel;
@end

@implementation TradeResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"支付提示";
    
    
    [self checkStatus];
    [self setUpSubviews];
}

- (void)setUpSubviews {
    [self.view addSubview:self.tabView];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataMuArr.count;
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
    
    UIView *content = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIGHT, 155)];
    content.backgroundColor = [UIColor whiteColor];
    [mainView addSubview:content];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 50, SCREEN_WIGHT-20, 1)];
    line.backgroundColor = [UIColor Grey_LineColor];
    [content addSubview:line];
    
    
    UIImageView *imgv = [UIImageView new];
    [content addSubview:imgv];
    imgv.image = IMG(@"");
    [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(20));
        make.left.equalTo(content.mas_left).offset(13);
        make.top.equalTo(content.mas_top).offset(15);
    }];
    NSString *status = @"";
    if ([self.orderModel.orderStatus integerValue]==2) {
        status = @"交易成功";
        imgv.image = IMG(@"Success_Out");
    }
    if ([self.orderModel.orderStatus integerValue]==3) {
        status = @"交易失败";
        imgv.image = IMG(@"Failure_Out");
    }
    UILabel *label = [UILabel lableWithText:status Font:FONT_ArialMT(18) TextColor:[UIColor mianColor:1]];
    [content addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(imgv.mas_centerY);
        make.left.equalTo(imgv.mas_right).offset(10);
        make.height.equalTo(@(18));
    }];
    
    
    UILabel *hint = [UILabel lableWithText:[NSString stringWithFormat:@"已成功收款%@元", self.orderModel.orderAmount.length ?[self.orderModel.orderAmount handleDataSourceTail]:self.cashStr] Font:FONT_ArialMT(13) TextColor:[UIColor Grey_WordColor]];
    
    [content addSubview:hint];
    [hint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(label.mas_bottom);
        make.left.equalTo(label.mas_right).offset(18);
        make.height.equalTo(@(13));
    }];
    if (self.orderModel.orderAmount.length) {
        hint.attributedText = [UILabel labGetAttributedStringFrom:hint.text.length-[self.orderModel.orderAmount handleDataSourceTail].length-1 toEnd:[self.orderModel.orderAmount handleDataSourceTail].length WithColor:[UIColor Grey_OrangeColor] andFont:FONT_ArialMT(13) allFullText:hint.text];
    } else {
        hint.attributedText = [UILabel labGetAttributedStringFrom:hint.text.length-self.cashStr.length-1 toEnd:self.cashStr.length WithColor:[UIColor Grey_OrangeColor] andFont:FONT_ArialMT(13) allFullText:hint.text];
    }
    
    
    
    NSArray *hintArr = @[@"交易单号",@"交易方式",@"手续费",@"交易时间"];
    NSArray *tempArr = nil;
    if (self.orderModel) {
        tempArr = @[self.orderModel.orderNo,self.orderModel.orderTypeCn,[NSString stringWithFormat:@"￥%@", [self.orderModel.orderFee handleDataSourceTail]],[self.orderModel.orderCreateTime NSTimeIntervalTransToYear_Month_Day]];
    } else {
        tempArr = @[@"",@"",@"",@""];
    }
    
    for (NSInteger i=0; i<4; i++) {
        UIView *blank = [[UIView alloc] initWithFrame:CGRectMake(15, 60+22*i, SCREEN_WIGHT-25, 12)];
        UILabel *titleLab = [UILabel lableWithText:[hintArr objectAtIndex:i] Font:FONT_ArialMT(12) TextColor:[UIColor mianColor:2]];
        [blank addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(blank.mas_left);
            make.height.equalTo(@(12));
            make.centerY.equalTo(blank.mas_centerY);
        }];
        
        UILabel *desLab = [UILabel lableWithText:[tempArr objectAtIndex:i] Font:FONT_ArialMT(12) TextColor:[UIColor Grey_WordColor]];
        
        [blank addSubview:desLab];
        [desLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(blank.mas_right);
            make.height.equalTo(@(12));
            make.centerY.equalTo(blank.mas_centerY);
            make.width.equalTo(@(150));
        }];
        
        if (i==2) {
            desLab.textColor = [UIColor Grey_OrangeColor];
        }
        
        [content addSubview:blank];
    }
    
    
    
    
    
    
    
    UIButton *leftBtn = [UIButton buttonWithTitle:@"查看结算详情" andFont:FONT_ArialMT(18) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:nil andHighlightedImage:nil];
    [mainView addSubview:leftBtn];
    leftBtn.backgroundColor = [UIColor mianColor:1];
    leftBtn.layer.cornerRadius = 5;
    leftBtn.clipsToBounds = YES;
    [leftBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mainView.mas_left).offset(15);
        make.top.equalTo(content.mas_bottom).offset(25);
        make.height.equalTo(@(40));
        make.width.equalTo(@((SCREEN_WIGHT-40)/2));
    }];
    UIButton *rightBtn = [UIButton buttonWithTitle:@"返回收款页" andFont:FONT_ArialMT(18) andtitleNormaColor:[UIColor mianColor:1] andHighlightedTitle:[UIColor whiteColor] andNormaImage:nil andHighlightedImage:nil];
    [mainView addSubview:rightBtn];
    rightBtn.backgroundColor = [UIColor whiteColor];
    rightBtn.layer.cornerRadius = 5;
    rightBtn.layer.borderWidth = 1;
    rightBtn.layer.borderColor = [UIColor mianColor:1].CGColor;
    rightBtn.clipsToBounds = YES;
    [rightBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(mainView.mas_right).offset(-15);
        make.top.equalTo(content.mas_bottom).offset(25);
        make.height.equalTo(@(40));
        make.width.equalTo(@((SCREEN_WIGHT-40)/2));
    }];
    
    return mainView;
}


- (void)buttonClick:(UIButton *)sender {
    if ([sender.currentTitle isEqualToString:@"查看结算详情"]) {
        TradeDetailViewController *deta = [TradeDetailViewController new];
        deta.cashStr = self.cashStr;
        deta.orderID = self.orderID;
        [self.navigationController pushViewController:deta animated:YES];
    } else {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)checkStatus {//查询订单状态 2秒一次
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
//    [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"userToken":[UserData currentUser].userToken,@"orderId":self.orderID}] forKey:@"transc.queryOrder"];
//    NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
//    [dict setObject:json forKey:@"key"];
//    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
//        NSLog(@"-----%@", resultDic);
//        self.orderModel = [[TransOrder alloc] initWithDictionary:resultDic[@"resultData"] error:nil];
//        [self.tabView reloadData];
//        NSLog(@"-----%@", [self.orderModel.orderCreateTime NSTimeIntervalTransToYear_Month_Day]);
//        //status  0等待支付 1支付中 2支付成功 3支付失败
//    } failure:^(NSString *error, NSInteger code) {
//
//    }];
    [[PublicFuntionTool sharedInstance] getOrderStatus:^(TransOrder *order) {
        self.orderModel = order;
        [self.tabView reloadData];
    } byOrderID:self.orderID];

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
