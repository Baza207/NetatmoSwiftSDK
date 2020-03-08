//
//  Event.swift
//  NetatmoSwiftSDK
//
//  Created by James Barrow on 2020-02-27.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public extension NetatmoSecurity {
    
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
        public let date: Date
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
            case date = "time"
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
        
        // MARK: - Init
        
        init(identifier: String, type: EventType, subType: Int? = nil, date: Date, cameraId: String, deviceId: String, personId: String? = nil, snapshot: Snapshot? = nil, vignette: Vignette? = nil, eventList: [SubEvent]? = nil, videoId: String? = nil, videoStatus: String? = nil, isArrival: Bool, message: String? = nil) {
            
            self.identifier = identifier
            self.rawType = type.rawValue
            self.subType = subType
            self.date = date
            self.cameraId = cameraId
            self.deviceId = deviceId
            self.personId = personId
            self.snapshot = snapshot
            self.vignette = vignette
            self.eventList = eventList
            self.videoId = videoId
            self.videoStatus = videoStatus
            self.rawIsArrival = isArrival
            self.message = message
        }
        
    }
    
}
