//
//  NoCardInfamationViewController.m
//  WHFinance
//
//  Created by wanhong on 2017/7/11.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "NoCardInfamationViewController.h"
#import "CertificatePhotoViewController.h"

@interface NoCardInfamationViewController (){
    UIImageView *leftImg;//付款人信用卡
    UIImageView *rightImg;//付款人身份证
    UIImageView *backImgv;
}

@end

@implementation NoCardInfamationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"提交无卡交易资料";
    [self.dataMuArr addObjectsFromArray:@[@"收款人:",@"金    额:",@"时    间:",@"付款人:",@"卡    号:",@"原    因:"]];
    
    
    [self setUpSubViews];
}


- (void)setUpSubViews {
    self.view.backgroundColor = [UIColor Grey_BackColor1];
    
    UIView *content = [UIView new];
    content.layer.cornerRadius = 10;
    content.clipsToBounds = YES;
    content.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:content];
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(60);
        make.width.equalTo(@(SCREEN_WIGHT-30));
        make.height.equalTo(@(674/2));
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    
    UIView *topView = [UIView new];
    topView.backgroundColor = [UIColor colorWithR:220 G:221 B:222 A:1];
    [content addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(content);
        make.height.equalTo(@(45));
    }];
    UILabel *hint = [UILabel lableWithText:@"请拍照" Font:FONT_ArialMT(15) TextColor:[UIColor mianColor:1]];
    [topView addSubview:hint];
    [hint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(15));
        make.centerX.equalTo(topView.mas_centerX);
        make.centerY.equalTo(topView.mas_centerY);
    }];
    
    NSArray *tempArr = @[@"张三",@"￥558.00",@"2017-07-06 20:20:20",@"李四",@"626565658545454545",@"请上传照片"];
    UIView *lastView = nil;
    for (NSInteger i=0; i<6; i++) {
        UIView *blank = [UIView new];
        [content addSubview:blank];
        [blank mas_makeConstraints:^(MASConstraintMaker *make) {
            if (lastView) {
                make.top.equalTo(lastView.mas_bottom).offset(8);
            } else {
                make.top.equalTo(topView.mas_bottom).offset(15);
            }
            make.left.equalTo(content.mas_left).offset(34);
            make.height.equalTo(@(12));
            make.right.equalTo(content.mas_right).offset(-34);
        }];
        
        UILabel *leftLab = [UILabel lableWithText:[self.dataMuArr objectAtIndex:i] Font:FONT_ArialMT(12) TextColor:[UIColor Grey_BackColor]];
        [blank addSubview:leftLab];
        [leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(blank.mas_centerY);
            make.left.equalTo(blank.mas_left);
            make.height.equalTo(@(15));
        }];
        if (i==5) {
            leftLab.textColor = [UIColor mianColor:1];
        }
        UILabel *rightLab = [UILabel lableWithText:[tempArr objectAtIndex:i] Font:FONT_ArialMT(12) TextColor:[UIColor Grey_BackColor]];
        [blank addSubview:rightLab];
        [rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftLab.mas_right).offset(10);
            make.centerY.equalTo(blank.mas_centerY);
            make.height.equalTo(@(15));
        }];
        if (i==1 || i==3 || i==4 ||i==5) {
            rightLab.textColor = [UIColor mianColor:1];
        }
        
        
        lastView = blank;
    }
    
    
    UIView *photoView = [UIView new];
    [content addSubview:photoView];
    [photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(content.mas_left).offset(34);
        make.right.equalTo(content.mas_right).offset(-34);
        make.top.equalTo(lastView.mas_bottom).offset(15);
        make.height.equalTo(@(67));
    }];
    
    leftImg = [UIImageView new];
    [photoView addSubview:leftImg];
    leftImg.contentMode = UIViewContentModeScaleAspectFill;
    leftImg.clipsToBounds = YES;
    [leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(photoView.mas_top).offset(5);
        make.left.equalTo(photoView.mas_left).offset(5);
        make.bottom.equalTo(photoView.mas_bottom).offset(-5);
        make.width.equalTo(@((SCREEN_WIGHT-118)/2));
    }];
    rightImg = [UIImageView new];
    [photoView addSubview:rightImg];
    rightImg.contentMode = UIViewContentModeScaleAspectFill;
    rightImg.clipsToBounds = YES;
    [rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(photoView.mas_top).offset(5);
        make.left.equalTo(leftImg.mas_right).offset(10);
        make.bottom.equalTo(photoView.mas_bottom).offset(-5);
        make.width.equalTo(@((SCREEN_WIGHT-118)/2));
    }];
    
    backImgv = [UIImageView new];
    [photoView addSubview:backImgv];
    backImgv.image = IMG(@"no_card_infa");
    [backImgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(photoView);
    }];
    
    UITapGestureRecognizer *imgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPhotoTap:)];
    [photoView addGestureRecognizer:imgTap];
    
    
    
    
    UIButton *button = [UIButton buttonWithTitle:@"确定" andFont:FONT_ArialMT(18) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:nil andHighlightedImage:nil];
    button.backgroundColor = [UIColor mianColor:1];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [content addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(content);
        make.height.equalTo(@(45));
    }];
    
    UILabel *bottomHint = [UILabel lableWithText:@"温馨提示:\n\n为确保持卡人的资金安全，首次交易需要拍摄持卡人的身份证和信用卡照片，第二次交易无需再提交" Font:FONT_ArialMT(12) TextColor:[UIColor mianColor:2]];
    [self.view addSubview:bottomHint];
    bottomHint.numberOfLines = 0;
    [bottomHint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(25);
        make.right.equalTo(self.view.mas_right).offset(-25);
        make.top.equalTo(content.mas_bottom).offset(15);
    }];
    NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc] initWithString:bottomHint.text];
    NSMutableParagraphStyle *para = [NSMutableParagraphStyle new];
    para.lineSpacing = 5;
    para.alignment = NSTextAlignmentLeft;  //对齐
    para.headIndent = 0.0f;//行首缩进
    //参数：（字体大小17号字乘以2，34f即首行空出两个字符）
    CGFloat emptylen = bottomHint.font.pointSize * 2;
    para.firstLineHeadIndent = emptylen;//首行缩进
    [attstr addAttribute:NSFontAttributeName value:FONT_ArialMT(14) range:NSMakeRange(0, 5)];
    [attstr addAttribute:NSForegroundColorAttributeName value:[UIColor mianColor:1] range:NSMakeRange(0, 5)];
    [attstr addAttribute:NSParagraphStyleAttributeName value:para range:NSMakeRange(1, bottomHint.text.length-1)];
    
    
    
    bottomHint.attributedText = attstr;
    
}


- (void)buttonClick:(UIButton *)sender {
    NSLog(@"确定提交");
//    key={"transqury.uploadAnotherPersonCardInfoAuditingPic":{"cardInfoId":"47","userToken":"f600b4330750acda03ad6a1bedeec3e2e29158033addc6e697890d3b268d6e1c","creditCardPic":"A","identityCardPic":"A","transOrderId":"178"}}
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"userToken":[UserData currentUser].userToken,@"creditCardPic":[[PublicFuntionTool sharedInstance] getBase64StringFrom:leftImg.image],@"identityCardPic":[[PublicFuntionTool sharedInstance] getBase64StringFrom:rightImg.image],@"transOrderId":self.orderID}] forKey:@"transqury.uploadAnotherPersonCardInfoAuditingPic"];
    NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
    [dict setObject:json forKey:@"key"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"---%@", resultDic);
        
        
    } failure:^(NSString *error, NSInteger code) {
        
        
    }];
    
}

- (void)addPhotoTap:(UITapGestureRecognizer *)sender {
    CertificatePhotoViewController *photo = [CertificatePhotoViewController new];
    photo.fromController = @"no_card";
    photo.ReturnPhotoBlock = ^(NSMutableArray *photoArr) {
//        NSLog(@"********%@", photoArr);
        [backImgv removeFromSuperview];
        leftImg.image = [photoArr firstObject];
        rightImg.image = [photoArr lastObject];
    };
    
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
