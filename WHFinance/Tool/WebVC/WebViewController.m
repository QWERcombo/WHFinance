//
//  WebViewController.m
//  XiYouPartner
//
//  Created by 265G on 15/8/11.
//  Copyright (c) 2015年 YXCompanion. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
@property (nonatomic,strong)UIWebView *webView;

@end

@implementation WebViewController

-(void)viewWillDisappear:(BOOL)animated
{
//http://blog.csdn.net/lwjok2007/article/details/47058101
    [self.webView stopLoading];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[UIWebView alloc]init];
    self.webView.delegate = self;
    self.webView.allowsInlineMediaPlayback = NO;
    [self.view addSubview:self.webView];
    [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(self.view.mas_height);
    }];
    
    if (self.urlStr != nil)
    {
        NSLog(@"网页链接：%@",self.urlStr);
        NSURL *url = [[NSURL alloc]initWithString:self.urlStr];
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:15];
        [self.webView loadRequest:request];
    }
    else{
        [[UtilsData sharedInstance]showAlertTitle:@"网页链接异常" detailsText:nil time:1.5 aboutType:MBProgressHUDModeIndeterminate state:NO];
    }
    
    
}


- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)web{
    
    NSLog(@"webViewDidFinishLoad");
}

-(void)webView:(UIWebView*)webView  DidFailLoadWithError:(NSError*)error{
    
    NSLog(@"DidFailLoadWithError");
}

//实现WebView的代理方法，并在此函数中调用SDK的webviewStartLoadWithRequest:传入request参数，进行统计
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
//    [[BaiduMobStat defaultStat] webviewStartLoadWithRequest:request];
    return YES;
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
