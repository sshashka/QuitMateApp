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
    @State var info: String = "Info"
    @State var selectedItem: PhotosPickerItem? = nil
    //    @State private var selectedImageData: Data? = nil
    @StateObject var viewModel: EditProfileViewModel
    @FocusState var focus: EditProfileFocusFields?
    var body: some View {
        VStack(spacing: Spacings.spacing25) {
            ProfileImagePic(image: viewModel.userImage)
            PhotosPicker(selection: $selectedItem, matching: .images,
                         photoLibrary: .shared()) {
                Text("Set new photo")
                    .fontStyle(.buttonsText)
                    .frame(maxWidth: .infinity)
            }.onChange(of: selectedItem) { newValue in
                Task {
                    // Retrive selected asset in the form of Data
                    if let data = try? await newValue?.loadTransferable(type: Data.self) {
                        viewModel.udateImage(with: data)
                    }
                }
            }
            .onTapGesture {
                focus = nil
            }
            Form {
                Section("Personal information") {
                    TextField("Name", text: $viewModel.userName)
                        .focused($focus, equals: .name)
                    TextField("Age", text: $viewModel.userAge)
                        .focused($focus, equals: .age)
                        .keyboardType(.numberPad)
                }
                
                Section("Contact information") {
                    TextField("Email", text: $viewModel.userEmail)
                        .focused($focus, equals: .email)
                        .keyboardType(.emailAddress)
                }
            }.onSubmit {
                if focus == .name {
                    focus = .age
                } else if focus == .age {
                    focus = .email
                } else if focus == .email {
                    focus = .name
                }
            }
            .fontStyle(.textFieldText)
        }.padding()
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        @State var mock: String = "Info"
        EditProfileView(info: mock, viewModel: EditProfileViewModel(storageService: FirebaseStorageService()))
    }
}
