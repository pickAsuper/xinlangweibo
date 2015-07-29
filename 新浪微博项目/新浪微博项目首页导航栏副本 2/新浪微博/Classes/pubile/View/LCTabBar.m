//
//  LCTabBar.m
//  新浪微博
//
//  Created by lichao on 15/7/27.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "LCTabBar.h"
@interface LCTabBar ()

@property(nonatomic,strong)UIButton *btn;

@end

@implementation LCTabBar

//告诉系统我已经在父类中实现了这个方法
@dynamic delegate;


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *btn =[[UIButton alloc]init];
        
        //为了下面能给btn赋值位置
        self.btn =btn;
        
        //设置按钮背景图片
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        //设置 按钮的图片
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        
        //给按钮设置按钮大小
        btn.size = btn.currentBackgroundImage.size;
        
        
        //添加到tabbar上去
        [self addSubview:btn];
        //给按钮添加点击事件
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return self;
}


//中间按钮点击事件
-(void)btnClick:(UIButton *)btn{
    NSLog(@"asd");
    if ([self.delegate respondsToSelector:@selector(tabbar:btnClick:)]) {
        [self.delegate tabbar:self btnClick:btn];
    }
    
}



//布局子控件的位置
-(void)layoutSubviews{
    [super layoutSubviews];
   
    //在这个方法里面设置按钮的位置
    self.btn.centerX =self.width *0.5;
    self.btn.centerY =self.height *0.5;
    
    //每一个tabbar的宽度 有5个子控件 是1/5
       CGFloat barw = self.width * 0.2;
    
      //下标来记录是第几个子控件
    NSInteger index =0;
    for (int i = 0 ; i < self.subviews.count; i++) {
       UIView *view = self.subviews[i];
           //NSLog(@"%@",view);
        //判断是不是系统的UITabBarButton
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            NSLog(@"%@",view);

            //每个控件的位置
           view.width = barw;
            view.x =index * barw;
              //让tabar往后加一个位置 来摆放中间加号按钮
            if (index == 1) {
                index ++;
            }
            
            index++;
            
           
            
            
    }
        
        
    }

    

    
    

}















@end
