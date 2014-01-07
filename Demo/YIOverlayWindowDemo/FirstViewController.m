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
    
#else
    // view example
    
    UINib* nib = [UINib nibWithNibName:@"TutorialView" bundle:nil];
    UIView* overlayView = [[nib instantiateWithOwner:self options:nil] objectAtIndex:0];
    
    [YIOverlayWindow presentOverlayView:overlayView animated:YES completion:NULL];
    
#endif
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
