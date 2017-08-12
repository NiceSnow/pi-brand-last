//
//  advertisementTableViewCell.m
//  pi-brand
//
//  Created by shengtian on 2017/8/11.
//  Copyright © 2017年 shengtian. All rights reserved.
//

#import "advertisementTableViewCell.h"

@interface advertisementTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *AdImageView;

@end

@implementation advertisementTableViewCell


-(void)setImageString:(NSString *)imageString{
    [self.AdImageView sd_setImageWithURL:[imageString safeUrlString] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [UIView transitionWithView:self.AdImageView duration:during options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
//            CGSize imageSize = image.size;
            self.AdImageView.alpha = 1;
        } completion:nil];
    }];
}

+ (instancetype)createCellWithTableView:(UITableView *)tableView
{
    static NSString * iden = @"advertisementTableViewCell";
    advertisementTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (!cell) {
        cell = [[advertisementTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"advertisementTableViewCell" owner:self options:nil]lastObject];
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
