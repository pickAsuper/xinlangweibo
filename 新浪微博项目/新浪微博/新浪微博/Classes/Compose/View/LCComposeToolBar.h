//
//  LCComposeToolBar.h
//  新浪微博
//
//  Created by lichao on 15/8/8.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, LCComposeToolBarType) {
    LCComposeToolBarTypeCamera,  //照相机
    LCComposeToolBarTypePicture,  //图片
    LCComposeToolBarTypeMetion,   //@
    LCComposeToolBarTypeTrend,    // #
    LCComposeToolBarTypeEmotion,  //表情
    
};
@class LCComposeToolBar;


@interface LCComposeToolBar : UIView


//这里只传一个btn过去 就不知道点得是那个按钮所以需要定义一个枚举来传过去
@property(nonatomic,copy)void(^buttonClick)(LCComposeToolBarType type);


@end
