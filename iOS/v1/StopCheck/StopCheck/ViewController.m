//
//  ViewController.m
//  StopCheck
//
//  Created by Jeremiah on 30/12/13.
//  Copyright (c) 2013 Jeremiah. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //set up notificaiton listener
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentLocationAddViewController:) name:SHOW_LOCATION_ADD_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentLocationUpdateViewController:) name:SHOW_LOCATION_UPDATE_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentLocationViewController:) name:SHOW_LOCATION_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentMapViewController:) name:SHOW_MAP_NOTIFICATION object:nil];
    
    mapViewController = [[MapViewController alloc] init];
    locationManager = [[LocationManager alloc] init];
    
    [self presentMapViewController:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (LocationManager *)locationManager
{
    if(locationManager == NULL)
        locationManager = [[LocationManager alloc] init];
    
    return locationManager;
}

#pragma mark - IBActions

- (IBAction)viewControllerBtnClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSLog(@"%li, Btn pressed", (long)btn.tag);
    
}

#pragma mark - Show View Controller Methods
- (void)presentMapViewController:(NSNotification *)notification
{
    [self performSegueWithIdentifier:@"mapViewSegue" sender:self];
}
- (void)presentLocationViewController:(NSNotification *)notification
{
    location = (Location *)notification.object;
    [self performSegueWithIdentifier:@"locationViewSegue" sender:self];
}
- (void)presentLocationAddViewController:(NSNotification *)notification
{
    location = (Location *)notification.object;
    
    if(locationAddViewController == NULL)
        locationAddViewController = [[LocationAddViewController alloc] init];
    
    [locationAddViewController setLocation:location];
    [locationAddViewController setLocationManager:[self locationManager]];
    
    [self performSegueWithIdentifier:@"AddNotesSegue" sender:self];
}
- (void)presentLocationUpdateViewController:(NSNotification *)notification
{
    NSDictionary *object = (NSDictionary *)notification.object;
    location = (Location *)[object objectForKey:@"Location"];
    reminder = (Reminder *)[object objectForKey:@"Reminder"];
    
    if(locationUpdateViewController == NULL)
        locationUpdateViewController = [[LocationUpdateViewController alloc] init];
    
    [locationUpdateViewController setLocation:location];
    [locationUpdateViewController setReminder:reminder];
    [locationUpdateViewController setLocationManager:[self locationManager]];
    
    [self performSegueWithIdentifier:@"UpdateNotesSegue" sender:self];
}

#pragma mark - segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    //disable hide button
    if([segue.identifier isEqualToString:@"mapViewSegue"] || [segue.identifier isEqualToString:@"locationViewSegue"])
    {
        [[segue.destinationViewController navigationItem] setHidesBackButton:YES];
        [segue.destinationViewController setLocationManager:[self locationManager]];

    }
    //define location
    
    if([segue.identifier isEqualToString:@"AddNotesSegue"])
    {
        [segue.destinationViewController setDelegate:locationAddViewController];
        [locationAddViewController setReminderNotesViewController:segue.destinationViewController];
    }
    else if([segue.identifier isEqualToString:@"UpdateNotesSegue"])
    {
        [segue.destinationViewController setDelegate:locationUpdateViewController];
        [segue.destinationViewController setReminder:[locationUpdateViewController reminder]];
        [locationUpdateViewController setReminderNotesViewController:segue.destinationViewController];
    }
    else if ([segue.identifier isEqualToString:@"locationViewSegue"])
    {
        [segue.destinationViewController setLocation:location];
        [segue.destinationViewController setLocationManager:[self locationManager]];
    }
    
    
}

@end
