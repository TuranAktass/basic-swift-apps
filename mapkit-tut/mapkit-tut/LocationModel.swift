//
//  LocationModel.swift
//  mapkit-tut
//
//  Created by Risetime on 14.12.2022.
//

import Foundation


class LocationModel{
    
    var id : UUID
    var name : String
    var note: String
    var longitude : Double
    var latitude : Double
    
    init(locationEntity : LocationEntity) {
        self.id = locationEntity.value(forKey: "id") as! UUID
        self.name = locationEntity.value(forKey: "name") as! String
        self.note = locationEntity.value(forKey: "comment") as! String
        self.longitude = locationEntity.value(forKey: "longitude") as! Double
        self.latitude = locationEntity.value(forKey: "latitude") as! Double
    }
    
    
}
