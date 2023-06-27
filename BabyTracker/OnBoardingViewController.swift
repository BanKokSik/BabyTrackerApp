//
//  OnBoardingViewController.swift
//  BabyTracker
//
//  Created by Мявкo on 26.06.23.
//

import UIKit

class OnBoardingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        creation()
    }
    
//    let collectionView: UICollectionView = {
//        let collectionView = UICollectionView()
//        return collectionView
//    }()
    
    let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        //stackView.spacing = 5
        stackView.distribution = .fillProportionally
        stackView.backgroundColor = R.color.alabaster()
                
        return stackView
    }()
    
    let calendarIconImageView: UIImageView = {
        let imageView = UIImageView(image: R.image.icon())
        imageView.contentMode = .center
        return imageView
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "8 мая"
        label.font = Fonts.gilroyRegular22
        label.textAlignment = .center
        return label
    }()
    
    let yearLabel: UILabel = {
        let label = UILabel()
        label.text = "2021"
        label.font = Fonts.gilroyRegular12
        label.textAlignment = .center
        return label
    }()
    
    let calendarImageView: UIImageView = {
        let imageView = UIImageView(image: R.image.calendar())
        //imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let callGrandmaLabel: UILabel = {
        let label = UILabel()
        label.text = "Позвонить бабушке"
        label.font = Fonts.gilroyRegular12
        return label
    }()
    
    let passPhysicalLabel: UILabel = {
        let label = UILabel()
        label.text = "Пройти медосмотр"
        label.font = Fonts.gilroyRegular12
        return label
    }()
    
    let goToDoctorLabel: UILabel = {
        let label = UILabel()
        label.text = "Пойти к доктору на укол"
        label.font = Fonts.gilroyRegular12
        return label
    }()
    
    func creation() {
        
        // Добавление элементов в StackView
        verticalStackView.addArrangedSubview(calendarIconImageView)
        verticalStackView.addArrangedSubview(dateLabel)
        verticalStackView.addArrangedSubview(yearLabel)
        verticalStackView.addArrangedSubview(calendarImageView)
        verticalStackView.addArrangedSubview(callGrandmaLabel)
        verticalStackView.addArrangedSubview(passPhysicalLabel)
        verticalStackView.addArrangedSubview(goToDoctorLabel)
        
        calendarIconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.centerX.equalToSuperview()
            make.width.equalTo(25.1)
            make.height.equalTo(23.8)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(calendarIconImageView).offset(20)
            make.centerX.equalToSuperview()
            //make.width.equalTo(103)
            //make.height.equalTo(50)
        }
        
        yearLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(51)
            //make.height.equalTo(30)
        }
        
        calendarImageView.snp.makeConstraints { make in
            make.top.equalTo(yearLabel).inset(9)
            //make.bottom.equalToSuperview().inset(50)
            //make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(38)
            make.width.equalTo(220)
            make.height.equalTo(200)
        }
        
        view.addSubview(verticalStackView)
        verticalStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(70)
            make.centerX.equalToSuperview()
            make.width.equalTo(315)
            make.height.equalTo(554)
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
