//
//  SettingsView.swift
//  Todo App
//
//  Created by Matteo Buompastore on 11/08/23.
//

import SwiftUI

struct SettingsView: View {
    
    //MARK: - PROPERTIES
    @Environment(\.presentationMode) private var presentation
    
    //MARK: - BODY
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                
                Form {
                    
                    //MARK: - SECTION 3
                    Section {
                        FormRowLinkView(icon: "globe", color: .pink, text: "Github", link: "https://github.com/MatHeartGaming")
                        FormRowLinkView(icon: "link", color: .blue, text: "Linkedin", link: "https://www.linkedin.com/in/matteo-buompastore-3b78921a0/?original_referer=")
                        FormRowLinkView(icon: "keyboard", color: .orange, text: "Stack Overflow", link: "https://stackoverflow.com/users/12989363/matbuompy")
                    } header: {
                        Text("Follow me on Social Media")
                    } //: SECTION 3

                    
                    //MARK: - SECTION 4
                    Section {
                        FormRowStaticVirew(icon: "gear", firstText: "Application", secondText: "Todo")
                        FormRowStaticVirew(icon: "checkmark.seal", firstText: "Compatibility", secondText: "iOS, iPadOS")
                        FormRowStaticVirew(icon: "gear", firstText: "Application", secondText: "Todo")
                        FormRowStaticVirew(icon: "keyboard", firstText: "Developer", secondText: "MatBuompy")
                        FormRowStaticVirew(icon: "paintbrush", firstText: "Designer", secondText: "MatBuompy")
                        FormRowStaticVirew(icon: "flag", firstText: "Version", secondText: "1.0.0")
                    } header: {
                        Text("About the application")
                    } //: SECTION 4
                    
                } //: FORM
                .listStyle(.grouped)
                .environment(\.horizontalSizeClass, .regular)
                
                
                //MARK: - FOOTER
                Text("Copyright ©️ All rights reserved.\nBetter Apps ♡ Less Code.")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding(.top, 6)
                    .padding(.bottom)
                    .foregroundColor(.secondary)
                
            } //: VSTACK
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color("ColorBackground"))
            .edgesIgnoringSafeArea([.horizontal, .bottom])
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        presentation.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }

                }
            }
        } //: NAVIGATION
    }
}


//MARK: - PREVIEW
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
