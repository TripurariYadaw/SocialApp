//
//  VideoPlayerCell.swift
//  SocialMedia-Demo
//
//  Created by User on 21/06/22.
//


import UIKit
import AVFoundation

class VideoPlayerCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var videoView: UIView!
    
    var playerLayer: AVPlayerLayer?
    var player : AVPlayer?
   
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }

    var cellViewModel: FeedCellViewModel? {
        didSet {
            nameLabel.text = cellViewModel?.name
            self.setupItems(with: URL(string: cellViewModel!.content)!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupItems(with videoUrl: URL) {
        playVideo(videoUrl: videoUrl)
    }
   
    func playVideo(videoUrl: URL) {
        player = AVPlayer(url: videoUrl)
        playerLayer = AVPlayerLayer(player: player)

        playerLayer?.frame = self.bounds
        
        playerLayer?.videoGravity = .resizeAspectFill
        
        videoView.layer.addSublayer(playerLayer!)
//        player?.play()
    }
    
    func initView() {
        // Cell view customization
        backgroundColor = .clear

        // Line separator full width
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
    }
}
