//
//  ImageTableViewCell.swift
//  SocialMedia-Demo
//
//  Created by User on 21/06/22.
//

import UIKit
import SDWebImage

class ImageTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var feedImageView: UIImageView!
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }

    var cellViewModel: FeedCellViewModel? {
        didSet {
            nameLabel.text = cellViewModel?.name
            feedImageView.sd_setImage(with: URL(string: cellViewModel!.content), placeholderImage: UIImage(systemName: "photo"))
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
        feedImageView.image = nil
    }
}

