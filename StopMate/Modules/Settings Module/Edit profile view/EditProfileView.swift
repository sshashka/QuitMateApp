//
//  EditProfileView.swift
//  QuitMate
//
//  Created by Саша Василенко on 11.07.2023.
//

import SwiftUI
import PhotosUI
import Foundation

struct EditProfileView: View {
    @State var info: String = Localizables.info
    @State var selectedItem: PhotosPickerItem? = nil

    @StateObject var viewModel: EditProfileViewModel
    var body: some View {
        VStack(spacing: Spacings.spacing25) {
            ProfileImagePic(data: viewModel.userImage)
                .overlay {
                    if viewModel.imageLoadState == .loading {
                        ZStack {
                            ProgressView()
                            Color.black.opacity(0.4)
                        }
                    }
                }

            PhotosPicker(selection: $selectedItem, matching: .images,
                         photoLibrary: .shared()) {
                Text(Localizables.EditProfileStrings.setNewPhoto)
                    .fontStyle(.buttonsText)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color.buttonsPurpleColor)
            }.onChange(of: selectedItem) { newValue in
                Task {
                    // Retrive selected asset in the form of Data
                    if let data = try? await newValue?.loadTransferable(type: Data.self) {
                        viewModel.updateImage(with: data)
                    }
                }
            }
            Form {
                Section(Localizables.EditProfileStrings.personalInformation) {
                    TextField(Localizables.Shared.name, text: $viewModel.userName)
                    TextField(Localizables.Shared.age, text: $viewModel.userAge)
                        .keyboardType(.numberPad)
                }
                
                Section(Localizables.EditProfileStrings.contactInfo) {
                    TextField("Email", text: $viewModel.userEmail)
                        .keyboardType(.emailAddress)
                }
            }
            .fontStyle(.textFieldText)
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(Localizables.Shared.done) {
                    viewModel.updateUserProfile()
                }
                .foregroundColor(Color.buttonsPurpleColor)
            }
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        @State var mock: String = "Info"
        EditProfileView(info: mock, viewModel: EditProfileViewModel(storageService: FirebaseStorageService()))
    }
}


