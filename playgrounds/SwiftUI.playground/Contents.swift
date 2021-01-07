import SwiftUI
import PlaygroundSupport


//public struct ProgressView: View {
//    public var body: some View {
//        ZStack {
//            Circle()
//                .stroke(lineWidth: 30.0)
//                .foregroundColor(.blue)
//            Text("25%")
//        }
//    }
//}
//
//struct Preview: View {
//    var body: some View {
//        VStack(spacing: 50) {
//            ProgressView()
//            ProgressView()
//                .environment(\.colorScheme, .dark)
//        }
//        .padding(100)
//        .background(Color(UIColor.secondarySystemBackground))
//    }
//}
//
//PlaygroundPage.current.setLiveView(
//    Preview()
//        .frame(width: 600, height: 600, alignment: .center)
//)
//


let url = URL(string: "themoviemanager://authenticate")!
let components = URLComponents(url: url, resolvingAgainstBaseURL: true)

components?.scheme
components?.host
