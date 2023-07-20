//
//  EditProfileView.swift
//  QuitMate
//
//  Created by Саша Василенко on 11.07.2023.
//

import SwiftUI
import PhotosUI
import Foundation

enum EditProfileFocusFields: Hashable {
    case name, age, email
}

struct EditProfileView: View {
    @State var info: String
    @State var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @FocusState var focus: EditProfileFocusFields?
    var body: some View {
        VStack(spacing: Spacings.spacing25) {
            Image("Tokyo")
                .resizable()
                .clipShape(Circle())
                .frame(width: 100, height: 100)
            PhotosPicker(selection: $selectedItem, matching: .images,
                         photoLibrary: .shared()) {
                Text("Set new photo")
                    .fontStyle(.buttonsText)
                    .frame(maxWidth: .infinity)
            }.onChange(of: selectedImageData) { newValue in
                Task {
                    // Retrive selected asset in the form of Data
                    if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                        selectedImageData = data
                    }
                }
            }
            //            Button {
            //
            //            } label: {
            //                Text("Set new photo")
            //                    .fontStyle(.buttonsText)
            //                    .frame(maxWidth: .infinity)
            //            }
            //            .buttonStyle(.bordered)
            Form {
                Section("Personal information") {
                    TextField("Name", text: $info)
                        .focused($focus, equals: .name)
                    TextField("Age", text: $info)
                        .focused($focus, equals: .age)
                }
                
                Section("Contact information") {
                    TextField("Email", text: $info)
                        .focused($focus, equals: .email)
                }
            }
            .fontStyle(.textFieldText)
        }.padding()
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        @State var mock: String = "Info"
        EditProfileView(info: mock)
    }
}
