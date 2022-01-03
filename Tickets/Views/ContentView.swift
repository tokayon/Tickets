//
//  ContentView.swift
//  Tickets
//
//  Created by Serge Sinkevych on 1/2/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State private var showTicketView: Bool = false
    @State private var currentTicket: Ticket = Ticket(name: "")
    @State private var filter: String = ""
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \TicketEntity.timestamp, ascending: false)])
    private var tickets: FetchedResults<TicketEntity>

    var body: some View {
        ZStack {
            VStack {
                // MARK: HEADER
                HStack(spacing: 10) {
                    // TITLE
                    Text("Tickets")
                        .font(.system(.largeTitle, design: .rounded))
                        .fontWeight(.heavy)
                        .padding(.leading, 4)
                        .padding(.trailing, 20)
                    
                    
                    TextField("Search...", text: $filter)
                        .frame(width: 100)
                    Spacer()
                    
                    // IMPORT BUTTON
                    Button(action: importTickets) {
                        Text("Import...")
                    }
                    
                    // EXPORT BUTTON
                    Button(action: exportTickets) {
                        Text("Export...")
                    }
                    
                    // ADD BUTTON
                    Button(action: addTicket) {
                        Text("Add Ticket")
                    }
                    
                }//: HSTACK
                .padding()
                
                FilteredList(filter: filter) { ticket in
                    currentTicket = ticket
                    showTicketView = true
                }
                .shadow(color: .black.opacity(0.3), radius: 12)
                .padding(.vertical, 20)
                .padding(.horizontal, 20)
                
            }//: VSTACK
            .background(Color.pink)
            .blur(radius: showTicketView ? 8.0 : 0, opaque: false)

            FlexibleSheet(show: $showTicketView) {
                TicketView(show: $showTicketView,
                           ticket: $currentTicket,
                           saveTicket: saveTicket,
                           deleteTicket: deleteTicket)
            }
            
        }//: ZSTACK
        .padding(.vertical, 0)
    }

    func importTickets() {
        let panel = NSOpenPanel()

        panel.canChooseDirectories = false
        panel.canChooseFiles = true
        panel.allowedFileTypes = ["json"]
        panel.runModal()

        if let chosenFile = panel.url {
            do {
                let file = try Data(contentsOf: chosenFile)
                let decoder = JSONDecoder()
                let tickets = try decoder.decode([Ticket].self, from: file)
                for ticket in tickets {
                    print("ticket: ", ticket.name)
                    let newTicket = TicketEntity(context: viewContext)
                    newTicket.timestamp = ticket.date
                    newTicket.name = ticket.name
                    newTicket.statusTag = Int16(ticket.statusTag)
                    newTicket.jiraLink = ticket.jiraLink
                    newTicket.prLink = ticket.prLink
                    newTicket.notes = ticket.notes
                    newTicket.id = ticket.id

                    do {
                        try viewContext.save()
                    } catch {
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    }
                }
            } catch {
                print ("loading file error")
            }
            print("file: ", chosenFile)
        }
    }
    
    private func exportTickets() {
        let tickets = tickets.map({ Ticket(from: $0) })
        guard let json = try? JSONEncoder().encode(tickets) else { return }

        let savePanel = NSSavePanel()
        savePanel.canCreateDirectories = true
        savePanel.showsTagField = false
        savePanel.nameFieldStringValue = "tickets.json"
        savePanel.level = NSWindow.Level(rawValue: Int(CGWindowLevelForKey(.modalPanelWindow)))
        savePanel.begin { (result) in
            switch result {
            case .OK:
                if let dir = savePanel.directoryURL {
                    let fileUrl = dir.appendingPathComponent(savePanel.nameFieldStringValue)
                    do {
                        try json.write(to: fileUrl, options: .noFileProtection)
                    }
                    catch { /* error handling here */ }
                }
            default:
                print(result)
            }
        }
    }
    
    private func saveTicket() {
        withAnimation {
            let fetchRequest: NSFetchRequest<TicketEntity> = TicketEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", currentTicket.id as CVarArg)
            if let ticket = try? viewContext.fetch(fetchRequest).first {
                ticket.timestamp = currentTicket.date
                ticket.name = currentTicket.name
                ticket.statusTag = Int16(currentTicket.statusTag)
                ticket.jiraLink = currentTicket.jiraLink
                ticket.prLink = currentTicket.prLink
                ticket.notes = currentTicket.notes
            } else {
                let newTicket = TicketEntity(context: viewContext)
                newTicket.timestamp = currentTicket.date
                newTicket.name = currentTicket.name
                newTicket.statusTag = Int16(currentTicket.statusTag)
                newTicket.jiraLink = currentTicket.jiraLink
                newTicket.prLink = currentTicket.prLink
                newTicket.notes = currentTicket.notes
                newTicket.id = currentTicket.id
            }
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func addTicket() {
        currentTicket = Ticket(name: "")
        showTicketView = true
    }
    
    private func deleteTicket() {
        withAnimation {
            let fetchRequest: NSFetchRequest<TicketEntity> = TicketEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", currentTicket.id as CVarArg)
            if let ticket = try? viewContext.fetch(fetchRequest).first {
                viewContext.delete(ticket)
                do {
                    try viewContext.save()
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
