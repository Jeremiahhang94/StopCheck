//
//  MapViewController.h
//  StopCheck
//
//  Created by Jeremiah on 2/1/14.
//  Copyright (c) 2014 Jeremiah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "AllLocationViewController.h"

#define MONITORED_LOCATION_NOTIFICATION @"monitoredLocationNotification"
#define SEARCH_NOTIFICATION @"searchNotification"

@interface MapViewController : UIViewController <MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
{
    Location *location;
    MKPointAnnotation *currentPin;
    BOOL isShowingUserLocation;
    NSMutableArray *monitoredLocationPinArray;
    
    //Search Table Data
    NSArray *search_DatabaseTableData;
    NSArray *search_ResponseTableData;
    
    //location manager
    LocationManager *locationManager;
}

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIView *info_view;
@property (strong, nonatomic) IBOutlet UILabel *info_name_lbl;
@property (strong, nonatomic) IBOutlet UILabel *info_street_lbl;
@property (strong, nonatomic) IBOutlet UIButton *info_btn;

//Search Mechanism
@property (strong, nonatomic) IBOutlet UITableView *searchTableView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

- (void)dropPinCoordinate:(CLLocationCoordinate2D)coordinate;
- (void)dropPinMonitored:(MonitoredLocationPin *)monitoredPin;
- (void)clearPinMonitored;
- (void)displayLocationInformationWithName:(NSString *)name Street:(NSString *)street Button:(NSString *)button;
- (void)dismissLocationInformationAnimated:(BOOL)animated;

- (void)displaySearchTable;
- (void)dismissSearchTable;

#pragma mark - IBAction

- (IBAction)addNewBtnPressed:(id)sender;

#pragma mark - Map View Listener

- (void)mapViewDidTap:(UIGestureRecognizer *)gesture;
- (void)locationFetchComplete:(NSNotification *)notification;
- (void)displayMonitoredLocation:(NSNotification *)notification;
- (void)searchLocationComplete:(NSNotification *)notification;

#pragma mark - Location Manager

- (void)setLocationManager:(LocationManager *)newlocationManager;
- (LocationManager *)locationManager;

@end
