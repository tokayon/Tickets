//
//  TicketView.swift
//  Tickets
//
//  Created by Serge Sinkevych on 1/2/22.
//

import SwiftUI

struct TicketView: View {

    @Binding var show: Bool
    @Binding var ticket: Ticket
    var saveTicket: (() -> Void)?
    var deleteTicket: (() -> Void)?
    
    init(show: Binding<Bool>, ticket: Binding<Ticket>, saveTicket: (() -> Void)?, deleteTicket: (() -> Void)?) {
        _show = show
        _ticket = ticket
        self.saveTicket = saveTicket
        self.deleteTicket = deleteTicket
    }
    
    var body: some View {
        VStack {
            //: HEADER
            HStack(alignment: .center) {
                Text(createTicketTitle())
                    .font(.system(.title))
                    .padding()
            }//: HSTACK
                
            //: BODY
            VStack(spacing: 20) {
                
                // NAME
                HStack(alignment: .top) {
                    Text("TITLE")
                        .font(.title3)
                        .bold()
                        .padding(.horizontal, 15)
                        .frame(width: 150, alignment: .leading)
                    TextEditor(text: $ticket.name)
                        .foregroundColor(.white)
                        .frame(height: 40)
                        .font(.system(.body))
                        .cornerRadius(6)
                    Spacer()
                }
                
                // JIRA LINK
                HStack(alignment: .center) {
                    Text("JIRA LINK")
                        .font(.title3)
                        .bold()
                        .padding(.horizontal, 15)
                        .frame(width: 150, alignment: .leading)
                    TextField(ticket.jiraLink, text: $ticket.jiraLink)
                        .cornerRadius(6)
                    Spacer()
                }
                
                // PR LINK
                HStack(alignment: .center) {
                    Text("PR LINK")
                        .font(.title3)
                        .bold()
                        .padding(.horizontal, 15)
                        .frame(width: 150, alignment: .leading)
                    TextField(ticket.prLink, text: $ticket.prLink)
                        .cornerRadius(6)
                    Spacer()
                }
                
                // NOTES
                HStack(alignment: .top) {
                    Text("NOTES")
                        .font(.title3)
                        .bold()
                        .padding(.horizontal, 15)
                        .frame(width: 150, alignment: .leading)
                    TextEditor(text: $ticket.notes)
                        .foregroundColor(.white)
                        .frame(height: 40)
                        .font(.system(.body))
                        .cornerRadius(6)
                    Spacer()
                }
                
                // DATE
                HStack(alignment: .center) {
                    Text("DATE")
                        .font(.title3)
                        .bold()
                        .padding(.horizontal, 15)
                        .frame(width: 150, alignment: .leading)
                    DatePicker("", selection: $ticket.date, displayedComponents: .date)
                        .frame(width: 80, height: 30)
                        .cornerRadius(10)
                    Spacer()
                }
                
                // STATUS
                HStack {
                    Text("STATUS")
                        .font(.title3)
                        .bold()
                        .padding(.horizontal, 15)
                        .frame(width: 150, alignment: .leading)
                    Picker("", selection: $ticket.statusTag) {
                        ForEach(0..<TicketStatus.cases, id: \.self) {
                            Text(TicketStatus.status(from: $0).description).tag($0)
                        }
                    }
                    
                    TicketStatus.status(from: ticket.statusTag).image
                        .font(.system(.title))
                        .foregroundColor(TicketStatus.status(from: ticket.statusTag).color)
                        .padding(15)
                        .background(Color.gray(50))
                        .cornerRadius(15)
                    Spacer()
                    
                    VStack {
                        Spacer()
                        //: BUTTONS
                        HStack(spacing: 20) {
                            Spacer()
                            Button {
                                show = false
                            } label: {
                                Text("Cancel")
                            }
                            
                            Button {
                                let alert = NSAlert()
                                alert.messageText = "Delete Ticket"
                                alert.informativeText = "Are you sure?"
                                alert.addButton(withTitle: "Cancel")
                                alert.addButton(withTitle: "Yes")
                                let modalResult = alert.runModal()

                                switch modalResult {
                                case .alertSecondButtonReturn:
                                    show = false
                                    deleteTicket?()
                                default:
                                    print("do nothing")
                                }
                            } label: {
                                Text("Delete")
                            }
                            
                            Button {
                                show = false
                                saveTicket?()
                            } label: {
                                Text("Save")
                            }
                            .disabled(ticket.name.isEmpty)
                            
                        }//: HSTACK BUTTONS
                        .padding()
                    }//: VSTACK BUTTONS
                }//: HSTACK STATUS
                Spacer()
            }//: VSTACK BODY
        }//: VSTACK
        .padding()
        .background(Color.pink)
    }
    
    func createTicketTitle() -> String {
        if !ticket.jiraLink.isEmpty, let link = URL(string: ticket.jiraLink) {
            return link.lastPathComponent
        } else {
            return "TICKET"
        }
    }
}

struct TicketView_Previews: PreviewProvider {
    
    @State static var ticket: Ticket = Ticket(name: "Long name")

    static var previews: some View {
        TicketView(show: .constant(true), ticket: $ticket, saveTicket: nil, deleteTicket: nil)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

