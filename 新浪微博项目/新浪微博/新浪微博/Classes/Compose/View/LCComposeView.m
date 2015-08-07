//
//  LCComposeView.m
//  新浪微博
//
//  Created by lichao on 15/8/7.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "LCComposeView.h"
#import "UIImage+ImageEffects.h"
#import "MJExtension.h"
#import "LCComposeMenuInfo.h"
#import "LCComposeMenuButton.h"
#import "POP.h"
#import "LCComposeViewCtrl.h"
#import "LCNavigationController.h"
@interface LCComposeView ()

@property(nonatomic ,strong)NSMutableArray *childMenus;

@property(nonatomic ,strong)UIViewController *tagert;


@end


@implementation LCComposeView

-(instancetype)initWithTagert:(UIViewController *)tagert{
    if (self =[super init]) {
        self.tagert =tagert;
    }
    return self;
    
}


//里面存的是自定义按钮
-(NSMutableArray *)childMenus{
    if (!_childMenus) {
        _childMenus =[NSMutableArray array];
    }
    return _childMenus;
}



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //这个view和屏幕一样大小
        self.size =CGSizeMake(SCREENW, SCREENH);
        
//        在这个view上创建了一个imageView
        UIImageView *imageView =[[UIImageView alloc]initWithFrame:self.bounds];
          //截图 加磨砂效果
        imageView.image = [[self screenImage] applyLightEffect];
        
      [self addSubview:imageView];
        
         //广告
        UIImageView *adImage =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"compose_slogan"]];
        adImage.x = self.centerX*0.5;
        adImage.y = 100;
        [self addSubview:adImage];
       
         //自定义按钮的添加
        [self setupChildMenu];
        
        
        
    }
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    [self removeFromSuperview];
    [self hide];
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

//自定义按钮
-(void)setupChildMenu{
 
    //字典转模型
   NSArray  *menuInfos = [LCComposeMenuInfo objectArrayWithFilename:@"compose.plist"];
    
    NSInteger cols =3 ;
    CGFloat childW = 80;
    CGFloat childH =110;
    CGFloat margin = (SCREENW - (cols * childW))/4;
    for (int i = 0 ; i < 6; i++) {
          //用模型来取按钮的文字图片 >>文字和图片放在plist文件中了
        LCComposeMenuInfo *menuInfo = menuInfos[i];
        LCComposeMenuButton *btn =[[LCComposeMenuButton alloc]init];
        
        [btn setTitle:menuInfo.title forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:menuInfo.icon] forState:UIControlStateNormal];
      
        [btn addTarget:self action:@selector(menuItemClick:) forControlEvents:UIControlEventTouchUpInside];
    
        btn.size = CGSizeMake(childW, childH);
        int col =i % cols;
        int row =i /cols;
        

         btn.x = (col + 1 ) *margin + (col * childW);
        btn.y = row * (childW + margin)+SCREENH;
        
        [self addSubview:btn];
    
        
        //添加到集合里面,以便执行动画的时候使用
        [self.childMenus addObject:btn];
      
        
    }

}

//提供个接口为了方便外面使用
-(void)show{
    //UIWindow *window =[UIApplication sharedApplication].keyWindow;
    //    [window addSubview:self];
    //不用创建window了
    [self.tagert.view addSubview:self];
    [self startAnim];
}


//在modal出来的时间就调用 >> LCTabBarController 里面去调用的
-(void)startAnim{
     // 变量里面的自控件
    [self.childMenus enumerateObjectsUsingBlock:^(LCComposeMenuButton *obj, NSUInteger idx, BOOL *stop) {
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
          [obj showWithType:LCComposeMenuButtonTypeUp index:idx];
     
          
       });
  }];
}

/**
 *  隐藏 会执行子控件向下移动的动画 把当前View从父控件里面移除
 */
-(void)hide{
    NSArray *reverse =[self.childMenus reverseObjectEnumerator].allObjects;
   
    [reverse enumerateObjectsUsingBlock:^(LCComposeMenuButton *obj, NSUInteger idx, BOOL *stop) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.025 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [obj showWithType:LCComposeMenuButtonTypeDown index:idx];
            
//        POPSpringAnimation *anim =[POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
//        
//        anim.toValue =[NSValue valueWithCGPoint:CGPointMake(obj.centerX, obj.centerY + 350)];
//        
//        anim.springBounciness = 9;
//        anim.springSpeed =12;
//        [obj pop_addAnimation:anim forKey:nil];
        
        
       });
       
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self removeFromSuperview];
            
        });
        
        
    }];
    

}
/**
 *  执行按钮点击动画
 *
 *  @param btn <#btn description#>
 */
-(void)menuItemClick:(UIButton *)btn{
   [UIView animateWithDuration:0.25 animations:^{
       [self.childMenus enumerateObjectsUsingBlock:^(LCComposeMenuButton *obj, NSUInteger idx, BOOL *stop) {
           if (btn ==obj) {
//               点击的按钮变大
               obj.transform = CGAffineTransformMakeScale(2.0, 2.0);
               
           }else{
             //还原
               obj.transform =CGAffineTransformMakeScale(0.3, 0.3);
               
           }
           obj.alpha=0.2;

       }];

   }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 animations:^{
            LCComposeViewCtrl *composeCtrl =[[LCComposeViewCtrl alloc]init];
            [self.tagert presentViewController:[[LCNavigationController alloc]initWithRootViewController:composeCtrl] animated:YES completion:^{
                [self removeFromSuperview];
            }];


            
            
            //       [self.childMenus enumerateObjectsUsingBlock:^(LCComposeMenuButton *obj, NSUInteger idx, BOOL *stop) {
//           obj.transform = CGAffineTransformIdentity;
//           obj.alpha =1;
//       }];
      }];
   }];



}


@end
