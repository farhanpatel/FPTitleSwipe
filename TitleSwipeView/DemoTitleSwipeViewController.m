//
//  DemoTitleSwipeViewController.m
//  TitleSwipeView
//
//  Created by Farhan Patel on 12/31/12.
//  Copyright (c) 2012 Farhan Patel. All rights reserved.
//

#import "DemoTitleSwipeViewController.h"

@interface DemoTitleSwipeViewController ()

@end

@implementation DemoTitleSwipeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray* titles = @[@"Page 1",@"Page 2",@"Page 3"];
    FPNavTitleSwipeView* view = [[FPNavTitleSwipeView alloc] initWithFrame:CGRectMake(0, 0, 120, 40) titleItems:titles];
    view.delegate = self;
    [view setCurrentPageColor:[UIColor redColor]];
    [view setPageColor:[UIColor lightGrayColor]];
    self.navigationItem.titleView = view;
    
    UILabel* testLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [testLabel setTextAlignment:NSTextAlignmentCenter];
    [testLabel setTag:1];
    [testLabel setText:@"Page 1"];
    [self.view addSubview:testLabel];
}


-(void)titleViewChange:(int)page {
    NSLog(@"new page %d",page+1);
    UILabel* testLabel = (UILabel*)[self.view viewWithTag:1];
    [testLabel setText:[NSString stringWithFormat:@"Page %d",page+1]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
