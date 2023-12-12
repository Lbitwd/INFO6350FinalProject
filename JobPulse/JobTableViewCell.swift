//
//  JobTableViewCell.swift
//  JobPulse
//
//  Created by Shuya Yang on 12/12/23.
//

import UIKit

class JobTableViewCell: UITableViewCell {
    
    @IBOutlet weak var jobTitleLabel: UILabel?
    @IBOutlet weak var salaryLabel: UILabel?
    @IBOutlet weak var companyNameLabel: UILabel?
    @IBOutlet weak var companyLocationLabel: UILabel?
    @IBOutlet weak var companyLogo: UIImageView?
    @IBOutlet weak var jobonSite: UIButton?
    @IBOutlet weak var jobPostDate: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
