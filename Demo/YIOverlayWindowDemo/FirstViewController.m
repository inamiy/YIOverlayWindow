//
//  FirstViewController.m
//  YIOverlayWindowDemo
//
//  Created by Yasuhiro Inami on 2014/01/07.
//  Copyright (c) 2014年 Yasuhiro Inami. All rights reserved.
//

#import "FirstViewController.h"
#import "YIOverlayWindow.h"
#import "TutorialViewController.h"


@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
#if 1
    // viewController example
    
    //
    // NOTE:
    // Specify nibName=TutorialViewController.xib here, or TutorialView.xib will be loaded instead.
    // (see [UIViewController nibName] in document)
    //
    TutorialViewController* tutorialVC = [[TutorialViewController alloc] initWithNibName:@"TutorialViewController" bundle:nil];
    [YIOverlayWindow presentOverlayViewController:tutorialVC animated:YES completion:NULL];
    
#elif 0
    // view example
    
    UINib* nib = [UINib nibWithNibName:@"TutorialView" bundle:nil];
    UIView* overlayView = [[nib instantiateWithOwner:self options:nil] objectAtIndex:0];
    
    [YIOverlayWindow presentOverlayView:overlayView animated:YES completion:NULL];
    
#else
    // partial view example
    
    UILabel* overlayLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 200, 50)];
    overlayLabel.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
    overlayLabel.text = @"Tap here to dismiss";
    overlayLabel.textAlignment = NSTextAlignmentCenter;
    
    [YIOverlayWindow presentOverlayView:overlayLabel animated:YES completion:NULL];
    
#endif
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
