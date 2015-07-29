//
//  LCPopView.h
//  新浪微博
//
//  Created by lichao on 15/7/29.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCPopView : UIButton

//传一个view进去 >> 为了灰色框的大小和 和添加控件
- (instancetype)initWithCustomsView:(UIView *)view;

-(void)showFromView:(UIView *)showView;

@end
