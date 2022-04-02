//
//  TripListViewController.m
//  TripPlanner
//
//  Created by Marco on 23/05/21.
//

#import "TripListViewController.h"
#import "TripDataSource.h"
#import "AddTripViewController.h"

@interface TripListViewController ()

@property (nonatomic, strong) TripList* trips;
-(void) accessoryButtonPressed:(id) sender;
-(void) refreshTableView;

@end

@implementation TripListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Trips";
    self.dataSource = [[TripDataSource alloc] init];
    if(self.dataSource != nil) {
        self.trips = [self.dataSource getTripList];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshTableView)
                                                 name:TripListChangedNotification object:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return self.trips.size;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TripCellIdentifier" forIndexPath:indexPath];
    UIImage* trashImage = [UIImage systemImageNamed:@"trash"];
    UIButton* trashButton = [UIButton systemButtonWithImage:trashImage
                                                     target:self
                                                     action:@selector(accessoryButtonPressed:)];
    trashButton.tag = indexPath.row;
    cell.accessoryView = trashButton;
    Trip* trip = [self.trips getAtIndex:indexPath.row];
    cell.textLabel.text = trip.name;
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString* startDate = [dateFormatter stringFromDate:trip.startDate];
    NSString* endDate = [dateFormatter stringFromDate:trip.endDate];
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
            [self.dataSource deleteTrip:[self.trips getAtIndex:idx]];
        }];
        [alert addAction:negativeAction];
        [alert addAction:positiveAction];
        [self presentViewController:alert
                           animated:YES
                         completion:nil];
    }
}

- (void)refreshTableView {
    self.trips = [self.dataSource getTripList];
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"AddTrip"]) {
        if([segue.destinationViewController isKindOfClass:[AddTripViewController class]]) {
            AddTripViewController* destinationVC = (AddTripViewController*) segue.destinationViewController;
            destinationVC.dataSource = self.dataSource;
            destinationVC.trip = nil;
        }
    } else if([segue.identifier isEqualToString:@"GoToTripDetails"]) {
        NSIndexPath* indexPath = [self.tableView indexPathForCell:sender];
        if([segue.destinationViewController isKindOfClass:[AddTripViewController class]]) {
            AddTripViewController* destinationVC = (AddTripViewController*) segue.destinationViewController;
            destinationVC.dataSource = self.dataSource;
            destinationVC.trip = [self.trips getAtIndex:indexPath.row];
        }
    }}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TripListChangedNotification object:nil];
}


@end
