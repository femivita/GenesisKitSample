import SwiftUI
import UIKit

struct VideoFeedViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> VideoFeedViewController {
        return VideoFeedViewController()
    }

    func updateUIViewController(_ uiViewController: VideoFeedViewController, context: Context) {
    }
}
