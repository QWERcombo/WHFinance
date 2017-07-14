//
//  GatheringViewController.m
//  WHFinance
//
//  Created by wanhong on 2017/6/26.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "GatheringViewController.h"
#import "MessageViewController.h"
#import "CertificateViewController.h"
#import "BankPayViewController.h"
#import "PayWaysViewController.h"
#import "ChoosePayWaysViewController.h"
#import "NoCardPayViewController.h"

@interface GatheringViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    NSInteger lastSelected;
}
@property (nonatomic, strong) UILabel *showLab;
@property (nonatomic, strong) NSArray *payName;
@property (nonatomic, strong) NSArray *payImage;
@property (nonatomic, strong) NSMutableString *showString;
@property (nonatomic, assign) BOOL isDecimal;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) IconModel *selectedModel;
@end

#define Btn_Width (SCREEN_WIGHT-3-14)/4
#define Btn_Height (((SCREEN_HEIGHT-64-50-25)/3*2-5)/5)
#define Content_Height (SCREEN_HEIGHT-64-50-25)/3
#define ShowView_Width (SCREEN_WIGHT-14)/4

@implementation GatheringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"收款";
    self.showString = [NSMutableString string];
    lastSelected = 666;
    
    UIButton *messageBtn = [UIButton buttonWithTitle:nil andFont:nil andtitleNormaColor:nil andHighlightedTitle:nil andNormaImage:IMG(@"message_notice") andHighlightedImage:IMG(@"message_notice")];
    messageBtn.frame = CGRectMake(0, 0, 25, 25);
    [messageBtn addTarget:self action:@selector(messageAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:messageBtn];
    self.navigationItem.leftBarButtonItem.badgeValue = @"1";
    self.navigationItem.leftBarButtonItem.badgeBGColor = [UIColor whiteColor];
    
    
    
    self.payName = @[@"支付宝",@"微信",@"QQ钱包",@"无卡支付",@"323"];
    self.payImage = @[@"",@"",@"",@"",@""];
    [self setUpSubviews];
    [self getdatasource];
}

- (void)setUpSubviews {
    self.view.backgroundColor = [UIColor Grey_BackColor1];
    UIView *showView = [[UIView alloc] init];
    [self.view addSubview:showView];
    showView.backgroundColor = [UIColor whiteColor];
    showView.layer.cornerRadius = 20;
    showView.clipsToBounds = YES;
    [showView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(7);
        make.right.equalTo(self.view.mas_right).offset(-7);
        make.top.equalTo(self.view.mas_top).offset(12.5);
        make.bottom.equalTo(self.view.mas_bottom).offset(-12.5-50);
    }];
    
    JXButton *btn = [[JXButton alloc] initWithFrame:CGRectMake(19, Content_Height-90, 55, 55) withTitleFont:FONT_ArialMT(11)];
    [btn addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor colorWithR:1 G:170 B:239 A:1] forState:UIControlStateNormal];
    [btn setTitle:@"固定码收款" forState:0];
    [btn setImage:IMG(@"fix_code") forState:0];
    [showView addSubview:btn];
    self.showLab = [UILabel lableWithText:[NSString pointTailTwo:@"0"] Font:FONT_ArialMT(36) TextColor:[UIColor Grey_WordColor]];
    [showView addSubview:self.showLab];
    self.showLab.textAlignment = NSTextAlignmentRight;
    [self.showLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(showView.mas_right).offset(-13);
        make.top.equalTo(showView.mas_top).offset(Content_Height-85);
        make.height.equalTo(@(33));
        make.left.equalTo(showView.mas_left).offset(70);
    }];
    UILabel *hintLab = [UILabel lableWithText:@"收款金额" Font:FONT_ArialMT(14) TextColor:[UIColor mianColor:2]];
    [showView addSubview:hintLab];
    [hintLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(14));
        make.bottom.equalTo(self.showLab.mas_top).offset(-18);
        make.right.equalTo(self.showLab.mas_right);
    }];
    
    
    UIView *operateView = [UIView new];
    [showView addSubview:operateView];
    operateView.backgroundColor = [UIColor Grey_BackColor1];
    [operateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(showView);
        make.top.equalTo(self.showLab.mas_bottom).offset(32);
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(Btn_Width, Btn_Height);
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    [_collectionView registerClass:[PayTypeCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [operateView addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(operateView.mas_right);
        make.top.equalTo(operateView.mas_top).offset(21);
        make.width.equalTo(@(Btn_Width));
        make.height.equalTo(@(Btn_Height*4+3));
    }];
    
    
    for (NSInteger i=0; i<4; i++) {
        for (NSInteger j=0; j<3; j++) {
            
            UIButton *operateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            operateBtn.tag = 1000+(i*3+j);
            operateBtn.backgroundColor = [UIColor whiteColor];
            [self setupOperateBtn:operateBtn];
            [operateBtn addTarget:self action:@selector(operateBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [operateView addSubview:operateBtn];
            
            if (i==0) {
                operateBtn.frame = CGRectMake((Btn_Width+1)*j,21, Btn_Width, Btn_Height);
            } else {
                operateBtn.frame = CGRectMake((Btn_Width+1)*j,(Btn_Height+1)*i+21, Btn_Width, Btn_Height);
            }
            
        }
    }
    
    UIButton *getMoney = [UIButton buttonWithTitle:@"确认收款" andFont:FONT_ArialMT(20) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:nil andHighlightedImage:nil];
    getMoney.backgroundColor = [UIColor mianColor:1];
    [getMoney addTarget:self action:@selector(getMoneyClick:) forControlEvents:UIControlEventTouchUpInside];
    [operateView addSubview:getMoney];
    [getMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(operateView);
        make.height.equalTo(@(Btn_Height+1));
    }];
    
    UILabel *moneyHint = [UILabel lableWithText:@"收入金额" Font:FONT_ArialMT(11) TextColor:[UIColor Grey_BackColor]];
    [showView addSubview:moneyHint];
    moneyHint.textAlignment = NSTextAlignmentCenter;
    [moneyHint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(12));
        make.width.equalTo(@(50));
        make.left.equalTo(showView.mas_left).offset(((ShowView_Width*3)-50)/2);
        make.top.equalTo(showView.mas_top).offset(Content_Height-16);
    }];
    UILabel *payHint = [UILabel lableWithText:@"选择支付方式" Font:FONT_ArialMT(11) TextColor:[UIColor Grey_BackColor]];
    [showView addSubview:payHint];
    payHint.textAlignment = NSTextAlignmentCenter;
    [payHint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(12));
        make.width.equalTo(@(70));
        make.right.equalTo(showView.mas_right).offset(-((ShowView_Width-70)/2));
        make.top.equalTo(showView.mas_top).offset(Content_Height-16);
    }];
    
}

#pragma mark - UICollectionView
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    IconModel *icon = [self.dataMuArr objectAtIndex:indexPath.row];
    PayTypeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.payName.text = icon.productName;
    [cell.payImgv sd_setImageWithURL:URL_STRING(icon.icon)];
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataMuArr.count;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (lastSelected!=666) {
        IconModel *icon = [self.dataMuArr objectAtIndex:lastSelected];
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:lastSelected inSection:0];
        PayTypeCollectionViewCell *cell = (PayTypeCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexpath];
        [cell.payImgv sd_setImageWithURL:URL_STRING(icon.icon)];
    }
    
    IconModel *icon = [self.dataMuArr objectAtIndex:indexPath.row];
    PayTypeCollectionViewCell *cell = (PayTypeCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    [cell.payImgv sd_setImageWithURL:URL_STRING(icon.iconSelected)];
    
    self.selectedModel = icon;
    lastSelected = indexPath.row;
}

#pragma mark - Action
- (void)titleButtonClick:(UIButton *)sender {
//    [[UtilsData sharedInstance] showAlertControllerWithTitle:@"提示" detail:@"敬请期待..." doneTitle:@"确定" cancelTitle:nil haveCancel:NO doneAction:nil controller:self];
    NoCardPayViewController *bank = [NoCardPayViewController new];
    [self.navigationController pushViewController:bank animated:YES];
}
- (void)messageAction:(UIButton *)sender {
    MessageViewController *message = [MessageViewController new];
    [self.navigationController pushViewController:message animated:YES];
}

- (void)setupOperateBtn:(UIButton *)sender {
    [sender setTitleColor:[UIColor Grey_WordColor] forState:UIControlStateNormal];
    
    if (sender.tag==1011) {//删除
        UIImageView *imgv = [UIImageView new];
        [sender addSubview:imgv];
        imgv.image = IMG(@"delete");
        [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@(30));
            make.center.equalTo(sender);
        }];
    }
    
    if (sender.tag<1011) {//数字
        if (sender.tag==1009) {
            [sender setTitle:@"." forState:UIControlStateNormal];
        } else if (sender.tag==1010){
            [sender setTitle:@"0" forState:UIControlStateNormal];
        } else {
            [sender setTitle:SINT(sender.tag-999) forState:UIControlStateNormal];
        }
    }
    
}

- (void)getMoneyClick:(UIButton *)click {
//    [[UtilsData sharedInstance] showAlertControllerWithTitle:@"提示" detail:@"您要进行实名认证才能进行收款，是否进入实名认证" doneTitle:@"是" cancelTitle:@"否" haveCancel:YES doneAction:^{
//        CertificateViewController *cer = [CertificateViewController new];
//        [self.navigationController pushViewController:cer animated:YES];
//    } controller:self];
//    [self getRealName];
    
    if (!self.selectedModel) {
        [[UtilsData sharedInstance] showAlertControllerWithTitle:@"提示" detail:@"您还未选择收款方式" doneTitle:@"确定" cancelTitle:@"" haveCancel:NO doneAction:^{
            
        } controller:self];
        return;
    }
    ChoosePayWaysViewController *choose = [ChoosePayWaysViewController new];
    choose.productId = self.selectedModel.tid;
    choose.cashCount = self.showString;
    [self.navigationController pushViewController:choose animated:YES];
    
}

- (void)operateBtnAction:(UIButton *)sender {
    if (sender.tag<1011) {//数字
        if (self.showLab.text.length>12) {
            
            return;
        }
        if (sender.tag==1009) {//小数点
            [self.showString appendString:@"."];
            self.isDecimal = YES;
            
        } else {//数字
            if (self.isDecimal) {
                NSArray *arr = [self.showString componentsSeparatedByString:@"."];
                NSString *ss = [arr lastObject];
                if (ss.length>1) {
                    return;
                }
                [self.showString appendString:sender.currentTitle];
                
            } else {
                [self.showString appendString:sender.currentTitle];
            }
            
        }
        self.showLab.text = [NSString pointTailTwo:self.showString];
        
    }
    
    if (sender.tag==1011) {//删除
        if (!self.showString.length) {
            return;
        }
        if (self.isDecimal) {
            NSArray *arr = [self.showString componentsSeparatedByString:@"."];
            NSString *ss = [arr lastObject];
            if (ss.length==1) {
                self.isDecimal = NO;
                [self.showString deleteCharactersInRange:NSMakeRange(self.showString.length-2, 2)];
            } else {
                [self.showString deleteCharactersInRange:NSMakeRange(self.showString.length-1, 1)];
            }
        } else {
            [self.showString deleteCharactersInRange:NSMakeRange(self.showString.length-1, 1)];
        }
        
        self.showLab.text = [NSString pointTailTwo:self.showString];
    }
    
    
}
- (UIView *)createPayViewWithTitle:(NSString *)title image:(UIImage *)image {
    UIView *blank = [[UIView alloc] init];
    UIImageView *payImgv = [UIImageView new];
    [blank addSubview:payImgv];
    payImgv.backgroundColor = [UIColor mianColor:1];
    payImgv.image = image;
    [payImgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(35));
        make.top.equalTo(blank);
        make.centerX.equalTo(blank.mas_centerX);
    }];
    
    UILabel *titleLab = [UILabel lableWithText:title Font:FONT_ArialMT(14) TextColor:[UIColor mianColor:2]];
    [blank addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(14));
        make.top.equalTo(payImgv.mas_bottom).offset(5);
        make.centerX.equalTo(payImgv.mas_centerX);
        make.left.right.bottom.equalTo(blank);
    }];
    
    
    return blank;
}

- (void)getdatasource {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"userToken":[UserData currentUser].userToken}] forKey:@"transc.getProducts"];
    NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
    [dict setObject:json forKey:@"key"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
//        NSLog(@"%@", resultDic);
        NSArray *dataArr = resultDic[@"resultData"];
        for (NSDictionary *dic in dataArr) {
            IconModel *icon = [[IconModel alloc] initWithDictionary:dic error:nil];
            [self.dataMuArr addObject:icon];
        }
        [self.collectionView reloadData];
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
