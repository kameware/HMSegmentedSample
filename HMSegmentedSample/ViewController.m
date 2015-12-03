//
//  ViewController.m
//  HMSegmentedSample
//
//  Created by mineharu on 2015/12/04.
//  Copyright © 2015年 mine. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGFloat scrollWidth = self.view.frame.size.width;
    CGFloat scrollHeight = self.view.frame.size.height - self.headerView.frame.size.height;
    
    self.segmentedControl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.headerView.frame.size.height)];
    self.segmentedControl.sectionTitles = @[@"あか", @"あお", @"みどり"];
    self.segmentedControl.selectedSegmentIndex = 0;
    self.segmentedControl.backgroundColor = [UIColor orangeColor];
    self.segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor yellowColor]};
    self.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.segmentedControl.selectionIndicatorColor = [UIColor lightGrayColor];
    self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleBox;
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    
    __weak typeof(self) weakSelf = self;
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
        [weakSelf.scrollView scrollRectToVisible:CGRectMake(scrollWidth * index, 0, scrollWidth, 200) animated:YES];
    }];
    
    [self.headerView addSubview:self.segmentedControl];
    
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(scrollWidth * 3, scrollHeight);
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    
    UIView *page1view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, scrollWidth, scrollHeight)];
    page1view.backgroundColor = [UIColor redColor];
    [self.scrollView addSubview:page1view];
    
    UIView *page2view = [[UIView alloc] initWithFrame:CGRectMake(scrollWidth, 0, scrollWidth, scrollHeight)];
    page2view.backgroundColor = [UIColor blueColor];
    [self.scrollView addSubview:page2view];
    
    UIView *page3view = [[UIView alloc] initWithFrame:CGRectMake(scrollWidth * 2, 0, scrollWidth, scrollHeight)];
    page3view.backgroundColor = [UIColor greenColor];
    [self.scrollView addSubview:page3view];
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    
    [self.segmentedControl setSelectedSegmentIndex:page animated:YES];
}

@end
