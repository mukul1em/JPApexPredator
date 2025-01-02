//
//  PredatorDetail.swift
//  JPApexPredator
//
//  Created by Mukul Rawat on 1/1/25.
//

import SwiftUI
import MapKit

struct PredatorDetail: View {
    let predator: ApexPredator
    @State var position: MapCameraPosition
    @Namespace var nameSpace
    var body: some View {
        GeometryReader { geo in
            
             
            ScrollView {
                
                ZStack(alignment: .bottomTrailing ) {
                    //Background Image
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay {
                            LinearGradient(stops: [Gradient.Stop(color: .clear, location: 0.8 ),
                                                   Gradient.Stop(color: .black , location: 1 ) ],
                                           startPoint: .top, endPoint: .bottom  )
                        }
                    
                    //Dinasaur image
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width/1.5, height: geo.size.height/3.7 )
                        .scaleEffect(x: -1)
                        .shadow(color: .black, radius:  7)
                        .offset(y: 20)
                     
                     
                    
                }
                
                // Dino name
                VStack (alignment: .leading){
                    Text(predator.name)
                        .font(.largeTitle)
                    
                    // Location
                    NavigationLink {
                        PredatorMap(position: .camera(MapCamera(
                            centerCoordinate: predator.location ,
                            distance: 1000,
                            heading: 250,
                            pitch: 80))
                        ).navigationTransition(.zoom(sourceID: 1, in: nameSpace))
                        
                    }label: {
                        Map(position: $position ) {
                            Annotation(predator.name,  coordinate: predator.location)
                            {
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                    .symbolEffect(.pulse)
                            }
                            .annotationTitles(.hidden  )
                        }
                        .frame(height: 125 )
                        .clipShape(.rect(cornerRadius : 15))
                        .overlay(alignment: .trailing) {
                             Image(systemName: "greaterthan")
                                .imageScale(.large)
                                .font(.title3)
                                .padding(.trailing, 5)
                        }
                        .overlay(alignment :.topLeading) {
                            Text("Current Location: ")
                                .padding([.bottom, .leading], 5 )
                                .padding(.trailing, 5)
                                .background(Color.black.opacity(0.33))
                                .clipShape(.rect(bottomTrailingRadius: 1))
                        }
                    }
                    .matchedTransitionSource(id: 1 , in: nameSpace)
                    
                    //Appears in
                    Text("Appears In: ")
                        .font(.title3)
                        .padding(.top)
                    ForEach(predator.movies, id: \.self){
                        movie in Text("•  " + movie)
                            .font(.subheadline)
                     
                    }
                    //movie moments
                    Text("Movie Moments:")
                        .font(.title)
                        .padding(.top,  15)
                    
                    ForEach(predator.movieScenes) {scene in
                        Text(scene.movie)
                            .font(.title2)
                            .padding(.vertical, 1)
                        
                        Text(scene.sceneDescription)
                            .padding(.bottom, 16)
                    }
                     
                    //Link to the webpage
                    Text("Read More: ")
                        .font(.caption)
                    
                    Link(predator.link, destination: URL(string: predator.link)!)
                        .font(.caption)
                        .foregroundStyle(.blue)
                }
                .padding()
                .padding(.bottom)
                .frame(width: geo.size.width, alignment: .leading)
            }
            
        }
         .ignoresSafeArea()
         .toolbarBackground(.automatic)
    }
}

#Preview {
    PredatorDetail(predator: Predators().apexPredator[2], position: .camera(MapCamera(centerCoordinate: Predators().apexPredator[2] .location, distance: 30000)))
        .preferredColorScheme(.dark)
}
   
