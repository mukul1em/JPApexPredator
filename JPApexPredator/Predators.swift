 //
//  Predators.swift
//  JPApexPredator
//
//  Created by Mukul Rawat on 1/1/25.
//

import Foundation

//class works better when it comes to data manuplations

class Predators {
    var allApexPredator: [ApexPredator] = []
    var apexPredator: [ApexPredator] = []
    
    init(){
        decodeApexPredatorData()
    }
    
    func decodeApexPredatorData() {
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json")
        {
            do {
                
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                allApexPredator = try decoder.decode([ApexPredator].self, from: data)
                apexPredator = allApexPredator
            }
            
            catch {
                print("error in decoding json data \(error)")
            }
        }
    }
    
    func search(for searchTerm: String) -> [ApexPredator] {
        if searchTerm.isEmpty {
            return apexPredator
        }
        else{
            return apexPredator.filter {
                predator in predator.name.localizedCaseInsensitiveContains(searchTerm)
            }
        }
    }
    
    func sort(by alphabetical: Bool) {
        apexPredator.sort { predidator1, predidator2 in
            if alphabetical{
                predidator1.name < predidator2.name
            }
            else{
                predidator1.id < predidator2.id
                  
            }
        }
    }
    
    func filter(by type: APType) {
        if type == .all {
            apexPredator = allApexPredator
        } else {
            apexPredator = allApexPredator.filter { predator in
                predator.type == type
            }
        } 
          
    }
    
}


