//
//  ViewController.h
//  StopCheck
//
//  Created by Jeremiah on 30/12/13.
//  Copyright (c) 2013 Jeremiah. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MapViewController.h"
#import "LocationViewController.h"
#import "LocationAddViewController.h"
#import "LocationUpdateViewController.h"

@interface ViewController : UIViewController
{
    UIViewController *activeViewController;
    
    MapViewController *mapViewController;
    LocationAddViewController *locationAddViewController;
    LocationUpdateViewController *locationUpdateViewController;
    LocationManager *locationManager;
    Location *location;
    Reminder *reminder;
}

- (LocationManager *)locationManager;

#pragma mark - IBActions

- (IBAction)viewControllerBtnClicked:(id)sender;

#pragma mark - Show View Controller Methods
- (void)presentMapViewController:(NSNotification *)notification;
- (void)presentLocationViewController:(NSNotification *)notification;
- (void)presentLocationAddViewController:(NSNotification *)notification;
- (void)presentLocationUpdateViewController:(NSNotification *)notification;



@end
