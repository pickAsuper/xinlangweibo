//
//  LCHomeTitelBtn.m
//  新浪微博
//
//  Created by lichao on 15/7/27.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "LCHomeTitelBtn.h"

@implementation LCHomeTitelBtn

-(void)layoutSubviews{
    [super layoutSubviews];
    //调整按钮里面文字和图片的 x 值 进行交换
    self.titleLabel.x = 0;
    self.imageView.x =CGRectGetMaxX(self.titleLabel.frame)+5;
    
    self.width = CGRectGetMaxX(self.imageView.frame)+5;
    self.centerX =self.superview.centerX;
}

@end
