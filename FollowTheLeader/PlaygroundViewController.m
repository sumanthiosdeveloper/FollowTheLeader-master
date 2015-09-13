//
//  PlaygroundViewController.m
//  FollowTheLeader
//
//  Created by sumanth on 9/12/15.
//  Copyright (c) 2015 sumanth. All rights reserved.
//

#import "PlaygroundViewController.h"

@interface PlaygroundViewController ()

@property (strong, nonatomic) NSMutableArray *followers;
@property (assign, nonatomic) CGPoint leaderViewOriginalPosition;
@property (assign, nonatomic) CGPoint leaderViewNewPosition;

@end

@implementation PlaygroundViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.followers = [NSMutableArray array];
    
    [self setupGesturesToLeaderView];
    [self setupFollowerViews];
}

#pragma mark - Instance methods

- (void)setupGesturesToLeaderView {
    
    UIPanGestureRecognizer *gestrure = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveToPoint:)];
    [gestrure setMinimumNumberOfTouches:1];
    [gestrure setMaximumNumberOfTouches:1];
    [self.leaderView addGestureRecognizer:gestrure];
}

- (void)setupFollowerViews {
    
    for (NSInteger index = 0; index < [self.followersCount intValue]; index ++) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(120, 120, 20, 20)];
        view.backgroundColor = self.leaderView.backgroundColor;
        view.center = self.leaderView.center;
        [self.view addSubview:view];
        [self.followers addObject:view];
    }
    
    [self.view bringSubviewToFront:self.leaderView];
}

- (void)moveToPoint:(id)sender {
    
    self.leaderViewOriginalPosition = self.leaderView.center;
    
    UIPanGestureRecognizer *gesture = (UIPanGestureRecognizer *)sender;
    if (gesture.state == UIGestureRecognizerStateChanged) {
        
        CGPoint location = [gesture locationInView:self.view];
        [self.leaderView setCenter:location];
        self.leaderViewNewPosition = location;
        [self followTheLeader];
    }
}

- (void)followTheLeader {
    
    for (NSInteger index = 0; index < self.followers.count; index ++) {
        
        UIView *view = self.followers[index];
        
        [UIView animateWithDuration:0.5/index
                              delay:0.5/index
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                                 view.center = self.leaderViewNewPosition;
                         }
                         completion:NULL];
    }
}

#pragma mark - IBActions

- (IBAction)editButtonPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
