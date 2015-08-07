//
//  LCComposeView.m
//  新浪微博
//
//  Created by lichao on 15/8/7.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "LCComposeView.h"
#import "UIImage+ImageEffects.h"



@implementation LCComposeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.size =CGSizeMake(SCREENW, SCREENH);
        UIImageView *imageView =[[UIImageView alloc]initWithFrame:self.bounds];
        
        imageView.image = [[self screenImage] applyLightEffect];
        
      
        
        
        [self addSubview:imageView];
        
        
    }
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
}

//截图
-(UIImage *)screenImage{
//   获取屏幕大小
   UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    //开启图形上下文
     UIGraphicsBeginImageContext(window.size);
    //开启图片上下文
    CGContextRef getImageC = UIGraphicsGetCurrentContext();
    //渲染到上下文
    [window.layer renderInContext:getImageC];
    //获取渲染好的上下文
  UIImage *currentImage = UIGraphicsGetImageFromCurrentImageContext();
  //关闭图形上下文
    UIGraphicsEndImageContext();
    
    return currentImage;
    
    
    
    

}

@end
