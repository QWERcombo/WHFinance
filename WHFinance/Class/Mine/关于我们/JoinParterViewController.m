//
//  JoinParterViewController.m
//  WHFinance
//
//  Created by wanhong on 2017/7/7.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "JoinParterViewController.h"
#import "JoinParterPayWayCell.h"
#import "PayWaysViewController.h"
#import "NoCardPayViewController.h"

@interface JoinParterViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger lastSelectNum;
@end

@implementation JoinParterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"加入合伙人";
    NSArray *arr = @[@"无卡支付",@"微信支付",@"支付宝支付"];
    self.dataMuArr = [NSMutableArray arrayWithArray:arr];
    
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
    return [self createMainView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.view.size.height;
}

- (UIView *)createMainView  {
    UIView *mainView = [[UIView alloc] initWithFrame:self.view.bounds];
    UIView *content = [UIView new];
    [mainView addSubview:content];
    content.backgroundColor = [UIColor colorWithR:245 G:237 B:232 A:1];
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(mainView);
    }];
    UIImageView *backImgv = [[UIImageView alloc] init];
    backImgv.image = IMG(@"join_parter");
    [content addSubview:backImgv];
    [backImgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(content);
        make.bottom.equalTo(content.mas_bottom).offset(-90);
    }];
    
    
    UIView *payView = [UIView new];
    [content addSubview:payView];
    payView.tag = 666;
    [payView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(content.mas_left).offset(15);
        make.right.equalTo(content.mas_right).offset(-15);
        make.centerX.equalTo(content.mas_centerX);
        make.top.equalTo(backImgv.mas_bottom).offset(7);
        make.height.equalTo(@(30));
    }];
    
    UILabel *hint = [UILabel lableWithText:@"支付方式: " Font:FONT_BoldMT(11) TextColor:[UIColor mianColor:2]];
    [payView addSubview:hint];
    [hint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(11));
        make.left.equalTo(payView.mas_left).offset(25);
        make.centerY.equalTo(payView.mas_centerY);
    }];
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[JoinParterPayWayCell class] forCellWithReuseIdentifier:@"collect"];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [payView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(30));
        make.left.equalTo(hint.mas_right).offset(5);
        make.right.equalTo(payView.mas_right);
        make.centerY.equalTo(payView.mas_centerY);
    }];
    
    
    UIButton *button = [UIButton buttonWithTitle:@"点击支付 成为创业合伙人" andFont:FONT_BoldMT(18) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:nil andHighlightedImage:nil];
    button.tag = 1004;
    button.backgroundColor = [UIColor mianColor:1];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [content addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(35));
        make.bottom.equalTo(content.mas_bottom).offset(-12.5);
        make.width.equalTo(@(SCREEN_WIGHT-15));
        make.centerX.equalTo(content.mas_centerX);
    }];
    
    return mainView;
}

#pragma mark - UICollectionView
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JoinParterPayWayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collect" forIndexPath:indexPath];
    [cell loadData:[self.dataMuArr objectAtIndex:indexPath.row] andCliker:^(NSString *clueStr) {
        
    }];
    if (indexPath.row==0) {
        cell.typeImgv.image = IMG(@"join_select_0");
    } else {
        NSString *img = [NSString stringWithFormat:@"join_pay_%ld", indexPath.row];
        cell.typeImgv.image = IMG(img);
    }
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataMuArr.count;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    JoinParterPayWayCell *cell = (JoinParterPayWayCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.nameLab.textColor = [UIColor Grey_OrangeColor];
    NSString *select_img = [NSString stringWithFormat:@"join_select_%ld", indexPath.row];
    cell.typeImgv.image = IMG(select_img);
    
    //取消之前的选中
    NSIndexPath *index = [NSIndexPath indexPathForRow:self.lastSelectNum inSection:0];
    JoinParterPayWayCell *lastcell = (JoinParterPayWayCell *)[collectionView cellForItemAtIndexPath:index];
    lastcell.nameLab.textColor = [UIColor mianColor:2];
    NSString *img = [NSString stringWithFormat:@"join_pay_%ld", index.row];
    lastcell.typeImgv.image = IMG(img);
    
    self.lastSelectNum = indexPath.row;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = [UILabel getSizeWithText:[self.dataMuArr objectAtIndex:indexPath.row] andFont:FONT_ArialMT(10) andSize:CGSizeMake(0, 20)];
    
    return CGSizeMake(size.width+25, 20);
}


// 65500微信 65501支付宝
- (void)buttonClick:(UIButton *)sender {
    NSLog(@"%@", [self.dataMuArr objectAtIndex:self.lastSelectNum]);
    
    PayWaysViewController *pay = [PayWaysViewController new];
    if (self.lastSelectNum ==1) {//微信
        pay.mainColor = [UIColor colorWithR:77 G:168 B:65 A:1];
        pay.payWay = @"0";
        pay.proudctDetailId = @"65500";
    } else if (self.lastSelectNum==2) {//支付宝
        pay.mainColor = [UIColor colorWithR:85 G:166 B:229 A:1];
        pay.payWay = @"2";
        pay.proudctDetailId = @"65501";
    } else if (self.lastSelectNum==0) {//银联
        NoCardPayViewController *no = [NoCardPayViewController new];
        no.isPartner = @"yes";
        no.cashCount = @"399";
        [self.navigationController pushViewController:no animated:YES];
        return;
    } else {
        
    }
    pay.navIMG = [UIImage imageWithColor:pay.mainColor];
    pay.moneyStr = @"399";
    [self.navigationController pushViewController:pay animated:YES];
    
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
