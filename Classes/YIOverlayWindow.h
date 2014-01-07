//
//  YIOverlayWindow.h
//  YIOverlayWindow
//
//  Created by Yasuhiro Inami on 2014/01/07.
//  Copyright (c) 2014年 Yasuhiro Inami. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YIOverlayWindow : UIWindow

@property (nonatomic) UITapGestureRecognizer* tapToDismissGestureRecognizer;

- (void)presentOverlayView:(UIView*)view animated:(BOOL)animated completion:(void (^)(BOOL))completion;
- (void)presentOverlayViewController:(UIViewController*)viewController animated:(BOOL)animated completion:(void (^)(BOOL))completion;
- (void)dismissAnimated:(BOOL)animated completion:(void (^)(BOOL))completion;

@end

#pragma mark -

#pragma mark Convenient singleton methods

@interface YIOverlayWindow (Singleton)

+ (instancetype)sharedWindow;
+ (void)presentOverlayView:(UIView*)overlayView animated:(BOOL)animated completion:(void (^)(BOOL))completion;
+ (void)presentOverlayViewController:(UIViewController*)viewController animated:(BOOL)animated completion:(void (^)(BOOL))completion;
+ (void)dismissAnimated:(BOOL)animated completion:(void (^)(BOOL))completion;

@end