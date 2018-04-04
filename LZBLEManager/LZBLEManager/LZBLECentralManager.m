//
//  LZBLECentralManager.m
//  LZBLEManager
//
//  Created by luyoudui on 2017/4/11.
//  Copyright © 2017年 Hangzhou Lianzhong Medical Technology Co., Ltd. All rights reserved.
//

#import "LZBLECentralManager.h"

#define callback [speaker callback]

@implementation LZBLECentralManager

- (instancetype)init
{
    if (self = [super init])
    {
        centralManager = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
    }
    return self;
}

#pragma mark - 接口实现
// 扫描Peripherals
- (void)scanPeripherals
{
    [centralManager scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey:@YES}];
}

// 连接Peripherals
- (void)connectToPeripheral:(CBPeripheral *)peripheral
{
    [centralManager connectPeripheral:peripheral options:nil];
}

// 断开设备连接
- (void)cancelPeripheralConnection:(CBPeripheral *)peripheral
{
    [centralManager cancelPeripheralConnection:peripheral];
}

// 停止扫描
- (void)cancelScan
{
    [centralManager stopScan];
}

#pragma mark - CBCentralManagerDelegate委托方法 
// 蓝牙状态改变
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    // 根据状态改变发出通知
    switch (central.state) {
        case CBManagerStateUnknown:
            break;
        case CBManagerStateResetting:
            break;
        case CBManagerStateUnsupported:
            break;
        case CBManagerStateUnauthorized:
            break;
        case CBManagerStatePoweredOff:
            break;
        case CBManagerStatePoweredOn:
            break;
        default:
            break;
    }
    
    if ([callback blockOnCentralManagerDidUpdateState])
    {
        [callback blockOnCentralManagerDidUpdateState](central);
    }
}

// 发现外设
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI
{
    if ([callback filterOnDiscoverPeripherals])
    {
        if ([callback filterOnDiscoverPeripherals](peripheral.name,advertisementData,RSSI))
        {
            if ([callback blockOnDiscoverPeripherals])
            {
                [callback blockOnDiscoverPeripherals](central,peripheral,advertisementData,RSSI);
            }
        }
    }
}

// 连接外设
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    peripheral.delegate = self;
    
    [peripheral discoverServices:nil];
    
    if ([callback blockOnConnectedPeripheral])
    {
        [callback blockOnConnectedPeripheral](central,peripheral);
    }
}

// 连接外设失败
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    if ([callback blockOnFailToConnect])
    {
        [callback blockOnFailToConnect](central,peripheral,error);
    }
}

// 断开连接
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    if ([callback blockOnDisconnect])
    {
        [callback blockOnDisconnect](central,peripheral,error);
    }
}

// 发现外设服务
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    for (CBService *service in peripheral.services)
    {
//        NSLog(@"%@",[service.UUID UUIDString]);
//        if ([[service.UUID UUIDString] isEqualToString:@"FFF0"])
//        {
//            [peripheral discoverCharacteristics:nil forService:service];
//        }
        [peripheral discoverCharacteristics:nil forService:service];
    }
    
    if ([callback blockOnDiscoverServices])
    {
        [callback blockOnDiscoverServices](peripheral,error);
    }
}

// 发现服务特征
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    if ([callback blockOnDiscoverCharacteristics])
    {
        [callback blockOnDiscoverCharacteristics](peripheral,service,error);
    }
}

// 获取外设值
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if ([callback blockOnReadValueForCharacteristic])
    {
        [callback blockOnReadValueForCharacteristic](peripheral,characteristic,error);
    }
}

@end
