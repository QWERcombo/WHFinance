//
//  CertificateViewController.m
//  WHFinance
//
//  Created by wanhong on 2017/6/26.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "CertificateViewController.h"
#import "CertificatePhotoViewController.h"

@interface CertificateViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) NSArray *nameArray;
@property (nonatomic, strong) NSArray *placeholderArray;
@property (nonatomic, assign) CGSize kbSize;
@property (nonatomic, assign) BOOL isCer;
@end

@implementation CertificateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"实名认证";
    [self setUpSubviews];
    
    self.nameArray = [NSArray arrayWithObjects:@"姓       名",@"身份证号",@"银行账号",@"所属银行",@"所在地址",@"手机号码", nil];
    self.placeholderArray = [NSArray arrayWithObjects:@"请输入经营者姓名",@"请输入经营者身份证号",@"请输入持卡人银行账号",@"请输入账号所属银行",@"请输入经营者所在地",@"13231313131", nil];
    
}

- (void)setUpSubviews {
    [self.view addSubview:self.tabView];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (_isCer) {
        return [self createMainViewCertificated];
    } else {
        return [self createMainView];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.view.size.height;
}


- (UIView *)createMainView {//未认证
    UIView *mainView = [[UIView alloc] initWithFrame:self.view.bounds];
    mainView.backgroundColor = [UIColor Grey_BackColor1];
    
    UILabel *hintLab = [YXPUtil creatUILable:@"为了保障您的合法权益，请填写认证信息" Font:FONT_ArialMT(14) TextColor:[UIColor colorWithR:253 G:120 B:45 A:1]];
    [mainView addSubview:hintLab];
    [hintLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mainView.mas_left).offset(15);
        make.top.equalTo(mainView.mas_top).offset(13);
        make.height.equalTo(@(15));
    }];
    
    for (NSInteger i=0; i<6; i++) {
        
        UIView *blank = [[UIView alloc] initWithFrame:CGRectMake(0, 40+i*45, SCREEN_WIGHT, 45)];
        blank.backgroundColor = [UIColor whiteColor];
        
        UIView *line =[[UIView alloc] initWithFrame:CGRectMake(15, 44, SCREEN_WIGHT-30, 1)];
        line.backgroundColor = line.backgroundColor = [UIColor Grey_LineColor];
        
        UILabel *nameLab = [YXPUtil creatUILable:[self.nameArray objectAtIndex:i] Font:FONT_ArialMT(14) TextColor:[UIColor colorWithR:51 G:51 B:51 A:1]];
        [blank addSubview:nameLab];
        [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(blank.mas_centerY);
            make.left.equalTo(blank.mas_left).offset(20);
            make.height.equalTo(@(16));
        }];
        
        
        UITextField *tempTF = nil;
        tempTF.tag = 110+i;
        if (i==1 || i==2 || i==5) {
            tempTF = [[CustomTextField alloc] initWithFrame:CGRectMake(100, 5, 200, 35) withPlaceHolder:[self.placeholderArray objectAtIndex:i] withSeparateCount:4 withFont:FONT_ArialMT(14)];
        } else {
            tempTF = [[UITextField alloc] initWithFrame:CGRectMake(100, 5, 200, 35)];
            tempTF.placeholder = [self.placeholderArray objectAtIndex:i];
            tempTF.font = FONT_ArialMT(14);
        }
        [blank addSubview:tempTF];
        
        
        if (i==5) {
        } else {
        [blank addSubview:line];
        }
        
        
        [mainView addSubview:blank];
    }
    
    UIButton *doneBtn = [UIButton buttonWithTitle:@"确定" andFont:FONT_ArialMT(18) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:IMG(@"register_btn") andHighlightedImage:IMG(@"register_btn")];
    [doneBtn addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
    doneBtn.frame = CGRectMake(15, 330, SCREEN_WIGHT-30, 40);
    [mainView addSubview:doneBtn];
    
    UITapGestureRecognizer *cerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cerTap:)];
    [mainView addGestureRecognizer:cerTap];
    
    
    return mainView;
}


- (UIView *)createMainViewCertificated {
    UIView *mianView = [[UIView alloc] initWithFrame:self.view.bounds];
    mianView.backgroundColor = [UIColor Grey_BackColor1];
    
    
    UIView *imgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 200)];
    imgView.backgroundColor = [UIColor whiteColor];
    [mianView addSubview:imgView];
    
    UIImageView *imgv = [UIImageView new];
    imgv.image = IMG(@"");
    imgv.backgroundColor = [UIColor mianColor:1];
    [imgView addSubview:imgv];
    [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(117));
        make.top.equalTo(imgView.mas_top).offset(35);
        make.centerX.equalTo(imgView.mas_centerX);
    }];
    UILabel *hint = [UILabel lableWithText:@"您已经通过实名认证" Font:FONT_ArialMT(14) TextColor:[UIColor mianColor:1]];
    [imgView addSubview:hint];
    [hint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(14));
        make.top.equalTo(imgv.mas_bottom).offset(14);
        make.centerX.equalTo(imgv.mas_centerX);
    }];
    
    
    UIView *infoView = [[UIView alloc] initWithFrame:CGRectMake(0, 210, SCREEN_WIGHT, 90)];
    infoView.backgroundColor = [UIColor whiteColor];
    [mianView addSubview:infoView];
    UILabel *name = [UILabel lableWithText:@"姓    名" Font:FONT_ArialMT(14) TextColor:[UIColor Grey_WordColor]];
    [infoView addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(infoView.mas_left).offset(13);
        make.height.equalTo(@(14));
        make.top.equalTo(infoView.mas_top).offset(15.5);
    }];
    UILabel *name_de = [UILabel lableWithText:@"姓名" Font:FONT_ArialMT(14) TextColor:[UIColor colorWithR:205 G:205 B:205 A:1]];
    name_de.textAlignment = NSTextAlignmentRight;
    [infoView addSubview:name_de];
    [name_de mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(infoView.mas_right).offset(-13);
        make.height.equalTo(@(14));
        make.top.equalTo(infoView.mas_top).offset(15.5);
        make.left.equalTo(name.mas_right);
    }];
    UILabel *identi = [UILabel lableWithText:@"身份证号" Font:FONT_ArialMT(14) TextColor:[UIColor Grey_WordColor]];
    [infoView addSubview:identi];
    [identi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(infoView.mas_left).offset(13);
        make.height.equalTo(@(14));
        make.top.equalTo(infoView.mas_top).offset(15.5+45);
    }];
    UILabel *identi_de = [UILabel lableWithText:@"2123123123123124" Font:FONT_ArialMT(14) TextColor:[UIColor colorWithR:205 G:205 B:205 A:1]];
    identi_de.textAlignment = NSTextAlignmentRight;
    [infoView addSubview:identi_de];
    [identi_de mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(infoView.mas_right).offset(-13);
        make.height.equalTo(@(14));
        make.top.equalTo(infoView.mas_top).offset(15.5+45);
        make.left.equalTo(name.mas_right);
    }];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(13, 44.5, SCREEN_WIGHT-26, 1)];
    line.backgroundColor = [UIColor Grey_LineColor];
    [infoView addSubview:line];
    
    
    
    
    UIButton *getMoney = [UIButton buttonWithTitle:@"马上收款" andFont:FONT_ArialMT(18) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:IMG(@"register_btn") andHighlightedImage:IMG(@"register_btn")];
    getMoney.tag = 1001;
    [getMoney addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [mianView addSubview:getMoney];
    [getMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(40));
        make.width.equalTo(@(SCREEN_WIGHT-26));
        make.centerX.equalTo(mianView.mas_centerX);
        make.top.equalTo(infoView.mas_bottom).offset(20);
    }];
    
    UIButton *photoCer = [UIButton buttonWithTitle:@"完善照片信息" andFont:FONT_ArialMT(18) andtitleNormaColor:[UIColor mianColor:1] andHighlightedTitle:[UIColor mianColor:1] andNormaImage:IMG(@"") andHighlightedImage:IMG(@"")];
    photoCer.layer.borderColor = [UIColor mianColor:1].CGColor;
    photoCer.layer.borderWidth = 1;
    photoCer.layer.cornerRadius = 5;
    photoCer.clipsToBounds = YES;
    photoCer.tag = 1002;
    [photoCer addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [mianView addSubview:photoCer];
    [photoCer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(40));
        make.width.equalTo(@(SCREEN_WIGHT-26));
        make.centerX.equalTo(mianView.mas_centerX);
        make.top.equalTo(getMoney.mas_bottom).offset(20);
    }];
    
    return mianView;
}


#pragma mark - Action
- (void)cerTap:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}
- (void)doneAction:(UIButton *)sender {
    [self.view endEditing:YES];
//    key={"user.realNameSave":{"userRealName":{"address":"测试地址","bankCardNo":"622222222222222222","bankName":"工商银行","identityCardNo":"440402198810019291","mobileNumber":"13631233543","realName":"ceshi","status":0},"sessionId":"12a4309795c0ba2e8f370b4db3367bfbebdf3eb39ae76e4006f5723b4ab06a8a"}}
//    CustomTextField *text = (CustomTextField *)[self.view viewWithTag:111];
//    NSLog(@"---%@", text.userInputContent);
    
    
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
//    [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"userRealName":@{@"address":@"测试地址",@"bankCardNo":@"622222222222222222",@"bankName":@"工商银行",@"identityCardNo":@"440402198810019291",@"mobileNumber":@"13631233543",@"realName":@"ceshi1"},@"userToken":[UserData currentUser].userToken}] forKey:@"user.realNameSave"];
//    NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
//    [dict setObject:json forKey:@"key"];
//
//    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
//
//        if (resultDic) {
//            [[UtilsData sharedInstance] showAlertTitle:@"认证成功" detailsText:nil time:2 aboutType:MBProgressHUDModeCustomView state:YES];
//        }
//
//    } failure:^(NSString *error, NSInteger code) {
//
//    }];
    
    self.isCer = YES;
    [self.tabView reloadData];
}
- (void)buttonClick:(UIButton *)sender {
    if (sender.tag==1001) {
        NSLog(@"马上收款");
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        CertificatePhotoViewController *photo = [CertificatePhotoViewController new];
        [self.navigationController pushViewController:photo animated:YES];
    }
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
