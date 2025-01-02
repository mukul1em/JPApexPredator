//
//  ContentView.swift
//  JPApexPredator
//
//  Created by Mukul Rawat on 1/1/25.
//

import SwiftUI
import MapKit 
 
struct ContentView: View {
    @State var searchText = ""
    @State var alphabetical = false
    @State var currentSelectionType = APType.all
       
    let predators = Predators()
    var filteredDino: [ApexPredator] {
        predators.filter(by: currentSelectionType) 
        predators.sort(by: alphabetical )
        return predators.search(for: searchText)
    }
     
      
    var body: some View {
        NavigationStack{
            List(filteredDino) { predator in
                NavigationLink {
                    PredatorDetail(predator: predator, position: .camera(MapCamera(centerCoordinate: Predators().apexPredator[2 ].location, distance: 30000)))
                    
                } label : {
                    HStack {
                        //Dinasaur Image
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100 )
                            .shadow(color: .white, radius: 1)
                        
                        VStack(alignment: .leading){
                            //Dinasaur Name
                            Text(predator.name)
                                .fontWeight(.bold)
                            //Type
                            Text(predator.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 13)
                                .padding(.vertical, 5)
                                .background(predator.type  .background)
                                .clipShape(.capsule)
                            
                        }
                    }
                    
                }
                  
            }.navigationTitle("Apex Predators ")
                .searchable(text: $searchText)
                .autocorrectionDisabled()
                .animation(.default, value: searchText)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            withAnimation {
                                alphabetical.toggle()
                            }
                        } label :{
                            if alphabetical {
                                Image(systemName: "film")
                                    .symbolEffect(.bounce, value: alphabetical)
                            } else {
                                Image(systemName: "textformat")
                                    .symbolEffect(.bounce, value: alphabetical)
                            }
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu {
                            Picker("Filter", selection: $currentSelectionType.animation() ) {
                                ForEach(APType.allCases) {
                                    type in Label(type.rawValue.capitalized,
                                    systemImage: type.icon)
                                }
                            }
                        }label: {
                            Image(systemName: "slider.horizontal.3")
                        }
                    }
                }
           
        } .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
