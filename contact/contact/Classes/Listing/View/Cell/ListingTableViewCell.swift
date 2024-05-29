//
//  ListingTableViewCell.swift
//  contact
//
//  Created by Siti Norain Ishak on 29/05/2024.
//

import UIKit

class ListingTableViewCell: UITableViewCell {
    @IBOutlet private var nameLabel: UILabel!
    
    static func fromXib() -> (cellNib: UINib, reuseIdentifier: String) {
        return (UINib(resource: R.nib.listingTableViewCell), String(describing: self))
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func configureViews() {
        
    }
    
    func refreshViews(firstName: String, lastName: String) {
        nameLabel.text = "\(firstName) \(lastName)"
    }
}
