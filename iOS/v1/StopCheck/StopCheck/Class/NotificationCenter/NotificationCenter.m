//
//  NotificationCenter.m
//  StopCheck
//
//  Created by Jeremiah on 7/1/14.
//  Copyright (c) 2014 Jeremiah. All rights reserved.
//

#import "NotificationCenter.h"

@implementation NotificationCenter

+ (void)requestForLocationAddViewControllerWithLocation:(Location *)location
{
    [[NSNotificationCenter defaultCenter] postNotificationName:SHOW_LOCATION_ADD_NOTIFICATION object:location];
}
+ (void)requestForLocationUpdateViewControllerWithLocation:(NSDictionary *)location
{
    [[NSNotificationCenter defaultCenter] postNotificationName:SHOW_LOCATION_UPDATE_NOTIFICATION object:location];
}
+ (void)requestForLocationViewControllerWithLocation:(Location *)location
{
    [[NSNotificationCenter defaultCenter] postNotificationName:SHOW_LOCATION_NOTIFICATION object:location];
}
+ (void)requestForMapViewControllerWithLocation:(Location *)location
{
    [[NSNotificationCenter defaultCenter] postNotificationName:SHOW_MAP_NOTIFICATION object:location];
}

@end
