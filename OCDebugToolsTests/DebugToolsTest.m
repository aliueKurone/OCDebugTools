//
//  DebugToolsTest.m
//  OCEfficient
//
//  Created by aliuekurone on 1/9/14.
//  Copyright (c) 2014 aliueKurone. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "OCDebugTools.h"


@interface DebugToolsTest : SenTestCase

- (void)testDebugLog;
- (void)testLoggingMethod;
- (void)testLoggingObject;
- (void)testLoggingScalar;
- (void)testLoggingError;
- (void)testLoggingException;
@end


@implementation DebugToolsTest


- (void)testDebugLog
{
    DebugLog(@"scalar: %d %u %.1f", 10, 10000U, 0.2f);
    NSString *str = @"string object";
    DebugLog(@"object: %@", str);
}


- (void)testLoggingMethod
{
    LoggingMethod();
}


- (void)testLoggingObject
{
    NSString *str = @"I'm string object";    
    LoggingObject(str);
    
    NSArray *array = @[@"this is array", @233, @{@"dictkey": @23}];
    LoggingObject(array);
    
    LoggingObject(@1000);
}


- (void)testLoggingScalar
{
    int na = 10;
    LoggingScalar(na);
    
    int nb = -100;
    LoggingScalar(nb);
    
    double da = 0.02;
    LoggingScalar(da);
}


- (void)testLoggingError
{
    NSError *error = [NSError errorWithDomain:@"error log test" code:9999 userInfo:nil];
    LoggingError(error);
}


- (void)testLoggingException
{
    @try {
        NSException *ex = [NSException exceptionWithName:@"log test" reason:@"this is test" userInfo:nil];
        @throw ex;
    }
    @catch (NSException *exception) {
        LoggingException(exception);
    }
}


@end