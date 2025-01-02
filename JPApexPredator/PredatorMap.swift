//
//  PredatorMap.swift
//  JPApexPredator
//
//  Created by Mukul Rawat on 1/1/25.
//

import SwiftUI
import MapKit

struct PredatorMap: View {
    @State var position: MapCameraPosition
    let predators = Predators()
     
    var body: some View {
        Map(position: $position) {
            ForEach(predators.apexPredator) {
                predator in
                Annotation(predator.name,
                           coordinate: predator.location
                ){
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100 )
                        .shadow(color: .white, radius: 3 )
                        .scaleEffect(x: -1 )
                     
                }
            }
        }
    }
}

#Preview {
    PredatorMap(position: .camera(MapCamera(
        centerCoordinate: Predators().apexPredator[2].location ,
        distance: 1000,
        heading: 250,
    pitch: 80)))
    .preferredColorScheme(.dark)
}
  
