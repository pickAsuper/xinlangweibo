//
//  UIView+Inspectable.h
//  新浪微博
//
//  Created by lichao on 15/7/28.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface UIView (Inspectable)


//这是设置XIB的圆角
@property(nonatomic ,assign)IBInspectable CGFloat  cornerRadius;

//这是设置XIB边框的颜色
@property(nonatomic,assign)IBInspectable UIColor *borderColor;

//这是设置XIB边框的宽度
@property(nonatomic ,assign)IBInspectable CGFloat borderWidth;


@end
