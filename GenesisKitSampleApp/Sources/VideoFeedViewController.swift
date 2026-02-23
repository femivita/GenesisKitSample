import UIKit
import GenesisKitCore
import GenesisKitPlayer

final class VideoFeedViewController: UIViewController {

    private let playersManager: GKPlayersManager
    private let playlist: GKCustomPlaylist

    private let collectionView: UICollectionView

    private var currentIndex: Int = 0
    private var visibleIndexPaths: Set<IndexPath> = []

    init() {
        self.playersManager = GKPlayersManager(prerenderDistance: 1, preloadDistance: 3)
        self.playlist = SampleVideos.makePlaylist()

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        super.init(nibName: nil, bundle: nil)

        self.playersManager.preferredVideoResolution = .p720
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black

        collectionView.backgroundColor = .black
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(VideoFeedCell.self, forCellWithReuseIdentifier: VideoFeedCell.reuseId)

        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        playersManager.setPlaylist(playlist, index: 0)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playCurrentVisibleIfNeeded()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        playersManager.pausePlayers()
    }

    private func playCurrentVisibleIfNeeded() {
        guard let indexPath = collectionView.indexPathsForVisibleItems.sorted().first else { return }
        requestPlayer(for: indexPath, shouldAutoplay: true)
    }

    private func requestPlayer(for indexPath: IndexPath, shouldAutoplay: Bool) {
        playersManager.getPlayerFor(index: indexPath.item) { [weak self] player, error in
            guard let self else { return }
            guard let cell = self.collectionView.cellForItem(at: indexPath) as? VideoFeedCell else { return }

            if let error {
                cell.setErrorText(error.localizedDescription)
                return
            }

            guard let player else {
                cell.setErrorText("No player")
                return
            }

            player.aspectMode = .resizeAspectFill
            player.loop = true
            player.muted = false
            player.showControls = false
            player.showSpinner = true
            player.showErrorMessages = true

            cell.attach(playerViewController: player, in: self)

            if shouldAutoplay {
                player.play()
                self.currentIndex = indexPath.item
            }
        }
    }
}

extension VideoFeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playlist.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoFeedCell.reuseId, for: indexPath)
        return cell
    }
}

extension VideoFeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        playCurrentVisibleIfNeeded()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            playCurrentVisibleIfNeeded()
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        visibleIndexPaths.insert(indexPath)
        requestPlayer(for: indexPath, shouldAutoplay: false)
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        visibleIndexPaths.remove(indexPath)
    }
}
