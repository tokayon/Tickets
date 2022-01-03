//
//  TicketStatus.swift
//  Tickets
//
//  Created by Serge Sinkevych on 1/2/22.
//

import SwiftUI

enum TicketStatus: Int {
    case new
    case inProgress
    case pr
    case blocked
    case qa
    case verified
    case done
    case closed
    
    
    static var cases: Int {
        return 8
    }
    
    static func status(from tag: Int) -> TicketStatus {
        return TicketStatus(rawValue: tag) ?? TicketStatus.new
    }
    
    static func status(from description: String) -> TicketStatus {
        switch description {
        case "new":
            return .new
        case "inProgress":
            return .inProgress
        case "pr":
            return .pr
        case "blocked":
            return .blocked
        case "qa":
            return .qa
        case "verified":
            return .verified
        case "done":
            return .done
        case "closed":
            return .closed
        default:
            return .new
        }
    }
    
    var image: Image {
        switch self {
        case .new:
            return Image(systemName: "smallcircle.filled.circle.fill")
        case .inProgress:
            return Image(systemName: "swift")
        case .pr:
            return Image(systemName: "binoculars")
        case .blocked:
            return Image(systemName: "hand.raised.fill")
        case .qa:
            return Image(systemName: "atom")
        case .verified:
            return Image(systemName: "checkmark.rectangle")
        case .done:
            return Image(systemName: "checkmark.rectangle.fill")
        case .closed:
            return Image(systemName: "grid")
        }
    }
    
    var color: Color {
        switch self {
        case .new:
            return .orange
        case .inProgress:
            return .pink
        case .pr:
            return .purple
        case .blocked:
            return .red
        case .qa:
            return .blue
        case .verified, .done:
            return .green
        case .closed:
            return .yellow
        }
    }
    
    var description: String {
        switch self {
        case .new:
            return "new"
        case .inProgress:
            return "inProgress"
        case .pr:
            return "pr"
        case .blocked:
            return "blocked"
        case .qa:
            return "qa"
        case .verified:
            return "verified"
        case .done:
            return "done"
        case .closed:
            return "closed"
        }
    }
}
