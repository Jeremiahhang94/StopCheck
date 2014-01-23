//
//  Map.m
//  StopCheck
//
//  Created by Jeremiah on 2/1/14.
//  Copyright (c) 2014 Jeremiah. All rights reserved.
//

#import "Map.h"

@implementation Map

@synthesize viewController;

- (id)init
{
    self = [super init];
    if(self)
    {
        viewController = [[MapViewController alloc] init];
    }
    return self;
}



@end
