//
//  HomeData.swift
//  NetatmoSwiftSDK
//
//  Created by James Barrow on 2020-02-24.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

// TODO: Fix issue if a new item is added which doesn't exist in SecurityTypes
// TODO: Add subtype to Event

public extension NetatmoSecurity {
    
    struct HomeDataBase: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        /// The body of the result.
        public let body: HomeData?
        /// The status of the result.
        public let status: String?
        /// The error if the request errors.
        internal let error: NetatmoManager.RequestError?
        
        public var description: String {
            if let status = self.status, let body = self.body {
                return "HomeDataBase(status: \(status), body: \(body))"
            } else if let error = self.error {
                return "HomeDataBase(errorCode: \(error.code), body: \(error.message))"
            }
            return "HomeDataBase()"
        }
        
    }
    
    struct HomeData: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        public let homes: [Home]
        public let user: User
        public let globalInfo: GlobalInfo
        
        public var description: String {
            "HomeData(homes: \(homes), user: \(user), globalInfo: \(globalInfo))"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case homes
            case user
            case globalInfo = "global_info"
        }
    }
    
    struct Home: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        /// ID of the home.
        public let identifier: String
        /// Name of the home.
        public let name: String
        public let people: [Person]
        public let place: NetatmoWeather.Place
        public let cameras: [Camera]
        public let smokeDetectors: [SmokeDetector]
        public let events: [Event]
        
        public var description: String {
            "Home(identifier: \(identifier), name: \(name), peopleCount: \(people.count), place: \(place), cameras: \(cameras), smokeDetectors: \(smokeDetectors), eventsCount: \(events.count))"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case identifier = "id"
            case name
            case people = "persons"
            case place
            case cameras
            case smokeDetectors = "smokedetectors"
            case events
        }
    }
    
    struct Person: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        public let identifier: String
        private let lastSeen: TimeInterval
        public var lastSeenDate: Date { Date(timeIntervalSince1970: lastSeen) }
        public let outOfSight: Bool
        public let face: Face
        /// If pseudo is missing, the person is unknown
        public let pseudo: String?
        
        public var description: String {
            "Person(identifier: \(identifier), lastSeenDate: \(lastSeenDate), outOfSight: \(outOfSight), face: \(face), pseudo: \(pseudo ?? "Unknown"))"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case identifier = "id"
            case lastSeen = "last_seen"
            case outOfSight = "out_of_sight"
            case face
            case pseudo
        }
    }
    
    struct Face: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        public let identifier: String
        public let version: Int
        public let key: String
        public let url: String
        
        public var description: String {
            "Face(identifier: \(identifier), version: \(version), key: \(key))"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case identifier = "id"
            case version
            case key
            case url
        }
    }
    
    struct Camera: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        public let identifier: String
        private let rawType: String
        public var type: ProductType { ProductType(rawValue: rawType) }
        public let status: String
        public let vpnURL: String?
        public let isLocal: Bool
        public let sdCardStatus: String
        public let alimStatus: String
        public let name: String
        public var modules: [Module]?
        private let rawUsePinCode: Bool?
        public var usePinCode: Bool { rawUsePinCode ?? false }
        private let lastSetup: TimeInterval
        public var lastSetupDate: Date { Date(timeIntervalSince1970: lastSetup) }
        
        public var description: String {
            "Camera(identifier: \(identifier), type: \(type), status: \(status), isLocal: \(isLocal), sdCardStatus: \(sdCardStatus), alimentationStatus: \(alimStatus), name: \(name), modules: \(modules ?? []), usePinCode: \(usePinCode), lastSetupDate: \(lastSetupDate))"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case identifier = "id"
            case rawType = "type"
            case status
            case vpnURL = "vpn_url"
            case isLocal = "is_local"
            case sdCardStatus = "sd_status"
            case alimStatus = "alim_status"
            case name
            case modules
            case rawUsePinCode = "use_pin_code"
            case lastSetup = "last_setup"
        }
    }
    
    struct Module: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        public let identifier: String
        private let rawType: String
        public var type: ProductType { ProductType(rawValue: rawType) }
        public let batteryPercent: Int
        public let rfStatus: Int
        public let status: String
        public let monitoring: String?
        public let alimSource: String?
        private let rawTamperDetectionEnabled: Bool?
        public var tamperDetectionEnabled: Bool { rawTamperDetectionEnabled ?? false }
        public let name: String?
        public let category: String?
        public let room: String?
        private let lastActivity: TimeInterval?
        public var lastActivityDate: Date? {
            guard let lastActivity = self.lastActivity else { return nil }
            return Date(timeIntervalSince1970: lastActivity)
        }
        
        public var description: String {
            "Module(identifier: \(identifier))"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case identifier = "id"
            case rawType = "type"
            case batteryPercent = "battery_percent"
            case rfStatus = "rf"
            case status
            case monitoring
            case alimSource = "alim_source"
            case rawTamperDetectionEnabled = "tamper_detection_enabled"
            case name
            case category
            case room
            case lastActivity = "last_activity"
        }
    }
    
    struct SmokeDetector: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        public let identifier: String
        private let rawType: String
        public var type: ProductType { ProductType(rawValue: rawType) }
        private let lastSetup: TimeInterval
        public var lastSetupDate: Date { Date(timeIntervalSince1970: lastSetup) }
        public let name: String
        
        public var description: String {
            "SmokeDetector(identifier: \(identifier), type: \(type), lastSetupDate: \(lastSetupDate), name: \(name))"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case identifier = "id"
            case rawType = "type"
            case lastSetup = "last_setup"
            case name
        }
    }
    
    struct Event: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        public let identifier: String
        public let rawType: String
        public var type: EventType { EventType(rawValue: rawType) }
        public let subType: Int?
        public var sdSubType: SDCardSubType? {
            guard let subType = self.subType else { return nil }
            switch type {
            case .sd:
                return SDCardSubType(rawValue: subType)
            default:
                return nil
            }
        }
        public var alimSubType: AlimentationSubType? {
            guard let subType = self.subType else { return nil }
            switch type {
            case .alim:
                return AlimentationSubType(rawValue: subType)
            default:
                return nil
            }
        }
        private let time: TimeInterval
        public var date: Date { Date(timeIntervalSince1970: time) }
        public let cameraId: String
        public let deviceId: String
        public let personId: String?
        public let snapshot: Snapshot?
        public let vignette: Vignette?
        public let eventList: [SubEvent]?
        public let videoId: String?
        public let videoStatus: String?
        private let rawIsArrival: Bool?
        /// If person was considered away before being seen during this event
        public var isArrival: Bool { rawIsArrival ?? false }
        public let message: String?
        
        public var description: String {
            var description = "Event(identifier: \(identifier), type: \(type)"

            if let sdSubType = self.sdSubType {
                description += ", sdSubType: \(sdSubType)"
            }

            if let alimSubType = self.alimSubType {
                description += ", alimSubType: \(alimSubType)"
            }
            
            description += ", date: \(date), cameraId: \(cameraId), deviceId: \(deviceId)"
            
            if let personId = self.personId {
                description += ", personId: \(personId)"
            }
            
            if let snapshot = self.snapshot {
                description += ", snapshot: \(snapshot)"
            }
            
            if let vignette = self.vignette {
                description += ", vignette: \(vignette)"
            }
            
            if let eventList = self.eventList {
                description += ", eventList: \(eventList)"
            }
            
            if let videoId = self.videoId {
                description += ", videoId: \(videoId)"
            }
            
            if let videoStatus = self.videoStatus {
                description += ", videoStatus: \(videoStatus)"
            }
            
            description += ", isArrival: \(isArrival)"
            
            if let message = self.message {
                description += ", message: \(message)"
            }
            
            return description + ")"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case identifier = "id"
            case rawType = "type"
            case subType = "sub_type"
            case time
            case cameraId = "camera_id"
            case deviceId = "device_id"
            case personId = "person_id"
            case snapshot
            case vignette
            case eventList = "event_list"
            case videoId = "video_id"
            case videoStatus = "video_status"
            case rawIsArrival = "is_arrival"
            case message
        }
    }
    
    struct SubEvent: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        public let identifier: String
        public let rawType: String
        public var type: SubEventType { SubEventType(rawValue: rawType) }
        private let time: TimeInterval
        public var date: Date { Date(timeIntervalSince1970: time) }
        public let offset: Int
        public let snapshot: Snapshot
        public let vignette: Vignette
        public let message: String
        
        public var description: String {
            "SubEvent(identifier: \(identifier), type: \(type), date: \(date), offset: \(offset), snapshot: \(snapshot), vignette: \(vignette), message: \(message))"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case identifier = "id"
            case rawType = "type"
            case time
            case offset
            case snapshot
            case vignette
            case message
        }
    }
    
    struct Snapshot: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        public let identifier: String?
        public let version: Int?
        public let key: String?
        public let url: String?
        public let filename: String?
        
        public var description: String {
            if let identifier = self.identifier, let version = self.version, let key = self.key {
                return "Snapshot(identifier: \(identifier), version: \(version), key: \(key))"
            } else if let filename = self.filename {
                return "Snapshot(filename: \(filename))"
            }
            return "Snapshot()"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case identifier = "id"
            case version
            case key
            case url
            case filename
        }
    }
    
    struct Vignette: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        public let identifier: String?
        public let version: Int?
        public let key: String?
        public let url: String?
        public let filename: String?
        
        public var description: String {
            if let identifier = self.identifier, let version = self.version, let key = self.key {
                return "Vignette(identifier: \(identifier), version: \(version), key: \(key))"
            } else if let filename = self.filename {
                return "Vignette(filename: \(filename))"
            }
            return "Vignette()"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case identifier = "id"
            case version
            case key
            case url
            case filename
        }
    }
    
    struct User: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        public let regionLocale: String
        public let language: String
        public let country: String?
        public let mail: String
        
        public var description: String {
            if let country = self.country {
                return "User(regionLocale: \(regionLocale), language: \(language), country: \(country), mail: \(mail))"
            }
            return "User(regionLocale: \(regionLocale), language: \(language), mail: \(mail))"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case regionLocale = "reg_locale"
            case language = "lang"
            case country
            case mail
        }
    }
    
    struct GlobalInfo: Decodable, CustomStringConvertible {
        
        // MARK: - Properties
        
        public let showTags: Bool
        
        public var description: String {
            "GlobalInfo(showTags: \(showTags))"
        }
        
        // MARK: - Coding
        
        private enum CodingKeys: String, CodingKey {
            case showTags = "show_tags"
        }
    }
    
}
