//
//  EXIAccountModel.m
//  Dashboard
//
//  Created by Swapnil Jain on 8/22/13.
//

#import "EXIAccountModel.h"

@implementation EXIAccountModel

-(id)initWithId:(NSNumber*)idd URL:(NSString*)url Login:(NSString*)login Password:(NSString*)password Category:(NSString*)category{

    self = [super init];

    if(self){
        self.itemId = idd;
        self.url = url;
        self.login = login;
        self.password = password;
        self.category = category;
    }
    return self;
}

@end
