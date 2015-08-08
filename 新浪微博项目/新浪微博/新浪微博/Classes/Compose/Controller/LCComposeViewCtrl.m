//
//  LCComposeViewCtrl.m
//  新浪微博
//
//  Created by lichao on 15/8/7.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "LCComposeViewCtrl.h"
#import "LCAccountTool.h"
#import "LCOauth.h"
#import "LCTextView.h"

@interface LCComposeViewCtrl ()<UITextViewDelegate>

@end

@implementation LCComposeViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
   // self.view.backgroundColor =randomColor;
    
    
    [self setupNav];
    
   //创建占位文字
    LCTextView *textView =[[LCTextView alloc]initWithFrame:self.view.bounds];
    textView.font =SYS_FONT(16);
    textView.placehoder =@"每当我错过一个女孩的时候,我就向山上放一块砖,于是就有了长城";
    textView.delegate =self;
    [self.view addSubview:textView];
    
    
    
    
    
    
}

-(void)setupNav{
    //导航栏左右按钮
    self.navigationItem.leftBarButtonItem =[UIBarButtonItem itemWithTitel:@"返回" target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem =[UIBarButtonItem itemWithTitel:@"发送" target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled =NO;
    
    
    
//  导航栏中间按钮
    
    UILabel *titelLabel =[[UILabel alloc]init] ;
    titelLabel.numberOfLines =0;
    titelLabel.textAlignment =NSTextAlignmentCenter;
    
    NSString *preStr = @"发微博";
    
    //解档里面取出值来
    NSString *screen_name = [LCAccountTool AccountOpen].screen_name;
    
    NSString *fullString =nil;
    
    if (screen_name.length) {
        fullString =[NSString stringWithFormat:@"%@\n%@",preStr,screen_name];
        
    }else{
        fullString =[NSString stringWithFormat:@"%@",preStr];
    }
    //初始化一个属性文字
    NSMutableAttributedString *attributedStr =[[NSMutableAttributedString alloc]initWithString:fullString];

//    设置属性文字的大小
   NSRange preRange = NSMakeRange(0,fullString.length);
  [attributedStr addAttribute:NSFontAttributeName value:SYS_FONT(16) range:preRange];

    // screen_name 在 LCHomeVirewController 里面的获取用户信息那里去设置保存的
   NSRange nameRange = [fullString rangeOfString:screen_name];
    if (nameRange.location !=NSNotFound) {
        [attributedStr addAttribute:NSFontAttributeName value:SYS_FONT(14) range:nameRange];
        
        [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:nameRange];
        //设置让titleLabel显示带有属性的文字
        titelLabel.attributedText =attributedStr;
        [titelLabel sizeToFit];
        self.navigationItem.titleView =titelLabel;
        
        
    }
    


}


-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];

}
-(void)send{

    NSLog(@"send");


}
-(void)textViewDidChange:(UITextView *)textView{
  self.navigationItem.rightBarButtonItem.enabled = textView.text.length;
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
