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
    @State var info: String = "Info"
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
                Text("Set new photo")
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
                Section("Personal information") {
                    TextField("Name", text: $viewModel.userName)
                    TextField("Age", text: $viewModel.userAge)
                        .keyboardType(.numberPad)
                }
                
                Section("Contact information") {
                    TextField("Email", text: $viewModel.userEmail)
                        .keyboardType(.emailAddress)
                }
            }
            .fontStyle(.textFieldText)
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Done") {
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


