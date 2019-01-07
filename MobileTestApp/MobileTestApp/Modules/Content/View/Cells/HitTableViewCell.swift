//
//  HitTableViewCell.swift
//  MobileTestApp
//
//  Created by Nisum on 1/6/19.
//  Copyright © 2019 Demo1. All rights reserved.
//

import UIKit

class HitTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!

    static let nibName = "HitTableViewCell"
    static let reuseIdentifier = "HitTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func setup(data: Hit) {
        self.titleLabel.text = data.title
        var subtitleDate = ""
        if let date = data.createdDateFormat {
            subtitleDate = DateHelper.sharedInstance.dayDifference(from: date)
        }
        var subtitle = data.author ?? ""
        if !subtitleDate.isEmpty {
            if !subtitle.isEmpty {
                subtitle = subtitle + " - "
            }
            subtitle = subtitle + subtitleDate
        }
        self.subTitleLabel.text = subtitle
    }

    override func prepareForReuse() {
        self.titleLabel.text = ""
        self.subTitleLabel.text = ""
    }
    
}
