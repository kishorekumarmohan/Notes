//
//  EditNotesViewController.m
//  Notes
//
//  Created by Mohan, Kishore Kumar on 7/17/15.
//  Copyright (c) 2015 kmohan. All rights reserved.
//

#import "KKMEditNotesViewController.h"
#import "KKMNote.h"
#import "KKMNotesDataManager.h"
#import "KKMNotesViewController.h"

@interface KKMEditNotesViewController ()

@property (nonatomic, strong) KKMNotesDataManager *dataManager;

@end

@implementation KKMEditNotesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void)setup
{
    [self setupBarButtonItem];
    [self setupDataManager];
    [self setupTextView];
}

- (void)setupBarButtonItem
{
    self.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    self.navigationItem.leftItemsSupplementBackButton = true;
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:nil action:@selector(saveNote)];
}

- (void)setupTextView
{
    [self.noteTextView becomeFirstResponder];
    self.noteTextView.text = self.note.notes;
}

- (void)setupDataManager
{
    if (self.dataManager == nil)
        self.dataManager = [KKMNotesDataManager new];
}

- (void)saveNote
{
    KKMNote *note = [KKMNote new];
    note.notes = self.noteTextView.text;
    [self.dataManager upsertNote:note];
}


#pragma mark - UISplitViewControllerDelegate

- (void)splitViewController:(UISplitViewController *)svc willChangeToDisplayMode:(UISplitViewControllerDisplayMode)displayMode
{
}

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController
{
    UINavigationController *nc = (UINavigationController *)secondaryViewController;
    KKMEditNotesViewController *controller = (KKMEditNotesViewController *)nc.topViewController;
    if (controller.note) {
        return NO;
    } else {
        return YES;
    }
}

@end
