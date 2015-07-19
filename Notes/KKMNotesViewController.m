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

@interface KKMNotesViewController ()

@property (nonatomic, strong) KKMNotesDataManager *dataManager;
@property (nonatomic, strong) NSMutableArray *notesArray;

@end

@implementation KKMNotesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupDataManager];
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
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    KKMEditNotesViewController *controller = (KKMEditNotesViewController *)[mainStoryboard instantiateViewControllerWithIdentifier: @"KKMEditNotesViewController"];
    controller.note = self.notesArray[indexPath.row];
    [self showViewController:controller sender:self];
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
        [self.dataManager deleteNote:self.notesArray[indexPath.row]];
        [self.notesArray removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }
}

@end
