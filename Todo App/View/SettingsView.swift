//
//  SettingsView.swift
//  Todo App
//
//  Created by Matteo Buompastore on 11/08/23.
//

import SwiftUI

struct SettingsView: View {
    
    //MARK: - PROPERTIES
    private let alternateAppIcons = [
        "AppIcon-Blue-Dark", "AppIcon-Blue-Light", "AppIcon-Blue",
        "AppIcon-Green-Light", "AppIcon-Green", "AppIcon-Pink-Dark",
        "AppIcon-Pink-Light", "AppIcon-Pink", "AppIcon"
    ]
    @AppStorage("selectedIcon") private var selectedIcon = "AppIcon"
    @State private var showIcons = false
    @Environment(\.presentationMode) private var presentation
    
    //THEMES
    @EnvironmentObject private var theme : ThemeSettings
    private let themes : [Theme] = themeData
    
    
    //MARK: - BODY
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                
                Form {
                    
                    //MARK: - SECTION 1
                    VStack {
                        HStack {
                            Text("Choose the App Icon")
                                .fontWeight(.semibold)
                        }
                        .onTapGesture {
                            withAnimation(.spring(response: 1, dampingFraction: 0.8, blendDuration: 0.8)) {
                                showIcons.toggle()
                            }
                        }
                        List(alternateAppIcons, id: \.self) {icon in
                            HStack {
                                Text(icon)
                                    .foregroundColor(icon == selectedIcon ? themes[theme.themeSettings].themeColor : .primary)
                                    .fontWeight(icon == selectedIcon ? .bold : .regular)
                                Spacer()
                                Image(uiImage: UIImage(named: icon) ?? UIImage())
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 36, height: 36, alignment: .center)
                                    .cornerRadius(10)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                                            .fill(icon == selectedIcon ? themes[theme.themeSettings].themeColor : .white)
                                            .frame(width: 39, height: 39, alignment: .center)
                                            .cornerRadius(10)
                                    )
                            } //: HSTACK
                            .onTapGesture {
                                IconNames.changerIcon(with: icon != "AppIcon" ? icon : nil)
                                selectedIcon = icon
                            }
                        } //: ICON LIST
                    } //: VSTACK
                    
                    //MARK: - SECTION 2
                    Section {
                        List {
                            ForEach(themes) { theme in
                                Button {
                                    self.theme.themeSettings = theme.id
                                } label: {
                                    HStack {
                                        Image(systemName: "circle.fill")
                                            .foregroundColor(theme.themeColor)
                                        Text(theme.themeName)
                                    } //: HSTACK
                                } //: BUTTON CHANGE THEME
                                .tint(.primary)
                                
                            } //: LOOP
                        }
                    } header: {
                        HStack {
                            Text("Choose the App Theme")
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 10, height: 10)
                                .foregroundColor(themes[theme.themeSettings].themeColor)
                        }
                    } //: SECTION 2
                    .padding(.vertical, 3)

                    
                    
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
        .tint(themes[theme.themeSettings].themeColor)
        .navigationViewStyle(.stack)
    }
}


//MARK: - PREVIEW
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(IconNames())
            .environmentObject(ThemeSettings())
    }
}
