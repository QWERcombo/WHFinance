//
//  SharePopView.m
//  WHFinance
//
//  Created by wanhong on 2017/7/11.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "SharePopView.h"

@interface SharePopView ()
@property (nonatomic, strong) BaseViewController *rootVC;//跟控制器

@end

#define Item_WIdth ((SCREEN_WIGHT-83)/4)
@implementation SharePopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *back = [[UIView alloc] initWithFrame:MY_WINDOW.bounds];
        back.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [self addSubview:back];
        
        UIView *content = [UIView new];
        [back addSubview:content];
        content.backgroundColor = [UIColor whiteColor];
        [content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(80));
            make.center.equalTo(back);
            make.width.equalTo(@(SCREEN_WIGHT-80));
        }];
        
        
        NSArray *arr = @[@"微信好友",@"微信朋友圈",@"QQ好友",@"QQ空间"];
        for (NSInteger i=0; i<4; i++) {
            
            JXButton *button = [[JXButton alloc] initWithFrame:CGRectMake((Item_WIdth+1)*i, 12.5, Item_WIdth , 55) withTitleFont:FONT_ArialMT(13)];
            button.tag = 100+i;
            [button setTitle:[arr objectAtIndex:i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor Black_WordColor] forState:UIControlStateNormal];
            NSString *img = [NSString stringWithFormat:@"share_%ld", i];
            [button setImage:IMG(img) forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [content addSubview:button];
            
        }
        
        
        UITapGestureRecognizer *removeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(remoTapAction:)];
        [back addGestureRecognizer:removeTap];
    }
    return self;
}

- (void)buttonClick:(UIButton *)sender {//分享操作
    UMSocialPlatformType type=-1;
    switch (sender.tag-100) {
        case 0:
            type = UMSocialPlatformType_WechatSession;//朋友
            break;
        case 1:
            type = UMSocialPlatformType_WechatTimeLine;//朋友圈
            break;
        case 2:
            type = UMSocialPlatformType_QQ;//QQ
            break;
        case 3:
            type = UMSocialPlatformType_Qzone;//空间
            break;
        default:
            break;
    }
    [self removeFromSuperview];
    [[PublicFuntionTool sharedInstance] uMengShareWithObject:type andBaseController:self.rootVC];
    
}
- (void)remoTapAction:(UITapGestureRecognizer *)sender {
    [self removeFromSuperview];
}

+ (void)addSharePopViewTo:(BaseViewController *)controller {
    SharePopView *share = [[SharePopView alloc] initWithFrame:MY_WINDOW.bounds];
    share.rootVC = controller;
    
    [MY_WINDOW addSubview:share];
}

@end
