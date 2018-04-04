//
//  LZBLESpeaker.h
//  LZBLEManager
//
//  Created by luyoudui on 2017/4/11.
//  Copyright © 2017年 Hangzhou Lianzhong Medical Technology Co., Ltd. All rights reserved.
//

/******说明******/

/*
 这个类归纳蓝牙基本代理转成block的block定义
 */

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

//设备状态改变的委托
typedef void (^LZBLECentralManagerDidUpdateStateBlock)(CBCentralManager *central);

// 找到设备的委托
typedef void (^LZBLEDiscoverPeripheralsBlock)(CBCentralManager *central,CBPeripheral *peripheral,NSDictionary *advertisementData, NSNumber *RSSI);

// 连接设备成功的block
typedef void (^LZBLEConnectedPeripheralBlock)(CBCentralManager *central,CBPeripheral *peripheral);

// 连接设备失败的block
typedef void (^LZBLEFailToConnectBlock)(CBCentralManager *central,CBPeripheral *peripheral,NSError *error);

// 断开设备连接的bock
typedef void (^LZBLEDisconnectBlock)(CBCentralManager *central,CBPeripheral *peripheral,NSError *error);

// 找到服务的block
typedef void (^LZBLEDiscoverServicesBlock)(CBPeripheral *peripheral,NSError *error);

// 找到Characteristics的block
typedef void (^LZBLEDiscoverCharacteristicsBlock)(CBPeripheral *peripheral,CBService *service,NSError *error);

// 更新（获取）Characteristics的value的block
typedef void (^LZBLEReadValueForCharacteristicBlock)(CBPeripheral *peripheral,CBCharacteristic *characteristic,NSError *error);

@interface LZBLECallback : NSObject

#pragma mark - callback block
// 设备状态改变的委托
@property (nonatomic,copy) LZBLECentralManagerDidUpdateStateBlock blockOnCentralManagerDidUpdateState;

// 发现peripherals
@property (nonatomic,copy) LZBLEDiscoverPeripheralsBlock blockOnDiscoverPeripherals;

// 连接callback
@property (nonatomic,copy) LZBLEConnectedPeripheralBlock blockOnConnectedPeripheral;

// 连接设备失败的block
@property (nonatomic,copy) LZBLEFailToConnectBlock blockOnFailToConnect;

// 断开设备连接的bock
@property (nonatomic,copy) LZBLEDisconnectBlock blockOnDisconnect;

// 发现services
@property (nonatomic,copy) LZBLEDiscoverServicesBlock blockOnDiscoverServices;

// 发现Characteristics
@property (nonatomic,copy) LZBLEDiscoverCharacteristicsBlock blockOnDiscoverCharacteristics;

// 发现更新Characteristics的值
@property (nonatomic,copy) LZBLEReadValueForCharacteristicBlock blockOnReadValueForCharacteristic;

#pragma mark - 过滤器Filter
// 发现peripherals规则
@property (nonatomic,copy) BOOL (^filterOnDiscoverPeripherals)(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI);

@end


@interface LZBLESpeaker : NSObject

- (LZBLECallback *)callback;

@end
