//
//  NotificationCenter.h
//  StopCheck
//
//  Created by Jeremiah on 7/1/14.
//  Copyright (c) 2014 Jeremiah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"

@interface NotificationCenter : NSObject

+ (void)requestForLocationAddViewControllerWithLocation:(Location *)location;
+ (void)requestForLocationUpdateViewControllerWithLocation:(NSDictionary *)location;
+ (void)requestForLocationViewControllerWithLocation:(Location *)location;
+ (void)requestForMapViewControllerWithLocation:(Location *)location;

@end
