//
//  LCTabBar.h
//  新浪微博
//
//  Created by lichao on 15/7/27.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LCTabBar;
@protocol LCTabBarDelegate  <NSObject,UITabBarDelegate>

-(void)tabbar:(LCTabBar *)tabbar btnClick:(UIButton *)btn;

@end

@interface LCTabBar : UITabBar

@property (nonatomic ,weak)id<LCTabBarDelegate> delegate;




@end
