//
//  LCPopView.m
//  新浪微博
//
//  Created by lichao on 15/7/29.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "LCPopView.h"

@interface LCPopView ()

@property (nonatomic ,weak)UIImageView *contentView;


@end

@implementation LCPopView

- (instancetype)initWithCustomsView:(UIView *)view
{
    self = [super init];
    if (self) {
        // 设置按钮的宽高 >>等于屏幕高度
        self.width = SCREENW;
        self.height =SCREENH;
        
        //按钮的点击事件
        [self addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //创建灰色的相框
        UIImageView *contentView =[[UIImageView alloc]init];
        contentView.image =[UIImage imageNamed:@"popover_background"];
        contentView.width =view.width +10;
        contentView.height= view.height +20;
        contentView.userInteractionEnabled=YES;
        self.contentView =contentView;
          //把图片背景设置到按钮上去
        [self addSubview:contentView];
        
        view.x =4;
        view.y =12;
        
        //把传进来的按钮(view)添加到灰色的图片上
        [contentView addSubview:view];
        
        
        
    }
    return self;
}
-(void)showFromView:(UIView *)showView{
    //得到父控件的位置 通过查找到 在哪一个窗口上 找到它的父控件才能进行位置的确定
 CGRect rect = [showView convertRect:showView.bounds toView:nil];
   
    self.contentView.centerX = CGRectGetMidX(rect);
    self.contentView.y =CGRectGetMaxY(rect);
   // [self layoutIfNeeded];
   
    UIWindow *window =[[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
}


//蒙版(透明)按钮的点击事件
-(void)btnClick:(UIButton *)btn{
  //  NSLog(@"点击了中间按钮");
    [self removeFromSuperview];
}

@end
