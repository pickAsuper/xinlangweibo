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
#import "LCStatusCell.h"
#import "LCStatusFrame.h"

//运行时
#import <objc/runtime.h>

// 加载条数
#define LOAD_COUNT 20


@interface LCHomeVirewController ()

@property(nonatomic ,strong)NSMutableArray *statusFrames;

@end
@implementation LCHomeVirewController

-(NSMutableArray *)statusFrames{
    if (!_statusFrames) {
        _statusFrames =[NSMutableArray array];
    }
    return _statusFrames;
}

//把模型转场frame
-(NSArray *)converToFramesWithStatues:(NSArray *)statues{

    
    NSMutableArray *statusArray =[NSMutableArray array];
    
    for (LCStatus *status in statues) {
        //初始化一个frame
        LCStatusFrame *frame =[LCStatusFrame new];
//        设置frame的模型数据 (去计算 >>setStatus)这个方法去计算
        frame.status =status;
        [statusArray addObject:frame];
        
        
    }
    return [statusArray copy];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //就不用去缓存池中找了
    [self.tableView registerClass:[LCStatusCell class] forCellReuseIdentifier:identifier];
    
    //这段代码让cell的横线 靠左边了(系统默认是不靠左边的)
      [self setSeparatorInsetZeroWithTableView:self.tableView];

    //去掉tableView  最后的cell的线
    UIView *footView =[UIView new];
    self.tableView.tableFooterView = footView;
    //去掉cell 最后一根线 >>只要在下边指定一个宽度就ok了哦
    self.tableView.separatorInset =UIEdgeInsetsMake(0, 0, 5, 0);
    
    
    //首页
    [self setupNav];

    
    // 用户信息
    [self getUserData];

    // 加载首页微博数据
    // [self loadNewStatues];
    [self setRefreshView];
    
    self.tabBarItem.badgeValue =@"10";
    
//    //创建timer 定时器
//    NSTimer *timer =[NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(loadUnReadCount) userInfo:nil repeats:YES];
//    //timer立马运行
//    [timer fire];
//     //添加到消息循环
//    NSRunLoop *runloop =[NSRunLoop mainRunLoop];
//    [runloop addTimer:timer forMode:NSRunLoopCommonModes];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarItem.badgeValue =nil;
    
    
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

#pragma mark --加载首页导航控制器
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
    
    
    
   // 设置导航栏左右按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_friendsearch" target:self action:@selector(barButtonClick)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_pop" target:self action:@selector(rightbarClick)];

}

#pragma mark --按钮点击事件
-(void)barButtonClick{
   // NSLog(@"btn =%s",__func__);
    SunView *view =[[SunView alloc]init];
   
    //push到下一个控制器
    [self.navigationController pushViewController:view animated:YES];

}
-(void)rightbarClick{
    NSLog(@"right = %s",__func__);
  
}

//首页中间按钮的点击事件
-(void)titelBtnClick:(UIButton *)btn{
    
    // 逻辑>>
    // 点击中间按钮 >> 创建一个了一个view 再把创建好的view 添加到自定义的按钮(透明的蒙版按钮LCPopView)里面创建的imageView上 这个imageView就是能看见的灰色view 再把传进来的btn 添加最后一个窗口上显示;
    
    UIView *view =[[UIView alloc]init];
    view.size = CGSizeMake(100, 100);
    view.backgroundColor =[UIColor blueColor];
  
    // 当点击中间按钮的时候就创建一个按钮作为蒙版
    LCPopView *popView =[[LCPopView alloc]initWithCustomsView:view];

    //    设置背景图片
    // popView.backgroundColor =[UIColor redColor];
    // popView.alpha = 0.5;
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
    // 解档模型取值
    LCOauth *oauth = [LCAccountTool AccountOpen];
    dict[@"access_token"]=oauth.access_token;
    dict[@"uid"]=oauth.uid;
    
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    [manager GET:str parameters:dict success:^(AFHTTPRequestOperation * op, id reque) {
        // NSMutableDictionary *dic =[NSMutableDictionary dictionary];
        LCUser *userInfo =[LCUser new];
        
        // 调用了第三方框架(MJExtension)给成员变量赋值
        [userInfo setKeyValues:reque];
        
        // 设置导航栏中间的文字为用户名(新浪用户名) >> 转成自定义的 LCHomeTitelBtn
       
         // LCHomeTitelBtn >> 进行了文字和图片的交换
        LCHomeTitelBtn *homeTitel =(LCHomeTitelBtn *)self.navigationItem.titleView;
        [homeTitel setTitle:userInfo.screen_name forState:UIControlStateNormal];
   
    } failure:^(AFHTTPRequestOperation * op, NSError *error) {
        NSLog(@"获取用户信息失败%@",error);
    }];
}



#pragma -mark  加载首页微博数据 
-(void)getNewStatus:(UIRefreshControl *)refreshCtrl{
   
    //请求地址
    NSString *str =@"https://api.weibo.com/2/statuses/friends_timeline.json";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    // 解档模型取值
    LCOauth *oau =[LCAccountTool AccountOpen];
    dict[@"access_token"] = oau.access_token;
    dict[@"count"] =@(LOAD_COUNT);
    
    //如果是第一个数据 就从去加载最新的数据时间的数据 id 定义为了long long 类型
    if ([self.statusFrames firstObject]) {
        LCStatusFrame *frame = [self.statusFrames firstObject];
        dict[@"since_id"] = @(frame.status.id);
       }
    
    //发送请求获取数据
   AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:str parameters:dict success:^(AFHTTPRequestOperation * op, id retuq) {
      
        self.tabBarItem.badgeValue= nil;
        [UIApplication sharedApplication].applicationIconBadgeNumber =0;
        //获取到数据以后 结束refreshCtrl 加载
        [refreshCtrl endRefreshing];
        
        // 取出 statuses 里面的值>>最外层是字典{statuses是字典里面的数组 statuses里面存的也是字典}
        NSArray *array = retuq[@"statuses"];
       // NSLog(@"retup %@",retuq[@"statuses"]);
      
        // 通过第三方框架进行字典转模型
       NSArray *status = [LCStatus objectArrayWithKeyValuesArray:array];

        //得把status模型转成frame模型
        NSArray *statuesFames =[self converToFramesWithStatues:status];
        
        
        //初始一个范围-->我们刷新回来的数据，需要添加到的tableView的前面(添加到数组的前面)
       NSIndexSet *indexSet =[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, status.count)];
        
        
         // /添加到数组的什么位置
        [self.statusFrames insertObjects:statuesFames atIndexes:indexSet];

        //刷新tableView
        [self.tableView reloadData];
     
        //显示加载条
        [self showCountLabelWithCount:status.count];
        
        
        
        
    } failure:^(AFHTTPRequestOperation *op, NSError * error) {
        NSLog(@"首页数据获取失败信息 - error%@",error);
        [refreshCtrl endRefreshing];
    }];
}




//cell滑动到最后 >>滑动到最后在这里计算
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //没有数据或者有显示tableFooterView 就直接返回
    if (self.statusFrames.count == 0 || self.tableView.tableFooterView.hidden ==NO) {
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
    if ([self.statusFrames lastObject]) {
       // dict[@"max_id"] =@([[self.statusFrames lastObject] id]-1);
       LCStatusFrame *statusFrame = [self.statusFrames lastObject];
        dict[@"max_id"]=@([statusFrame.status id]-1);
    }
    
    //发送请求获取数据
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:str parameters:dict success:^(AFHTTPRequestOperation * op, id retuq) {
       
        //加载数据完成之后，把底部控件设置为隐藏，以及再次下拉的时候执行加载更多的逻辑
      self.tableView.tableFooterView.hidden = YES;
        
    // 取出 statuses 里面的值>>最外层是字典{statuses是字典里面的数组 statuses里面存的也是字典}
        NSArray *array = retuq[@"statuses"];
     
        // 通过第三方框架进行字典转模型
        NSArray *status = [LCStatus objectArrayWithKeyValuesArray:array];
        
        //得把status模型转成frame模型
        NSArray *statuesFames =[self converToFramesWithStatues:status];

        //frame模型
        [self.statusFrames addObjectsFromArray:statuesFames];
         //刷新tableView
        [self.tableView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *op, NSError * error) {
        NSLog(@"首页数据获取失败信息 - error%@",error);
       
        self.tableView.tableFooterView.hidden =YES;
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
          //设置桌面上应用图标右上角的badgeNumber
          [UIApplication sharedApplication].applicationIconBadgeNumber =reaCount.status;
          
          
      }else{
          self.tabBarItem.badgeValue=nil;
      }
      
  } failure:^(AFHTTPRequestOperation *op, NSError * error) {
      NSLog(@"获取未读信息失败%@,",error);
  }];




}

//showCountLabelWithCount
-(void)showCountLabelWithCount:(NSInteger )count{
   NSString *string =@"没有加载到更多数据";
    if (count) {
        string =[NSString stringWithFormat:@"共加载到%zd条数据",count];
    }
    UILabel *label =[UILabel new];
    label.text =string;
    label.font = SYS_FONT(14);
    label.textColor =[UIColor whiteColor];
    label.textAlignment =NSTextAlignmentCenter;
    label.backgroundColor =[UIColor orangeColor];
    label.size =CGSizeMake(SCREENW, 35);
    label.y = 65 - label.width;
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    [UIView animateWithDuration:5 animations:^{
        
       label.y = 65;
     //label.transform = CGAffineTransformMakeTranslation(0, label.height);
     
      //label.transform = CGAffineTransformMakeTranslation(0, label.height);
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:5 animations:^{

            label.y =65-label.width;
             //形变还原
           // label.transform = CGAffineTransformIdentity;
            
        }completion:^(BOOL finished) {
            //移除
            [label removeFromSuperview];
            label.hidden =YES;
            
        }];
        
    }];
    

}




#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.statusFrames.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     // 创建自定义cell
    LCStatusCell *cell = [LCStatusCell cellWithTableView:tableView];
    
    // 设置frame模型
    LCStatusFrame *statusFrame =self.statusFrames[indexPath.row];
   
    
    [cell setStatusFrame:statusFrame];
    
    

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
       self.tabBarItem.badgeValue =@"15";

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   return [self.statusFrames[indexPath.row] cellHeight];
    
}

@end
