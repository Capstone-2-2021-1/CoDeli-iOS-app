//
//  HomeView.swift
//  CoDeli
//
//  Created by Changsung Lim on 4/11/21.
//

import SwiftUI

struct MakeRoomFullScreenModalView: View {
    @Environment(\.presentationMode) var presentationMode

    @State private var restaurant: String = ""
    @State private var deliveryApp: String = ""
    @State private var deliveryAddress: String = ""
    @State private var deliveryDetailAddress: String = ""
    @State private var minOrderAmount: UInt = 0
    @State private var deliveryCost: UInt = 0
    @State private var participantsNum: UInt = 0

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
                                .fill(Color(hex: 0xFFC618, alpha: 0.7)))
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
                        value: $minOrderAmount,
                        formatter: NumberFormatter()
                    ) { isEditing in
                        self.isEditing = isEditing
                    } onCommit: {
            //            validate(name: username)
                    }
                }
                Section(header: Text("배달비")) {
                    TextField(
                        "3000",
                        value: $deliveryCost,
                        formatter: NumberFormatter()
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
                leading:
                    Button("취소") {
                        print("취소 버튼 눌림!")
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(.white),
                trailing:
                    Button("완료") {
                        print("완료 버튼 눌림!")
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(.white)
            )
            .onAppear() {
                UINavigationBarAppearance()
                    .setColor(title: .white, background: UIColor(Color(hex: 0xFFC618, alpha: 0.7)))
            }
        }
    }
}


struct HomeView: View {
    @State private var showingSheet = false

    var body: some View {
        NavigationView {
            ZStack {
                List(rooms) { room in
                    HomeRow(room: room)
                }

                VStack {
                    Spacer()    // minLength?

                    HStack {
                        Spacer()
                        Button(action: {
                            print("방 만들기 버튼 눌림")
                            showingSheet.toggle()
                        }) {
                            Image("makeRoomButton")
                        }
                        .fullScreenCover(isPresented: $showingSheet) {
                            MakeRoomFullScreenModalView()
                        }
                        .shadow(color: Color/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.3), radius: 3, x: 3, y: 3)
                    }
                }
            }
            
            .navigationBarTitle("서울 동작구 흑석로 84", displayMode: .inline)
            .navigationBarItems(
                trailing:
                    Button(action: {
                        print("검색 버튼 눌림!")
                    }) {
                        Image(systemName: "magnifyingglass")
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
