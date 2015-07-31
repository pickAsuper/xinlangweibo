//
//  LCHomeVirewController.m
//  新浪微博
//
//  Created by lichao on 15/7/27.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "LCHomeVirewController.h"
#import "LCHomeTitelBtn.h"
#import "SunView.h"
#import "LCPopView.h"
#import "LCOauth.h"
#import "LCAccountTool.h"
#import "AFNetworking.h"
#import "LCUser.h"
#import "MJExtension.h"

@interface LCHomeVirewController ()

@end

@implementation LCHomeVirewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
   
//    LCOauth *oauthq = [LCAccountTool AccountOpen];
//    NSLog(@"%@",oauthq.access_token);
//    NSLog(@"%@",oauthq.uid);
    
    //用户信息
    [self getUserData];

}
-(void)setupNav{
    //创建首页标题按钮
    LCHomeTitelBtn *titelBtn =[[LCHomeTitelBtn alloc]init];
    [titelBtn setTitle:@"首页" forState:UIControlStateNormal];
    [titelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [titelBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titelBtn sizeToFit];
   // NSLog(@"titelBtn = %f",titelBtn.centerX);
    
    
     //给中间按钮添加点击事件
    [titelBtn addTarget:self action:@selector(titelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //添加到中间标题
    self.navigationItem.titleView =titelBtn;
    
    
    
//设置左右按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_friendsearch" target:self action:@selector(barButtonClick)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_pop" target:self action:@selector(rightbarClick)];

}

-(void)barButtonClick{
   // NSLog(@"btn =%s",__func__);
    SunView *view =[[SunView alloc]init];
   
    
    [self.navigationController pushViewController:view animated:YES];
    
    
    
    
}

-(void)rightbarClick{
    //NSLog(@"right = %s",__func__);
  
}

//首页中间按钮的点击事件
-(void)titelBtnClick:(UIButton *)btn{
   
    UIView *view =[[UIView alloc]init];
    view.size = CGSizeMake(100, 100);
    view.backgroundColor =[UIColor blueColor];
  
    //当点击中间按钮的时候就创建一个按钮作为蒙版
    LCPopView *popView =[[LCPopView alloc]initWithCustomsView:view];

    //    设置背景图片
//    popView.backgroundColor =[UIColor redColor];
//    popView.alpha = 0.5;
    //添加到主窗口上 这个蒙版创建出来 是让用户不能和下面的控件进行交互
  //[[UIApplication sharedApplication].keyWindow addSubview:popView];
    
  // UIWindow *window=  [[UIApplication sharedApplication].windows lastObject];
    //[window addSubview:popView];
   
    [popView showFromView:btn];
    

}
-(void)getUserData{
    
    //NSString *str =@"https://api.weibo.com/2/users/show.json?access_token=2.009JDZsFbIHNLDd2f5f867cbUDEeUE&uid=5386939902";
   // 2.009JDZsFbIHNLDd2f5f867cbUDEeUE
//     5386939902
    
    NSString *str =@"https://api.weibo.com/2/users/show.json";
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    LCOauth *oauth = [LCAccountTool AccountOpen];
    dict[@"access_token"]=oauth.access_token;
    dict[@"uid"]=oauth.uid;
    
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    [manager POST:str parameters:dict success:^(AFHTTPRequestOperation * op, id asd) {
       // NSMutableDictionary *dic =[NSMutableDictionary dictionary];
        LCUser *userInfo =[LCUser new];
        
        //调用了第三方框架
        [userInfo setKeyValues:asd];
        
        LCHomeTitelBtn *homeTitel =(LCHomeTitelBtn *)self.navigationItem.titleView;
        [homeTitel setTitle:userInfo.screen_name forState:UIControlStateNormal];

    } failure:
    ^(AFHTTPRequestOperation *op, NSError *error) {
        
    }];
    

}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
