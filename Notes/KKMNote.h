//
//  KKMNotes.h
//  Notes
//
//  Created by Mohan, Kishore Kumar on 7/17/15.
//  Copyright (c) 2015 kmohan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKMNote : NSObject

@property (nonatomic, strong) NSString *noteID;
@property (nonatomic, strong) NSString *notes;
@property (nonatomic, strong) NSDate *modifiedDate;
@property (nonatomic, strong) NSDate *createdDate;


@end
