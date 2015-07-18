//
//  ViewController.h
//  Notes
//
//  Created by Mohan, Kishore Kumar on 7/17/15.
//  Copyright (c) 2015 kmohan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKMNotesViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *previewSegmentControl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

