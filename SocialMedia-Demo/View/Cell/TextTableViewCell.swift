//
//  TextTableViewCell.swift
//  SocialMedia-Demo
//
//  Created by User on 21/06/22.
//

import UIKit

class TextTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }

    var cellViewModel: FeedCellViewModel? {
        didSet {
            nameLabel.text = cellViewModel?.name
            contentLabel.text = cellViewModel?.content
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
        contentLabel.text = nil
    }
}
