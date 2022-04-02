//
//  AddStageViewController.m
//  TripPlanner
//
//  Created by Marco on 09/06/21.
//

#import "AddStageViewController.h"
#import "Place.h"

@interface AddStageViewController ()

@property (weak, nonatomic) IBOutlet UITextField *fromPlaceTextField;
@property (weak, nonatomic) IBOutlet UITextField *toPlaceTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *arrivalDatePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *leaveDatePicker;
-(BOOL) checkFromPlaceName:(NSString*)fromPlaceName
           toPlaceName:(NSString*)toPlaceName;
-(BOOL) checkArrivalDate:(NSDate*)arrivalDate
               leaveDate:(NSDate*)leaveDate;

@end

@implementation AddStageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Stage";
    if(self.stage != nil) {
        self.fromPlaceTextField.text = self.stage.movement.fromPlace.name;
        self.toPlaceTextField.text = self.stage.movement.toPlace.name;
        self.arrivalDatePicker.date = self.stage.stay.arrivalDate;
        self.leaveDatePicker.date = self.stage.stay.leaveDate;
    }
}
- (IBAction)saveStage:(UIBarButtonItem *)sender {
    NSDate* arrivalDate = self.arrivalDatePicker.date;
    NSDate* leaveDate = self.leaveDatePicker.date;
    NSString* fromPlaceName = self.fromPlaceTextField.text;
    NSString* toPlaceName = self.toPlaceTextField.text;
    if([self checkFromPlaceName:fromPlaceName
                    toPlaceName:toPlaceName] && [self checkArrivalDate:arrivalDate
                    leaveDate:leaveDate]) {
        Place* fromPlace = [[Place alloc] initWithName:fromPlaceName];
        Place* toPlace = [[Place alloc] initWithName:toPlaceName];
        Movement* movement = [[Movement alloc] initWithArrivalDate:arrivalDate fromPlace:fromPlace toPlace:toPlace];
        Stay* stay = [[Stay alloc] initWithPlace:toPlace arrivalDate:arrivalDate leaveDate:leaveDate];
        if(self.stage != nil) {
            [self.dataSource updateStage:self.stage
                            withMovement:movement
                                    stay:stay];
        } else {
            Stage* stage = [[Stage alloc] initWithMovement:movement
                                                      stay:stay];
            [self.dataSource insertStage:stage
                                 forTrip:self.trip];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    printf("SAVED");
}
- (BOOL)checkFromPlaceName:(NSString *)fromPlaceName
               toPlaceName:(NSString *)toPlaceName {
    if(fromPlaceName==nil || [fromPlaceName isEqualToString:@""] ||
       toPlaceName==nil || [toPlaceName isEqualToString:@""]) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Place field empty"
                                                                       message:@"Please fill all fields."
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

- (BOOL)checkArrivalDate:(NSDate *)arrivalDate
               leaveDate:(NSDate *)leaveDate {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    if([calendar compareDate:arrivalDate
                      toDate:leaveDate
           toUnitGranularity:NSCalendarUnitDay] == NSOrderedDescending) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Dates not correct"
                                                                       message:@"Arrival date must be earlier than leave date."
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
    [self.fromPlaceTextField resignFirstResponder];
    [self.toPlaceTextField resignFirstResponder];
}

@end
