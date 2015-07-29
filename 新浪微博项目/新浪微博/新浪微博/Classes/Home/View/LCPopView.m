//
//  LCPopView.m
//  新浪微博
//
//  Created by lichao on 15/7/29.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "LCPopView.h"

@implementation LCPopView

- (instancetype)initWithCustomsView:(UIView *)view
{
    self = [super init];
    if (self) {
        //设置按钮的宽高>>等于屏幕高度
        self.width = SCREENW;
        self.height =SCREENH;
        
        //按钮的点击事件
        [self addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:view];
        
        
    }
    return self;
}
-(void)btnClick:(UIButton *)btn{
    NSLog(@"点击了中间按钮");
    [self removeFromSuperview];
}

@end
