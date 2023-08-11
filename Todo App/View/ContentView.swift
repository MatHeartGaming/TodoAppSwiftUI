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
    @State private var showAddTodoView = false
    @State private var showSettings = false
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Todo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name, ascending: true)]) private var todos : FetchedResults<Todo>
    
    @State private var animatingButton = false
    
    
    //MARK: - BODY
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(todos, id: \.self) {todo in
                        HStack {
                            Text(todo.name ?? "Unknown")
                            
                            Spacer()
                            
                            Text(todo.priority ?? "Unknown")
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
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
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
                            .fill(.blue)
                            .opacity(animatingButton ? 0.2 : 0)
                            .scaleEffect(animatingButton ? 1 : 0)
                            .frame(width: 68, height: 68, alignment: .center)
                        
                        Circle()
                            .fill(.blue)
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
                } //. ZSTACK
                    .padding(.bottom, 15)
                    .padding(.trailing, 15)
                , alignment: .bottomTrailing)
            
        } //: NAVIGATION
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
    
}

//MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.sizeThatFits)
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
