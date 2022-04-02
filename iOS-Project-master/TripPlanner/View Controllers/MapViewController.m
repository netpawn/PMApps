//
//  MapViewController.m
//  TripPlanner
//
//  Created by Marco on 10/06/21.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "Place+MapAnnotation.h"

@interface MapViewController ()<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
    [[self.stages getPlacesInOrder] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj isKindOfClass:[Place class]]){
            Place *place = (Place *)obj;
            place.sequenceValue = [NSNumber numberWithLong:(idx+1)];
            [self.mapView addAnnotation:place];
        }
    }];
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView
             viewForAnnotation:(id<MKAnnotation>)annotation{
    static NSString *AnnotationIdentifer = @"MapAnnotationView";
    MKAnnotationView *view = [mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifer];
    if(!view){
        view = [[MKMarkerAnnotationView alloc] initWithAnnotation:annotation
                                               reuseIdentifier:AnnotationIdentifer];
        view.canShowCallout = YES;
        ((MKMarkerAnnotationView*)view).glyphText = annotation.description;
    }
    view.annotation = annotation;
    return view;
    
}

@end
