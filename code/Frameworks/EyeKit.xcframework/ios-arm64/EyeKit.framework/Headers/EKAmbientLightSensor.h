//
//  RDMAmbientLightSensor.h
//  ReadingDetector
//
//  Created by Leon Nissen on 13.04.21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EKAmbientLightSensor : NSObject

+ (void)get_lux:(int *)lux
            ch0:(float *)ch0
            ch1:(float *)ch1
            ch2:(float *)ch2
            ch3:(float *)ch3;

+ (void)init_iokit:(int)updateInterval;

+ (void)start_iokit;

+ (void)stop_iokit;

@end

NS_ASSUME_NONNULL_END
