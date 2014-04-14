//
//  WAMapViewController.m
//  WorldAlumni
//
//  Created by Zhenyi ZHANG on 2014-04-06.
//  Copyright (c) 2014 Zhenyi Zhang. All rights reserved.
//

#import "WAMapViewController.h"
#import "WADataController.h"
#import "WAUserAnnotation.h"
#import "WAUserNearby.h"
#import "WAUserDetailViewController.h"

@interface WAMapViewController () <MKMapViewDelegate, UISearchBarDelegate>
@property (strong, nonatomic) WAUserAnnotation *selectedAnnotation;
@end

@implementation WAMapViewController

@synthesize mapView = _mapView;
@synthesize annotations = _annotations;
@synthesize selectedAnnotation = _selectedAnnotation;


//以下几个方法一般都要写
-(void)updateMapView
{
    if (self.mapView.annotations) [self.mapView removeAnnotations:self.mapView.annotations];
    if (self.annotations) [self.mapView addAnnotations:self.annotations];
}

- (void)setMapView:(MKMapView *)mapView
{
    _mapView = mapView;
    _mapView.delegate = self;
    
//    [self updateMapView];
}

- (void)setAnnotations:(NSArray *)annotations
{
    _annotations = annotations;
    [self updateMapView];
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
    [self updateMapView];
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

// Selector functions
-(void)showUserDetailFromMapView
{
    [self performSegueWithIdentifier: @"showUserDetailFromMapView" sender:self];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{

    // Don't overwrite current location annotation
    if([annotation isKindOfClass: [MKUserLocation class]]) {
        return nil;
    } else if ([annotation isKindOfClass:[WAUserAnnotation class]]) {
        
        MKAnnotationView *aView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"UserAnno"];
        aView.canShowCallout = YES;// DON'T FORGET THIS LINE OF CODE !!
        WAUserAnnotation *userAnnotation = (WAUserAnnotation *)annotation;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
        if ([userAnnotation.user.provider isEqualToString:@"facebook"]) {
            NSString *imageUrlString = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?width=200&height=200", userAnnotation.user.uid];
            [imageView setImageWithURL:[NSURL URLWithString:imageUrlString]
                                    placeholderImage:[UIImage imageNamed:@"WorldAlumni.png"]];
        } else {
            [imageView setImage:[UIImage imageNamed:@"WorldAlumni.png"]];
        }
        
        aView.leftCalloutAccessoryView = imageView;
        
        // create right view
        aView.rightCalloutAccessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30,30)];
        UIButton *showDetailButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [showDetailButton addTarget:self action:@selector(showUserDetailFromMapView) forControlEvents:UIControlEventTouchUpInside];
        [aView.rightCalloutAccessoryView addSubview:showDetailButton];
        
        return aView;
        
    }
    
    return nil;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{

    self.selectedAnnotation = view.annotation;

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"showUserDetailFromMapView"]) {
        
        WAUserDetailViewController *detailViewController = [segue destinationViewController];
        detailViewController.user = self.selectedAnnotation.user;
    }
}

@end
