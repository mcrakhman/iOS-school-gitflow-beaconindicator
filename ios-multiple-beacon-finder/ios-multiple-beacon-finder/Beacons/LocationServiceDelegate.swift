//
//  LocationServiceDelegate.swift
//  ios-multiple-beacon-finder
//
//  Created by m.rakhmanov on 11.12.16.
//  Copyright © 2016 m.rakhmanov. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationServiceDelegate {
    func didLocateClosest(_ beacon: CLBeacon)
}
