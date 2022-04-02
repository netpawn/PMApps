//
//  AddTripViewController.m
//  TripPlanner
//
//  Created by Marco on 30/05/21.
//

#import "AddTripViewController.h"
#import "Trip.h"
#import "TripDataSource.h"
#import "StageListViewController.h"
#import "MapViewController.h"
#import "StageList.h"

@interface AddTripViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tripNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UITextField *meanOfTransportTextField;
@property (weak, nonatomic) IBOutlet UITextField *hotelNameTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *startDatePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *endDatePicker;
@property (nonatomic) bool isTripToBeInserted;
- (BOOL) checkStages:(StageList*)stages;
- (BOOL) checkStartDate:(NSDate*)startDate
                endDate:(NSDate*)endDate;

@end

@implementation AddTripViewController             

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Trip";
    if(self.trip != nil) {
        self.isTripToBeInserted = NO;
        self.tripNameTextField.text = self.trip.name;
        self.descriptionTextField.text = self.trip.tripDescription;
        self.meanOfTransportTextField.text = self.trip.meanOfTransport;
        self.hotelNameTextField.text = self.trip.hotelName;
        self.startDatePicker.date = self.trip.startDate;
        self.endDatePicker.date = self.trip.endDate;
    } else {
        self.isTripToBeInserted = YES;
        self.trip = [[Trip alloc] init];
    }
}

- (IBAction)saveTrip:(UIBarButtonItem *)sender {
    NSDate* startDate = self.startDatePicker.date;
    NSDate* endDate = self.endDatePicker.date;
    if([self checkStages:self.trip.stages] && [self checkStartDate:startDate endDate:endDate]) {
        NSString* tripName = self.tripNameTextField.text;
        NSString* tripDescription = self.descriptionTextField.text;
        NSString* meanOfTransport = self.meanOfTransportTextField.text;
        NSString* hotelName = self.hotelNameTextField.text;
        if(tripName == nil || [tripName isEqualToString:@""]) {
            NSString* initialPlaceName = [self.trip.stages getAtIndex:0].movement.fromPlace.name;
            NSString* finalPlaceName = [self.trip.stages getAtIndex:self.trip.stages.size-1].movement.toPlace.name;
            tripName = [NSString stringWithFormat:@"%@ - %@", initialPlaceName, finalPlaceName];
        }
        if(self.isTripToBeInserted) {
            Trip* trip = [[Trip alloc] initWithName:tripName
                                        description:tripDescription
                                          startDate:startDate
                                            endDate:endDate
                                          stageList:self.trip.stages
                                    meanOfTransport:meanOfTransport
                                          hotelName:hotelName];
            [self.dataSource insertTrip:trip];
        } else {
            [self.dataSource updateTrip:self.trip
                               withName:tripName
                            description:tripDescription
                              startDate:startDate
                                endDate:endDate
                              stageList:self.trip.stages
                        meanOfTransport:meanOfTransport
                              hotelName:hotelName];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (BOOL) checkStages:(StageList*)stages {
    if(self.trip.stages.size == 0) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Stages not found"
                                                                       message:@"Please insert stages."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* alertAction = [UIAlertAction actionWithTitle:@"OK"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction* action) {}];
        [alert addAction:alertAction];
        [self presentViewController:alert
                           animated:YES
                         completion:nil];
        return false;
    }
    return true;
}

- (BOOL) checkStartDate:(NSDate *)startDate endDate:(NSDate *)endDate {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    if([calendar compareDate:startDate
                      toDate:endDate
           toUnitGranularity:NSCalendarUnitDay] == NSOrderedDescending) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Dates not correct"
                                                                       message:@"Start date must be earlier than end date."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* alertAction = [UIAlertAction actionWithTitle:@"OK"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction* action) {}];
        [alert addAction:alertAction];
        [self presentViewController:alert
                           animated:YES
                         completion:nil];
        return false;
    }
    return true;
}

- (IBAction)dismissKeyboard:(UIControl *)sender {
    [self.tripNameTextField resignFirstResponder];
    [self.descriptionTextField resignFirstResponder];
    [self.meanOfTransportTextField resignFirstResponder];
    [self.hotelNameTextField resignFirstResponder];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"GoToStageList"]) {
        if([segue.destinationViewController isKindOfClass:[StageListViewController class]]) {
            StageListViewController* destinationVC = (StageListViewController*) segue.destinationViewController;
            destinationVC.dataSource = self.dataSource;
            destinationVC.trip = self.trip;
        }
    }
    if([segue.identifier isEqualToString:@"ShowMap"]) {
        if([segue.destinationViewController isKindOfClass:[MapViewController class]]) {
            MapViewController* destinationVC = (MapViewController*) segue.destinationViewController;
            destinationVC.stages = self.trip.stages;
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    if(self.trip.stages.size > 0) {
        NSDate* currentStartDate = self.startDatePicker.date;
        NSDate* currentEndDate = self.endDatePicker.date;
        NSDate* firstStageArrivalDate = [self.trip.stages getAtIndex:0].movement.arrivalDate;
        NSDate* finalStageLeaveDate = [self.trip.stages getAtIndex:self.trip.stages.size-1].stay.leaveDate;
        NSCalendar* calendar = [NSCalendar currentCalendar];
        if([calendar compareDate:currentStartDate
                          toDate:firstStageArrivalDate
               toUnitGranularity:NSCalendarUnitDay] == NSOrderedDescending) {
            self.startDatePicker.date = firstStageArrivalDate;
        }
        if([calendar compareDate:currentEndDate
                          toDate:finalStageLeaveDate
               toUnitGranularity:NSCalendarUnitDay] == NSOrderedAscending) {
            self.endDatePicker.date = finalStageLeaveDate;
        }
    }
}


@end
