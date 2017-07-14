//
//  CertificatePhotoViewController.m
//  WHFinance
//
//  Created by 赵越 on 2017/7/2.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "CertificatePhotoViewController.h"

@interface CertificatePhotoViewController ()
@property (nonatomic, strong) NSArray *nameArr;
@property (nonatomic, strong) NSArray *detailArr;
@property (nonatomic, strong) UIImage *identi_ahead, *identi_tail;//身份证正面  手持身份证
@property (nonatomic, strong) UIImage *credit, *handheld;//付款人信用卡  付款人身份证
@property (nonatomic, strong) NSMutableArray *selectPhotoArr;//传回上个页面的照片数组
@end

@implementation CertificatePhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"实名认证";
    self.nameArr = @[@"身份证正面",@"手持身份证照片",@"付款信用卡",@"付款人身份证照片"];
    self.detailArr = @[@[@"身份证照片要求：",@"1.请按照示例图提交身份证照片；\n\n2.照片需要清晰标识身份证上的相片、身份证号码和证件有效期。"],@[@"身份证照片要求：",@"1.请按照实例图提交身份证照片；\n\n2.照片需要清晰标识身份证上的相片、身份证号码和证件有效期。"],@[@"照片要求：",@"1.请按照示例提交手持信用卡半身照片；\n\n2.照片需露出头、肩膀、手臂以及卡片内容清晰可辨认。"],@[@"照片要求：",@"1.请按照示例提交储蓄卡信用卡照片；\n\n2.拍摄时请将储蓄卡和信用卡上下放置拍摄于同一张照片内，确保边框完整、字体清晰。"]];
    self.selectPhotoArr = [NSMutableArray array];
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


- (UIView *)createMainView {
    UIView *mainView = [[UIView alloc] initWithFrame:self.view.bounds];
    mainView.backgroundColor = [UIColor whiteColor];
    UIView *top = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 10)];
    top.backgroundColor = [UIColor Grey_BackColor1];
    [mainView addSubview:top];
    
    UILabel *hint = [UILabel lableWithText:@"请拍照" Font:FONT_ArialMT(18) TextColor:[UIColor mianColor:2]];
    [mainView addSubview:hint];
    [hint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(18));
        make.centerX.equalTo(mainView.mas_centerX);
        make.top.equalTo(mainView.mas_top).offset(25);
    }];
    
    float ww = (SCREEN_WIGHT-65)/2;
    float hh = 250/2;
    for (NSInteger j=0; j<2; j++) {
        
        NSString *tempstr = @"";
        if ([self.fromController isEqualToString:@"no_card"]) {
            tempstr = [self.nameArr objectAtIndex:j+2];
        } else {
            tempstr = [self.nameArr objectAtIndex:j];
        }
        
        UIView *blank = [self createCellViewWithImage:IMG(@"") andTittle:tempstr];
        blank.tag = 1000+j;
        blank.frame = CGRectMake(25+(ww+15)*j, 60, ww, hh);
        [mainView addSubview:blank];
        
        UITapGestureRecognizer *blankTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blankTapAction:)];
        [blank addGestureRecognizer:blankTap];
    }
    
    
    UIButton *doneBtn = [UIButton buttonWithTitle:@"提交" andFont:FONT_ArialMT(18) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:IMG(@"") andHighlightedImage:IMG(@"")];
    doneBtn.layer.cornerRadius = 5;
    doneBtn.clipsToBounds = YES;
    doneBtn.backgroundColor = [UIColor mianColor:1];
    [doneBtn addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
    doneBtn.frame = CGRectMake(15, 210, SCREEN_WIGHT-30, 40);
    [mainView addSubview:doneBtn];
    
    
    UIButton *nextBtn = [UIButton buttonWithTitle:@"稍后再提交照片" andFont:FONT_ArialMT(14) andtitleNormaColor:[UIColor Grey_OrangeColor] andHighlightedTitle:[UIColor Grey_OrangeColor] andNormaImage:nil andHighlightedImage:nil];
    [mainView addSubview:nextBtn];
    [nextBtn addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(14));
        make.centerX.equalTo(mainView.mas_centerX);
        make.top.equalTo(doneBtn.mas_bottom).offset(15);
    }];
    
    UILabel *detailLab = [UILabel lableWithText:@"说明:\n1.500元以上交易，需要提交认证照片后才能到账\n2.500以下交易正常到账" Font:FONT_ArialMT(14) TextColor:[UIColor mianColor:2]];
    detailLab.numberOfLines = 0;
    [mainView addSubview:detailLab];
    [detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(150));
        make.width.equalTo(@(SCREEN_WIGHT-40));
        make.top.equalTo(nextBtn.mas_bottom).offset(35);
        make.centerX.equalTo(mainView.mas_centerX);
    }];
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
    para.lineSpacing = 5;
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:detailLab.text];
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor Grey_OrangeColor] range:NSMakeRange(0, 3)];
    [attStr addAttribute:NSParagraphStyleAttributeName value:para range:NSMakeRange(0, detailLab.text.length)];
    detailLab.attributedText = attStr;
    
    
    return mainView;
}

- (UIView *)createCellViewWithImage:(UIImage *)image andTittle:(NSString *)tittle {//缩略图
    
    float ww = (SCREEN_WIGHT-65)/2;
    float hh = 250/2;
    UIView *blank = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ww, hh)];
    
    UIImageView *imgv = [UIImageView new];
    imgv.contentMode = UIViewContentModeScaleAspectFill;
    [blank addSubview:imgv];
    imgv.backgroundColor = COLOR_TEMP;
    imgv.image = image;
    [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(blank);
        make.height.equalTo(@(210/2));
    }];
    
    UILabel *title = [UILabel lableWithText:tittle Font:FONT_ArialMT(12) TextColor:[UIColor mianColor:2]];
    title.backgroundColor = [UIColor Grey_BackColor];
    title.textColor = [UIColor whiteColor];
    [blank addSubview:title];
    title.textAlignment = NSTextAlignmentCenter;
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgv.mas_bottom);
        make.left.bottom.right.equalTo(blank);
    }];
    
    return blank;
}
- (UIView *)createDetailViewWith:(UIImage *)image andTitle:(NSString *)title detailContent:(NSArray *)contentArr {
    UIView *mainView = [[UIView alloc] initWithFrame:MY_WINDOW.bounds];
    mainView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    mainView.tag = 1024;
    
    UIView *content = [UIView new];
    content.backgroundColor = [UIColor whiteColor];
    content.layer.cornerRadius = 15;
    content.clipsToBounds = YES;
    [mainView addSubview:content];
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(mainView);
        make.width.equalTo(@(SCREEN_WIGHT-25));
        make.height.equalTo(@(450));
    }];
    
    UILabel *hint = [UILabel lableWithText:title Font:FONT_ArialMT(15) TextColor:[UIColor Grey_WordColor]];
    [content addSubview:hint];
    [hint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(15));
        make.centerX.equalTo(content.mas_centerX);
        make.top.equalTo(content.mas_top).offset(25/2);
    }];
    UIView *line = [UIView new];
    [content addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(1));
        make.width.equalTo(@(SCREEN_WIGHT-25));
        make.top.equalTo(hint.mas_bottom).offset(12.5);
    }];
    UILabel *label = [UILabel lableWithText:@"示例图" Font:FONT_ArialMT(11) TextColor:[UIColor Grey_WordColor]];
    [content addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(10);
        make.height.equalTo(@(11));
        make.centerX.equalTo(content.mas_centerX);
    }];
    
    UIImageView *imgview = [UIImageView new];
    imgview.backgroundColor = COLOR_TEMP;
    imgview.image = image;
    [content addSubview:imgview];
    [imgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(590/2));
        make.height.equalTo(@(376/2));
        make.centerX.equalTo(content.mas_centerX);
        make.top.equalTo(line.mas_bottom).offset(37);
    }];
    
    
    UILabel *titlelab = [UILabel lableWithText:[contentArr firstObject] Font:FONT_ArialMT(15) TextColor:[UIColor Grey_WordColor]];
    [content addSubview:titlelab];
    [titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(content.mas_left).offset(55/2);
        make.height.equalTo(@(15));
        make.top.equalTo(imgview.mas_bottom).offset(15);
    }];
    UILabel *detailLab = [UILabel lableWithText:[contentArr lastObject] Font:FONT_ArialMT(12) TextColor:[UIColor mianColor:2]];
    detailLab.numberOfLines = 0;
    [content addSubview:detailLab];
    [detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titlelab.mas_bottom).offset(15);
        make.centerX.equalTo(content.mas_centerX);
        make.width.equalTo(@(SCREEN_WIGHT-55));
    }];
    
    UIButton *doneBtn = [UIButton buttonWithTitle:@"知道了，我要上传图片" andFont:FONT_ArialMT(18) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:IMG(@"") andHighlightedImage:IMG(@"")];
    doneBtn.backgroundColor = [UIColor mianColor:1];
    [doneBtn addTarget:self action:@selector(buttonCliked:) forControlEvents:UIControlEventTouchUpInside];
    doneBtn.tag = [self.nameArr indexOfObject:title]+2000;
    [content addSubview:doneBtn];
    [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(40));
        make.left.equalTo(content.mas_left).offset(27.5);
        make.right.equalTo(content.mas_right).offset(-27.5);
        make.top.equalTo(detailLab.mas_bottom).offset(20);
    }];
    
    
    UITapGestureRecognizer *mainTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mainTapAction:)];
    [mainView addGestureRecognizer:mainTap];
    return mainView;
}


#pragma mark - Action
- (void)doneAction:(UIButton *)sender {//完成
//    NSLog(@"%@--%@--%@--%@", self.identi_ahead,self.identi_tail,self.credit,self.handheld);
    if ([self.fromController isEqualToString:@"no_card"]) {//传回无卡支付信息页面
        //调用block
        _ReturnPhotoBlock(self.selectPhotoArr);
        [self.navigationController popViewControllerAnimated:YES];
        
    } else {//实名认证提交照片
        [[UtilsData sharedInstance] showAlertTitle:@"提交成功" detailsText:@"等待审核" time:2 aboutType:MBProgressHUDModeCustomView state:YES];
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
        // identityF   onHand
        [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"identityF":[[PublicFuntionTool sharedInstance] getBase64StringFrom:self.identi_ahead],@"onHand":[[PublicFuntionTool sharedInstance] getBase64StringFrom:self.identi_tail],@"userToken":[UserData currentUser].userToken}] forKey:@"user.uploadRealNamePic"];
        NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
        [dict setObject:json forKey:@"key"];
        
        [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
            NSLog(@"%@",resultDic);
            
        } failure:^(NSString *error, NSInteger code) {
            
        }];
    }
    
}
- (void)blankTapAction:(UITapGestureRecognizer *)sender {//点击事件
    NSString *title = @"";
    NSArray *detailArr = [NSArray array];
    if ([self.fromController isEqualToString:@"no_card"]) {
        title = [self.nameArr objectAtIndex:sender.view.tag-998];
        detailArr = [self.detailArr objectAtIndex:sender.view.tag-998];
    } else {
        title = [self.nameArr objectAtIndex:sender.view.tag-1000];
        detailArr = [self.detailArr objectAtIndex:sender.view.tag-1000];
    }
//    NSLog(@"%@", [self.nameArr objectAtIndex:sender.view.tag-1000]);
    UIView *back = [self createDetailViewWith:IMG(@"") andTitle:title detailContent:detailArr];
    
    [MY_WINDOW addSubview:back];
}
- (void)mainTapAction:(UITapGestureRecognizer *)sender {
    UIView *bbb = [MY_WINDOW viewWithTag:1024];
    [bbb removeFromSuperview];
}

- (void)buttonCliked:(UIButton *)sender {
    NSLog(@"%ld", sender.tag);
    UIView *bbb = [MY_WINDOW viewWithTag:1024];
    [bbb removeFromSuperview];
    
    ZZCameraController *cameraController = [[ZZCameraController alloc]init];
    cameraController.takePhotoOfMax = 1;
    cameraController.isSaveLocal = YES;
    [cameraController showIn:self result:^(id responseObject){
        ZZCamera *camera = (ZZCamera *)[responseObject firstObject];
        NSInteger jj;
        if ([self.fromController isEqualToString:@"no_card"]) {
            jj = sender.tag-2002;
        } else {
            jj = sender.tag-2000;
        }
        
        switch (jj) {
            case 0:
                if ([self.fromController isEqualToString:@"no_card"]) {
                    self.identi_ahead = camera.image;//信用卡正面
                    [self.selectPhotoArr addObject:camera.image];
                } else {
                    self.identi_ahead = camera.image;//身份证正面
                }
                break;
            case 1:
                if ([self.fromController isEqualToString:@"no_card"]) {
                    self.identi_tail = camera.image;//信用卡手持身份证
                    [self.selectPhotoArr addObject:camera.image];
                } else {
                    self.identi_tail = camera.image;//身份证
                }
                break;
                
            default:
                break;
                
        }
        
        UIView *blank = [self.fromController isEqualToString:@"no_card"]?[self.view viewWithTag:sender.tag-1002]:[self.view viewWithTag:sender.tag-1000];
        for (UIView *suib in blank.subviews) {
            if ([suib isKindOfClass:[UIImageView class]]) {
                UIImageView *subImgv = (UIImageView *)suib;
                subImgv.contentMode = UIViewContentModeScaleAspectFill;
                subImgv.clipsToBounds = YES;
                subImgv.image = camera.image;
            }
        }
        
        
        
        NSLog(@"%@", responseObject);
    }];
}


- (void)nextAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
