//
//  AddTodoView.swift
//  Todo App
//
//  Created by Matteo Buompastore on 11/08/23.
//

import SwiftUI

struct AddTodoView: View {
    
    //MARK: - PROPERTIES
    @Environment(\.presentationMode) private var presentation
    @Environment(\.managedObjectContext) private var managedContext
    @State private var name : String = ""
    @State private var priority : String = "Normal"
    @State var showAlertNameEmpty = false
    @State private var errorShowing = false
    @State private var errorTitle : String = ""
    @State private var errorMessage : String = ""
    
    private let priorities = ["High", "Normal", "Low"]
    
    //MARK: - BODY
    var body: some View {
        NavigationView {
            
            ZStack(alignment: .center) {
                VStack {
                    VStack(alignment: .leading, spacing: 20) {
                        //MARK: - TODO NAME
                        TextField("Todo", text: $name)
                            .padding()
                            .background(Color(UIColor.tertiarySystemFill))
                            .cornerRadius(10)
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                        
                        
                        //MARK: - TODO PRIORITY
                        Picker("Priority", selection: $priority) {
                            ForEach(priorities, id: \.self) { prio in
                                Text(prio)
                            } //: LOOP
                        } //: PICKER
                        .pickerStyle(.segmented)
                        
                        //MARK: - SAVE BUTTON
                        Button {
                            if (!self.name.isEmpty) {
                                let todo = Todo(context: managedContext)
                                todo.name = self.name
                                todo.priority = self.priority
                                do {
                                    try self.managedContext.save()
                                    print("New todo: \(todo.name!), Priority: \(todo.priority!)")
                                } catch {
                                    print("Error saving the todo \(String(describing: todo.name)): \(error.localizedDescription)")
                                }
                            } else {
                                showAlertNameEmpty = true
                                errorTitle = "Name is Empty"
                                errorMessage = "Make sure to enter something for\nthe todo item."
                                return
                            }
                            self.presentation.wrappedValue.dismiss()
                        } label: {
                            Text("Save")
                                .font(.system(size: 24, weight: .semibold, design: .rounded))
                                .padding()
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .background(
                                    LinearGradient(colors: [.blue, .indigo], startPoint: .top, endPoint: .bottom)
                                )
                                .cornerRadius(10)
                                .foregroundColor(.white)
                        } //: SAVE BUTTON
                        
                    } //: VSTACK
                    .padding(.horizontal)
                    .padding(.vertical, 20)
                    
                    Spacer()
                    
                } //: VSTACK
                /*.alert("Name is Empty", isPresented: $showAlertNameEmpty, actions: {
                    Text("OK")
                })*/
                .blur(radius: showAlertNameEmpty ? 10 : 0)
                .navigationTitle("New Todo")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            presentation.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "xmark")
                        }
                        
                    }
                } //: TOOLBAR
                
                
                CustomAlertDialog(title: "WARNING", message: "Name cannot be empty!")
                    .padding()
                    .offset(y: showAlertNameEmpty ? 0 : -100)
                    .opacity(showAlertNameEmpty ? 1 : 0)
                    .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.3), value: showAlertNameEmpty)
                    .onChange(of: showAlertNameEmpty, perform: { _ in
                        if showAlertNameEmpty == true {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation {
                                    showAlertNameEmpty = false
                                }
                            }
                        }
                    }) //: CUSTOM ALERT
                
                
            } //: ZSTACK
            
        } //: NAVIGATION
        
    }
}


//MARK: - PREVIEW
struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
            .previewLayout(.sizeThatFits)
        //.padding()
    }
}
