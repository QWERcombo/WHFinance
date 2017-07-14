//
//  NoCardPayViewController.m
//  WHFinance
//
//  Created by wanhong on 2017/7/7.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "NoCardPayViewController.h"
#import "TradeResultViewController.h"
#import "WithdrawRecordViewController.h"
#import "BindedCardViewController.h"
#import "JoinParterViewController.h"

@interface NoCardPayViewController () {
    NSIndexPath* preSelect;
}
@property (nonatomic, strong) BankCardModel *selectedCard;//选中的银行卡tid
@end

@implementation NoCardPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"无卡支付";
//    preSelect = -1;
    
    [self setUpSubviews];
    [self getCardInfomationList];
}

- (void)setUpSubviews {
    UIView *vvv = [self createResultView];//认证
    [self.view addSubview:vvv];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return self.dataMuArr.count;
    } else {
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BankCardModel *model = [self.dataMuArr objectAtIndex:indexPath.row];
    return [UtilsMold creatCell:@"BankCardChooseCell" table:tableView deledate:self model:model data:indexPath andCliker:^(NSDictionary *clueDic) {
        if ([clueDic[@"clueStr"] isEqualToString:@"1"]) {
            self.selectedCard = model;
            //获取选中的银行卡
            model.isSelectedCard = YES;
            [self.dataMuArr removeObjectAtIndex:indexPath.row];
            [self.dataMuArr insertObject:model atIndex:indexPath.row];
            NSIndexPath *tmpIndexpath=[NSIndexPath indexPathForRow:indexPath.row inSection:0];
            [self.tabView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:tmpIndexpath, nil] withRowAnimation:UITableViewRowAnimationNone];
            //取消之前选中
//            if (preSelect != -1) {
//                BankCardModel *preModel = [self.dataMuArr objectAtIndex:preSelect];
//                preModel.isSelectedCard = NO;
//                [self.dataMuArr removeObjectAtIndex:preSelect];
//                [self.dataMuArr insertObject:preModel atIndex:preSelect];
//                NSIndexPath *pretmpIndexpath=[NSIndexPath indexPathForRow:preSelect inSection:0];
//                [self.tabView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:pretmpIndexpath, nil] withRowAnimation:UITableViewRowAnimationNone];
//            }
//             preSelect = indexPath;
            
        }
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold getCellHight:@"BankCardChooseCell" data:nil model:nil indexPath:indexPath];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return nil;
    } else {
        UIButton *blank = [UIButton buttonWithTitle:nil andFont:FONT_ArialMT(15) andtitleNormaColor:[UIColor Grey_BackColor] andHighlightedTitle:[UIColor Grey_BackColor] andNormaImage:IMG(@"add_card") andHighlightedImage:IMG(@"add_card")];
        blank.frame = CGRectMake(0, 0, SCREEN_WIGHT-66, 60);
        [blank addTarget:self action:@selector(addnew:) forControlEvents:UIControlEventTouchUpInside];
        return blank;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return 0;
    } else {
        return 60;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

#pragma mark - init subviews
- (UIView *)createResultView {//已认证
    UIView *mainView = [[UIView alloc] initWithFrame:self.view.bounds];
    mainView.backgroundColor = [UIColor Grey_BackColor1];
    mainView.tag = 666;
    
    UIImageView *logo = [UIImageView new];
    [mainView addSubview:logo];
    logo.image = IMG(@"pay_way_nocard");
    [logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mainView.mas_left).offset(20);
        make.top.equalTo(mainView.mas_top).offset(27);
        make.width.equalTo(@(98));
        make.height.equalTo(@(24));
    }];
    UILabel *llll = [UILabel lableWithText:@"支付金额" Font:FONT_ArialMT(10) TextColor:[UIColor Grey_WordColor]];
    [mainView addSubview:llll];
    [llll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(10));
        make.left.equalTo(logo.mas_left);
        make.top.equalTo(logo.mas_bottom).offset(5);
    }];
    UILabel *mmmm = [UILabel lableWithText:@"交易银行有积分，单笔最高两万" Font:FONT_ArialMT(12) TextColor:[UIColor Grey_WordColor]];
    [mainView addSubview:mmmm];
    [mmmm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(12));
        make.right.equalTo(mainView.mas_right).offset(-20);
        make.top.equalTo(logo.mas_top);
    }];
    
    UILabel *cashLab = [UILabel lableWithText:[NSString pointTailTwo:self.cashCount] Font:FONT_ArialMT(24) TextColor:[UIColor mianColor:1]];
    [mainView addSubview:cashLab];
    [cashLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(24));
        make.right.equalTo(mmmm.mas_right);
        make.top.equalTo(mmmm.mas_bottom).offset(10);
    }];
    
    
    //主要内容
    UIView *content = [UIView new];
    [mainView addSubview:content];
    content.backgroundColor = [UIColor whiteColor];
    content.layer.cornerRadius = 10;
    content.clipsToBounds = YES;
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(293));
        make.left.equalTo(mainView.mas_left).offset(10);
        make.right.equalTo(mainView.mas_right).offset(-10);
        make.top.equalTo(llll.mas_bottom).offset(17);
    }];
    
    UIView *topView = [UIView new];
    topView.backgroundColor = [UIColor colorWithR:221 G:221 B:221 A:1];
    [content addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(45));
        make.left.top.right.equalTo(content);
    }];
    
    UIView *vvv = [UIView joinUsWithStatus:YES];
    [topView addSubview:vvv];
    [vvv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topView.mas_centerY);
        make.right.equalTo(topView.mas_right).offset(-5);
        make.height.equalTo(@(20));
    }];
    UITapGestureRecognizer *vvvtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(vvvTap:)];
    [vvv addGestureRecognizer:vvvtap];
    
    UILabel *textLab = [UILabel lableWithText:@"普通级会员手续费0.02元\n创业合伙人手续费0.02元" Font:FONT_ArialMT(11) TextColor:[UIColor mianColor:2]];
    textLab.numberOfLines = 2;
    [topView addSubview:textLab];
    [textLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView.mas_left).offset(10);
        make.top.equalTo(topView.mas_top).offset(0);
        make.bottom.equalTo(topView.mas_bottom).offset(5);
    }];
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
    para.lineSpacing = 5;
    NSRange rang = NSMakeRange(0, textLab.text.length/2);
    NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc] initWithString:textLab.text attributes:@{NSParagraphStyleAttributeName:para}];
    [attstr addAttribute:NSFontAttributeName value:FONT_ArialMT(11) range:rang];
    [attstr addAttribute:NSForegroundColorAttributeName value:[UIColor mianColor:1] range:rang];
    textLab.attributedText = attstr;
    
    
    self.tabView.backgroundColor = [UIColor whiteColor];
    [content addSubview:self.tabView];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(content.mas_left).offset(23);
        make.right.equalTo(content.mas_right).offset(-23);
        make.top.equalTo(topView.mas_bottom).offset(15);
        make.bottom.equalTo(content.mas_bottom).offset(-60);
    }];
    
    
    UIButton *bottomBtn = [UIButton buttonWithTitle:@"提交支付" andFont:FONT_ArialMT(19) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:nil andHighlightedImage:nil];
    [content addSubview:bottomBtn];
    [bottomBtn addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
    bottomBtn.backgroundColor = [UIColor mianColor:1];
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(45));
        make.left.right.bottom.equalTo(content);
    }];
    
    return mainView;
}


#pragma mark - Action
- (void)payAction:(UIButton *)sender {//立即支付
    //subProductId 3 无卡支付
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"userToken":[UserData currentUser].userToken,@"transAmount":self.cashCount,@"subProductId":[self.isPartner isEqualToString:@"yes"]?@"65502":@"3",@"transUserCardId":self.selectedCard.tid}] forKey:@"transc.placeOrderByCardInfo"];
    NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
    [dict setObject:json forKey:@"key"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"+++***%@", resultDic);
        WithdrawRecordViewController *with = [WithdrawRecordViewController new];
        with.orderID = resultDic[@"resultData"];
        [self.navigationController pushViewController:with animated:YES];
        
    } failure:^(NSString *error, NSInteger code) {
        
    }];
}

- (void)vvvTap:(UITapGestureRecognizer *)sender {//加入创业合伙人
    JoinParterViewController *join = [JoinParterViewController new];
    [self.navigationController pushViewController:join animated:YES];
}


- (void)addnew:(UIButton *)sender {
    BindedCardViewController *bind = [BindedCardViewController new];
    bind.cashCount = self.cashCount;
    bind.isPartner = self.isPartner;
    [self.navigationController pushViewController:bind animated:YES];
    
}

- (void)getCardInfomationList {
    //查询卡列表
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"userToken":[UserData currentUser].userToken}] forKey:@"transqury.queryUserCard"];
    NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
    [dict setObject:json forKey:@"key"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
//        NSLog(@"%@", resultDic);
        NSArray *dataArr = resultDic[@"resultData"];
        for (NSDictionary *dataDic in dataArr) {
            BankCardModel *model = [[BankCardModel alloc] initWithDictionary:dataDic error:nil];
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
