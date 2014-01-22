//
//  YIOverlayWindow.m
//  YIOverlayWindow
//
//  Created by Yasuhiro Inami on 2014/01/07.
//  Copyright (c) 2014年 Yasuhiro Inami. All rights reserved.
//

#import "YIOverlayWindow.h"

#define ANIMATION_DURATION  0.3

@implementation YIOverlayWindow

- (id)init
{
    return [self initWithFrame:[UIScreen mainScreen].bounds];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.windowLevel = UIWindowLevelStatusBar+1;
        self.opaque = NO;    // for transparency while rotating
        
        _tapToDismissGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapToDismissGesture:)];
        [self addGestureRecognizer:_tapToDismissGestureRecognizer];
    }
    return self;
}

- (void)handleTapToDismissGesture:(UITapGestureRecognizer*)gesture
{
    [self dismissAnimated:YES completion:NULL];
}

- (void)presentOverlayView:(UIView*)view animated:(BOOL)animated completion:(void (^)(BOOL))completion
{
    [self presentOverlayViewController:nil animated:animated completion:completion];
    
    // comment-out: don't resize automatically for partial overlay
//    view.frame = self.rootViewController.view.bounds;
//    view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    
    [self.rootViewController.view addSubview:view];
}

- (void)presentOverlayViewController:(UIViewController*)viewController animated:(BOOL)animated completion:(void (^)(BOOL))completion
{
    if (viewController) {
        self.rootViewController = viewController;
    }
    else {
        self.rootViewController = [[UIViewController alloc] init];
    }
    
#if !defined(__IPHONE_7_0) || __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    self.rootViewController.wantsFullScreenLayout = YES;
#endif
    
    [self makeKeyAndVisible];
    
    self.rootViewController.view.alpha = 0;
    
    [UIView animateWithDuration:(animated ? ANIMATION_DURATION : 0) animations:^{
        self.rootViewController.view.alpha = 1;
    } completion:completion];
}

- (void)dismissAnimated:(BOOL)animated completion:(void (^)(BOOL))completion
{
    [UIView animateWithDuration:(animated ? ANIMATION_DURATION : 0) animations:^{
        self.rootViewController.view.alpha = 0;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        self.rootViewController = nil;
        
        UIWindow* mainWindow = [UIApplication sharedApplication].delegate.window;
        [mainWindow makeKeyAndVisible];
        
        if (completion) {
            completion(finished);
        }
    }];
}

#pragma mark -

#pragma mark UIViewGeometry

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    for (UIView* subview in self.rootViewController.view.subviews) {
        CGPoint convertedPoint = [self convertPoint:point toView:subview];
        
        if ([subview pointInside:convertedPoint withEvent:event]) {
            return YES;
        }
    }
    
    // don't detect non-presenting view touches & forward to next window
    return NO;
}

@end


#pragma mark -

#pragma mark Convenient singleton methods

@implementation YIOverlayWindow (Singleton)

+ (instancetype)sharedWindow
{
    static dispatch_once_t onceToken = 0;
    static id instance = nil;
    
    dispatch_once(&onceToken, ^{
        instance = [[YIOverlayWindow alloc] init];
    });
    
    return instance;
}

+ (void)presentOverlayView:(UIView*)overlayView animated:(BOOL)animated completion:(void (^)(BOOL))completion
{
    [[self sharedWindow] presentOverlayView:overlayView animated:animated completion:completion];
}

+ (void)presentOverlayViewController:(UIViewController*)viewController animated:(BOOL)animated completion:(void (^)(BOOL))completion
{
    [[self sharedWindow] presentOverlayViewController:viewController animated:animated completion:completion];
}

+ (void)dismissAnimated:(BOOL)animated completion:(void (^)(BOOL))completion
{
    [[self sharedWindow] dismissAnimated:animated completion:completion];
}

@end
