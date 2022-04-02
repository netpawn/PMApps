//
//  TripListViewController.h
//  TripPlanner
//
//  Created by Marco on 23/05/21.
//

#import <UIKit/UIKit.h>
#import "DataSource.h"

@interface TripListViewController : UITableViewController

@property (nonatomic, strong) id<DataSource> dataSource;

@end

