//
//  CardInformationViewController.m
//  WHFinance
//
//  Created by 赵越 on 2017/7/1.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "CardInformationViewController.h"
#import "BankSearchViewController.h"

@interface CardInformationViewController (){
    CustomTextField *tf;
}
@property (nonatomic, strong) NSArray *nameArr;
@property (nonatomic, strong) NSArray *tempArr;
@property (nonatomic, assign) BOOL isEdite;
@property (nonatomic, strong) NSString *bankNo;
@property (nonatomic, strong) RealCertificateModel *dataModel;
@end

@implementation CardInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改结算卡";
    self.nameArr = @[@"姓        名:",@"身份证号:",@"结算卡号:",@"选择银行:",@"银行支行:"];
    
    UIButton *right_f = [UIButton buttonWithTitle:@"" andFont:nil andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:IMG(@"mine_editor") andHighlightedImage:IMG(@"mine_editor")];
    right_f.frame = CGRectMake(0, 0, 25, 25);
    [right_f addTarget:self action:@selector(ediAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right_f];
    
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
    if (self.isEdite) {
        return [self createEditorMainView];
    } else {
        return [self createMainView];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return SCREEN_HEIGHT;
}

- (UIView *)createMainView {
    UIView *mainview = [[UIView alloc] initWithFrame:self.view.bounds];
    mainview.backgroundColor = [UIColor Grey_BackColor1];
    
    UILabel *left = [UILabel lableWithText:@"个人信息" Font:FONT_ArialMT(12) TextColor:[UIColor Grey_OrangeColor]];
    left.frame = CGRectMake(20, 6.5, 50, 12);
    [mainview addSubview:left];
    UILabel *right = [UILabel lableWithText:@"已完善" Font:FONT_ArialMT(12) TextColor:[UIColor mianColor:2]];
    right.frame = CGRectMake(SCREEN_WIGHT-50, 6.5, 40, 12);
    [mainview addSubview:right];
    
    UIView *content = [[UIView alloc] initWithFrame:CGRectMake(0, 25, SCREEN_WIGHT, 135)];
    content.backgroundColor = [UIColor whiteColor];
    [mainview addSubview:content];
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 1)];
    line1.backgroundColor = [UIColor Grey_LineColor];
    [content addSubview:line1];
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 134, SCREEN_WIGHT, 1)];
    line2.backgroundColor = [UIColor Grey_LineColor];
    [content addSubview:line2];
    
    if (self.dataModel) {
        self.tempArr = @[self.dataModel.realName,self.dataModel.identityCardNo,self.dataModel.bankCardNo,self.dataModel.bankName,self.dataModel.bankName];
    } else {
        self.tempArr = @[@"",@"",@"",@"",@""];
    }
    for (NSInteger i=0; i<5; i++) {
        
        UIView *blank = [[UIView alloc] initWithFrame:CGRectMake(0, 19.5*i+45, SCREEN_WIGHT, 12)];
        blank.backgroundColor = [UIColor whiteColor];
        [mainview addSubview:blank];
        
        UILabel *nameLab = [UILabel lableWithText:[self.nameArr objectAtIndex:i] Font:FONT_ArialMT(12) TextColor:[UIColor Grey_WordColor]];
        [blank addSubview:nameLab];
        [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(blank.mas_left).offset(15);
            make.height.equalTo(@(12));
            make.centerY.equalTo(blank.mas_centerY);
        }];
        UILabel *detailLab = [UILabel lableWithText:[self.tempArr objectAtIndex:i] Font:FONT_ArialMT(12) TextColor:[UIColor mianColor:2]];
        [blank addSubview:detailLab];
        [detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(blank.mas_right).offset(-12.5);
            make.height.equalTo(@(12));
            make.centerY.equalTo(blank.mas_centerY);
            make.left.equalTo(nameLab.mas_right).offset(5);
        }];
        
        
    }
    
    
    
    return mainview;
}

- (UIView *)createEditorMainView {
    UIView *mainView = [[UIView alloc] initWithFrame:self.view.bounds];
    mainView.backgroundColor = [UIColor Grey_BackColor1];
    
    UIView *content = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIGHT, 200)];
    content.backgroundColor = [UIColor whiteColor];
    [mainView addSubview:content];
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 1)];
    line1.backgroundColor = [UIColor Grey_LineColor];
    [content addSubview:line1];
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 199, SCREEN_WIGHT, 1)];
    line2.backgroundColor = [UIColor Grey_LineColor];
    [content addSubview:line2];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 40, SCREEN_WIGHT-20, 1)];
    line.backgroundColor = [UIColor Grey_LineColor];
    [content addSubview:line];
    
    UILabel *label = [UILabel lableWithText:@"请修改" Font:FONT_ArialMT(15) TextColor:[UIColor mianColor:1]];
    [content addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(15));
        make.centerX.equalTo(content.mas_centerX);
        make.top.equalTo(content.mas_top).offset(12.5);
    }];
    
    
    for (NSInteger i=0; i<2; i++) {
        
        NSString *temp = [NSString stringWithFormat:@"%@  %@", [self.nameArr objectAtIndex:i],[self.tempArr objectAtIndex:i]];
        UILabel *infoLab = [UILabel lableWithText:temp Font:FONT_ArialMT(12) TextColor:[UIColor Grey_WordColor]];
        [content addSubview:infoLab];
        infoLab.frame = CGRectMake(15, 19.5*i+55, SCREEN_WIGHT-30, 12);
        
    }
    
    UILabel *label1 = [UILabel lableWithText:@"结算卡号" Font:FONT_ArialMT(12) TextColor:[UIColor Grey_WordColor]];
    [content addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(12));
        make.left.equalTo(content.mas_left).offset(15);
        make.top.equalTo(line.mas_bottom).offset(63);
    }];
    
    tf = [[CustomTextField alloc] initWithFrame:CGRectMake(75, 93.5, SCREEN_WIGHT-140, 30) withPlaceHolder:@"" withSeparateCount:4 withFont:FONT_ArialMT(14)];
    tf.borderStyle = UITextBorderStyleRoundedRect;
    [content addSubview:tf];
    
    
    
    
    for (NSInteger i=0; i<1; i++) {
        UIView *blank = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(tf.frame)+10+40*i, SCREEN_WIGHT, 40)];
        
        UIView *linee = [[UIView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIGHT-20, 1)];
        linee.backgroundColor = [UIColor Grey_LineColor];
        [blank addSubview:linee];
        
        UILabel *label = [UILabel lableWithText:[self.nameArr objectAtIndex:3+i] Font:FONT_ArialMT(12) TextColor:[UIColor Grey_WordColor]];
        label.frame = CGRectMake(15, 24, 55, 12);
        [blank addSubview:label];
        
        UIButton *showLab = [UIButton buttonWithTitle:@"请选择" andFont:FONT_ArialMT(13) andtitleNormaColor:[UIColor mianColor:2] andHighlightedTitle:[UIColor mianColor:2] andNormaImage:nil andHighlightedImage:nil];
        showLab.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        showLab.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail
        showLab.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
        showLab.tag = 888+i;
        showLab.layer.cornerRadius = 5;
        showLab.layer.borderColor = [UIColor colorWithR:205 G:205 B:205 A:1].CGColor;
        showLab.layer.borderWidth = 0.5;
        showLab.clipsToBounds = YES;
        showLab.frame = CGRectMake(75, 15, SCREEN_WIGHT-140, 30);
        [showLab addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [blank addSubview:showLab];
        
        
        [content addSubview:blank];
        
    }
    
    return mainView;
}




- (void)ediAction:(UIBarButtonItem *)sender {
    [[UtilsData sharedInstance] certificateController:self success:^{
        if (!_isEdite) {
            
            self.isEdite = YES;
            [self.tabView reloadData];
        } else {
            
            [self changeCardInfomation];
        }
    }];
}

- (void)buttonClick:(UIButton *)sender {
    UIButton *button = [self.view viewWithTag:sender.tag];
    BankSearchViewController *search = [BankSearchViewController new];
    search.PassBankNameBlock = ^(BankModel *bank) {
        [button setTitle:bank.bankName forState:UIControlStateNormal];
        self.bankNo = bank.tid;
    };
    [self.navigationController pushViewController:search animated:YES];
}


- (void)getDataSource {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"userToken":[UserData currentUser].userToken}] forKey:@"user.getRealName"];
    NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
    [dict setObject:json forKey:@"key"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:nil showAnimation:NO success:^(NSDictionary *resultDic, NSString *msg) {
        
        self.dataModel = [[RealCertificateModel alloc] initWithDictionary:resultDic[@"resultData"] error:nil];
        self.dataModel.tid = [NSString stringWithFormat:@"%@", resultDic[@"resultData"][@"id"]];
        [self.tabView reloadData];
        
    } failure:^(NSString *error, NSInteger code) {
        
    }];
}

- (void)changeCardInfomation {//修改信息
    NSLog(@"----%d++++%@", [tf.userInputContent checkBankCardNumber:tf.userInputContent],tf.userInputContent);
    
    if (!self.bankNo.length) {
        [[UtilsData sharedInstance] showAlertTitle:@"提示" detailsText:@"请选择所属支行" time:2.0 aboutType:MBProgressHUDModeCustomView state:NO];
        return;
    }
    if (!tf.userInputContent.length) {
        [[UtilsData sharedInstance] showAlertTitle:@"提示" detailsText:@"请输入结算卡号" time:2.0 aboutType:MBProgressHUDModeCustomView state:NO];
        return;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"userToken":[UserData currentUser].userToken,@"bankId":self.bankNo,@"cardNumber":tf.userInputContent}] forKey:@"user.modifySettlementCard"];
    NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
    [dict setObject:json forKey:@"key"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:nil showAnimation:NO success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"%@", resultDic);
        self.isEdite = NO;
        [self getDataSource];
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
