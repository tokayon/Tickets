//
//  Ticket.swift
//  Tickets
//
//  Created by Serge Sinkevych on 1/2/22.
//

import Foundation

struct Ticket: Codable, Identifiable {
    var dateString: String
    var name: String
    var statusTag: Int
    var jiraLink: String
    var prLink: String
    var notes: String
    var id: UUID = UUID()
    
    private enum CodingKeys : String, CodingKey {
        case dateString, name, statusTag, jiraLink, prLink, notes
    }

    var date: Date {
        get {
            return dateString.iso8601
        }
        set {
            dateString = newValue.iso8601
        }
    }
    
    var status: TicketStatus {
        get {
            return TicketStatus.status(from: statusTag)
        }
        set {
            statusTag = newValue.rawValue
        }
    }
    
    init(name: String) {
        self.dateString = Date().iso8601
        self.name = name
        self.statusTag = 0
        self.jiraLink = ""
        self.prLink = ""
        self.notes = ""
        self.id = UUID()
    }
    
    init(from entity: TicketEntity) {
        self.dateString = (entity.timestamp ?? Date()).iso8601
        self.name = entity.name ?? ""
        self.statusTag = Int(entity.statusTag)
        self.jiraLink = entity.jiraLink ?? ""
        self.prLink = entity.prLink ?? ""
        self.notes = entity.notes ?? ""
        self.id = entity.id ?? UUID()
    }
}
