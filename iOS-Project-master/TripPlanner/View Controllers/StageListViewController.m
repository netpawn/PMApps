//
//  StageListViewController.m
//  TripPlanner
//
//  Created by Marco on 09/06/21.
//



#import "StageListViewController.h"
#import "StageList.h"
#import "TripDataSource.h"
#import "AddStageViewController.h"
#import "Trip.h"

@interface StageListViewController ()

@property (nonatomic, strong) StageList* stages;
-(void) accessoryButtonPressed:(id) sender;
-(void) refreshTableView;

@end

@implementation StageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Stages";
    self.stages = [self.dataSource getStageListForTrip:self.trip];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableView) name:StageListChangedNotification object:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.stages.size;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StageCellIdentifier" forIndexPath:indexPath];
    UIImage* trashImage = [UIImage systemImageNamed:@"trash"];
    UIButton* trashButton = [UIButton systemButtonWithImage:trashImage
                                                     target:self
                                                     action:@selector(accessoryButtonPressed:)];
    trashButton.tag = indexPath.row;
    cell.accessoryView = trashButton;
    Stage* stage = [self.stages getAtIndex:indexPath.row];
    NSString* initialPlaceName = stage.movement.fromPlace.name;
    NSString* finalPlaceName = stage.movement.toPlace.name;
    NSString* title = [NSString stringWithFormat:@"%@ - %@", initialPlaceName, finalPlaceName];
    cell.textLabel.text = title;
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString* startDate = [dateFormatter stringFromDate:stage.movement.arrivalDate];
    NSString* endDate = [dateFormatter stringFromDate:stage.stay.leaveDate];
    NSString* subtitle = [NSString stringWithFormat:@"%@ - %@", startDate, endDate];
    cell.detailTextLabel.text = subtitle;
    return cell;
}

- (void)accessoryButtonPressed:(id)sender {
    if([sender isKindOfClass:[UIButton class]]) {
        UIButton* button = (UIButton*) sender;
        long idx = button.tag;
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Delete"
                                                                       message:@"Are you sure you want to delete this item?"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* negativeAction = [UIAlertAction actionWithTitle:@"NO"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction* action) {}];
        UIAlertAction* positiveAction = [UIAlertAction actionWithTitle:@"YES"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction* action) {
            [self.dataSource deleteStage:[self.stages getAtIndex:idx]
                                 forTrip:self.trip];
        }];
        [alert addAction:negativeAction];
        [alert addAction:positiveAction];
        [self presentViewController:alert
                           animated:YES
                         completion:nil];
    }
}

- (void)refreshTableView {
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"GoToAddStageViewController"]) {
        if([segue.destinationViewController isKindOfClass:[AddStageViewController class]]) {
            AddStageViewController* destinationVC = (AddStageViewController*) segue.destinationViewController;
            destinationVC.dataSource = self.dataSource;
            destinationVC.stage = nil;
            destinationVC.trip = self.trip;
        }
    }
    if([segue.identifier isEqualToString:@"GoToStageDetails"]) {
        NSIndexPath* indexPath = [self.tableView indexPathForCell:sender];
        if([segue.destinationViewController isKindOfClass:[AddStageViewController class]]) {
            AddStageViewController* destinationVC = (AddStageViewController*) segue.destinationViewController;
            destinationVC.dataSource = self.dataSource;
            destinationVC.stage = [self.stages getAtIndex:indexPath.row];
            destinationVC.trip = self.trip;
        }
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:StageListChangedNotification object:nil];
}


@end
