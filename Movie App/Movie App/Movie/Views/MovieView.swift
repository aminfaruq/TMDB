//
//  MovieView.swift
//  Movie App
//
//  Created by Phincon on 28/10/23.
//

import UIKit
import SnapKit

class MovieView: UIView {
    lazy var moviePosterImg: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleToFill
        return img
    }()
    
    lazy var movieTitleLbl: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.boldSystemFont(ofSize: 12)
        lb.numberOfLines = 1
        return lb
    }()
    
    lazy var movieRatingLbl: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 12)
        lb.numberOfLines = 1
        return lb
    }()
    
    lazy var movieReleaseLbl: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 11)
        lb.numberOfLines = 1
        return lb
    }()
    
    lazy var iconRatingImg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "star.fill")
        return img
    }()
    
    lazy var containerView: UIView = {
        let vw = UIView()
        vw.backgroundColor = UIColor(hex: "F5F7F8")
        vw.setCornerRadius(radius: 8)
        return vw
    }()
    
    func setupView() {
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(125)
        }
        
        containerView.addSubview(moviePosterImg)
        moviePosterImg.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(133)
        }
        
        containerView.addSubview(iconRatingImg)
        iconRatingImg.snp.makeConstraints { make in
            make.top.equalTo(moviePosterImg.snp.bottom).offset(8)
            make.left.equalToSuperview().inset(8)
            make.height.width.equalTo(8)
        }
        
        containerView.addSubview(movieRatingLbl)
        movieRatingLbl.snp.makeConstraints { make in
            make.top.equalTo(moviePosterImg.snp.bottom).offset(4)
            make.left.equalTo(iconRatingImg.snp.right).offset(4)
        }
        
        containerView.addSubview(movieTitleLbl)
        movieTitleLbl.snp.makeConstraints { make in
            make.top.equalTo(movieRatingLbl.snp.bottom).offset(4)
            make.left.right.equalToSuperview().inset(8)
        }
        
        containerView.addSubview(movieReleaseLbl)
        movieReleaseLbl.snp.makeConstraints { make in
            make.top.equalTo(movieTitleLbl.snp.bottom).offset(4)
            make.left.right.equalToSuperview().inset(8)
        }
    }
}
