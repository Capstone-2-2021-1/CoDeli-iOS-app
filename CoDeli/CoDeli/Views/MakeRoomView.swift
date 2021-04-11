//
//  MakeRoomView.swift
//  CoDeli
//
//  Created by Changsung Lim on 4/11/21.
//

import SwiftUI

struct MakeRoomView: View {
    @State private var restaurant: String = ""
    @State private var deliveryApp: String = ""
    @State private var deliveryAddress: String = ""
    @State private var deliveryDetailAddress: String = ""
    @State private var minOrderAmount: String = ""
    @State private var deliveryCost: String = ""
    @State private var participantsNum: UInt8 = 0

    @State private var isEditing = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("음식점")) {
                    TextField(
                        "맘스터치 중앙대점",
                        text: $restaurant
                    ) { isEditing in
                        self.isEditing = isEditing
                    } onCommit: {   // Firebase로 데이터 보내기? - 차라리 다른 것들이랑 한 번에 모아서 보내는게 나을 듯
            //            validate(name: username)
                    }
                }
                Section(header: Text("주문 플랫폼")) {
                    TextField(
                        "배달의 민족",
                        text: $deliveryApp
                    ) { isEditing in
                        self.isEditing = isEditing
                    } onCommit: {
            //            validate(name: username)
                    }
                }
                Section(header: Text("배달 장소")) {
                    HStack {
                        Text("서울시 동작구 흑석로84")
                        Spacer()
                        Button("검색") {
                            print("검색 버튼 눌림!")
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 7)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color(hex: 0x008BBA, alpha: 0.7)))
                        .foregroundColor(.white)
                    }

                    TextField(
                        "상세 주소",
                        text: $deliveryDetailAddress
                    ) { isEditing in
                        self.isEditing = isEditing
                    } onCommit: {
            //            validate(name: username)
                    }
                }
                Section(header: Text("최소주문금액")) {
                    TextField(
                        "12000",
                        text: $minOrderAmount
                    ) { isEditing in
                        self.isEditing = isEditing
                    } onCommit: {
            //            validate(name: username)
                    }
                }
                Section(header: Text("배달비")) {
                    TextField(
                        "3000",
                        text: $deliveryCost
                    ) { isEditing in
                        self.isEditing = isEditing
                    } onCommit: {
            //            validate(name: username)
                    }
                }
                Section(header: Text("모집 인원")) {
                    Stepper(value: $participantsNum, in: 0...5) {
                        Text("\(participantsNum)")
                    }
                }
            }
            .autocapitalization(.none)
            .disableAutocorrection(true)

            .navigationBarTitle("방 만들기", displayMode: .large)
            .navigationBarItems(
                trailing:
                    Button("완료") {
                        print("완료 버튼 눌림!")
                    }
                    .foregroundColor(.white)
            )
            .onAppear() {
                UINavigationBarAppearance()
                    .setColor(title: .white, background: UIColor(Color(hex: 0x008BBA, alpha: 0.7)))
            }
        }
    }
}

struct MakeRoomView_Previews: PreviewProvider {
    static var previews: some View {
        MakeRoomView()
    }
}
