//
//  UIBarButtonItem+Extetion.m
//  新浪微博
//
//  Created by lichao on 15/7/28.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "UIBarButtonItem+Extetion.h"

@implementation UIBarButtonItem (Extetion)

+(instancetype)itemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action{
    UIButton *btn =[[UIButton alloc]init];
    
    //设置高亮图片
    [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@__highlighted",imageName]] forState:UIControlStateHighlighted];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
     //按钮点击事件
    btn.size =btn.currentImage.size;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    
    
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}

+(instancetype)itemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action titel:(NSString *)titel{
   
    UIButton *btn =[[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@__highlighted",imageName]] forState:UIControlStateHighlighted];
    ;
   // btn.size =btn.currentImage.size;
    
    [btn setTitle:titel forState:UIControlStateNormal];
    UIColor *color =RGB(68, 68, 68);
    [btn setTitleColor:color forState:UIControlStateNormal];
  
    //这个大小要放在设置了按钮的文字和图片大小以后
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    //注意: UIBarButtonItem 只是一个基本数据模型 是(NSObject类型)不是view   不能直接添加
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
    

}


@end
