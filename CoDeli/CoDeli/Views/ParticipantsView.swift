//
//  ParticipantsView.swift
//  CoDeli
//
//  Created by Changsung Lim on 5/5/21.
//

import SwiftUI
import Firebase

struct ParticipantsView: View {
    @EnvironmentObject var realtimeData: RealtimeData

    var isChatView: Bool = false

    var body: some View {
        ZStack {
            Color(hex: 0xf9f9f8)
                .ignoresSafeArea()
            VStack {
                ForEach(realtimeData.participants, id: \.self) { participant in
                    if !isChatView {    // RoomDetailView 에서는 본인 제외하고 참여자 목록 출력
                        if participant.id != realtimeData.myInfo.nickname {
                            HStack {
                                if participant.status { // true
                                    Circle()
                                        .frame(width: 5, height: 5)
                                        .foregroundColor(.green)
                                } else {
                                    Circle()
                                        .frame(width: 5, height: 5)
                                        .foregroundColor(.red)
                                }
                                Text(participant.id)
                                Spacer()
                                Text(participant.menuName)
                                Spacer()
                                Text(String(participant.menuPrice))
                            }
                        }
                    } else {    // ChatView이면 본인까지 출력
                        HStack(alignment: .lastTextBaseline) {
                            // ChatView에서는 '준비' 상태를 체크하는게 아니라 '확인' 상태를 체크?
                            if participant.location_verification_status {   // 위치 검증 성공

                                if participant.verificationStatus { // 수령 확인까지 완료

                                    Text(participant.id)
                                        .frame(width: 80, height: 25)
                                        .foregroundColor(.white)
                                        .background(Color.green)
                                        .clipShape(Capsule())

    //                                Circle()
    //                                    .frame(width: 5, height: 5)
    //                                    .foregroundColor(.green)
                                } else {
                                    Text(participant.id)
                                        .frame(width: 80, height: 25)
                                        .foregroundColor(.white)
                                        .background(Color.yellow)
                                        .clipShape(Capsule())

    //                                Circle()
    //                                    .frame(width: 5, height: 5)
    //                                    .foregroundColor(.yellow)
                                }
                            } else {
                                Text(participant.id)
                                    .frame(width: 80, height: 25)
                                    .foregroundColor(.white)
                                    .background(Color.red)
                                    .clipShape(Capsule())

    //                            Circle()
    //                                .frame(width: 5, height: 5)
    //                                .foregroundColor(.red)
                            }
                            Spacer()

                            Text(participant.menuName)
                                .frame(width: 150, height: 25)
                                .overlay(
                                    Capsule(style: .continuous)
                                        .stroke(Color(hex: 0xdddddb))
                                )
                                .background(Capsule().fill(Color.white))

                            Spacer()

                            Text(String(participant.menuPrice))
                                .frame(width: 80, height: 25)
                                .overlay(
                                    Capsule(style: .continuous)
                                        .stroke(Color(hex: 0xdddddb))
                                )
                                .background(Capsule().fill(Color.white))

                        }
                        .padding(7)
                        .overlay(
                            Capsule(style: .continuous)
                                .stroke(Color(hex: 0xdddddb))
                        )
                        .background(Capsule().fill(Color.white))
                    }
                }

                Spacer()    // VStack을 top으로 보내기
            }
            .padding(.top, 5)
        }
    }
}

struct ParticipantsView_Previews: PreviewProvider {
    static var previews: some View {
        ParticipantsView()
            .environmentObject(RealtimeData())
    }
}
