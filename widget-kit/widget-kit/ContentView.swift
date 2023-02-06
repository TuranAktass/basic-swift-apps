//
//  ContentView.swift
//  widget-kit
//
//  Created by Turan Aktaş on 6.02.2023.
//

import SwiftUI
import WidgetKit

let heroes = [spiderman, batman, ironman]

struct ContentView: View {
        
    var heroData : Data = Data()

    var body: some View {
        VStack {
            ForEach(heroes) {
                hero in HeroView(hero: hero).onTapGesture {
                    saveToDefaults(hero: hero)
                }
            }
        }
        .padding()
    }
    
    
     func saveToDefaults(hero : Superhero ) {
        try? UserDefaults().set(JSONEncoder().encode(hero), forKey: "hero")
        WidgetCenter.shared.reloadAllTimelines()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
