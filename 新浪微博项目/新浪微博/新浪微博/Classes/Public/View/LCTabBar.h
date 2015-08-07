//
//  LCTabBar.h
//  新浪微博
//
//  Created by lichao on 15/7/27.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import <UIKit/UIKit.h>



@class LCTabBar;
#warning 我们自己定义的控件，如果是继承于系统的控件的话，而且有代理的话，我们的协议一定要继承父类的协议
@protocol LCTabBarDelegate  <NSObject,UITabBarDelegate>

-(void)tabbar:(LCTabBar *)tabbar btnClick:(UIButton *)btn;

@end

@interface LCTabBar : UITabBar

@property (nonatomic ,weak)id<LCTabBarDelegate> delegate;

@property(nonatomic,copy)void(^btnClik)(UIButton *btn);



@end
