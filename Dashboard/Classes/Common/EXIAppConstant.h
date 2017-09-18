//
//  EXIAppConstant.h
//  Dashboard
//
//  Created by Swapnil Jain on 8/22/13.
//

#import <Foundation/Foundation.h>

@protocol EXIMainViewProtocol <NSObject>
-(void)refreshData;
@end

@interface EXIAppConstant : NSObject

enum pageType{
    eURLField = 0,
    eLogin,
    ePassword,
    eCategory
};

enum actionSheetIndex{
    eImport = 0,
    eExport
};

FOUNDATION_EXPORT NSString *const kItemIdKey;
FOUNDATION_EXPORT NSString *const kUrlKey;
FOUNDATION_EXPORT NSString *const kLoginKey;
FOUNDATION_EXPORT NSString *const kPasswordKey;
FOUNDATION_EXPORT NSString *const kCategoryKey;

FOUNDATION_EXPORT NSString *const kUrlText;
FOUNDATION_EXPORT NSString *const kLoginText;
FOUNDATION_EXPORT NSString *const kPasswordText;
FOUNDATION_EXPORT NSString *const kCategoryText;

FOUNDATION_EXPORT NSString *const kEntityIdentifier;
FOUNDATION_EXPORT NSString *const kStoryboardIdentifier;

FOUNDATION_EXPORT NSString *const kLoginViewController;
FOUNDATION_EXPORT NSString *const kMainViewController;

@end
