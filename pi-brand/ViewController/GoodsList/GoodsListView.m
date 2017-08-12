//
//  GoodsListView.m
//  pi-brand
//
//  Created by shengtian on 2017/8/11.
//  Copyright © 2017年 shengtian. All rights reserved.
//

#import "GoodsListView.h"
#import "GoodsListTableViewCell.h"

@interface GoodsListView ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UITableView* tableView;
@property(nonatomic,strong) NSMutableArray* array;
@property(nonatomic,strong) UIView* blackview;
@end

@implementation GoodsListView

-(void)setHiddenView:(BOOL)hiddenView{
    if (hiddenView) {
        self.blackview.hidden = NO;
    }else{
        self.blackview.hidden = YES;
    }
}
-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    NSMutableArray* temporary = [NSMutableArray new];
    for (int i = 0; i<_dataArray.count; i++) {
        [temporary insertObject:_dataArray[i] atIndex:i%1];
        if (i == _dataArray.count - 1 || temporary.count == 2) {
            [_array addObject:[temporary copy]];
            [temporary removeAllObjects];
        }
    }
    [self addSubview:self.tableView];
    [self addSubview:self.blackview];
    self.blackview.hidden = YES;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        if (!_array) {
            _array = [NSMutableArray new];
        }
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    CGFloat flt = _dataArray.count/2.0;
    return _array.count;//ceilf(flt);
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodsListTableViewCell* cell = [GoodsListTableViewCell createCellWithTableView:tableView];
    cell.dataArray = _array[indexPath.row];
    return cell;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, screenWidth, screenHeight-64) style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.estimatedRowHeight = 5;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 10)];
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 10)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = 0;
        
    }
    return _tableView;
}

-(UIView *)blackview{
    if (!_blackview) {
        _blackview = [[UIView alloc]initWithFrame:CGRectMake(0, 64, screenWidth, screenHeight-64)];
        _blackview.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    }
    return _blackview;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
