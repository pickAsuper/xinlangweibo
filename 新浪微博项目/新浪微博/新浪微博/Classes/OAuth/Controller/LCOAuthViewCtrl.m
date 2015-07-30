//
//  LCOAuthViewCtrl.m
//  新浪微博
//
//  Created by lichao on 15/7/30.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "LCOAuthViewCtrl.h"
//appKey
#define Client_id
// 请求回调地址
#define Redirect_uri
@interface LCOAuthViewCtrl ()<UIWebViewDelegate>

@end

@implementation LCOAuthViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
   UIWebView *webview = [[UIWebView alloc]initWithFrame:self.view.bounds];
    
    webview.delegate =self;
    
    [self.view addSubview:webview];
//    2914063897
    //.weibo.com/oauth2/authorize?client_id=123050457758183&redirect_uri=p://www.example.com/response&response_type=code
    NSString *str =[NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=2914063897&redirect_uri=http://weibo.com/u/5386939902/home?leftnav=1"];
    NSURL *url =[NSURL URLWithString:str];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [webview loadRequest:request];
    
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSLog(@"%@",request.URL.absoluteString);
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
