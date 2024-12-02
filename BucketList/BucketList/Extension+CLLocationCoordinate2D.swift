//
//  Extension+CLLocationCoordinate2D.swift
//  BucketList
//
//  Created by Xristos Mantsos on 2/12/24.
//

import CoreLocation
import Foundation

extension CLLocationCoordinate2D {
    func isCloseTo(_ other: CLLocationCoordinate2D, threshold: Double = 0.1) -> Bool {
        abs(self.latitude - other.latitude) < threshold && abs(self.longitude - other.longitude) < threshold
    }
}
