//
//  TradeDetailViewController.m
//  WHFinance
//
//  Created by wanhong on 2017/7/7.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "TradeDetailViewController.h"
#import "CertificatePhotoViewController.h"
#import "NoCardInfamationViewController.h"

@interface TradeDetailViewController ()
@property (nonatomic, strong) SettlementOrder *settlementOrder;
@property (nonatomic, strong) TransOrder *transOrder;
@property (nonatomic, strong) NSString *uploadAuditing;//显示图片按钮
@property (nonatomic, strong) NSString *payStatus;//支付状态
@end

@implementation TradeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"交易详情";
    [self getDataSource];
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
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.transOrder) {
        return [self createMainView];
    } else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.view.size.height;
}

- (UIView *)createMainView  {
    UIView *mainView = [[UIView alloc] initWithFrame:self.view.bounds];
    mainView.backgroundColor = [UIColor Grey_BackColor1];
    
    UILabel *labelhint = [UILabel lableWithText:@"交易详情" Font:FONT_ArialMT(12) TextColor:[UIColor Grey_OrangeColor]];
    [mainView addSubview:labelhint];
    [labelhint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(12));
        make.left.equalTo(mainView.mas_left).offset(15);
        make.top.equalTo(mainView.mas_top).offset(6.5);
    }];
    
    
    UIView *content = [[UIView alloc] initWithFrame:CGRectMake(0, 25, SCREEN_WIGHT, 160)];
    content.backgroundColor = [UIColor whiteColor];
    [mainView addSubview:content];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 55, SCREEN_WIGHT-20, 1)];
    line.backgroundColor = [UIColor Grey_LineColor];
    [content addSubview:line];
    
    UIImageView *imgv = [UIImageView new];
    [content addSubview:imgv];
    switch ([self.payStatus integerValue]) {
        case 0:
            imgv.image = IMG(@"bill_wait");
            break;
        case 1:
            imgv.image = IMG(@"bill_wait");
            break;
        case 2:
            imgv.image = IMG(@"bill_success");
            break;
        case 3:
            imgv.image = IMG(@"bill_wrong");
            break;
        default:
            break;
    }
    [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(20));
        make.left.equalTo(content.mas_left).offset(13);
        make.top.equalTo(content.mas_top).offset(17);
    }];
    UILabel *label = [UILabel lableWithText:self.transOrder.orderStatusCn Font:FONT_ArialMT(18) TextColor:[UIColor mianColor:1]];
    [content addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(imgv.mas_centerY);
        make.left.equalTo(imgv.mas_right).offset(10);
        make.height.equalTo(@(18));
    }];
    
    UILabel *hint = [UILabel lableWithText:[NSString stringWithFormat:@"交易金额:  ￥%@", [self.transOrder.orderAmount handleDataSourceTail]] Font:FONT_ArialMT(12) TextColor:[UIColor mianColor:2]];
    [content addSubview:hint];
    [hint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(label.mas_bottom);
        make.right.equalTo(content.mas_right).offset(-10);
        make.height.equalTo(@(18));
        make.width.equalTo(@(160));
    }];
    hint.attributedText = [UILabel labGetAttributedStringFrom:7 toEnd:[self.transOrder.orderAmount handleDataSourceTail].length+1 WithColor:[UIColor Grey_OrangeColor] andFont:FONT_ArialMT(18) allFullText:hint.text];
    
    
    NSArray *hintArr = @[@"交易单号",@"交易方式",@"手续费",@"交易时间"];
    NSArray *tempArr = @[self.transOrder.orderNo,self.transOrder.orderTypeCn,[NSString stringWithFormat:@"%@  ( + 提现费:  %@ )",[self.transOrder.orderFee handleDataSourceTail], [self.transOrder.orderSettlementFee handleDataSourceTail]],[self.transOrder.orderCreateTime NSTimeIntervalTransToYear_Month_Day]];
    
    for (NSInteger i=0; i<4; i++) {
        UIView *blank = [[UIView alloc] initWithFrame:CGRectMake(15, 65+22*i, SCREEN_WIGHT-25, 12)];
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
            make.right.equalTo(blank.mas_right).offset(-10);
            make.height.equalTo(@(12));
            make.centerY.equalTo(blank.mas_centerY);
            make.width.equalTo(@(140));
        }];
        
        if (i==2) {
            desLab.textColor = [UIColor Grey_OrangeColor];
        }
        
        [content addSubview:blank];
    }
    
  //-----------------------------------------------------------------------------------------
    if (self.settlementOrder) {
        
        UILabel *stalab = [UILabel lableWithText:@"结算状态" Font:FONT_ArialMT(12) TextColor:[UIColor Grey_OrangeColor]];
        [mainView addSubview:stalab];
        [stalab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(12));
            make.left.equalTo(mainView.mas_left).offset(15);
            make.top.equalTo(content.mas_bottom).offset(6.5);
        }];
        
        UIView *statusView = [[UIView alloc] init];
        [mainView addSubview:statusView];
        statusView.backgroundColor = [UIColor whiteColor];
        [statusView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(220));
            make.top.equalTo(content.mas_bottom).offset(25);
            make.left.right.equalTo(mainView);
        }];
        
        
        
        NSArray *statusArr = @[@"结算金额",@"进度处理",@"结算到",@"创建时间"];
        NSArray *tempArr2 = @[[self.settlementOrder.settleAmount handleDataSourceTail],@"",self.settlementOrder.settlementCardNo,[self.settlementOrder.settleTime NSTimeIntervalTransToYear_Month_Day]];
        
        UIView *lastview = nil;
        for (NSInteger i=0; i<4; i++) {
            
            UIView *blank = [[UIView alloc] init];
            [statusView addSubview:blank];
            [blank mas_makeConstraints:^(MASConstraintMaker *make) {
                if (lastview) {
                    make.top.equalTo(lastview.mas_bottom).offset(15);
                } else {
                    make.top.equalTo(statusView.mas_top).offset(10);
                }
                make.left.equalTo(statusView.mas_left).offset(15);
                if (i==1) {
                    make.height.equalTo(@(110));
                } else {
                    make.height.equalTo(@(12));
                }
                make.right.equalTo(statusView.mas_right).offset(-15);
            }];
            UILabel *left = [UILabel lableWithText:[statusArr objectAtIndex:i] Font:FONT_ArialMT(12) TextColor:[UIColor mianColor:2]];
            [blank addSubview:left];
            [left mas_makeConstraints:^(MASConstraintMaker *make) {
                if (i==1) {
                    make.top.equalTo(blank.mas_top);
                } else {
                    make.centerY.equalTo(blank.mas_centerY);
                }
                make.left.equalTo(blank.mas_left);
                make.height.equalTo(@(12));
            }];
            
            if (i==1) {
                UIView *vvv = [LineView addLineViewWithStatus:self.settlementOrder.statue andTime:[self.settlementOrder.settleTime NSTimeIntervalTransToYear_Month_Day]];
                vvv.frame = CGRectMake(105, 0, SCREEN_WIGHT-130, 110);
                [blank addSubview:vvv];
                
            } else {
                UILabel *detail = [UILabel lableWithText:[tempArr2 objectAtIndex:i] Font:FONT_ArialMT(12) TextColor:[UIColor mianColor:2]];
                if (i==0) {
                    detail.textColor = [UIColor Grey_OrangeColor];
                }
                [blank addSubview:detail];
                [detail mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(blank.mas_left).offset(205);
                    make.centerY.equalTo(blank.mas_centerY);
                    make.height.equalTo(@(12));
                }];
            }
            
            
            
            lastview = blank;
        }
        if ([self.uploadAuditing isEqualToString:@"1"]) {
            UIButton *button = [UIButton buttonWithTitle:@"上传信用卡照片" andFont:FONT_ArialMT(14) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:nil andHighlightedImage:nil];
            button.layer.cornerRadius = 5;
            button.clipsToBounds = YES;
            button.backgroundColor = [UIColor mianColor:1];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [mainView addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(statusView.mas_bottom).offset(0);
                make.right.equalTo(mainView.mas_right).offset(-10);
                make.height.equalTo(@(40));
                make.width.equalTo(@(120));
            }];
        }
        
    }
    
    
    
    return mainView;
}




- (void)getDataSource {
    //status  0等待支付 1支付中 2支付成功 3支付失败
    //交易单位为分 /100
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"userToken":[UserData currentUser].userToken,@"orderId":self.orderID}] forKey:@"transqury.selectOrderDetail"];
    NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
    [dict setObject:json forKey:@"key"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"*****%@", resultDic);
        self.settlementOrder = [[SettlementOrder alloc] initWithDictionary:resultDic[@"resultData"][@"settlementOrder"] error:nil];
        self.transOrder = [[TransOrder alloc] initWithDictionary:resultDic[@"resultData"][@"transOrder"] error:nil];
        self.uploadAuditing = [NSString stringWithFormat:@"%@",resultDic[@"resultData"][@"uploadAuditing"]];
        self.payStatus = STRING(self.transOrder.orderStatus);
        [self.tabView reloadData];
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
}

- (void)buttonClick:(UIButton *)sender {
//    CertificatePhotoViewController *photo = [CertificatePhotoViewController new];
//    photo.fromController = @"no_card";
    NoCardInfamationViewController *photo = [NoCardInfamationViewController new];
    photo.orderID = self.orderID;
    photo.timeStr = self.transOrder.orderCreateTime;
    photo.cashCount = self.transOrder.orderAmount;
    [self.navigationController pushViewController:photo animated:YES];
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
