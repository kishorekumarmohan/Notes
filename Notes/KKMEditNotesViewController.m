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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:nil action:@selector(saveNote)];
    
    [self setupDataManager];
    
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
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    KKMNotesViewController *controller = (KKMNotesViewController *)[mainStoryboard instantiateViewControllerWithIdentifier: @"KKMNotesViewController"];
    [self showViewController:controller sender:self];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
