//
//  LZBluetooth.m
//  LZBLEManager
//
//  Created by luyoudui on 2017/4/12.
//  Copyright © 2017年 Hangzhou Lianzhong Medical Technology Co., Ltd. All rights reserved.
//

#import "LZBluetooth.h"
#import "LZBLECentralManager.h"

#define callback [speaker callback]

@implementation LZBluetooth
{
    LZBLESpeaker *speaker;
    LZBLECentralManager *centralManager;
}

// 单例模式
+ (instancetype)shareLZBluetooth
{
    static LZBluetooth *share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[LZBluetooth alloc] init];
    });
    return share;
}

- (instancetype)init
{
    if (self = [super init])
    {
        // 初始化对象
        centralManager = [[LZBLECentralManager alloc]init];
        speaker = [[LZBLESpeaker alloc]init];
        centralManager->speaker = speaker;
    }
    return self;
}

#pragma mark - LZBluetooth的委托
// 设备状态改变的委托
- (void)setBlockOnCentralManagerDidUpdateState:(void (^)(CBCentralManager *central))block
{
    [callback setBlockOnCentralManagerDidUpdateState:block];
}

// 找到Peripherals的委托
- (void)setBlockOnDiscoverToPeripherals:(void (^)(CBCentralManager *central,CBPeripheral *peripheral,NSDictionary *advertisementData, NSNumber *RSSI))block
{
    [callback setBlockOnDiscoverPeripherals:block];
}

// 连接Peripherals成功的委托
- (void)setBlockOnConnected:(void (^)(CBCentralManager *central,CBPeripheral *peripheral))block
{
    [callback setBlockOnConnectedPeripheral:block];
}

// 设置查找到Characteristics的block
- (void)setBlockOnDiscoverCharacteristics:(void (^)(CBPeripheral *peripheral,CBService *service,NSError *error))block
{
    [callback setBlockOnDiscoverCharacteristics:block];
}

// 连接Peripherals失败的委托
- (void)setBlockOnFailToConnect:(void (^)(CBCentralManager *central,CBPeripheral *peripheral,NSError *error))block
{
    [callback setBlockOnFailToConnect:block];
}

// 断开Peripherals的连接
- (void)setBlockOnDisconnect:(void (^)(CBCentralManager *central,CBPeripheral *peripheral,NSError *error))block
{
    [callback setBlockOnDisconnect:block];
}

// 设置获取到最新Characteristics值的block
- (void)setBlockOnReadValueForCharacteristic:(void (^)(CBPeripheral *peripheral,CBCharacteristic *characteristic,NSError *error))block
{
    [callback setBlockOnReadValueForCharacteristic:block];
}

// 设置查找服务回叫
- (void)setBlockOnDiscoverServices:(void (^)(CBPeripheral *peripheral,NSError *error))block
{
    [callback setBlockOnDiscoverServices:block];
}

- (void)setFilterOnDiscoverPeripherals:(BOOL (^)(NSString *, NSDictionary *, NSNumber *))filter
{
    [callback setFilterOnDiscoverPeripherals:filter];
}

#pragma mark - 链式函数
// 查找Peripherals
- (LZBluetooth *(^)())scanForPeripherals
{
    return ^LZBluetooth *() {
        [centralManager scanPeripherals];
        return self;
    };
}

// 连接Peripheral
- (LZBluetooth *(^)(CBPeripheral *))connectToPeripheral
{
    return ^LZBluetooth *(CBPeripheral *p) {
        [centralManager connectToPeripheral:p];
        return self;
    };
}

// 断开Peripheral
- (LZBluetooth *(^)(CBPeripheral *))cancelPeripheralConnection
{
    return ^LZBluetooth *(CBPeripheral *p){
        [centralManager cancelPeripheralConnection:p];
        return self;
    };
}

// 停止扫描
- (LZBluetooth *(^)())stopScan
{
    return ^LZBluetooth *(){
        [centralManager cancelScan];
        return self;
    };
}

// 获取当前蓝牙中心设备的对象
- (CBCentralManager *)centralManager
{
    return centralManager->centralManager;
}
@end
