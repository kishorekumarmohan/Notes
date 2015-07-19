//
//  KKMNotes.m
//  Notes
//
//  Created by Mohan, Kishore Kumar on 7/17/15.
//  Copyright (c) 2015 kmohan. All rights reserved.
//

#import "KKMNote.h"

NSString* const KKMNotes = @"notes";
NSString* const KKMNoteID = @"noteID";
NSString* const KKMModifiedDate = @"modifiedDate";

@implementation KKMNote

- (instancetype)initWithNoteID:(NSString *)noteID notes:(NSString *)notes modifiedDate:(NSDate *)modifiedDate
{
    self = [super init];
    if (self)
    {
        _noteID = noteID;
        _notes = notes;
        _modifiedDate = modifiedDate;
    }
    return self;
}

#pragma mark - NSCoding

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.noteID forKey:KKMNoteID];
    [aCoder encodeObject:self.notes forKey:KKMNotes];
    [aCoder encodeObject:self.modifiedDate forKey:KKMModifiedDate];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    NSString *noteID = [aDecoder decodeObjectForKey:KKMNoteID];
    NSString *notes = [aDecoder decodeObjectForKey:KKMNotes];
    NSDate *modfiedDate = [aDecoder decodeObjectForKey:KKMModifiedDate];
    
    return [self initWithNoteID:noteID notes:notes modifiedDate:modfiedDate];
}

#pragma mark - Helpers
-(NSString *)description
{
    NSString *desc = [NSString stringWithFormat:@"%@: %@\n%@: %@\n%@: %@", KKMNoteID, self.noteID, KKMNotes, self.notes, KKMModifiedDate, self.modifiedDate];
    return desc;
}

@end
