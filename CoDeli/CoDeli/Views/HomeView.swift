//
//  HomeView.swift
//  CoDeli
//
//  Created by Changsung Lim on 4/11/21.
//

import SwiftUI
import FirebaseFirestore
import Alamofire

struct AddressSearchFullScreenModalView: View {
    @Environment(\.presentationMode) var presentationMode

    @State private var deliveryAddress: String = ""

    var body: some View {
        Text("도로명 주소")
    }
}

struct MakeRoomFullScreenModalView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var firestoreData: FirestoreData
    @EnvironmentObject var realtimeData: RealtimeData
    @EnvironmentObject var internalData: InternalData
    private var db = Firestore.firestore()

    @State private var restaurant: String = ""
    @State private var deliveryApp: String = ""
    @State private var deliveryAddress: String = ""
    @State private var deliveryDetailAddress: String = ""
    @State private var minOrderAmount: String = ""
    @State private var deliveryCost: String = ""
    @State private var participantsMax: UInt = 0

    @State private var isEditing = false

    @State private var isPresented = false

    init() {
        UINavigationBarAppearance()
            .setColor(title: .white, background: UIColor(Color(hex: 0xf6cd53)))
    }

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
                        TextField(
                            "도로명 주소 (혹은 지번 주소)",
                            text: $deliveryAddress
                        ) { isEditing in
                            self.isEditing = isEditing
                        } onCommit: {
                //            validate(name: username)
                        }
                        Spacer()
                        Button("검색") {
                            isPresented.toggle()

                            let parameters: [String:Any] = ["query": deliveryAddress]
                            let headers: HTTPHeaders = ["Authorization": "KakaoAK {REST_API_KEY}"]
                            AF.request("https://dapi.kakao.com/v2/local/search/address.json", method: .get,
                                       parameters: parameters, headers: headers).responseJSON() { response in
                                        switch response.result {
                                        case .success:
                                            if let data = try! response.result.get() as? [String: Any] {
                                                print(data)
                                                if let document = data["documents"] as? [[String:Any]] {
                                                    for item in document {
                                                        var addressName: String = ""
                                                        if let address = item["address"] as? [String:Any] {
                                                            addressName = address["address_name"] as? String ?? ""
                                                        }
                                                        let addressNameRoad = item["address_name"] as? String ?? ""
                                                        let longitudeX = item["x"] as? String ?? ""
                                                        let latitudeY = item["y"] as? String ?? ""

                                                        self.internalData.addressList.append(Address(addressName: addressName, addressNameRoad: addressNameRoad, longitudeX: longitudeX, latitudeY: latitudeY))
                                                    }
                                                }
                                                print(internalData.addressList)
                                            }
                                        case .failure(let error):
                                            print(error)
                                        }
                                       }

                        }
                        .fullScreenCover(isPresented: $isPresented, content: AddressSearchFullScreenModalView.init)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 7)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color(hex: 0xf6cd53)))
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
//                        value: $minOrderAmount,
//                        formatter: formatter
                    ) { isEditing in
                        self.isEditing = isEditing
                    } onCommit: {
            //            validate(name: username)
                    }
                    .keyboardType(.numberPad)
                }
                Section(header: Text("배달비")) {
                    TextField(
                        "3000",
                        text: $deliveryCost
//                        value: $deliveryCost,
//                        formatter: formatter
                    ) { isEditing in
                        self.isEditing = isEditing
                    } onCommit: {
            //            validate(name: username)
                    }
                    .keyboardType(.numberPad)
                }
                Section(header: Text("모집 인원")) {
                    Stepper(value: $participantsMax, in: 0...5) {
                        Text("\(participantsMax)")
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

                        // 방장에게는 현재 방이 자신이 만든 방
                        internalData.currentRoom = Room(id: firestoreData.rooms.count, restaurant: restaurant, deliveryApp: deliveryApp, currentValue: 0, minOrderAmount: UInt(minOrderAmount) ?? 0, deliveryCost: UInt(deliveryCost) ?? 0, deliveryAddress: deliveryAddress, deliveryDetailAddress: deliveryDetailAddress, participantsNum: 1, participantsMax: participantsMax, owner: realtimeData.myInfo.nickname)

                        db.collection("Rooms").document(String(firestoreData.rooms.count)).setData([
                            "restaurant": restaurant,
                            "deliveryApp": deliveryApp,
                            "currentValue": 0,
                            "minOrderAmount": UInt(minOrderAmount) ?? 0,
                            "deliveryCost": UInt(deliveryCost) ?? 0,
                            "deliveryAddress": deliveryAddress,
                            "deliveryDetailAddress": deliveryDetailAddress,
                            "participantsNum": 1,
                            "participantsMax": participantsMax,
                            "owner": realtimeData.myInfo.nickname
                        ]) { err in
                            if let err = err {
                                print("Error writing document: \(err)")
                            } else {
                                print("Document successfully written!")
                            }
                        }

                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(.white)
            )
        }
    }
}


struct HomeView: View {
    @EnvironmentObject var firestoreData: FirestoreData
    @EnvironmentObject var realtimeData: RealtimeData

    @State private var showingSheet = false

    var body: some View {
        NavigationView {
            ZStack {
                List(firestoreData.rooms) { room in
                    NavigationLink(destination: RoomDetailView(room: room)) {
                        HomeRow(room: room)
                    }
                }

                VStack {
                    Spacer()

                    HStack {
                        Spacer()
                        Button(action: {
                            print("방 만들기 버튼 눌림")
                            print(firestoreData.rooms)
                            showingSheet.toggle()
                        }) {
                            Image("makeRoomButton")
                        }
                        .fullScreenCover(isPresented: $showingSheet) {
                            MakeRoomFullScreenModalView()
                        }
                        .shadow(color: Color.black.opacity(0.3), radius: 3, x: 3, y: 3)
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
                self.firestoreData.fetchData()
                UINavigationBarAppearance()
                    .setColor(title: .white, background: UIColor(Color(hex: 0x4caece)))
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(FirestoreData())
    }
}
