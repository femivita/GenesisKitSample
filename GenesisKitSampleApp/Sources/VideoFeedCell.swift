import UIKit
import GenesisKitPlayer

final class VideoFeedCell: UICollectionViewCell {
    static let reuseId = "VideoFeedCell"

    private let containerView = UIView()
    private let errorLabel = UILabel()

    private weak var currentPlayerVC: GKPlayerViewController?

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .black

        containerView.backgroundColor = .black
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])

        errorLabel.textColor = .white
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .center
        errorLabel.isHidden = true

        contentView.addSubview(errorLabel)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            errorLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 16),
            errorLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        setErrorText(nil)

        if let currentPlayerVC {
            currentPlayerVC.pause()
        }

        currentPlayerVC = nil

        for sub in containerView.subviews {
            sub.removeFromSuperview()
        }
    }

    func attach(playerViewController: GKPlayerViewController, in parent: UIViewController) {
        if currentPlayerVC === playerViewController {
            return
        }

        if let currentPlayerVC {
            currentPlayerVC.pause()
        }

        currentPlayerVC = playerViewController

        for sub in containerView.subviews {
            sub.removeFromSuperview()
        }

        parent.addChild(playerViewController)
        containerView.addSubview(playerViewController.view)
        playerViewController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            playerViewController.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            playerViewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            playerViewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            playerViewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])

        playerViewController.didMove(toParent: parent)
    }

    func setErrorText(_ text: String?) {
        if let text {
            errorLabel.text = text
            errorLabel.isHidden = false
        } else {
            errorLabel.text = nil
            errorLabel.isHidden = true
        }
    }
}
