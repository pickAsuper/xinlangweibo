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
#import "LCStatus.h"
#import "UIViewController+ESSeparatorInset.h"

@interface LCHomeVirewController ()

@property(nonatomic ,strong)NSArray *statueS;

@end
static NSString *identifier =@"cell";
@implementation LCHomeVirewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    //就不用去缓存池中找了
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    
    //这段代码让cell的横线 靠左边了(系统默认是不靠左边的)
      [self setSeparatorInsetZeroWithTableView:self.tableView];

    //LCOauth *oauthq = [LCAccountTool AccountOpen];
//    NSLog(@"%@",oauthq.access_token);
//    NSLog(@"%@",oauthq.uid);
    
    //用户信息
    [self getUserData];

    //加载首页微博数据
//    [self loadNewStatues];
    [self getNewStatus];
}



#pragma mark --加载首页
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
#pragma mark --按钮点击事件
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





#pragma mark -获取用户信息
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
    [manager GET:str parameters:dict success:^(AFHTTPRequestOperation * op, id reque) {
        // NSMutableDictionary *dic =[NSMutableDictionary dictionary];
        LCUser *userInfo =[LCUser new];
        
        //调用了第三方框架
        [userInfo setKeyValues:reque];
        
        LCHomeTitelBtn *homeTitel =(LCHomeTitelBtn *)self.navigationItem.titleView;
        [homeTitel setTitle:userInfo.screen_name forState:UIControlStateNormal];
        

        
    } failure:^(AFHTTPRequestOperation * op, NSError *error) {
        
    }];

}

#pragma -mark  加载首页微博数据
 
-(void)getNewStatus{
   
    //请求地址
    NSString *str =@"https://api.weibo.com/2/statuses/friends_timeline.json";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    LCOauth *oau =[LCAccountTool AccountOpen];
    dict[@"access_token"] = oau.access_token;
    dict[@"count"] =@(5);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:str parameters:dict success:^(AFHTTPRequestOperation * op, id retuq) {
       // NSLog(@"getNewUserData %@",retuq);
         //获取字典数组
        NSLog(@"ret %@",retuq);
        NSArray *array = retuq[@"statuses"];
        
//        通过第三方框架进行字典转模型
       NSArray *arr = [LCStatus objectArrayWithKeyValuesArray:array];
        self.statueS =arr;

        //刷新tableView
        [self.tableView reloadData];
     
    } failure:^(AFHTTPRequestOperation *op, NSError * error) {
        NSLog(@"首页数据获取失败信息 - error%@",error);
    }];
}


#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.statueS.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //NSString *ID =@"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if (cell ==nil) {
//        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
//    }
 
    LCStatus *status = self.statueS[indexPath.row];
    cell.textLabel.text =status.text;
    
    
    
    return cell;
}



@end
