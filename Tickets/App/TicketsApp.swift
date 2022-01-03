//
//  TicketsApp.swift
//  Tickets
//
//  Created by Serge Sinkevych on 1/2/22.
//

import SwiftUI

@main
struct TicketsApp: App {
    let persistenceController = PersistenceController.shared
            
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .commands {
            CommandMenu("Transfer") {
                Button("Import...") {
                    importTickets()
                }
                Button("Export...") {
                    exportTickets()
                }
            }
        }
    }
    
    func importTickets() {
        
    }
    
    func exportTickets() {

    }
}
