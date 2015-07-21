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

@interface KKMEditNotesViewController () <UITextViewDelegate>

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

#pragma mark - Action methods
- (IBAction)saveNote:(id)sender
{
    [self removeSaveBarButtonItem];
    
    KKMNote *note = [KKMNote new];
    note.notes = self.noteTextView.text;
    __weak id weakSelf = self;
    
    [self.dataManager upsertNote:note handler:^(BOOL result) {
        KKMEditNotesViewController *strongSelf = weakSelf;
        [strongSelf.noteSavedDelegate noteSaved];
    }];
}

- (void)removeSaveBarButtonItem
{
    self.navigationItem.rightBarButtonItem = nil;
    [self.noteTextView resignFirstResponder];
}

- (void)addSaveBarButtonItem
{
    self.navigationItem.rightBarButtonItem = self.saveBarButtonItem;
}


#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self becomeFirstResponder];
    [self addSaveBarButtonItem];
}


#pragma mark - UISplitViewControllerDelegate

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
