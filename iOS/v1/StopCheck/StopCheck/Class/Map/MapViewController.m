//
//  MapViewController.m
//  StopCheck
//
//  Created by Jeremiah on 2/1/14.
//  Copyright (c) 2014 Jeremiah. All rights reserved.
//

#import "MapViewController.h"

#define LOCATION_DID_SELECT_NOTIFICATION @"LocationDidSelectNotification"

#define INFO_BUTTON_VIEW @"View Notes"
#define INFO_BUTTON_ADD @"Add Notes"

@interface MapViewController ()

@end

@implementation MapViewController

@synthesize
info_btn,
info_name_lbl,
info_street_lbl;

#pragma mark - View Life Cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    //Get All Monitored Location
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(displayMonitoredLocation:) name:MONITORED_LOCATION_NOTIFICATION object:nil];
    [[self locationManager] monitoredRegionWithNotification:MONITORED_LOCATION_NOTIFICATION];
    
    if(currentPin == NULL)
        [self dismissLocationInformationAnimated:NO];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //long press gesture recogniser
    UILongPressGestureRecognizer *longTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(mapViewDidTap:)];
    [self.mapView addGestureRecognizer:longTap];
    
    //Move to current location
    isShowingUserLocation = NO;
    [self.mapView setShowsUserLocation:YES];
    
    //search table
    search_DatabaseTableData = [[NSArray alloc] init];
    search_ResponseTableData = [[NSArray alloc] init];
    [self dismissSearchTable];
    
    //dismiss location information
    [self dismissLocationInformationAnimated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"AllLocationViewControllerSegue"])
    {
        [segue.destinationViewController setTableArray:monitoredLocationPinArray];
        [segue.destinationViewController setLocationManager:[self locationManager]];
    }
}

#pragma mark - Display Methods

- (void)dropPinCoordinate:(CLLocationCoordinate2D)coordinate
{
    [self.mapView removeAnnotation:currentPin];
    currentPin = NULL;
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = coordinate;
    annotation.title = @"temp";
    
    [self.mapView addAnnotation:annotation];
    [self.mapView setCenterCoordinate:coordinate animated:YES];
    
    currentPin = annotation;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationFetchComplete:) name:LOCATION_DID_SELECT_NOTIFICATION object:nil];
    [[self locationManager] locationOfCoordinate:coordinate
                             Notification:LOCATION_DID_SELECT_NOTIFICATION];
}

- (void)dropPinMonitored:(MonitoredLocationPin *)monitoredPin
{
    NSLog(@"%@", monitoredLocationPinArray);
    [monitoredLocationPinArray addObject:monitoredPin];
    [self.mapView addAnnotation:monitoredPin];
}

- (void)clearPinMonitored
{
    NSUInteger ii, length = [monitoredLocationPinArray count];
    for(ii = 0; ii<length; ii++)
    {
        [self.mapView removeAnnotation:[monitoredLocationPinArray objectAtIndex:ii]];
    }
}

- (void)displayLocationInformationWithName:(NSString *)name
                                    Street:(NSString *)street
                                    Button:(NSString *)button
{
    CGRect frame = [self.info_view frame];
    if(frame.origin.y >= self.view.bounds.size.height)
    {
        //it is hidden
        //need to bring it up
        
        frame.origin.y = self.view.bounds.size.height - frame.size.height;
        [UIView animateWithDuration:0.3 animations:^{
            [self.info_view setFrame:frame];
        }];
        
    }
    
    [info_btn setTitle:button forState:UIControlStateNormal];
    
    [UIView beginAnimations:@"animateText" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.3];
    [self.info_name_lbl setAlpha:0];
    [self.info_street_lbl setAlpha:0];
    [self.info_name_lbl setText:name];
    [self.info_street_lbl setText:street];
    [self.info_name_lbl setAlpha:1];
    [self.info_street_lbl setAlpha:1];
    [UIView commitAnimations];
}

- (void)dismissLocationInformationAnimated:(BOOL)animated
{
    CGRect frame = [self.info_view frame];
    NSLog(@"%f, %f", frame.origin.y, self.view.bounds.size.height);
    if(frame.origin.y < self.view.bounds.size.height)
    {
        //it is not hidde
        //need to bring it down
        frame.origin.y = self.view.bounds.size.height;
        if(animated)
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self.info_view setFrame:frame];
            }];
        }
        else
            [self.info_view setFrame:frame];
        
        
        
    }
}

- (void)displaySearchTable
{
    [self.searchTableView setAlpha:1];
}

- (void)dismissSearchTable
{
    [self.searchTableView setAlpha:0];
}

#pragma mark - IBAction

- (IBAction)addNewBtnPressed:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    if([btn.titleLabel.text isEqualToString:INFO_BUTTON_ADD])
        [NotificationCenter requestForLocationAddViewControllerWithLocation:location];
    else if([btn.titleLabel.text isEqualToString:INFO_BUTTON_VIEW])
        [NotificationCenter requestForLocationViewControllerWithLocation:location];
}

#pragma mark - Map View Listener

- (void)mapViewDidTap:(UIGestureRecognizer *)gesture
{
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        CGPoint touchPoint = [gesture locationInView:self.mapView];
        CLLocationCoordinate2D touchMapCoordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
        
        [self dropPinCoordinate:touchMapCoordinate];
        
    }

}

- (void)locationFetchComplete:(NSNotification *)notification
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LOCATION_DID_SELECT_NOTIFICATION object:nil];
    Location *fetchedLocation = (Location *)notification.object;
    location = fetchedLocation;
    
    NSLog(@"Location Fetch Complete");
    
    [self displayLocationInformationWithName:fetchedLocation.name Street:fetchedLocation.street Button:INFO_BUTTON_ADD];
}


- (void)displayMonitoredLocation:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MONITORED_LOCATION_NOTIFICATION object:nil];
    [self clearPinMonitored];
    
    NSArray *monitoredLocation = notification.object;
    monitoredLocationPinArray = [[NSMutableArray alloc] init];
    
    NSUInteger ii, length = [monitoredLocation count];
    Location_CD *currentMonitoredLocation;
    for(ii = 0; ii<length; ii++)
    {
        currentMonitoredLocation = (Location_CD *)[monitoredLocation objectAtIndex:ii];
        
        MonitoredLocationPin *monitoredPin = [[MonitoredLocationPin alloc] init];
        
        monitoredPin.coordinate = CLLocationCoordinate2DMake(currentMonitoredLocation.latitude.floatValue, currentMonitoredLocation.longitude.floatValue);
        monitoredPin.location = [[Location alloc] initWithLocation:currentMonitoredLocation];
        
        [self dropPinMonitored:monitoredPin];
    }
    
}

- (void)searchLocationComplete:(NSNotification *)notification
{
    
    NSDictionary *object = (NSDictionary *)notification.object;
    
    search_DatabaseTableData = [object objectForKey:@"database"];
    search_ResponseTableData = [object objectForKey:@"response"];
    
    [self.searchTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}

#pragma mark - MKMapViewDelegate Method

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if(!isShowingUserLocation)
    {
        NSInteger meters = 2000;
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, meters, meters);
        [self.mapView setRegion:region];
        isShowingUserLocation = YES;
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString *annotationIdentifier = @"annotation";
    MKPinAnnotationView *customAnnotation = [[MKPinAnnotationView alloc]
                                          initWithAnnotation:annotation
                                          reuseIdentifier:annotationIdentifier];
    
    if([annotation isKindOfClass:[MKUserLocation class]])
    {
        return nil;
    }
    else if([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        customAnnotation.animatesDrop = YES;
        if([annotation isKindOfClass:[MonitoredLocationPin class]])
        {
            customAnnotation.pinColor = MKPinAnnotationColorGreen;
            customAnnotation.animatesDrop = NO;
        }
    }
    
    return customAnnotation;
    
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    CLLocationCoordinate2D coordinate;
    
    if(![view.annotation.title isEqualToString:@"temp"])
    {
        if([view.annotation isKindOfClass:[MKUserLocation class]])
        {
            coordinate = [mapView.userLocation coordinate];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationFetchComplete:) name:LOCATION_DID_SELECT_NOTIFICATION object:nil];
            [[self locationManager] locationOfCoordinate:coordinate
                                     Notification:LOCATION_DID_SELECT_NOTIFICATION];
        }
        else if([view.annotation isKindOfClass:[MonitoredLocationPin class]])
        {
            MonitoredLocationPin *pin = (MonitoredLocationPin *)view.annotation;
            coordinate = pin.coordinate;
            location = pin.location;
            [self displayLocationInformationWithName:location.name Street:location.street Button: INFO_BUTTON_VIEW];
        }
        
        
        [self.mapView removeAnnotation:currentPin];
    }
    else
    {
        [info_btn setTitle:INFO_BUTTON_ADD forState:UIControlStateNormal];
    }
    
    
}

#pragma mark - UITableViewDataSource Method

- (int)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [search_DatabaseTableData count] + [search_ResponseTableData count];
}

#pragma mark - UITableViewDelegate Method

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //DatabaseLocationCell
    
    static NSString *CellIdentifier = @"SearchLocationCell";
    UITableViewCell *cell;
    NSString *currentItemName;
    NSInteger tag;
    
    if(indexPath.row < [search_DatabaseTableData count])
    {
        CellIdentifier = @"DatabaseLocationCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == NULL)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }

        Location_CD *currentItem = (Location_CD *)[search_DatabaseTableData objectAtIndex:indexPath.row];
        currentItemName = currentItem.name;
        tag = 0;
    }
    else
    {
        CellIdentifier = @"SearchLocationCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == NULL)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        NSUInteger row = indexPath.row - [search_DatabaseTableData count];
        MKMapItem *currentItem = (MKMapItem *)[search_ResponseTableData objectAtIndex:row];
        currentItemName = currentItem.name;
        tag = 1;
    }
    
    [[cell textLabel] setText:currentItemName];
    cell.tag = tag;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //deselect
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSString *street;
    NSString *name;
    NSString *buttonTitle;
    CLLocationCoordinate2D coordinate;
    
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if(cell.tag == 1)
    {
        NSUInteger row = indexPath.row - [search_DatabaseTableData count];
        MKMapItem *selectedMapItem = (MKMapItem *)[search_ResponseTableData objectAtIndex:row];
        NSDictionary *address = selectedMapItem.placemark.addressDictionary;
        
        street = [address objectForKey:@"Street"];
        name = [address objectForKey:@"Name"];
        coordinate = selectedMapItem.placemark.coordinate;
        buttonTitle = INFO_BUTTON_ADD;
        
        //drop Pin
        [self dropPinCoordinate:coordinate];
        
    }
    else if(cell.tag == 0)
    {
        Location_CD *locationCD = (Location_CD *)[search_DatabaseTableData objectAtIndex:indexPath.row];
        
        street = locationCD.street;
        name = locationCD.name;
        coordinate = CLLocationCoordinate2DMake(locationCD.latitude.doubleValue, locationCD.longitude.doubleValue);
        buttonTitle = INFO_BUTTON_VIEW;
        
        //move to lcoation
        [self.mapView setCenterCoordinate:coordinate];
    }
    
    Location *selectedLocation = [[self locationManager] locationOfCoordinate:coordinate Name:name Street:street];
    
    //update location information
    [self displayLocationInformationWithName:selectedLocation.name Street:selectedLocation.street Button:buttonTitle];
    //set location
    location = selectedLocation;
    //dismiss table view
    [self dismissSearchTable];
    //remove cancel
    [self.searchBar setShowsCancelButton:NO];
    //change search bar
    [self.searchBar setSearchBarStyle:UISearchBarStyleMinimal];
    //remove keyboard
    [self.view endEditing:YES];
    
}
#pragma mark - UISearchBarDelegate Method

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"Begin");
    [searchBar setSearchBarStyle:UISearchBarStyleProminent];
    [searchBar setShowsCancelButton:YES animated:YES];
    [self displaySearchTable];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    //dismiss search bar
    [searchBar setSearchBarStyle:UISearchBarStyleMinimal];
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar setText:nil];
    
    //dismiss search table
    [self dismissSearchTable];
    
    //dismiss keyboard
    [searchBar endEditing:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"Search");
    
    //dismiss keyboard
    [searchBar endEditing:YES];
    
    //send search
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchLocationComplete:) name:SEARCH_NOTIFICATION object:nil];
    [[self locationManager] locationOfSearchQuery:searchBar.text Region:self.mapView.region Notification:SEARCH_NOTIFICATION];
    
    
}

#pragma mark - Location Manager

- (void)setLocationManager:(LocationManager *)newlocationManager
{
    locationManager = newlocationManager;
}

- (LocationManager *)locationManager
{
    if(locationManager == NULL)
        locationManager = [[LocationManager alloc] init];
    
    return locationManager;
}


@end
