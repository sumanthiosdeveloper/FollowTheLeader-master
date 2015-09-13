//
//  ViewController.m
//  FollowTheLeader
//
//  Created by sumanth on 9/12/15.
//  Copyright (c) 2015 sumanth. All rights reserved.
//

#import "ConfigurationViewController.h"
#import "PlaygroundViewController.h"

@implementation ConfigurationViewController


- (IBAction)letsPlayButtonPressed:(id)sender {
    
    [self performSegueWithIdentifier:@"playgroundSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"playgroundSegue"]) {
        
        UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
        
        PlaygroundViewController *playgroundVC = (PlaygroundViewController *)[navController topViewController];
        playgroundVC.followersCount = @([self.followersCountTextBox.text integerValue]);
    }
}

@end
