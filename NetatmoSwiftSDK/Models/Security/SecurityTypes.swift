//
//  SecurityTypes.swift
//  NetatmoSwiftSDK
//
//  Created by James Barrow on 2020-02-23.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public extension NetatmoSecurity {
    
    enum ProductType: CustomStringConvertible {
        case indoorCamera
        case outdoorCamera
        case smokeDetector
        case doorWindowSensor
        case other(String)
        
        init(rawValue: String) {
            switch rawValue {
            case "NACamera":
                self = .indoorCamera
            case "NOC":
                self = .outdoorCamera
            case "NSD":
                self = .smokeDetector
            case "NACamDoorTag":
                self = .doorWindowSensor
            default:
                self = .other(rawValue)
            }
        }
        
        var rawValue: String {
            switch self {
            case .indoorCamera:
                return "NACamera"
            case .outdoorCamera:
                return "NOC"
            case .smokeDetector:
                return "NSD"
            case .doorWindowSensor:
                return "NACamDoorTag"
            case .other(let rawValue):
                return rawValue
            }
        }
        
        public var description: String {
            switch self {
            case .indoorCamera:
                return "Smart Indoor Camera"
            case .outdoorCamera:
                return "Smart Outdoor Camera"
            case .smokeDetector:
                return "Smart Smoke Detector"
            case .doorWindowSensor:
                return "Smart Door and Window Sensors"
            case .other(let rawValue):
                return "Other [\(rawValue)]"
            }
        }
    }
    
    enum EventType {
        /// When the Indoor Camera detects a face
        case person
        /// When Geofencing implues the person has left the home
        case personAway
        /// When the Indoor Camera detects a motion
        case movement
        /// A new Module has been paired with the Indoor Camera
        case newModule
        /// Module is connected with the Indoor Camera
        case moduleConnect
        /// Module lost its connection with the Indoor Camera
        case moduleDisconnect
        /// Module's battery is low
        case moduleLowBattery
        /// Module's firmware update is over
        case moduleEndUpdate
        /// When the Camera connect to Netatmo servers
        case connection
        /// When the Camera lose connection to Netatmo servers
        case disconnection
        /// When Camera Monitoring is resumed
        case on
        /// When Camera Monitoring is turned off
        case off
        /// When the Camera is booting
        case boot
        /// When Camera SD Card status change
        case sd
        /// When Camera power supply status change
        case alim
        /// When the Outdoor Camera detects a human, a car or an animal
        case outdoor
        /// When the Outdoor Camera viddeo summary of the last 24 hours is available
        case dailySummary
        /// Tag detected a big move
        case tagBigMove
        /// Tag detected a small move
        case tagSmallMove
        /// Tag was uninstalled
        case tagUninstalled
        /// Tag detected the door/window was left open
        case tagOpen
        /// When the smoke detection is activated or deactivated
        case hush
        /// When smoke is detected or smoke is cleared
        case smoke
        /// When smoke detector is ready or tampered
        case tampered
        /// When wifi status is updated
        case wifiStatus
        /// When battery status is too low
        case batteryStatus
        /// When the detection chamber is dusty or clean
        case detectionChamberStatus
        /// Sound test result
        case soundTest
        /// Any other not defined event types
        case other(String)
        
        init(rawValue: String) {
            switch rawValue {
            case "person":
                self = .person
            case "person_away":
                self = .personAway
            case "movement":
                self = .movement
            case "new_module":
                self = .newModule
            case "module_connect":
                self = .moduleConnect
            case "module_disconnect":
                self = .moduleDisconnect
            case "module_low_battery":
                self = .moduleLowBattery
            case "module_end_update":
                self = .moduleEndUpdate
            case "connection":
                self = .connection
            case "disconnection":
                self = .disconnection
            case "on":
                self = .on
            case "off":
                self = .off
            case "boot":
                self = .boot
            case "sd":
                self = .sd
            case "alim":
                self = .alim
            case "outdoor":
                self = .outdoor
            case "daily_summary":
                self = .dailySummary
            case "tag_big_move":
                self = .tagBigMove
            case "tag_small_move":
                self = .tagSmallMove
            case "tag_uninstalled":
                self = .tagUninstalled
            case "tag_open":
                self = .tagOpen
            case "hush":
                self = .hush
            case "smoke":
                self = .smoke
            case "tampered":
                self = .tampered
            case "wifi_status":
                self = .wifiStatus
            case "battery_status":
                self = .batteryStatus
            case "detection_chamber_status":
                self = .detectionChamberStatus
            case "sound_test":
                self = .soundTest
            default:
                self = .other(rawValue)
            }
        }
        
        var rawValue: String {
            switch self {
            case .person:
                return "person"
            case .personAway:
                return "person_away"
            case .movement:
                return "movement"
            case .newModule:
                return "new_module"
            case .moduleConnect:
                return "moduleconnect"
            case .moduleDisconnect:
                return "moduledisconnect"
            case .moduleLowBattery:
                return "module_low_battery"
            case .moduleEndUpdate:
                return "module_end_update"
            case .connection:
                return "connection"
            case .disconnection:
                return "disconnection"
            case .on:
                return "on"
            case .off:
                return "off"
            case .boot:
                return "boot"
            case .sd:
                return "sd"
            case .alim:
                return "alim"
            case .outdoor:
                return "outdoor"
            case .dailySummary:
                return "daily_summary"
            case .tagBigMove:
                return "tag_big_move"
            case .tagSmallMove:
                return "tag_small_move"
            case .tagUninstalled:
                return "tag_uninstalled"
            case .tagOpen:
                return "tag_open"
            case .hush:
                return "hush"
            case .smoke:
                return "smoke"
            case .tampered:
                return "tampered"
            case .wifiStatus:
                return "wifi_status"
            case .batteryStatus:
                return "battery_status"
            case .detectionChamberStatus:
                return "detection_chamber_status"
            case .soundTest:
                return "sound_test"
            case .other(let rawValue):
                return rawValue
            }
        }
    }
    
    enum SDCardSubType: CustomStringConvertible {
        case missing
        case inserted
        case formated
        case working
        case defective
        case incompatibleCardSpeed
        case insufficientCardSpace
        case other(Int)
        
        init(rawValue: Int) {
            switch rawValue {
            case 1:
                self = .missing
            case 2:
                self = .inserted
            case 3:
                self = .formated
            case 4:
                self = .working
            case 5:
                self = .defective
            case 6:
                self = .incompatibleCardSpeed
            case 7:
                self = .insufficientCardSpace
            default:
                self = .other(rawValue)
            }
        }
        
        var rawValue: Int {
            switch self {
            case .missing:
                return 1
            case .inserted:
                return 2
            case .formated:
                return 3
            case .working:
                return 4
            case .defective:
                return 5
            case .incompatibleCardSpeed:
                return 6
            case .insufficientCardSpace:
                return 7
            case .other(let rawValue):
                return rawValue
            }
        }
        
        public var description: String {
            switch self {
            case .missing:
                return "Missing SD Card"
            case .inserted:
                return "SD Card inserted"
            case .formated:
                return "SD Card formated"
            case .working:
                return "Working SD Card"
            case .defective:
                return "Defective SD Card"
            case .incompatibleCardSpeed:
                return "Incompatible SD Card speed"
            case .insufficientCardSpace:
                return "Insufficient SD Card space"
            case .other(let rawValue):
                return "Other [\(rawValue)]"
            }
        }
    }
    
    enum AlimentationSubType: CustomStringConvertible {
        case incorrectPowerAdapter
        case correctPowerAdapter
        case other(Int)
        
        init(rawValue: Int) {
            switch rawValue {
            case 1:
                self = .incorrectPowerAdapter
            case 2:
                self = .correctPowerAdapter
            default:
                self = .other(rawValue)
            }
        }
        
        var rawValue: Int {
            switch self {
            case .incorrectPowerAdapter:
                return 1
            case .correctPowerAdapter:
                return 2
            case .other(let rawValue):
                return rawValue
            }
        }
        
        public var description: String {
            switch self {
            case .incorrectPowerAdapter:
                return "Incorrect power adapter"
            case .correctPowerAdapter:
                return "Correct power adapter"
            case .other(let rawValue):
                return "Other [\(rawValue)]"
            }
        }
    }
    
    enum SubEventType {
        case human
        case animal
        case vehicle
        case other(String)
        
        init(rawValue: String) {
            switch rawValue {
            case "human":
                self = .human
            case "animal":
                self = .animal
            case "vehicle":
                self = .vehicle
            default:
                self = .other(rawValue)
            }
        }
        
        var rawValue: String {
            switch self {
            case .human:
                return "human"
            case .animal:
                return "animal"
            case .vehicle:
                return "vehicle"
            case .other(let rawValue):
                return rawValue
            }
        }
    }
    
}
