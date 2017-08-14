//
//  ADVICEView.m
//  pi-brand
//
//  Created by Madodg on 2017/8/14.
//  Copyright © 2017年 shengtian. All rights reserved.
//

#import "ADVICEView.h"

@interface ADVICEView ()<UIScrollViewDelegate,UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>{
    UIScrollView *_scroll;
    NSInteger _currentIndex;
    UIButton* _btn1;
    UIButton* _btn2;
}
@property(nonatomic,assign) NSInteger cont;
@property(nonatomic,assign) CGPoint startLocation;
@property(nonatomic,assign) CGPoint stopLocation;
@end

@implementation ADVICEView

-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    _cont = _dataArray.count;
    [self addScrollView];
    [self addScrollTableView];
    [self addbtn];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIPanGestureRecognizer * recognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
        recognizer.delegate = self;
        [self addGestureRecognizer:recognizer];
    }
    return self;
}

- (void)handleSwipeFrom:(UIPanGestureRecognizer *)recognizer{
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        _startLocation = [recognizer locationInView:self];
        
    }
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        _stopLocation = [recognizer locationInView:self];
        CGFloat dx = _stopLocation.x - _startLocation.x;
        if(dx>85) {
            DebugLog(@"left");
            
        }
        if(dx<-85) {
            DebugLog(@"right");
//            _scroll 
        }
        
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

-(void)addbtn{
    UIButton* btn1 = [UIButton new];
    _btn1 = btn1;
    [btn1 setImage:[UIImage imageNamed:@"left"] forState:normal];
//    btn1.hidden = YES;
    [self addSubview:btn1];
    UIButton* btn2 = [UIButton new];
    _btn2 = btn2;
    [btn2 setImage:[UIImage imageNamed:@"right"] forState:normal];
    [self addSubview:btn2];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.offset(2);
    }];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.offset(-2);
    }];
}

- (void)addScrollTableView
{
    CGSize size = _scroll.frame.size;
    for (int i = 0; i<_cont; i++) {
        
        NSString* imageString = _dataArray[i][@"img"];
        UITableView* tableView = [[UITableView alloc]initWithFrame:CGRectMake(i * size.width, 0, size.width, size.height - 62 )];
        [_scroll addSubview:tableView];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = [UIView new];
        UIImageView * backImageView = [UIImageView new];
        backImageView.alpha = 0;
        [backImageView sd_setImageWithURL:[imageString safeUrlString] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            CGSize imageSize = image.size;
            backImageView.frame = CGRectMake(0, 0, screenWidth, imageSize.height/imageSize.width*screenWidth);
            tableView.tableHeaderView = backImageView;
            [UIView transitionWithView:backImageView duration:during options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                backImageView.alpha = 1;
            } completion:nil];
        }];
        tableView.tag = i;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.showsHorizontalScrollIndicator = NO;
        tableView.bounces = NO;
    }
}

- (void)addScrollView
{
    UIScrollView *scroll = [[UIScrollView alloc] init];
    CGRect rect = [[UIScreen mainScreen] bounds];
    scroll.frame = rect;
    scroll.showsHorizontalScrollIndicator = NO;
    CGSize size = scroll.frame.size;
    scroll.contentSize = CGSizeMake(size.width * _cont, 0);
    scroll.pagingEnabled = YES;
    scroll.delegate = self;
    scroll.bounces = NO;
    [self addSubview:scroll];
    _scroll = scroll;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y>=0) {
        return;
    }
    NSInteger page = scrollView.contentOffset.x / screenWidth;
//    NSLog(@"%f",scrollView.contentOffset.y);
//    if (page == 0) {
//        _btn1.hidden = YES;
//    }else{
//        _btn1.hidden = NO;
//    }
//    if (page == _cont - 1) {
//        _btn2.hidden = YES;
//    }else{
//        _btn2.hidden = NO;
//    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
