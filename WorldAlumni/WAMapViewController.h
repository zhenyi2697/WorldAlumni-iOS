//
//  WAMapViewController.h
//  WorldAlumni
//
//  Created by Zhenyi ZHANG on 2014-04-06.
//  Copyright (c) 2014 Zhenyi Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface WAMapViewController : UIViewController
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic,strong) NSArray *annotations;  // of id <MKAnnotation>
@end
