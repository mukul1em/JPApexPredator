//
//  ApexPredator.swift
//  JPApexPredator
//
//  Created by Mukul Rawat on 1/1/25.
//

import SwiftUI
import MapKit

// decoding to json to swift
struct ApexPredator: Decodable, Identifiable {
    let id: Int
    let name: String
    let type: APType
    let latitude: Double
    let longitude: Double
    let movies: [String]
    let movieScenes: [movieScene]
    let link: String
    
    var image: String {
        name.lowercased().replacingOccurrences(of: " ", with: "") 
    }
    
    var location:  CLLocationCoordinate2D {
         CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
         
    }
    struct movieScene: Decodable, Identifiable {
        let id: Int
        let movie: String
        let sceneDescription:  String
        
    }
    
    
}


enum APType: String, Decodable, CaseIterable, Identifiable {
    case all
    case land
    case air
    case sea
    
    var id: APType {
        self
    }
    
    var background: Color {
        switch self {
        case .land:
            return Color.brown
        case .air:
            return Color.teal
        case .sea:
            return Color.blue
        case .all:
            return .black
        }
    
    }
    var icon: String {
        switch self {
        case .land:
            return "leaf.fill"  
        case .air:
            return "wind"
        case .sea:
            return "drop.fill"
        case .all:
            return "square.stack.3d.up.fill"
        }
    }
    }
