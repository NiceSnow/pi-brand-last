//
//  JoinusViewCell.m
//  HARMAY_PI_BRAND
//
//  Created by 刘厚宽 on 2017/7/27.
//  Copyright © 2017年 Madodg. All rights reserved.
//

#import "JoinusViewCell.h"
#import "joinSubModel.h"


@interface JoinusViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *workTypelabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;


@end
@implementation JoinusViewCell

-(void)setTelephone:(NSString *)telephone{
    _telephone = telephone;
}

-(void)setSelect:(NSInteger)select{
    _select = select;
    if (_subArray) {
        NSDictionary* dic = _subArray[_select];
        UIButton* Btn = [self.contentView viewWithTag:(100+_select)];
        [Btn sd_setImageWithURL:[NSURL URLWithString:dic[@"img2"]] forState:normal];
    }
}

-(void)setSubArray:(NSArray *)subArray{
    _subArray = subArray;
    for (int i = 0; i< _subArray.count; i++) {
        NSDictionary* dic = _subArray[i];
        
        UIButton* Btn = [self.contentView viewWithTag:(100+i)];

        [Btn sd_setImageWithURL:[NSURL URLWithString:dic[@"img"]] forState:normal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            [Btn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(40);
                make.height.mas_equalTo(40);
            }];
        }];
        
        UILabel* lab = [self.contentView viewWithTag:(1000+i)];
        lab.text = dic[@"title"];
        
        UIButton* passBtn = [UIButton new];
        passBtn.tag = i + 100;
        [passBtn addTarget:self action:@selector(btn1:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:passBtn];
//        passBtn.backgroundColor = [UIColor redColor ];
        [passBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(Btn);
            make.left.right.bottom.equalTo(lab);
        }];
        if (i == _subArray.count - 1) {
            [_lineView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lab.mas_bottom).offset(20);
            }];
        }
    }
}

+ (instancetype)createCellWithTableView:(UITableView *)tableView
{
    static NSString * iden = @"JoinusViewCell";
    JoinusViewCell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"JoinusViewCell" owner:self options:nil]lastObject];
    }
    return cell;
}

#pragma mark -
#pragma mark lifecycle
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"JoinusViewCell" owner:self options:nil]lastObject];
        
    }
    return self;
}
- (void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[dict[@"content"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    [_contentLabel setAttributedText:attrStr];
    _workTypelabel.text = dict[@"title"]; 
}
- (IBAction)btn1:(UIButton *)sender {
    if (self.block) {
        self.block(sender.tag-100);
    }
}
- (IBAction)calButton:(UIButton *)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",_telephone]]];
}
@end
