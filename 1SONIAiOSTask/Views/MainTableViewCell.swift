//
//  MainTableViewCell.swift
//  1SONIAiOSTask
//
//  Created by Mekhriddin Jumaev on 10/10/22.
//

import UIKit
import Kingfisher

class MainTableViewCell: UITableViewCell {
    
    static let identifier = "MainTableViewCell"
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 50
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.label
        return label
    }()
    
    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.label
        return label
    }()
    
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.label
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        stackView.spacing = 5
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        self.addSubview(avatarImageView)
        self.addSubview(stackView)
        for label in [nameLabel, statusLabel, locationLabel] {
            stackView.addArrangedSubview(label)
        }
    }
    
    private func setConstraints() {
        avatarImageView.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(20)
            make.centerY.equalTo(self)
            make.width.height.equalTo(100)
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(20)
            make.trailing.bottom.equalTo(self).offset(-20)
            make.top.equalTo(self).offset(20)
        }
    }
    
    func setData(character: CDCharacter) {
        if let imagePath = character.imagePath {
            avatarImageView.kf.setImage(with: URL(string: imagePath))
        }
        nameLabel.text = character.name
        statusLabel.text = character.status
        locationLabel.text = character.location
    }

}
