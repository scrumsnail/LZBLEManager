//
//  ViewController1.m
//  LZBLEManager
//
//  Created by luyoudui on 2017/4/17.
//  Copyright © 2017年 Hangzhou Lianzhong Medical Technology Co., Ltd. All rights reserved.
//

#import "ViewController1.h"

@interface ViewController1 ()

@end

@implementation ViewController1

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self LZBleDelegate];
}

- (void)LZBleDelegate
{
    // 以下事件根据需求来，没有必要都要写
    [self.LZBle setBlockOnCentralManagerDidUpdateState:^(CBCentralManager *central) {
        if (central.state == CBCentralManagerStatePoweredOff)
        {
            // 蓝牙主动断开事件
        }
    }];
    
    [self.LZBle setBlockOnConnected:^(CBCentralManager *central, CBPeripheral *peripheral) {
        NSLog(@"链接成功");
    }];
    
    [self.LZBle setBlockOnDisconnect:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
        NSLog(@"断开链接");
    }];
    
    [self.LZBle setBlockOnFailToConnect:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
        NSLog(@"链接失败");
    }];
    
    [self.LZBle setBlockOnDiscoverCharacteristics:^(CBPeripheral *peripheral, CBService *service, NSError *error) {
        if ([[service.UUID UUIDString] isEqualToString:@"FFF0"])
        {
            [peripheral setNotifyValue:YES forCharacteristic:service.characteristics[0]]; // 这里的去characteristics的第一个元素，这个就是fff0
        }
    }];
    
    // 接受到的数据
    [self.LZBle setBlockOnReadValueForCharacteristic:^(CBPeripheral *peripheral, CBCharacteristic *characteristic, NSError *error) {
        NSLog(@"%@",characteristic.value);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    self.LZBle.connectToPeripheral(self.peripheral);
}

@end
