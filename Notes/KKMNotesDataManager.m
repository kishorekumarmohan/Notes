//
//  KKMNotesDataManager.m
//  Notes
//
//  Created by Mohan, Kishore Kumar on 7/17/15.
//  Copyright (c) 2015 kmohan. All rights reserved.
//

#import "KKMNotesDataManager.h"
#import "KKMNote.h"

@implementation KKMNotesDataManager

-(void)fetchNotesWithHandler:(KKMNotesHandler) handler
{
    NSMutableArray *notesArray = [NSMutableArray new];
    
    NSInteger count = 10;
    for (NSInteger i = 0; i < count; i++)
    {
        KKMNote *note = [KKMNote new];
        note.notes = [NSString stringWithFormat:@"Test notes : %ld", i];
        note.createdDate = [NSDate new];
        note.modifiedDate = [NSDate new];
        
        notesArray[i] = note;
    }
    handler(notesArray);
}
@end
