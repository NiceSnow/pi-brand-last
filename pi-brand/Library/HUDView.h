//
//  HUDView.h
//  HARMAY_PI_BRAND
//
//  Created by Madodg on 2017/7/29.
//  Copyright © 2017年 Madodg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HUDView : UIView
+ (HUDView *)Instance;
+(void)showHUD:(UIViewController*)VC;
+(void)hiddenHUD;
@end
