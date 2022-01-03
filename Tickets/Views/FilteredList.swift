//
//  FilteredList.swift
//  Tickets
//
//  Created by Serge Sinkevych on 1/2/22.
//

import SwiftUI

struct FilteredList: View {
    
    @FetchRequest var fetchRequest: FetchedResults<TicketEntity>
    var completion: ((Ticket) -> Void)
    
    init(filter: String, completion: @escaping ((Ticket) -> Void)) {
        if filter.isEmpty {
            _fetchRequest = FetchRequest<TicketEntity>(sortDescriptors: [NSSortDescriptor(keyPath: \TicketEntity.timestamp, ascending: false)])
        } else {
            _fetchRequest = FetchRequest<TicketEntity>(sortDescriptors: [NSSortDescriptor(keyPath: \TicketEntity.timestamp, ascending: false)], predicate: NSPredicate(format: "name contains[c] %@ or jiraLink contains[c] %@ or prLink contains[c] %@", filter, filter, filter))
        }
        self.completion = completion
    }
    
    var body: some View {
        List {
            Section(header: HeaderView()) {
                ForEach(fetchRequest) { entity in
                    let ticket = Ticket(from: entity)
                    ListRow(ticket: ticket) {
                        completion(ticket)
                    }
                }
            }
        }//: LIST
    }
}
//
//struct FilteredList_Previews: PreviewProvider {
//    static var previews: some View {
//        FilteredList(filter: "", completion: {Ticket(name: "")})
//    }
//}
