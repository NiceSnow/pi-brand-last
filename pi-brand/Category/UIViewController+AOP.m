//
//  UIViewController+AOP.m
//  31jinfu
//
//  Created by 刘厚宽 on 2017/5/5.
//  Copyright © 2017年 刘厚宽. All rights reserved.
//

#import "UIViewController+AOP.h"
#import <objc/runtime.h>
#import "UMMobClick/MobClick.h"

@implementation UIViewController (AOP)
+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        swizzleMethod(class, @selector(viewDidLoad), @selector(aop_viewDidLoad));
        swizzleMethod(class, @selector(viewWillAppear:),@selector(aop_viewWillAppear:));
        swizzleMethod(class, @selector(viewWillDisappear:),@selector(aop_viewWillDisAppear:));
        swizzleMethod(class, @selector(viewDidAppear:), @selector(aop_viewDidAppear:));
    });
}

void swizzleMethod(Class class,SEL originalSelector, SEL swizzledSwlector)
{
    Method  originalMethod = class_getInstanceMethod(class , originalSelector);
    Method  swizzledMethod = class_getInstanceMethod(class , swizzledSwlector);
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSwlector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else{
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)aop_viewWillAppear:(BOOL)animation
{
    [self aop_viewWillAppear:animation];
    [MobClick beginLogPageView:NSStringFromClass([self class])];
}
- (void)aop_viewWillDisAppear:(BOOL)animation
{
    [self aop_viewWillDisAppear:animation];
    [MobClick endLogPageView:NSStringFromClass([self class])];
}
- (void)aop_viewDidAppear:(BOOL)animation
{
    [self aop_viewDidAppear:animation];
    
}
- (void)aop_viewDidLoad
{
    [self aop_viewDidLoad];
//    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] init];
//    backItem.title = @"";
//    UIImage* image = [UIImage imageNamed:@"back"];
//    [backItem setBackButtonBackgroundImage:[image resizableImageWithCapInsets:UIEdgeInsetsMake(0, image.size.width*1.5, 0, 0)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    self.navigationItem.backBarButtonItem = backItem;
}

@end
