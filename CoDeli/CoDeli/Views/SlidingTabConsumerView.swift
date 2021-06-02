import SwiftUI
import SlidingTabView

struct SlidingTabConsumerView : View {
    @State private var selectedTabIndex = 0

    var body: some View {
        VStack(alignment: .leading) {
            SlidingTabView(selection: self.$selectedTabIndex, tabs: ["First", "Second"])
            (selectedTabIndex == 0 ? Text("First View") : Text("Second View")).padding()
            Spacer()
        }
            .padding(.top, 50)
            .animation(.none)
    }
}

//@available(iOS 13.0.0, *)
//struct SlidingTabView_Previews : PreviewProvider {
//    static var previews: some View {
//        SlidingTabConsumerView()
//    }
//}
