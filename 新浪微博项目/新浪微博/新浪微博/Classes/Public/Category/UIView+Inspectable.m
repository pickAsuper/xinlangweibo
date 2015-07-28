//
//  UIView+Inspectable.m
//  新浪微博
//
//  Created by lichao on 15/7/28.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "UIView+Inspectable.h"

@implementation UIView (Inspectable)


-(void)setCornerRadius:(CGFloat)cornerRadius{
    //把传进来的圆角值(cornerRadius) 直接赋值给view的layer (cornerRadius)
    self.layer.cornerRadius =cornerRadius;
    self.layer.masksToBounds =cornerRadius>0;
    
}
-(CGFloat)cornerRadius{
    return self.layer.cornerRadius;
}

-(void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;

}
-(UIColor *)borderColor{
    return [UIColor colorWithCGColor: self.layer.borderColor];

}
-(void)setBorderWidth:(CGFloat)borderWidth{
    self.layer.borderWidth =borderWidth;
}
-(CGFloat)borderWidth{
    return self.layer.borderWidth;
}
@end
