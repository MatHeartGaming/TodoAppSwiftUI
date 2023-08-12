//
//  ContentView.swift
//  Todo App
//
//  Created by Matteo Buompastore on 11/08/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    //MARK: - PROPERTIES
    @EnvironmentObject var iconNames : IconNames
    @State private var showAddTodoView = false
    @State private var showSettings = false
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Todo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name, ascending: true)]) private var todos : FetchedResults<Todo>
    
    @State private var animatingButton = false
    
    //THEME
    @EnvironmentObject private var theme : ThemeSettings
    private let themes : [Theme] = themeData
    
    
    //MARK: - BODY
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(todos, id: \.self) {todo in
                        HStack {
                            Circle()
                                .frame(width: 12, height: 12, alignment: .center)
                                .foregroundColor(self.colorize(priority: todo.priority ?? "Normal"))
                            Text(todo.name ?? "Unknown")
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text(todo.priority ?? "Unknown")
                                .font(.footnote)
                                .foregroundColor(self.colorize(priority: todo.priority ?? "Normal"))
                                .padding(3)
                                .frame(minWidth: 62)
                                .overlay(
                                    Capsule()
                                        .stroke(self.colorize(priority: todo.priority ?? "Normal"), lineWidth: 2)
                                )
                        } //: HSTACK
                    } //: LOOP
                    .onDelete { indexes in
                        deleteTodo(at: indexes)
                    }
                } //: LIST
                .navigationTitle("Todo")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            print("Add Todo")
                            showSettings = true
                        } label: {
                            Image(systemName: "paintbrush")
                                .imageScale(.large)
                        } //: ADD BUTTON
                        .sheet(isPresented: $showSettings) {
                            SettingsView()
                                .environmentObject(iconNames)
                        }
                        .tint(themes[theme.themeSettings].themeColor)
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                            .tint(themes[theme.themeSettings].themeColor)
                    }
                    
                } //: TOOLBAR
                
                //MARK: - NO TODO ITEMS
                if todos.isEmpty {
                    EmptyListView()
                }
                
            } //: ZSTACK
            .sheet(isPresented: $showAddTodoView) {
                AddTodoView()
                    .environment(\.managedObjectContext, self.viewContext)
            }
            .overlay(
                ZStack {
                    
                    Group {
                        Circle()
                            .fill(themes[theme.themeSettings].themeColor)
                            .opacity(animatingButton ? 0.2 : 0)
                            .scaleEffect(animatingButton ? 1 : 0)
                            .frame(width: 68, height: 68, alignment: .center)
                        
                        Circle()
                            .fill(themes[theme.themeSettings].themeColor)
                            .opacity(animatingButton ? 0.15 : 0)
                            .scaleEffect(animatingButton ? 1 : 0)
                            .frame(width: 88, height: 88, alignment: .center)
                    } //: GROUP
                    .animation(.spring(response: 2, dampingFraction: 0.6, blendDuration: 0.5).repeatForever(), value: animatingButton)
                    .onAppear {
                        animatingButton = true
                    }
                    
                    Button(action: {
                        self.showAddTodoView.toggle()
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .background(
                                Circle()
                                    .fill(Color("ColorBase"))
                            )
                            .frame(width: 48, height: 48)
                    })
                    .tint(themes[theme.themeSettings].themeColor)
                } //. ZSTACK
                    .padding(.bottom, 15)
                    .padding(.trailing, 15)
                , alignment: .bottomTrailing)
            
        } //: NAVIGATION
        .navigationViewStyle(.stack)
    }
    
    
    //MARK: - FUNCTIONS
    private func deleteTodo(at offsets : IndexSet) {
        for index in offsets {
            let todo = todos[index]
            viewContext.delete(todo)
            
            do {
                try viewContext.save()
            } catch {
                print("Error deleting todo: \(error.localizedDescription)")
            }
        }
    }
    
    private func colorize(priority : String) -> Color {
        switch priority {
        case "High": return .pink
        case "Normal": return .green
        case "Low": return .blue
        default: return .gray
        }
    }
    
}

//MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.sizeThatFits)
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
            .environmentObject(IconNames())
            .environmentObject(ThemeSettings())
    }
}
