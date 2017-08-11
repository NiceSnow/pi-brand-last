//
//  advertisementTableViewCell.h
//  pi-brand
//
//  Created by shengtian on 2017/8/11.
//  Copyright © 2017年 shengtian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface advertisementTableViewCell : UITableViewCell
+ (instancetype)createCellWithTableView:(UITableView *)tableView;
@property (nonatomic, copy) NSString* imageString;
@end
