//
//  GoodsListTableViewCell.m
//  pi-brand
//
//  Created by shengtian on 2017/8/11.
//  Copyright © 2017年 shengtian. All rights reserved.
//

#import "GoodsListTableViewCell.h"
#import <UIKit/UIKit.h>
@interface GoodsListTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *backView1;
@property (weak, nonatomic) IBOutlet UIView *backView2;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage1;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage2;
@property (weak, nonatomic) IBOutlet UILabel *mainLabel1;
@property (weak, nonatomic) IBOutlet UILabel *mainLabel2;
@property (weak, nonatomic) IBOutlet UILabel *subLabel1;
@property (weak, nonatomic) IBOutlet UILabel *subLabel2;

@end

@implementation GoodsListTableViewCell

-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    if ([_dataArray[0][@"img"] length]>0) {
        [_goodsImage1 sd_setImageWithURL:[_dataArray[0][@"img"] safeUrlString] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [UIView transitionWithView:_goodsImage1 duration:during options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                _goodsImage1.alpha = 1;
            } completion:nil];
        }];
    }else{
        [_goodsImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
        [_goodsImage2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
        [_mainLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(15);
        }];
    }
    
    _mainLabel1.text = _dataArray[0][@"name"];
    _subLabel1.text = _dataArray[0][@"price"];
    if (_dataArray.count == 2) {
        if ([_dataArray[1][@"img"] length]>0) {
            [_goodsImage2 sd_setImageWithURL:[_dataArray[1][@"img"] safeUrlString] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [UIView transitionWithView:_goodsImage2 duration:during options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                    _goodsImage2.alpha = 1;
                } completion:nil];
            }];
        }else{
            [_goodsImage2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@0);
            }];
            [_mainLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.offset(15);
            }];
        }
        
        
        _mainLabel2.text = _dataArray[1][@"name"];
        _subLabel2.text = _dataArray[1][@"price"];
        _backView2.hidden = NO;
    }else{
        _backView2.hidden = YES;
    }
    
}
+ (instancetype)createCellWithTableView:(UITableView *)tableView
{
    static NSString * iden = @"GoodsListTableViewCell";
    GoodsListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (!cell) {
        cell = [[GoodsListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    return cell;
}

#pragma mark -
#pragma mark lifecycle
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"GoodsListTableViewCell" owner:self options:nil]lastObject];
        _backView1.layer.borderColor = [kLineColor colorWithAlphaComponent:0.5].CGColor;
        _backView1.layer.borderWidth = 0.5;
        _backView2.layer.borderColor = [kLineColor colorWithAlphaComponent:0.5].CGColor;
        _backView2.layer.borderWidth = 0.5;
        [_goodsImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(screenWidth*109/320);
            make.height.mas_equalTo(screenWidth*109/320*279/262);
        }];
        [_goodsImage2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(screenWidth*109/320);
            make.height.mas_equalTo(screenWidth*109/320*279/262);
        }];
        _mainLabel1.adjustsFontSizeToFitWidth = _mainLabel2.adjustsFontSizeToFitWidth = _subLabel1.adjustsFontSizeToFitWidth = _subLabel2.adjustsFontSizeToFitWidth = YES;
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
