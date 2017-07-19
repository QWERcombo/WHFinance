//
//  MineViewController.m
//  WHFinance
//
//  Created by wanhong on 2017/6/26.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "MineViewController.h"
#import "MainLoginViewController.h"
#import "OpenProductViewController.h"
#import "CustomerServiceViewController.h"
#import "SettingViewController.h"
#import "MessageViewController.h"
#import "CertificateListViewController.h"
#import "ShareViewController.h"
#import "FAQViewController.h"
#import "MyRateViewController.h"
#import "JoinParterViewController.h"
#import "CardInformationViewController.h"
#import "CertificatePhotoViewController.h"

@interface MineViewController ()
@property (nonatomic, strong) NSArray *nameArray1;
@property (nonatomic, strong) NSArray *nameArray2;
@property (nonatomic, strong) NSArray *nameArr;
@property (nonatomic, strong) NSArray *imageArr;

@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *phoneLab;
@property (nonatomic, strong) UILabel *stastusLab;
@property (nonatomic, strong) UIImageView *headerImgv;

@property (nonatomic, strong) NSString *realStatus;
@end

@implementation MineViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.tabView reloadData];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    self.navigationController.navigationBar.hidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.nameArray1 = @[@"我的费率",@"分享推广",@"我的结算卡",@"常见问题"];
    self.nameArray2 = @[@[@"mine_choose_0",@"实名认证"],@[@"mine_choose_1",@"客服电话"],@[@"mine_choose_2",@"设置"]];
    [self.dataMuArr addObjectsFromArray:self.nameArray2];
    self.nameArr = @[@"享受收款超低费率",@"享受100元每人直推返佣",@"办大额信用卡快速贷款",@"享受客服热线等更多服务"];
    
    [[PublicFuntionTool sharedInstance] getRealName:^(NSString *status) {
        self.realStatus = [NSString stringWithFormat:@"%@",status];//获取实名认证状态
        [self.tabView reloadData];
    }];
    [self setUpSubviews];
}

#pragma mark - SetUpSubViews
- (void)setUpSubviews {
    [self.view addSubview:self.tabView];
    self.tabView.backgroundColor = [UIColor Grey_BackColor1];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(-20);
    }];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==3) {
        return self.dataMuArr.count;
    } else {
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *namestr = [self.nameArray2 objectAtIndex:indexPath.row];
    MineListCell *cell = (MineListCell *)[UtilsMold creatCell:@"MineListCell" table:tableView deledate:self model:namestr data:nil andCliker:^(NSDictionary *clueDic) {
        
    }];
    
    if (indexPath.row==0) {
        if (self.realStatus.length) {
            cell.rightLab.text = [UserData currentUser].readName.length>0?[self.realStatus integerValue]>1?@"已认证":@"待提交图片":@"待提交结算卡";
        } else {
            cell.rightLab.text = @"";
        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell.line mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(1));
            make.left.equalTo(cell.contentView.mas_left).offset(12.5);
            make.right.equalTo(cell.contentView.mas_right).offset(17.5);
            make.bottom.equalTo(cell.contentView.mas_bottom);
        }];
    }
    
    return cell;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold getCellHight:@"MineListCell" data:nil model:nil indexPath:indexPath];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return [self createMainViewOne];
    } else if (section==1){
        return [self createMainViewTwo];;
    }  else {
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return 170+64;
    } else if (section==1){
        return 90;
    }  else {
        return 0;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==1) {
        [[UtilsData sharedInstance] showAlertControllerWithTitle:@"客服： 10086" detail:@"" doneTitle:@"呼叫" cancelTitle:@"取消" haveCancel:YES doneAction:^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", @"10086"]]];
        } controller:self];
    }
    if (indexPath.row==0) {
        if ([self.realStatus integerValue]==0) {//未认证
            CertificateListViewController *cer = [CertificateListViewController new];
            [self.navigationController pushViewController:cer animated:YES];
        }
        if ([self.realStatus integerValue]==1) {//未传图片
            CertificatePhotoViewController *cer = [CertificatePhotoViewController new];
            [self.navigationController pushViewController:cer animated:YES];
        }
        if ([self.realStatus integerValue]==2) {//已认证
            [[UtilsData sharedInstance] showAlertControllerWithTitle:@"提示" detail:@"实名认证已完成" doneTitle:@"确定" cancelTitle:@"" haveCancel:NO doneAction:^{
            } controller:self];
        }
    }
    if (indexPath.row==2) {
        SettingViewController *newcard = [SettingViewController new];
        [self.navigationController pushViewController:newcard animated:YES];
    }
    
}


- (UIView *)createMainViewOne {
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 170+64)];
    mainView.backgroundColor = [UIColor whiteColor];
    UIImageView *back_img = [UIImageView new];
    [mainView addSubview:back_img];
    back_img.image = IMG(@"mine_back");
    [back_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(mainView);
        make.bottom.equalTo(mainView.mas_bottom).offset(-58);
    }];
    UILabel *titleLab = [UILabel lableWithText:@"我的" Font:FONT_ArialMT(18) TextColor:[UIColor whiteColor]];
    [mainView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(mainView.mas_centerX);
        make.height.equalTo(@(18));
        make.top.equalTo(mainView.mas_top).offset(33);
    }];
    if ([[UserData currentUser].isPartner integerValue]!=1) {
        UIButton *right_f = [UIButton buttonWithTitle:@"加入合伙人" andFont:FONT_ArialMT(13) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:nil andHighlightedImage:nil];
        [right_f setImage:IMG(@"mine_join") forState:UIControlStateNormal];
        right_f.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        right_f.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [right_f addTarget:self action:@selector(right_f_Action:) forControlEvents:UIControlEventTouchUpInside];
        [mainView addSubview:right_f];
        [right_f mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(90));
            make.height.equalTo(@(20));
            make.right.equalTo(mainView.mas_right).offset(-10);
            make.centerY.equalTo(titleLab.mas_centerY);
        }];
        
    }
    
    UIImageView *infoView = [UIImageView new];
    [mainView addSubview:infoView];
    infoView.image = IMG(@"mine_info_back");
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(mainView);
        make.height.equalTo(@(68));
    }];
    
    for (NSInteger i=0; i<2; i++) {
        for (NSInteger j=0; j<2; j++) {
            float ww = (SCREEN_WIGHT-50)/2;
            float hh = 16;
            UIView *blank = [self getInfomationLabWithName:[self.nameArr objectAtIndex:2*i+j] imageName:[NSString stringWithFormat:@"mine_s_%ld", 2*i+j]];
            blank.frame = CGRectMake(12.5+(ww+25)*i, 22*j+20, ww, hh);
            
            [infoView addSubview:blank];
        }
    }
    
    
    _headerImgv = [UIImageView new];
    _headerImgv.userInteractionEnabled = YES;
    [mainView addSubview:_headerImgv];
    _headerImgv.backgroundColor = [UIColor whiteColor];
    _headerImgv.image = IMG(@"mine_user");
    [_headerImgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(60));
        make.left.equalTo(mainView.mas_left).offset(10);
        make.bottom.equalTo(infoView.mas_top).offset(-15);
    }];
//    UITapGestureRecognizer *changeHeader = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeHeaderAction:)];
//    [_headerImgv addGestureRecognizer:changeHeader];
    
    _nameLab = [UILabel lableWithText:[UserData currentUser].readName.length>0?[UserData currentUser].readName:@"未认证" Font:FONT_Helvetica(15) TextColor:[UIColor whiteColor]];
    [mainView addSubview:_nameLab];
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headerImgv.mas_right).offset(14);
        make.top.equalTo(_headerImgv.mas_top).offset(0);
        make.height.equalTo(@(15));
    }];
    _stastusLab = [UILabel lableWithText:@"您的等级:    普通会员" Font:FONT_ArialMT(12) TextColor:[UIColor colorWithR:253 G:183 B:173 A:1]];
    [mainView addSubview:_stastusLab];
    [_stastusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerImgv.mas_right).offset(14);
        make.top.equalTo(self.nameLab.mas_bottom).offset(14);
        make.height.equalTo(@(13));
    }];
    _phoneLab = [UILabel lableWithText:[NSString stringWithFormat:@"您的账号:    %@",[UserData currentUser].mobileNumber.length>0?[UserData currentUser].mobileNumber:@"未知"] Font:FONT_ArialMT(12) TextColor:[UIColor colorWithR:253 G:183 B:173 A:1]];
    [mainView addSubview:_phoneLab];
    [_phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerImgv.mas_right).offset(14);
        make.bottom.equalTo(self.headerImgv.mas_bottom).offset(-2);
        make.height.equalTo(@(13));
    }];
    
    UILabel *label = [UILabel lableWithText:@"创业合伙人可尊享" Font:FONT_ArialMT(12) TextColor:[UIColor colorWithR:253 G:183 B:173 A:1]];
    [mainView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(mainView.mas_right).offset(-15);
        make.height.equalTo(@(13));
        make.bottom.equalTo(_phoneLab.mas_bottom).offset(0);
    }];
    
    
    return mainView;
}
- (UIView *)createMainViewTwo {
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 90)];
    mainView.backgroundColor = [UIColor Grey_BackColor1];
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIGHT, 70)];
    contentView.backgroundColor = [UIColor whiteColor];
    [mainView addSubview:contentView];
    
    for (NSInteger i=0; i<4; i++) {
        JXButton *btn = [[JXButton alloc] initWithFrame:CGRectMake((SCREEN_WIGHT-240)/5+(((SCREEN_WIGHT-240)/5+60)*i), 10, 60, 50) withTitleFont:FONT_ArialMT(11)];
        [btn setTitleColor:[UIColor Grey_BackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:[self.nameArray1 objectAtIndex:i] forState:0];
        NSString *img = [NSString stringWithFormat:@"mine_%ld", i];
        [btn setImage:IMG(img) forState:0];
        [contentView addSubview:btn];
    }
    
    return mainView;
}


#pragma mark - CreateCellView
- (UIView *)getInfomationLabWithName:(NSString *)name imageName:(NSString *)count {
    UIView *tempView = [[UIView alloc] init];
    UIImageView *imgv = [UIImageView new];
    imgv.image = IMG(count);
    [tempView addSubview:imgv];
    [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(16));
        make.left.equalTo(tempView.mas_left);
        make.centerY.equalTo(tempView.mas_centerY);
    }];
    
    UILabel *content = [UILabel lableWithText:name Font:FONT_ArialMT(11) TextColor:[UIColor whiteColor]];
    [tempView addSubview:content];
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(tempView.mas_centerY);
        make.height.equalTo(@(11));
        make.left.equalTo(imgv.mas_right).offset(10);
        make.right.equalTo(tempView.mas_right);
    }];
    
    return tempView;
}

#pragma mark - Action
- (void)right_f_Action:(UIButton *)sender {
    JoinParterViewController *join = [JoinParterViewController new];
    [self.navigationController pushViewController:join animated:YES];
}

//- (void)changeHeaderAction:(UITapGestureRecognizer *)sender {
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"更换照片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    UIAlertAction *cerma = [UIAlertAction actionWithTitle:@"照相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//    }];
//    UIAlertAction *photo = [UIAlertAction actionWithTitle:@"本地相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//    }];
//    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//    }];
//    [cerma setValue:[UIColor mianColor:1] forKey:@"titleTextColor"];
//    [alert addAction:cerma];
//    [alert addAction:photo];
//    [alert addAction:cancel];
//
//    [self presentViewController:alert animated:YES completion:nil];
//}
    
- (void)titleButtonClick:(UIButton *)sender {
    if ([sender.currentTitle isEqualToString:@"分享推广"]) {
        [SharePopView addSharePopViewTo:self];
    }
    if ([sender.currentTitle isEqualToString:@"常见问题"]) {
        FAQViewController *faq = [FAQViewController new];
        [self.navigationController pushViewController:faq animated:YES];
    }
    if ([sender.currentTitle isEqualToString:@"我的费率"]) {
        MyRateViewController *faq = [MyRateViewController new];
        [self.navigationController pushViewController:faq animated:YES];
    }
    if ([sender.currentTitle isEqualToString:@"我的结算卡"]) {
        [[UtilsData sharedInstance] certificateController:self success:^{
            CardInformationViewController *bind = [CardInformationViewController new];
            [self.navigationController pushViewController:bind animated:YES];
        }];
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
