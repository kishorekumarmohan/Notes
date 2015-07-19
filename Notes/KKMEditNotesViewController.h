//
//  EditNotesViewController.h
//  Notes
//
//  Created by Mohan, Kishore Kumar on 7/17/15.
//  Copyright (c) 2015 kmohan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KKMNote;

@interface KKMEditNotesViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *noteTextView;
@property (nonatomic, strong) KKMNote *note;

@end
