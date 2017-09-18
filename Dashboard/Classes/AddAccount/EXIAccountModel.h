//
//  EXIAccountModel.h
//  Dashboard
//
//  Created by Swapnil Jain on 8/22/13.
//

#import <Foundation/Foundation.h>

@interface EXIAccountModel : NSObject

@property(nonatomic, strong) NSNumber *itemId;
@property(nonatomic, strong) NSString *url;
@property(nonatomic, strong) NSString *login;
@property(nonatomic, strong) NSString *password;
@property(nonatomic, strong) NSString *category;

-(id)initWithId:(NSNumber*)idd URL:(NSString*)url Login:(NSString*)login Password:(NSString*)password Category:(NSString*)category;

@end
