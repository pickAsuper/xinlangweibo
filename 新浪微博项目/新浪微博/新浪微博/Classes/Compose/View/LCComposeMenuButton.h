//
//  LCComposeMenuButton.h
//  新浪微博
//
//  Created by lichao on 15/8/7.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,LCComposeMenuButtonType ) {
    LCComposeMenuButtonTypeUp,
    LCComposeMenuButtonTypeDown,
  
};
@interface LCComposeMenuButton : UIButton

-(void)showWithType:(LCComposeMenuButtonType)type index:(NSInteger)index;

@end
