//
//  ViewController.m
//  LZBLEManager
//
//  Created by luyoudui on 2017/4/11.
//  Copyright © 2017年 Hangzhou Lianzhong Medical Technology Co., Ltd. All rights reserved.
//

#import "ViewController.h"
#import "LZBluetooth.h"
#import "ViewController1.h"

#define WS(weakSelf) __weak __typeof(&*self)weakSelf = self;

@interface ViewController ()
{
    LZBluetooth *LZBle;
}

@property (nonatomic,strong) NSMutableArray *arrayPeripherals;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    LZBle = [LZBluetooth shareLZBluetooth];
    [self LZBLEDelegate];
    self.arrayPeripherals = [NSMutableArray array];
}

- (void)LZBLEDelegate
{
    WS(weakSelf)
    // 以下事件根据需求来，没有必要都要写
    [LZBle setBlockOnDiscoverToPeripherals:^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI) {
        NSLog(@"%@",peripheral.name);
        [weakSelf.arrayPeripherals addObject:peripheral];
    }];
    
    [LZBle setFilterOnDiscoverPeripherals:^BOOL(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI) {
        // 过滤
        if ([peripheralName hasPrefix:@"LC"])
        {
            return YES;
        }
        return NO;
//        return YES;
    }];
}

- (IBAction)scan:(id)sender
{
    LZBle.scanForPeripherals();
}

- (IBAction)connect:(id)sender
{
    ViewController1 *v1 = [ViewController1 new];
    v1.LZBle = LZBle;
    v1.peripheral = self.arrayPeripherals[0];
    [self presentViewController:v1 animated:YES completion:nil];
}

@end
