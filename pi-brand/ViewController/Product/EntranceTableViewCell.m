//
//  EntranceTableViewCell.m
//  pi-brand
//
//  Created by shengtian on 2017/8/11.
//  Copyright © 2017年 shengtian. All rights reserved.
//

#import "EntranceTableViewCell.h"

@interface EntranceTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *entranceImage;

@end


@implementation EntranceTableViewCell

+ (instancetype)createCellWithTableView:(UITableView *)tableView
{
    static NSString * iden = @"EntranceTableViewCell";
    EntranceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (!cell) {
        cell = [[EntranceTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    return cell;
}

#pragma mark -
#pragma mark lifecycle
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"EntranceTableViewCell" owner:self options:nil]lastObject];
        [self.entranceImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(screenWidth/2);
            make.height.mas_equalTo(screenWidth/2*61/348);
        }];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
