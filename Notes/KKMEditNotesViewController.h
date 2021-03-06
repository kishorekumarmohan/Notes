//
//  EditNotesViewController.h
//  Notes
//
//  Created by Mohan, Kishore Kumar on 7/17/15.
//  Copyright (c) 2015 kmohan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKMNoteSavedProtocol.h"
@class KKMNote;

@interface KKMEditNotesViewController : UIViewController <UISplitViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextView *noteTextView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *saveBarButtonItem;

- (IBAction)saveNote:(id)sender;

@property (nonatomic, strong) KKMNote *note;
@property (nonatomic, weak) id<KKMNoteSavedProtocol> noteSavedDelegate;

@end
