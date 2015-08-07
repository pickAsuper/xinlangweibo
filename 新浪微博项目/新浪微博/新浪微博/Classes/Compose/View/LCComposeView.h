//
//  LCComposeView.h
//  新浪微博
//
//  Created by lichao on 15/8/7.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCComposeView : UIView
//-(void)startAnim;

//在初始化的时候把自己传过去就不用在LCTabBarController 里面做事了
-(instancetype)initWithTagert:(UIViewController *)tagert;

//显示出来 >>为了外界使用方便
-(void)show;


@end
