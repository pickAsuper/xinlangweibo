//
//  LCOAuthViewCtrl.m
//  新浪微博
//
//  Created by lichao on 15/7/30.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "LCOAuthViewCtrl.h"
#import "AFNetworking.h"
#import "LCOauth.h"
#import "LCTabBarController.h"

//appKey
#define Client_id @"2914063897"

//在新浪注册生成的client_secret
#define client_secret @"e1f26fae6da3a074bc9074e89d8f8749"

// 请求回调地址
#define Redirect_uri @"http://weibo.com/u/5386939902/home?leftnav=1"



@interface LCOAuthViewCtrl ()<UIWebViewDelegate>

@end

@implementation LCOAuthViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建一个webview
   UIWebView *webview = [[UIWebView alloc]initWithFrame:self.view.bounds];
    
    webview.delegate =self;
    
    [self.view addSubview:webview];
  
    // 2914063897  >>appkey
    //.weibo.com/oauth2/authorize?client_id=123050457758183&redirect_uri=p:www.example.com/response&response_type=code
    
    //发送get请求 >>加载到webview上显示
    NSString *str =[NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",Client_id,Redirect_uri];
    NSURL *url =[NSURL URLWithString:str];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [webview loadRequest:request];
    
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSLog(@"%@",request.URL.absoluteString);
    
    //通过request.URL.absoluteString 可以获取到 :
//htps://api.weibo.com/oauth2/authorize?client_id=2914063897&redirect_uri=htp://weibo.com/u/5386939902/home?leftnav=1
//  http://weibo.com/u/5386939902/home?leftnav=1&code=752487b0136740d40e2e478e96e7850c
   
     NSString *str =request.URL.absoluteString;
    //判断是否为回调页
    if ([str hasPrefix:Redirect_uri]) {
        NSString *testr =@"&code=";
       NSRange range = [str rangeOfString:testr];
        //不等于空 NSNotFound
        if (range.location != NSNotFound) {
           NSString *code = [str substringFromIndex:range.location+range.length];
         
            [self getAccessTonkeWithCode:code];
            return NO;
        }
    }

    return YES;
}

/**
 * 发送网络请求 post
 *
 *  @param code 截取的回调页 code
 */
-(void)getAccessTonkeWithCode:(NSString *)code{
    
//     //新浪官方要求 >> 复制自新浪网
//    HTTP请求方式
//    POST
//    请求参数
//    client_id		    申请应用时分配的AppKey。
//    client_secret		申请应用时分配的AppSecret。
//    grant_type		请求的类型，填写authorization_code
//    grant_type        为authorization_code时
//    code	true		调用authorize获得的code值。
//    redirect_uri	 	回调地址，需需与注册应用里的回调地址一致。
    
    NSString *postStr =@"https://api.weibo.com/oauth2/access_token";
    //创建请求管理者
    AFHTTPRequestOperationManager *maneger =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    dict[@"client_id"]= Client_id;
    dict[@"client_secret"] =client_secret;
    dict[@"grant_type"] =@"authorization_code";
    dict[@"code"] =code;
    dict[@"redirect_uri"] =Redirect_uri;
    // >>通过这个类去找到错误的地方 text/plain AFJSONResponseSerializer
    [maneger POST:postStr parameters:dict success:^(AFHTTPRequestOperation *op,id dict ) {
        
        NSLog(@"dict=%@",dict);
        //请求成功
        //字典转模型
        LCOauth *oauth =[[LCOauth alloc]init];
        [oauth setValuesForKeysWithDictionary:dict];
        
        //把模型归档保存
        NSString *pathField =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        //拼接一个路径 account.archiver
       pathField = [pathField stringByAppendingPathComponent:@"account.archiver"];
        
        //归档
        [NSKeyedArchiver archiveRootObject:oauth toFile:pathField];
        NSLog(@"pathFiel =%@",pathField);
       
        //创建根控制器
        LCTabBarController *tabvarCtr =[[LCTabBarController alloc]init];
       UIWindow *window = [UIApplication sharedApplication].keyWindow;
        window.rootViewController =tabvarCtr;
        
        
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        NSLog(@"%@",error);
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
