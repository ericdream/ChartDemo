//
//  StatementView.m
//  RefreshDemo
//
//  Created by apple on 18/05/2017.
//  Copyright © 2017 Eric. All rights reserved.
//

#import "StatementView.h"
#define defaultHeith 45
#define numberSection 4   // 等级数
@interface StatementView ()
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)FooterView *footerView;
@property(nonatomic,strong)DataContentView *contenView;

@end
// 每个日期所占宽度 每页10个日期
//CGFloat dayWidth(){
//    return (kDeviceWidth-20)/10;
//}
@implementation StatementView{
    CGFloat dayWidth;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self scrollView];
        [self footerView];
        /*    data   */
        [self contenView];
        dayWidth = (CGRectGetWidth(frame)-20)/10.0;
    }
    return self;
}
- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    _contenView.array = dataArray;
    CGFloat totalWidth = dataArray.count*dayWidth;
    CGRect contentRect = CGRectMake(0, 0, totalWidth, CGRectGetHeight(_scrollView.frame));
    _contenView.frame = contentRect;
    _scrollView.contentSize = CGSizeMake(totalWidth, CGRectGetHeight(self.scrollView.frame));
}
- (void)setDayTimes:(NSString *)dayTimes{
    self.footerView.dayLb.text = [NSString stringWithFormat:@"%@次",dayTimes];
}
- (void)setWeakTimes:(NSString *)weakTimes{
    self.footerView.weakLb.text = [NSString stringWithFormat:@"%@次",weakTimes];
}
- (void)setMonthTimes:(NSString *)monthTimes{
    self.footerView.monthLb.text = [NSString stringWithFormat:@"%@次",monthTimes];
}

- (DataContentView *)contenView{
    if(_contenView == nil){
        _contenView = [[DataContentView alloc] initWithFrame:self.scrollView.frame contentW:CGRectGetWidth(self.frame)];
        _contenView.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:_contenView];
    }
    return _contenView;
}
- (UIScrollView *)scrollView{
    if(_scrollView == nil){
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), defaultHeith*numberSection+50)];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = YES;
        _scrollView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_scrollView];
    }
    return _scrollView;
}
- (FooterView *)footerView{
    if(_footerView == nil){
        _footerView = [[FooterView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scrollView.frame), CGRectGetWidth(self.frame), 60)];
        _footerView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        [self addSubview:_footerView];
    }
    return _footerView;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
@interface FooterView ()
@property(nonatomic,strong) UILabel *dayTitleLb;

@property(nonatomic,strong) UILabel *weakTitleLb;

@property(nonatomic,strong) UILabel *monthTitleLb;

@end
@implementation FooterView
- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self creatItem];
        self.opaque = NO;
    }
    return self;
}
- (void)creatItem{
    
    CGFloat itemWidth = CGRectGetWidth(self.frame)/3.0;
    CGFloat itmeHeight = (self.frame.size.height-20)/2.0;
    
    _dayTitleLb = [self creatLbWithFont:14 color:[UIColor colorWithWhite:0.4 alpha:0.5]];
    _dayTitleLb.text = @"今日";
    [self addSubview:_dayTitleLb];
    _dayLb = [self creatLbWithFont:14 color:[UIColor colorWithWhite:0.4 alpha:0.5]];
    [self addSubview:_dayLb];
    _weakTitleLb = [self creatLbWithFont:14 color:[UIColor colorWithWhite:0.4 alpha:0.5]];
    _weakTitleLb.text = @"本周";
    [self addSubview:_weakTitleLb];
    _weakLb = [self creatLbWithFont:14 color:[UIColor colorWithWhite:0.4 alpha:0.5]];
    [self addSubview:_weakLb];
    _monthTitleLb = [self creatLbWithFont:14 color:[UIColor colorWithWhite:0.4 alpha:0.5]];
    _monthTitleLb.text = @"本月";
    [self addSubview:_monthTitleLb];
    _monthLb = [self creatLbWithFont:14 color:[UIColor colorWithWhite:0.4 alpha:0.5]];
    [self addSubview:_monthLb];
    NSArray *titles = @[_dayTitleLb,_weakTitleLb,_monthTitleLb];
    NSArray *contents = @[_dayLb,_weakLb,_monthLb];
    [titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *lb = (UILabel *)obj;
        lb.frame = CGRectMake(itemWidth*idx, 10, itemWidth, itmeHeight);
    }];
    [contents enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *lb = (UILabel *)obj;
        lb.frame = CGRectMake(itemWidth*idx, itmeHeight+10, itemWidth, itmeHeight);
    }];
}

- (UILabel *)creatLbWithFont:(CGFloat)font color:(UIColor *)color{
    UILabel *lb = [[UILabel alloc] init];
    lb.font = [UIFont systemFontOfSize:font];
    lb.textAlignment = NSTextAlignmentCenter;
    lb.textColor = color;
    return lb;
}

@end
@implementation DataContentView{
    CGFloat dayWidth;
}
- (instancetype)initWithFrame:(CGRect)frame contentW:(CGFloat)width{
    if(self = [super initWithFrame:frame]){
        dayWidth = (width-20)/10;
    }
    return self;
    
}
- (void)setArray:(NSArray *)array{
    _array = array;
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGFloat max = [[_array valueForKeyPath:@"@max.floatValue"] floatValue];
    NSInteger r_itemHeight = max /numberSection;
    for (int i =0; i<numberSection; i++) {
        UIColor *color = [UIColor colorWithWhite:0.8 alpha:1];
        if(i==3) color = [UIColor blueColor];
        [self addLineWithY:defaultHeith*(i+1) color:color];
        NSString *unit = [NSString stringWithFormat:@"%li",(numberSection-(i+1))*r_itemHeight];
        [self drawStrWithRecrt:CGRectMake(0, defaultHeith*(i+1)-7, 50, 20) str:unit font:[UIFont systemFontOfSize:10] color:[UIColor lightGrayColor] alignment:NSTextAlignmentLeft];
    }
    [self addLineChartWith:_array];
    [self addPointsWithData:_array];
    for (int i=0; i<_array.count; i++) {
        NSString *dateStr = [NSString stringWithFormat:@"%02d",i+1];
        CGFloat itemsW = dayWidth;
        [self drawStrWithRecrt:CGRectMake(itemsW*i, defaultHeith*numberSection+20, itemsW, 20)  str:dateStr font:[UIFont systemFontOfSize:14] color:[UIColor darkGrayColor] alignment:NSTextAlignmentCenter];
    }
}
- (void)drawStrWithRecrt:(CGRect)rect str:(NSString *)string font:(UIFont*)font color:(UIColor *)color alignment:(NSTextAlignment)alignment{
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.alignment = alignment;
    [string drawInRect:rect withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color,NSParagraphStyleAttributeName:paragraphStyle}];
}
- (void)addLineWithY:(CGFloat)y color:(UIColor *)color{
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(contextRef, 0.5);
    CGPoint start = CGPointMake(30, y);
    CGPoint end = CGPointMake(CGRectGetWidth(self.frame)-10, y);
    CGContextMoveToPoint(contextRef, start.x, start.y);
    CGContextAddLineToPoint(contextRef, end.x, end.y);
    [color setStroke];
    CGContextStrokePath(contextRef);
}
- (void)addLineChartWith:(NSArray *)points{
    CGContextRef contextRf = UIGraphicsGetCurrentContext();
    // 坐标转化
    CGFloat max = [[points valueForKeyPath:@"@max.floatValue"] floatValue];
    CGFloat k = (defaultHeith*4)/max; //  转化系数
    
    CGFloat itemsW = dayWidth;
    [points enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat point_y = getPointY([obj floatValue], k);
        CGFloat point_x = 20+itemsW*idx;
        
        if(idx ==0){
            CGContextMoveToPoint(contextRf, point_x, point_y);
        }else{
            CGContextAddLineToPoint(contextRf, point_x, point_y);
        }
    }];
    [[UIColor blueColor] setStroke];
    CGContextStrokePath(contextRf);
}

- (void)addPointsWithData:(NSArray *)points{
    CGContextRef contextRf = UIGraphicsGetCurrentContext();
    // 坐标转化
    CGFloat max = [[points valueForKeyPath:@"@max.floatValue"] floatValue];
    CGFloat k = (defaultHeith*4)/max; //  转化系数
    
    CGFloat itemsW = dayWidth;
    [points enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat point_y = getPointY([obj floatValue], k)-2;
        CGFloat point_x = 20+itemsW*idx-2;
        
        CGContextAddRect(contextRf, CGRectMake(point_x, point_y, 4, 4));
    }];
    [[UIColor blueColor] setFill];
    CGContextFillPath(contextRf);
}
- (void)addPointWithX:(CGFloat)x Y:(CGFloat)y{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddRect(context, CGRectMake(x, y, 4, 4));
    [[UIColor blueColor] setFill];
    CGContextFillPath(context);
    
}
// y 坐标转化 坐标系统和实际的是反的
CGFloat getPointY(CGFloat y,CGFloat k){
    y = y*k;
    y = defaultHeith*numberSection -y;
    return y;
}
@end
