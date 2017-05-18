//
//  ViewController.m
//  Demo
//
//  Created by apple on 18/05/2017.
//  Copyright © 2017 Eric. All rights reserved.
//

#import "ViewController.h"
#import "StatementView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    StatementView *statementView = [[StatementView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 300)];
    statementView.backgroundColor = [UIColor darkGrayColor];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:statementView];
    statementView.dataArray = @[@"20",@"2",@"100",@"50",@"60",@"200",@"30",@"150",@"189",@"400",@"50",@"40",@"33",@"11",@"67",@"45",@"11",@"111",@"145",@"456",@"33",@"1",@"67",@"88",@"134",@"122",@"14",@"55",@"77",@"44"];
    statementView.dayTimes = @"20";
    statementView.weakTimes = @"100";
    statementView.monthTimes = @"300";
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
