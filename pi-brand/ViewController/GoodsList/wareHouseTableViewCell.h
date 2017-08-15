//
//  wareHouseTableViewCell.h
//  pi-brand
//
//  Created by shengtian on 2017/8/11.
//  Copyright © 2017年 shengtian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface wareHouseTableViewCell : UITableViewCell
+ (instancetype)createCellWithTableView:(UITableView *)tableView;
-(void)updataCellWithString:(NSString*)text;
@end
