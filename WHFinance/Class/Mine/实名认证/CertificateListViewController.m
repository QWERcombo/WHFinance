//
//  CertificateListViewController.m
//  WHFinance
//
//  Created by wanhong on 2017/6/30.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "CertificateListViewController.h"
#import "CertificateViewController.h"
#import "CardInformationViewController.h"
#import "CertificatePhotoViewController.h"
#import "BankSearchViewController.h"

@interface CertificateListViewController ()
@property (nonatomic, strong) NSArray *nameArr;
@end

@implementation CertificateListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"实名认证";
    
    
    self.nameArr = @[@"银行卡信息",@"照片信息"];
    [self setUpSubviews];
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
    UIView *main = [[UIView alloc] initWithFrame:self.view.bounds];
    main.backgroundColor = [UIColor Grey_BackColor1];
    
    UIView *topView = [UIView new];
    [main addSubview:topView];
    topView.backgroundColor = [UIColor whiteColor];
    topView.layer.borderColor = [UIColor Grey_LineColor].CGColor;
    topView.layer.borderWidth = 1;
    topView.layer.cornerRadius = 2;
    topView.clipsToBounds = YES;
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(main.mas_top).offset(10);
        make.left.equalTo(main.mas_left).offset(12.5);
        make.right.equalTo(main.mas_right).offset(-12.5);
        make.height.equalTo(@(40));
    }];
    
    UILabel *label = [UILabel lableWithText:@"注册账号" Font:FONT_ArialMT(12) TextColor:[UIColor colorWithR:186 G:186 B:186 A:1]];
    [topView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topView.mas_centerY);
        make.left.equalTo(topView.mas_left).offset(10);
        make.height.equalTo(@(12));
    }];
    UILabel *account = [UILabel lableWithText:[UserData currentUser].mobileNumber Font:FONT_ArialMT(12) TextColor:[UIColor Grey_WordColor]];
    [topView addSubview:account];
    [account mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(12));
        make.centerY.equalTo(topView.mas_centerY);
        make.right.equalTo(topView.mas_right).offset(-10);
    }];
    
    
    //----------------------------------------------------------------
    UIView *content = [UIView new];
    content.backgroundColor = [UIColor whiteColor];
    content.backgroundColor = [UIColor whiteColor];
    content.layer.borderColor = [UIColor Grey_LineColor].CGColor;
    content.layer.borderWidth = 1;
    content.layer.cornerRadius = 5;
    topView.clipsToBounds = YES;
    [main addSubview:content];
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).offset(10);
        make.left.equalTo(main.mas_left).offset(12.5);
        make.right.equalTo(main.mas_right).offset(-12.5);
        make.height.equalTo(@(239));
    }];
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor Grey_LineColor];
    [content addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(1));
        make.left.equalTo(content.mas_left).offset(20);
        make.right.equalTo(content.mas_right).offset(-20);
        make.top.equalTo(content.mas_top).offset(52.5);
    }];
    
    
    UILabel *hint = [UILabel lableWithText:@"未认证, 请填写结算卡信息" Font:FONT_ArialMT(12) TextColor:[UIColor mianColor:1]];
    [content addSubview:hint];
    [hint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(12));
        make.centerX.equalTo(content.mas_centerX);
        make.top.equalTo(content.mas_top).offset(10);
    }];
    UILabel *des = [UILabel lableWithText:@"您的身份信息将被加密处理, 请放心填写" Font:FONT_ArialMT(11) TextColor:[UIColor colorWithR:186 G:186 B:186 A:1]];
    [content addSubview:des];
    [des mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(11));
        make.top.equalTo(hint.mas_bottom).offset(10);
        make.centerX.equalTo(content.mas_centerX);
    }];
    
    
    NSArray *arr = @[@"身份证号",@"真实姓名",@"结算卡号",@"所属支行"];
    for (NSInteger i=0; i<4; i++) {
        
        UIView *blank = [[UIView alloc] initWithFrame:CGRectMake(17, 65+40*i, SCREEN_WIGHT-59,30)];
        UILabel *left = [UILabel lableWithText:[arr objectAtIndex:i] Font:FONT_ArialMT(12) TextColor:[UIColor mianColor:2]];
        [blank addSubview:left];
        [left mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(30));
            make.centerY.equalTo(blank.mas_centerY);
            make.left.equalTo(blank.mas_left);
        }];
        
        CustomTextField *customTF = nil;
        customTF.tag = 1000+i;
        customTF.backgroundColor = [UIColor colorWithR:245 G:245 B:245 A:1];
        if (i==0 || i==2) {
            customTF = [[CustomTextField alloc] initWithFrame:CGRectMake(70, 0, SCREEN_WIGHT-129, 30) withPlaceHolder:@"" withSeparateCount:4 withFont:FONT_ArialMT(12)];
        } else {
            if (i==1) {
                customTF = [[CustomTextField alloc] initWithFrame:CGRectMake(70, 0, i==3?SCREEN_WIGHT-154:SCREEN_WIGHT-129, 30) withPlaceHolder:@"" withSeparateCount:0 withFont:FONT_ArialMT(12)];
                customTF.keyboardType = UIKeyboardTypeDefault;
            }
        }
        customTF.borderStyle = UITextBorderStyleRoundedRect;
        customTF.placeHolderLabel.backgroundColor = [UIColor Grey_BackColor1];
        [blank addSubview:customTF];
        
        if (i==3) {
            UIButton *button = [UIButton buttonWithTitle:@"    请选择" andFont:FONT_ArialMT(12) andtitleNormaColor:[UIColor Grey_WordColor] andHighlightedTitle:[UIColor Grey_WordColor] andNormaImage:nil andHighlightedImage:nil];
            button.tag = 111;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            button.backgroundColor = [UIColor colorWithR:245 G:245 B:245 A:1];
            button.frame = CGRectMake(70, 0, SCREEN_WIGHT-129, 30);
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [blank addSubview:button];
        }
        
        
        
        [content addSubview:blank];
    }
    
    
    //------------------------------------------------------------------------
    UIButton *uploadBtn = [UIButton buttonWithTitle:@"提交" andFont:FONT_ArialMT(19) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:nil andHighlightedImage:nil];
    uploadBtn.backgroundColor = [UIColor mianColor:1];
    uploadBtn.layer.cornerRadius = 5;
    uploadBtn.clipsToBounds = YES;
    [uploadBtn addTarget:self action:@selector(uploadAction:) forControlEvents:UIControlEventTouchUpInside];
    [main addSubview:uploadBtn];
    [uploadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(40));
        make.top.equalTo(content.mas_bottom).offset(25);
        make.centerX.equalTo(main.mas_centerX);
        make.width.equalTo(@(SCREEN_WIGHT-25));
    }];
    
    return main;
}



- (void)uploadAction:(UIButton *)sender {
    CertificatePhotoViewController *photo = [CertificatePhotoViewController new];
    [self.navigationController pushViewController:photo animated:YES];
    [self uploadCer];
}
- (void)buttonClick:(UIButton *)sender {
    BankSearchViewController *bank = [BankSearchViewController new];
    bank.PassBankNameBlock = ^(NSString *bankName) {
        UIButton *button = [self.tabView viewWithTag:111];
        [button setTitle:bankName forState:UIControlStateNormal];
        
    };
    [self.navigationController pushViewController:bank animated:YES];
}

- (void)uploadCer {//实名认证
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"userToken":[UserData currentUser].userToken,@"userRealName":@{@"bankCardNo":@"622222222222222222",@"bankNoId":@"1",@"identityCardNo":@"440402198810019299",@"realName":@"ceshi"}}] forKey:@"user.realNameSave"];
    NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
    [dict setObject:json forKey:@"key"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"%@", resultDic);
        
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
