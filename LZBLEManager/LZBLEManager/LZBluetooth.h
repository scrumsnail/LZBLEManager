//
//  LZBluetooth.h
//  LZBLEManager
//
//  Created by luyoudui on 2017/4/12.
//  Copyright © 2017年 Hangzhou Lianzhong Medical Technology Co., Ltd. All rights reserved.
//

/******说明******/

/*
 蓝牙主动操作采用点语法的形式，外部调用者只需看这个类的.h文件，从扫描到接受数据
 */

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface LZBluetooth : NSObject

#pragma mark - 蓝牙委托
/**
 设备状态改变的block
 */
- (void)setBlockOnCentralManagerDidUpdateState:(void (^)(CBCentralManager *central))block;

/**
 找到Peripherals的block
 */
- (void)setBlockOnDiscoverToPeripherals:(void (^)(CBCentralManager *central,CBPeripheral *peripheral,NSDictionary *advertisementData, NSNumber *RSSI))block;

/**
 连接Peripherals成功的block
 */
- (void)setBlockOnConnected:(void (^)(CBCentralManager *central,CBPeripheral *peripheral))block;

/**
 设置查找到Characteristics的block
 */
- (void)setBlockOnDiscoverCharacteristics:(void (^)(CBPeripheral *peripheral,CBService *service,NSError *error))block;

/**
 连接Peripherals失败的block
 */
- (void)setBlockOnFailToConnect:(void (^)(CBCentralManager *central,CBPeripheral *peripheral,NSError *error))block;

/**
 断开Peripherals的连接的block
 */
- (void)setBlockOnDisconnect:(void (^)(CBCentralManager *central,CBPeripheral *peripheral,NSError *error))block;

/**
 设置查找服务的block
 */
- (void)setBlockOnDiscoverServices:(void (^)(CBPeripheral *peripheral,NSError *error))block;

/**
 设置获取到最新Characteristics值的block
 */
- (void)setBlockOnReadValueForCharacteristic:(void (^)(CBPeripheral *peripheral,CBCharacteristic *characteristic,NSError *error))block;

/**
 设置查找Peripherals的规则
 */
- (void)setFilterOnDiscoverPeripherals:(BOOL (^)(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI))filter;

#pragma mark - 工具方法
/**
 * 单例构造方法
 */
+ (instancetype)shareLZBluetooth;

#pragma mark - 链式函数

/**
 查找Peripherals
 */
- (LZBluetooth *(^)()) scanForPeripherals;

/**
 连接Peripherals
 */
- (LZBluetooth *(^)(CBPeripheral *peripheral)) connectToPeripheral;

/**
 断开Peripherals
 */
- (LZBluetooth *(^)(CBPeripheral *peripheral)) cancelPeripheralConnection;

/**
 停止扫描
 */
- (LZBluetooth *(^)()) stopScan;

/**
 获取当前corebluetooth的centralManager对象
 */
- (CBCentralManager *)centralManager;

@end
