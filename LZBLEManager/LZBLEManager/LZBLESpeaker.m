//
//  LZBLESpeaker.m
//  LZBLEManager
//
//  Created by luyoudui on 2017/4/11.
//  Copyright © 2017年 Hangzhou Lianzhong Medical Technology Co., Ltd. All rights reserved.
//

#import "LZBLESpeaker.h"
#define KLZBLE_DETAULT_CHANNEL @"KLZBLE_DETAULT_CHANNEL"

@implementation LZBLECallback

- (instancetype)init
{
    if (self = [super init])
    {
        // 过滤外设设备名，外部采用peripherals.name的前缀
        [self setFilterOnDiscoverPeripherals:^BOOL(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI) {
            if (![peripheralName isEqualToString:@""])
            {
                return YES;
            }
            return NO;
        }];
    }
    return self;
}

@end

@implementation LZBLESpeaker
{
    //所有委托频道这里就一个频道就够了
    NSMutableDictionary *channels;
}

- (instancetype)init
{
    if (self = [super init])
    {
        LZBLECallback *defaultCallback = [[LZBLECallback alloc] init];
        channels = [[NSMutableDictionary alloc]init];
        [channels setObject:defaultCallback forKey:KLZBLE_DETAULT_CHANNEL];
    }
    return self;
}

- (LZBLECallback *)callback
{
    return [channels objectForKey:KLZBLE_DETAULT_CHANNEL];
}

@end
