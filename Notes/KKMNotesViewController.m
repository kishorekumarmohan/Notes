//
//  ViewController.m
//  Notes
//
//  Created by Mohan, Kishore Kumar on 7/17/15.
//  Copyright (c) 2015 kmohan. All rights reserved.
//

#import "KKMNotesViewController.h"
#import "KKMNotesDataManager.h"
#import "KKMNote.h"
#import "KKMEditNotesViewController.h"
#import "KKMNoteSavedProtocol.h"

@interface KKMNotesViewController() <KKMNoteSavedProtocol>

@property (nonatomic, strong) KKMNotesDataManager *dataManager;
@property (nonatomic, strong) NSMutableArray *notesArray;
@property (nonatomic, strong) KKMNote *selectedNote;
@property (nonatomic, assign) BOOL collapseDetailViewController;

@end

@implementation KKMNotesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupSplitViewController];
    [self setupDataManager];
}

- (void)setupSplitViewController
{
    self.splitViewController.delegate = self;
    self.collapseDetailViewController = YES;
}

- (void)setupDataManager
{
    if (self.dataManager == nil)
        self.dataManager = [KKMNotesDataManager new];
    
    __weak KKMNotesViewController *weakSelf = self;
    [self.dataManager fetchNotesWithHandler:^(NSArray *results) {
        weakSelf.notesArray = [results mutableCopy];
        [weakSelf.tableView reloadData];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = self.notesArray.count;
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"NOTE_CELL"];
    KKMNote *note = self.notesArray[indexPath.row];
    cell.textLabel.text = note.notes;
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView reloadData];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectedNote = self.notesArray[indexPath.row];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor colorWithRed:1.0f green:0.5f blue:0.0f alpha:0.25f];
    [self performSegueWithIdentifier:@"KKMEditNotesViewController_Edit" sender:self];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        self.selectedNote = nil;
        [self.dataManager deleteNote:self.notesArray[indexPath.row]];
        [self.notesArray removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }
}

#pragma mark - UIView
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UINavigationController *navController = segue.destinationViewController;
    KKMEditNotesViewController *controller = (KKMEditNotesViewController *)navController.topViewController;
    controller.noteSavedDelegate = self;

    if([segue.identifier isEqualToString:@"KKMEditNotesViewController_Edit"])
    {
        controller.note = self.selectedNote;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
        NSString *title = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:self.selectedNote.modifiedDate]];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        titleLabel.text = title;
        titleLabel.font = [UIFont systemFontOfSize:10.0f];
        controller.navigationItem.titleView = titleLabel;
    }
}


#pragma mark - UISplitViewControllerDelegate

-(BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController
{
    return self.collapseDetailViewController;
}

#pragma mark - KKMNoteSavedProtocol
-(void)noteSaved
{
    [self setupDataManager];
    [self.tableView reloadData];
}

@end
