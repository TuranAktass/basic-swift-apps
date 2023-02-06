//
//  hero_widget.swift
//  hero-widget
//
//  Created by Turan Aktaş on 6.02.2023.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(), hero: batman)
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        //let data = UserDefaults().data(forKey: "hero")
        //let hero = try? JSONDecoder().decode(Superhero.self, from: data!)
        let entry = SimpleEntry(date: Date(), configuration: configuration, hero: batman)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
       
            // let data =  UserDefaults().data(forKey: "hero")
            // let hero = try JSONDecoder().decode(Superhero.self, from: data!)
             
             let entry = SimpleEntry(date: Date(), configuration: configuration, hero: batman)
             let timeline = Timeline(entries: [entry], policy: .never)
             completion(timeline)
        
        
    
        
        
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let hero: Superhero
}

struct hero_widgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack{
            CircularImageView(image: Image(entry.hero.image))
            Text(entry.hero.name)
        }
    }
}

struct hero_widget: Widget {
    let kind: String = "hero_widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            hero_widgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}
