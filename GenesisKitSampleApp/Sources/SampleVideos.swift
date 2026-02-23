import Foundation
import GenesisKitCore

enum SampleVideos {
    static func makePlaylist() -> GKCustomPlaylist {
        let videos: [GKVideo] = [
            GKVideo(
                id: "1",
                videoURL: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"),
                thumbnailURL: URL(string: "https://peach.blender.org/wp-content/uploads/title_anouncement.jpg")
            ),
            GKVideo(
                id: "2",
                videoURL: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"),
                thumbnailURL: URL(string: "https://orange.blender.org/wp-content/themes/orange/images/common/ed_header.jpg")
            ),
            GKVideo(
                id: "3",
                videoURL: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4"),
                thumbnailURL: URL(string: "https://download.blender.org/durian/trailer/sintel_trailer-480p.jpg")
            )
        ]

        return GKCustomPlaylist(videos: videos)
    }
}
