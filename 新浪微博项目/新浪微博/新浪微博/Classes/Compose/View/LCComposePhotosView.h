//
//  LCComposePhotosView.h
//  新浪微博
//
//  Created by lichao on 15/8/9.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCComposePhotosView : UIView
//向当前配图添加一张照片
- (void)addImage:(UIImage *)image;


- (NSArray *)images;
@end
