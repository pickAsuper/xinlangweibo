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
#import "LCLoadMoreView.h"
#import "LCUnReacount.h"



// 加载条数
#define LOAD_COUNT 20


@interface LCHomeVirewController ()

@property(nonatomic ,strong)NSMutableArray *statueS;

@end
static NSString *identifier =@"cell";
@implementation LCHomeVirewController

-(NSMutableArray *)statueS{
    if (!_statueS) {
        _statueS =[NSMutableArray array];
    }
    return _statueS;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //就不用去缓存池中找了
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    
    //这段代码让cell的横线 靠左边了(系统默认是不靠左边的)
      [self setSeparatorInsetZeroWithTableView:self.tableView];

    //去掉tableView  最后的cell的线
    UIView *footView =[UIView new];
    self.tableView.tableFooterView = footView;
    //去掉cell 最后一根线
    self.tableView.separatorInset =UIEdgeInsetsMake(0, 0, 5, 0);
    
    
    //首页
    [self setupNav];

    
    // 用户信息
    [self getUserData];

    // 加载首页微博数据
    // [self loadNewStatues];
    [self setRefreshView];
    
    //创建timer 定时器
    NSTimer *timer =[NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(loadUnReadCount) userInfo:nil repeats:YES];
    [timer fire];
     //添加到消息循环
    NSRunLoop *runloop =[NSRunLoop mainRunLoop];
    [runloop addTimer:timer forMode:NSRunLoopCommonModes];
    
    
    

}




#pragma -mark 下拉加载更多

-(void)setRefreshView{
    
    //创建一个系统的下拉刷新控制器
    UIRefreshControl *refresh =[[UIRefreshControl alloc]init];
    
    //添加值改变事件
    [refresh addTarget:self action:@selector(getNewStatus:) forControlEvents:UIControlEventValueChanged];
    
    //添加到tableView 上
    [self.tableView addSubview:refresh];
    [refresh beginRefreshing];
    
     //加载用户新数据
    [self getNewStatus:refresh];
    
    //创建Xib 底部加载更多
    LCLoadMoreView *loadMoreView =[LCLoadMoreView loadMoreView];
    loadMoreView.hidden = YES;
    self.tableView.tableFooterView =loadMoreView;
    
    
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
 
-(void)getNewStatus:(UIRefreshControl *)refreshCtrl{
   
    //请求地址
    NSString *str =@"https://api.weibo.com/2/statuses/friends_timeline.json";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    //解档模型取值
    LCOauth *oau =[LCAccountTool AccountOpen];
    dict[@"access_token"] = oau.access_token;
    dict[@"count"] =@(LOAD_COUNT);
    
    //如果是第一个数据 就从去加载最新的数据时间的数据 id 定义为了long long 类型
    if ([self.statueS firstObject]) {
        dict[@"since_id"] =@([[self.statueS firstObject] id]);
        
    }
    
    //发送请求获取数据
   AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:str parameters:dict success:^(AFHTTPRequestOperation * op, id retuq) {
      
        //获取到数据以后 结束refreshCtrl 加载
        [refreshCtrl endRefreshing];
        
        // 取出 statuses 里面的值>>最外层是字典{statuses是字典里面的数组 statuses里面存的也是字典}
        NSArray *array = retuq[@"statuses"];
        NSLog(@"retup %@",retuq[@"statuses"]);
        // 通过第三方框架进行字典转模型
       NSArray *arr = [LCStatus objectArrayWithKeyValuesArray:array];
        
        //初始一个范围-->我们刷新回来的数据，需要添加到的tableView的前面(添加到数组的前面)
       NSIndexSet *indexSet =[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, arr.count)];
        
         // /添加到数组的什么位置
        [self.statueS insertObjects:arr atIndexes:indexSet];

        //刷新tableView
        [self.tableView reloadData];
     
        
    } failure:^(AFHTTPRequestOperation *op, NSError * error) {
        NSLog(@"首页数据获取失败信息 - error%@",error);
        [refreshCtrl endRefreshing];
    }];
}


//cell滑动到最后 >>滑动到最后在这里计算
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //没有数据或者有显示tableFooterView 就直接返回
    if (self.statueS.count == 0 || self.tableView.tableFooterView.hidden ==NO) {
        return;
        }
 
    // scrollView的滚动的高度 - 整个屏幕的高度
  CGFloat result =  scrollView.contentSize.height-SCREENH;
   
    // 如果说这个宽度小于 或者 等于了 scrollView的偏移量 就要加载旧的数据(之前的数据)
    // self.tabBarController.tabBar.height tabBar(底部)高度 49
    if (result <= scrollView.contentOffset.y - self.tabBarController.tabBar.height) {
        //显示加载条 tableFooterView >> (是Xib)
        self.tableView.tableFooterView.hidden=NO;
        
        //加载底部数据(之前的数据)
        [self getMoreStatus];
        
        
    }
    

}

#pragma -mark tableViewCELL  滑动到cell的最后加载的数据
-(void)getMoreStatus{
    //请求地址
    NSString *str =@"https://api.weibo.com/2/statuses/friends_timeline.json";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    //解档模型取值
    LCOauth *oau =[LCAccountTool AccountOpen];
    dict[@"access_token"] = oau.access_token;
    dict[@"count"] =@(LOAD_COUNT);
    
    //如果是最后的数据 就从去加载最新的数据时间的数据 id 定义为了long long 类型
    if ([self.statueS lastObject]) {
        dict[@"max_id"] =@([[self.statueS lastObject] id]-1);
        
    }
    
    //发送请求获取数据
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:str parameters:dict success:^(AFHTTPRequestOperation * op, id retuq) {
       
        //加载数据完成之后，把底部控件设置为隐藏，以及再次下拉的时候执行加载更多的逻辑
      self.tableView.tableFooterView.hidden = YES;
        
    // 取出 statuses 里面的值>>最外层是字典{statuses是字典里面的数组 statuses里面存的也是字典}
        NSArray *array = retuq[@"statuses"];
     
        // 通过第三方框架进行字典转模型
        NSArray *arr = [LCStatus objectArrayWithKeyValuesArray:array];
        
//        //初始一个范围-->我们刷新回来的数据，需要添加到的tableView的前面(添加到数组的前面)
//        NSIndexSet *indexSet =[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, arr.count)];
        // /添加到数组的什么位置
       // [self.statueS insertObjects:arr atIndexes:indexSet];
        
        [self.statueS addObjectsFromArray:arr];
        
        
        //刷新tableView
        [self.tableView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *op, NSError * error) {
        NSLog(@"首页数据获取失败信息 - error%@",error);
    
    }];
    
    

}
#pragma mark -loadUnReadCount
-(void)loadUnReadCount{
   NSString *str =@"https://rm.api.weibo.com/2/remind/unread_count.json";
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    
    LCOauth *oua =[LCAccountTool AccountOpen];
    dict[@"access_token"]=oua.access_token;
    dict[@"uid"]=oua.uid;
    
    
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
  [manager GET:str parameters:dict success:^(AFHTTPRequestOperation *op, id reta) {
      
      //获取到数据后把未读信息赋值到指标上
      LCUnReacount *reaCount =[LCUnReacount new];
      [reaCount setKeyValues:reta];
      
      //如果指标有值
      if (reaCount.status) {
          self.tabBarItem.badgeValue =[NSString stringWithFormat:@"%zd",reaCount.status];
      }else{
          self.tabBarItem.badgeValue=nil;
      }
      
  } failure:^(AFHTTPRequestOperation *op, NSError * error) {
      NSLog(@"获取未读信息失败%@,",error);
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
