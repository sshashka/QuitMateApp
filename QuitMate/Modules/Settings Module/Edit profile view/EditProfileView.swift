//
//  EditProfileView.swift
//  QuitMate
//
//  Created by Саша Василенко on 11.07.2023.
//

import SwiftUI

enum EditProfileFocusFields: Hashable {
    case name, age, email
}

struct EditProfileView: View {
    @State var info: String
    @FocusState var focus: EditProfileFocusFields?
    var body: some View {
        VStack(spacing: Spacings.spacing25) {
            Image("Tokyo")
                .resizable()
                .clipShape(Circle())
                .frame(width: 100, height: 100)
            Button {
                
            } label: {
                Text("Set new photo")
                    .fontStyle(.buttonsText)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
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
