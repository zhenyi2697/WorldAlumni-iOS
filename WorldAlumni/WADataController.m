//
//  WADataController.m
//  WorldAlumni
//
//  Created by Zhenyi ZHANG on 2014-04-05.
//  Copyright (c) 2014 Zhenyi Zhang. All rights reserved.
//

#import "WADataController.h"
#import "WAMappingProvider.h"
#import "WACheckBindingRequest.h"
#import "WAObjectManager.h"
#import "WAAppDelegate.h"
#import "WAUserAnnotation.h"

@implementation WADataController

@synthesize locationManager = _locationManager, currentLocation = _currentLocation, me = _me;

+ (id)sharedDataController {
    static WADataController *sharedDataController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDataController = [[self alloc] init];
        
        sharedDataController.locationManager = [[CLLocationManager alloc] init];
        sharedDataController.locationManager.delegate = sharedDataController;
        sharedDataController.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        [sharedDataController.locationManager startUpdatingLocation];
    });
    return sharedDataController;
}

-(void)checkBindingForUid:(NSString *)uid andProvider:(NSString *)provider
{
    RKObjectMapping *bindingMapping = [WAMappingProvider bindingMapping];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:bindingMapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:nil];
    
    RKObjectMapping *checkBindingMapping = [WAMappingProvider checkBindingRequestMapping];
    
    //Inverse mapping, to perform a POST
    RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:[checkBindingMapping inverseMapping] objectClass:[WACheckBindingRequest class] rootKeyPath:nil  method:RKRequestMethodAny];
    
    WAObjectManager *manager = [WAObjectManager objectManager];
    
    [manager addRequestDescriptor:requestDescriptor];
    [manager addResponseDescriptor:responseDescriptor];
    
    WACheckBindingRequest *request = [[WACheckBindingRequest alloc] init];
    request.uid = uid;
    request.provider = provider;
    request.access_token = [[[FBSession activeSession] accessTokenData] accessToken];
    
    [manager postObject:request path:@"/api/check_binding/" parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
        NSLog(@"Success");
        NSArray *bindings = [result array];
        
        for (WABinding *b in bindings) {
            if ([b.provider isEqual:provider]) {
                [self nearbyUsersForBinding:b];
                self.me = b;
            }
        }
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"Error");
    }];
    
}

-(void)nearbyUsersForBinding:(WABinding *)binding
{
    RKObjectMapping *locationRequestMapping = [WAMappingProvider locationRequestMapping];
//    RKObjectMapping *locationMapping = [WAMappingProvider locationMapping];
    RKObjectMapping *userNearbyMapping = [WAMappingProvider userNearbyMapping];
    
    RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:[locationRequestMapping inverseMapping] objectClass:[WALocation class] rootKeyPath:nil  method:RKRequestMethodAny];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:userNearbyMapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:nil];
    
    WAObjectManager *manager = [WAObjectManager objectManager];
    
    [manager addRequestDescriptor:requestDescriptor];
    [manager addResponseDescriptor:responseDescriptor];
    
    // Prepare request object
    WALocation *locationRequest = [[WALocation alloc] init];
    locationRequest.bindingId = binding.bindingId;
    float longitude = self.currentLocation.coordinate.longitude;
    float latitude = self.currentLocation.coordinate.latitude;
    locationRequest.latitude = [NSString stringWithFormat:@"%f", latitude];
    locationRequest.longitude = [NSString stringWithFormat:@"%f", longitude];
    
    [manager postObject:locationRequest path:@"/api/nearby_users/" parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
        WAAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
        appDelegate.listViewController.nearbyUsers = [result array];
        appDelegate.listViewController.navigationItem.leftBarButtonItem = appDelegate.listViewController.filterButton;
        
        NSMutableArray *userAnnotations = [[NSMutableArray alloc] init];
        for (WAUserNearby *u in [result array]) {
            if ([u.latitude isEqualToString:@"0"] && [u.longitude isEqualToString:@"0"]) {
                // just ignore, no real data returned
            } else {
                [userAnnotations addObject:[WAUserAnnotation annotationForUser:u]];
            }
        }
        appDelegate.mapViewController.annotations = userAnnotations;
        
        [appDelegate.listViewController.refreshControl endRefreshing];
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"Error");
    }];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
//    NSLog(@"didUpdateToLocation: %@", newLocation);
    self.currentLocation = newLocation;
    
//    if (self.currentLocation != nil) {
////        longitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
////        latitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
//    }
}

@end
