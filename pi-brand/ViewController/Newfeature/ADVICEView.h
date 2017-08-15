//
//  ADVICEView.h
//  pi-brand
//
//  Created by Madodg on 2017/8/14.
//  Copyright © 2017年 shengtian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol adviceDelegate <NSObject>

-(void)returnIndex:(NSInteger)index;

@end

@interface ADVICEView : UIView
@property(nonatomic,strong) NSArray* dataArray;

@property(nonatomic,assign)id<adviceDelegate>delegate;
@end
