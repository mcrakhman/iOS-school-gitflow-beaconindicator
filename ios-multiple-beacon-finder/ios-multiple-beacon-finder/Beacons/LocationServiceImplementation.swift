//
//  LocationServiceImplementation.swift
//  ios-multiple-beacon-finder
//
//  Created by m.rakhmanov on 11.12.16.
//  Copyright © 2016 m.rakhmanov. All rights reserved.
//

import Foundation
import CoreLocation

class LocationServiceImplementation: NSObject, LocationService, CLLocationManagerDelegate {
    
    var beaconRegions: [CLBeaconRegion] = []
    let locationManager = CLLocationManager()
    weak var delegate: LocationServiceDelegate?
    
    override init() {
        super.init()
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
    }
    
    deinit {
        for beaconRegion in beaconRegions {
            locationManager.stopMonitoring(for: beaconRegion)
            locationManager.stopRangingBeacons(in: beaconRegion)
        }
    }
    
    func register(_ beacon: Beacon) {
        let beaconRegion = CLBeaconRegion(proximityUUID: beacon.uuid,
                                          major: beacon.majorValue,
                                          minor: beacon.minorValue,
                                          identifier: beacon.name)
        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(in: beaconRegion)
        beaconRegions.append(beaconRegion)
    }
    
    // MARK: CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager,
                         didRangeBeacons beacons: [CLBeacon],
                         in region: CLBeaconRegion) {
        var closest = beacons[0]
        
        if beacons.count == 1 {
            delegate?.didLocateClosest(closest)
            return
        }
        
        for index in 1 ..< beacons.count {
            if closest.accuracy < beacons[index].accuracy {
                closest = beacons[index]
            }
        }
        delegate?.didLocateClosest(closest)
    }
}
