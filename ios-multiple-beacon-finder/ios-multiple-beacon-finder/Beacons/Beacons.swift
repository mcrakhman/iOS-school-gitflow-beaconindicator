//
//  Beacons.swift
//  ios-multiple-beacon-finder
//
//  Created by m.rakhmanov on 11.12.16.
//  Copyright © 2016 m.rakhmanov. All rights reserved.
//

import Foundation
import CoreLocation

struct Beacon {
    let name: String
    let uuid: UUID
    let majorValue: CLBeaconMajorValue
    let minorValue: CLBeaconMinorValue
}

func ==(beacon: Beacon, clbeacon: CLBeacon) -> Bool {
    return ((clbeacon.proximityUUID.uuidString == beacon.uuid.uuidString)
        && (Int(clbeacon.major) == Int(beacon.majorValue))
        && (Int(clbeacon.minor) == Int(beacon.minorValue)))
}
