//
//  LCNewFeatureCtrl.m
//  新浪微博
//
//  Created by lichao on 15/7/29.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "LCNewFeatureCtrl.h"
#import "LCTabBarController.h"


@interface LCNewFeatureCtrl ()<UIScrollViewDelegate>

//图片
@property(nonatomic ,weak)UIImageView *imageView;

//分页
@property(nonatomic ,weak)UIPageControl *pageCtrl;


@end

@implementation LCNewFeatureCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    NSInteger count =4;
    
    //创建分页控件
    UIPageControl *pageCtrl =[[UIPageControl alloc]init];
    
    pageCtrl.currentPageIndicatorTintColor =[UIColor redColor];
    pageCtrl.pageIndicatorTintColor =[UIColor blueColor];
    //设置位置
//    pageCtrl.size =CGSizeMake(30, 30);
    pageCtrl.centerX =SCREENW *0.5;
    pageCtrl.y =SCREENH -100;
    pageCtrl.numberOfPages =count;
    NSLog(@"%@",pageCtrl);
    self.pageCtrl =pageCtrl;
    [self.view addSubview:pageCtrl];
    
    
    
    
    
    //创建scrollView
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
     //设置分页效果
    scrollView.pagingEnabled =YES;
  // 取消滚动条
    scrollView.showsHorizontalScrollIndicator =NO;
    //取消弹簧效果
    scrollView.bounces =NO;
    
    //让控制器成为scrollView的代理
    //监听scrollView的滚动 >>通过代理
    scrollView.delegate =self;
    
    
    //创建相册
     for (int i = 0 ; i < count; i++) {
        UIImageView *imageView =[[UIImageView alloc]init];
        NSString *imageName =[NSString stringWithFormat:@"new_feature_%d",i+1];
        imageView.image =[UIImage imageNamed:imageName];
        // NSLog(@"imageView.width =%f",imageView.width);
         imageView.x = i * scrollView.width;
         imageView.size =scrollView.size;
         self.imageView =imageView;
         
         //把相册赋值个scrollView
         [scrollView addSubview:imageView];
        
         
         //如果是最后一张就在最后一张上面添加按钮
         if (i == count-1) {
             
             //添加进入微博
             [self addBtnWithImageView:imageView];
             
             //添加分享微博
             [self addshareWeiBo:imageView];
             
         }
         
    }
    //设置scrollView的滚动范围
    scrollView.contentSize = CGSizeMake(scrollView.width *count, 0);
    
    //insert 这个方法 可以指定你要添加的View 放在哪个位置 还可能有方法指定的这个View 放在某一个View 的下边或者上边
    [self.view insertSubview:scrollView belowSubview:pageCtrl];
    
    
    
}

////如果是最后一张就在最后一张上面添加按钮
-(void)addBtnWithImageView:(UIImageView *)imageView{
   
    UIButton *btn =[[UIButton alloc]init];
    [btn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [btn setTitle:@"进入微博" forState:UIControlStateNormal];
    
    
    btn.size =btn.currentBackgroundImage.size; //这句代码不能放在 计算x y 的后面 要不然位置不正确
    
    btn.centerX =imageView.width * 0.5;
   
    btn.y =imageView.height -150;
    [btn addTarget:self action:@selector(starWeiBo:) forControlEvents:UIControlEventTouchUpInside];
    
    [imageView addSubview:btn];

}
//分享微博
-(void)addshareWeiBo:(UIImageView *)imageView{
    //与用户交互
    imageView.userInteractionEnabled=YES;
  
    UIButton *btn =[[UIButton alloc]init];
    
    //添加按钮图片文字
    [btn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [btn setTitle:@"分享微博" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    [btn sizeToFit];
    btn.centerX = imageView.width*0.5;
    btn.y =imageView.height - 200;
   
    //按钮的点击事件
    [btn addTarget:self action:@selector(shareWeiBo:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:btn];
    
    
    
    

}

//拖拽的时候调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
  CGFloat page =scrollView.contentOffset.x/scrollView.width;
    NSUInteger pageNum = (int)(page + 0.5);
    
    self.pageCtrl.currentPage =pageNum;
   
    if (!self.pageCtrl.currentPage == pageNum) {
        self.pageCtrl.currentPage=pageNum;
    }
    


}

//分享微博的点击事件
-(void)shareWeiBo:(UIButton *)btn{
    btn.selected = !btn.selected;
    
    
}
//进入开始微博
-(void)starWeiBo:(UIButton *)btn{
    
   UIWindow *window = [[UIApplication sharedApplication]keyWindow];
    window.rootViewController =[[LCTabBarController alloc]init];

    
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
