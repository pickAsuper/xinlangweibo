//
//  LCIWTabBarItem.m
//  新浪微博
//
//  Created by lichao on 15/8/1.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "LCIWTabBarItem.h"
#import <objc/runtime.h>


@implementation LCIWTabBarItem
-(void)setBadgeValue:(NSString *)badgeValue{
    [super setBadgeValue:badgeValue];
  
    UITabBarController *tabBarCtrl = [self valueForKeyPath:@"_target"];
    
        //遍历出self.tabBarController.tabBar.subviews 里面子控件
        for (UIView *tabBarChild in tabBarCtrl.tabBar.subviews) {
            if ([tabBarChild isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
                for (UIView *tabBarButtonChild in tabBarChild.subviews) {
                    if ([tabBarButtonChild isKindOfClass:NSClassFromString(@"_UIBadgeView")]) {
                        for (UIView *badgeViewChild in tabBarButtonChild.subviews) {
                            if ([badgeViewChild isKindOfClass:NSClassFromString(@"_UIBadgeBackground")]) {
                                
                                NSLog(@"终于找到你,还好我没放弃");
                                NSLog(@"%@",badgeViewChild);
                                //  badgeViewChild.backgroundColor = [UIColor blackColor];
                                // 虽然找到了，不知道设置其身上什么值去更改那个大红色
                                // 有没有相关的方法去获取其身上的属性再看看
                                
                                unsigned int count;
                                // 获取某个类身上的属性
                                Ivar *ivars = class_copyIvarList([badgeViewChild class],&count);
                                
                                for (int i = 0 ; i < count; i++) {
                                    Ivar ivar = ivars[i];
                                    
                                    //  ivar_getName(ivar);
                                    //获取属性名字
                                    NSString *ivarName = [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
                                    //获取属性类型
                                    NSString *ivarTepy = [NSString stringWithCString:ivar_getTypeEncoding(ivar) encoding:NSUTF8StringEncoding];
                                    
                                    NSLog(@"属性姓名:%@ 属性类型:%@",ivarName,ivarTepy);
                                    
                                    //如果有就通过KVC赋值图片
                                    if ([ivarName isEqualToString:@"_image"]) {
                                        UIImage *image =[UIImage imageNamed:@"main_badge"];
                                        [badgeViewChild setValue:image forKey:@"image"];
                                        
                                    }
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                }
                
            }
            
        }
        
    }




@end
