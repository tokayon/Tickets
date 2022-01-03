//
//  ListRow.swift
//  Tickets
//
//  Created by Serge Sinkevych on 1/2/22.
//

import SwiftUI

struct ListRow: View {
    
    var ticket: Ticket
    var completion: (() -> Void)?
    
    var body: some View {
        HStack(spacing: 20) {
            Text(ticket.date.regular)
                .frame(minWidth: 100, alignment: .center)
                .font(.system(.title3))
            Divider()
                .frame(width: 2)
                .background(Color.gray)
            
            HStack {
                Spacer()
                ticket.status.image
                    .foregroundColor(ticket.status.color)
                    .font(.system(.title3))
                Spacer()
            }
            .contentShape(Rectangle())
            .frame(width: 60, alignment: .center)
            .onTapGesture {
                completion?()
            }

            Divider()
                .frame(width: 2)
                .background(Color.gray)

            LinkView(link: ticket.prLink, width: 100, color: .blue)
                .font(.system(.title3))
            Divider()
                .frame(width: 2)
                .background(Color.gray)
            
            LinkView(link: ticket.jiraLink, width: 100, color: .orange)
                .font(.system(.title3))
            Divider()
                .frame(width: 2)
                .background(Color.gray)
            
            HStack() {
                Text(ticket.name)
                    .font(.system(.title3))
                Spacer()
            }
            .contentShape(Rectangle())
            .frame(minWidth: 200, maxWidth: .infinity, alignment: .leading)
            .onTapGesture {
                completion?()
            }
        }
    }
}

struct ListRow_Previews: PreviewProvider {

    static var previews: some View {
        let ticket = Ticket(name: "Test")
        ListRow(ticket: ticket)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
