//
//  wareHouseTableViewCell.m
//  pi-brand
//
//  Created by shengtian on 2017/8/11.
//  Copyright © 2017年 shengtian. All rights reserved.
//

#import "wareHouseTableViewCell.h"

@interface wareHouseTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *textaLabel;

@end

@implementation wareHouseTableViewCell

-(void)updataCellWithString:(NSString*)text;{
    _textaLabel.text = text;
}

+ (instancetype)createCellWithTableView:(UITableView *)tableView
{
    static NSString * iden = @"wareHouseTableViewCell";
    wareHouseTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (!cell) {
        cell = [[wareHouseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    return cell;
}

#pragma mark -
#pragma mark lifecycle
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"wareHouseTableViewCell" owner:self options:nil]lastObject];
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
