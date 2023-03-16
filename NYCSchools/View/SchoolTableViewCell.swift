//
//  SchoolTableViewCell.swift
//  NYCSchools
//
//  Created by Tanzeem Ahamad on 3/15/23.
//

import UIKit


class SchoolTableViewCell: UITableViewCell {
    let dbnLabel = UILabel()
    let schoolLabel = UILabel()
   
    let dbnNameLabel = UILabel()
    let schoolNameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        dbnLabel.text = "DBN:"
        
        schoolLabel.text = NSLocalizedString("SCHOOL", comment: "") + ":"
        dbnLabel.font = .boldSystemFont(ofSize: 18)
        schoolLabel.font = .boldSystemFont(ofSize: 18)
   
        dbnLabel.translatesAutoresizingMaskIntoConstraints = false
        schoolLabel.translatesAutoresizingMaskIntoConstraints = false
        dbnNameLabel.translatesAutoresizingMaskIntoConstraints = false
        schoolNameLabel.translatesAutoresizingMaskIntoConstraints = false
        schoolNameLabel.numberOfLines  = 0
        
        contentView.addSubview(dbnLabel)
        contentView.addSubview(schoolLabel)
     
        contentView.addSubview(dbnNameLabel)
        contentView.addSubview(schoolNameLabel)
        
        dbnLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 2).isActive = true
        dbnLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 10).isActive = true
      
        dbnNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 2).isActive = true
        dbnNameLabel.leftAnchor.constraint(equalTo: dbnLabel.rightAnchor,constant: 10).isActive = true
        
        schoolLabel.topAnchor.constraint(equalTo: dbnNameLabel.bottomAnchor,constant: 2).isActive = true
        schoolLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 10).isActive = true
   
        
        schoolNameLabel.topAnchor.constraint(equalTo: dbnNameLabel.bottomAnchor,constant: 2).isActive = true
        schoolNameLabel.leftAnchor.constraint(equalTo: schoolLabel.rightAnchor,constant: 10).isActive = true
        schoolNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 2).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

