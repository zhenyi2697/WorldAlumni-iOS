//
//  WAMapViewController.m
//  WorldAlumni
//
//  Created by Zhenyi ZHANG on 2014-04-06.
//  Copyright (c) 2014 Zhenyi Zhang. All rights reserved.
//

#import "WAMapViewController.h"
#import "WADataController.h"

@interface WAMapViewController () <MKMapViewDelegate, UISearchBarDelegate>

@end

@implementation WAMapViewController

@synthesize mapView = _mapView;

- (void)setMapView:(MKMapView *)mapView
{
    _mapView = mapView;
    _mapView.delegate = self;
    
    //    [self updateMapView];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WADataController *dataController = [WADataController sharedDataController];
    [self centerToLocation:dataController.currentLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)centerToLocation:(CLLocation *)location
{
    
    [UIView animateWithDuration:0.8
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         MKCoordinateRegion region;
                         MKCoordinateSpan span;
                         span.latitudeDelta = 0.05;
                         span.longitudeDelta = 0.05;
                         region.span=span;
                         CLLocationCoordinate2D centerLocation;
                         centerLocation.latitude = location.coordinate.latitude;
                         centerLocation.longitude = location.coordinate.longitude;
                         region.center= centerLocation;
                         [self.mapView setCenterCoordinate:centerLocation animated:YES];
                         [self.mapView setRegion:region animated:YES];
                     }
                     completion:^(BOOL finished){
                         if(finished) {
                             //                             [self showBuildingAnnotations];
                         }
                     }];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
