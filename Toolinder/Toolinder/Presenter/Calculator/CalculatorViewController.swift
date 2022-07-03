//
//  CalculatorViewController.swift
//  Toolinder
//
//  Created by 송영모 on 2022/05/08.
//

import UIKit
import RxSwift
import RxCocoa
import Then

class CalculatorViewController: UIViewController {
    let viewModel = CalculatorViewModel()
    var disposeBag = DisposeBag()
    var viewController: DetailViewController!
    var recordZip: RecordZip!
    
    var resultLabel = UILabel().then {
        $0.text = "계산 결과"
        $0.textColor = Const.Color.black
        $0.font = Const.Font.footnote
    }
    var resultPriceLabel = UILabel().then {
        $0.text = "121252151".insertComma + "원"
        $0.textColor = Const.Color.indigo
        $0.font = Const.Font.title1
    }
    var resultCountLabel = UILabel().then {
        $0.text = "1212512".insertComma + "개"
        $0.textColor = Const.Color.black
        $0.font = Const.Font.title2
    }
    var resultSumLabel = UILabel().then {
        $0.text = "1212512".insertComma + "원"
        $0.textColor = Const.Color.darkGray
        $0.font = Const.Font.footnote
    }
    var nowLabel = UILabel().then {
        $0.text = "현재 보유"
        $0.textColor = Const.Color.black
        $0.font = Const.Font.footnote
    }
    var nowPriceLabel = UILabel().then {
        $0.text = "151,512원"
        $0.textColor = Const.Color.black
        $0.font = Const.Font.title1
    }
    var nowCountLabel = UILabel().then {
        $0.text = "156,59개"
        $0.textColor = Const.Color.black
        $0.font = Const.Font.title2
    }
    var nowSumLabel = UILabel().then {
        $0.text = "156,591원"
        $0.textColor = Const.Color.darkGray
        $0.font = Const.Font.footnote
    }
    var inputLabel = UILabel().then {
        $0.text = "추가 매수"
        $0.textColor = Const.Color.black
        $0.font = Const.Font.footnote
    }
    var inputPriceTextField = UITextField().then {
        $0.keyboardType = .decimalPad
        $0.font = Const.Font.title1
        $0.placeholder = "0.00원"
        $0.textAlignment = .right
    }
    var inputCountTextField = UITextField().then {
        $0.keyboardType = .decimalPad
        $0.font = Const.Font.title2
        $0.placeholder = "0.00개"
        $0.textAlignment = .right
    }
    var inputSumLabel = UILabel().then {
        $0.text = "156,591원"
        $0.textColor = Const.Color.darkGray
        $0.font = Const.Font.footnote
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(_ viewController: DetailViewController, recordZip: RecordZip) {
        super.init(nibName: nil, bundle: nil)
        self.viewController = viewController
        self.recordZip = recordZip
        viewModel.update(recordZip: recordZip)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setView()
        setBind()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        viewController.tryAd()
    }
}

extension CalculatorViewController {
    func setNavigation() {
        title = "평단가 계산하기"
    }
    
    func setView() {
        view.addSubview(resultLabel)
        view.addSubview(resultPriceLabel)
        view.addSubview(resultCountLabel)
        view.addSubview(resultSumLabel)
        view.addSubview(nowLabel)
        view.addSubview(nowPriceLabel)
        view.addSubview(nowCountLabel)
        view.addSubview(nowSumLabel)
        view.addSubview(inputLabel)
        view.addSubview(inputPriceTextField)
        view.addSubview(inputCountTextField)
        view.addSubview(inputSumLabel)
        
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        resultPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        resultCountLabel.translatesAutoresizingMaskIntoConstraints = false
        resultSumLabel.translatesAutoresizingMaskIntoConstraints = false
        nowLabel.translatesAutoresizingMaskIntoConstraints = false
        nowPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        nowCountLabel.translatesAutoresizingMaskIntoConstraints = false
        nowSumLabel.translatesAutoresizingMaskIntoConstraints = false
        inputLabel.translatesAutoresizingMaskIntoConstraints = false
        inputPriceTextField.translatesAutoresizingMaskIntoConstraints = false
        inputCountTextField.translatesAutoresizingMaskIntoConstraints = false
        inputSumLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = Const.Color.white
        
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            resultLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            resultPriceLabel.topAnchor.constraint(equalTo: resultLabel.bottomAnchor),
            resultPriceLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            resultCountLabel.topAnchor.constraint(equalTo: resultPriceLabel.bottomAnchor),
            resultCountLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            resultSumLabel.topAnchor.constraint(equalTo: resultCountLabel.bottomAnchor),
            resultSumLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            nowLabel.topAnchor.constraint(equalTo: resultSumLabel.bottomAnchor, constant: 15),
            nowLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            nowPriceLabel.topAnchor.constraint(equalTo: nowLabel.bottomAnchor),
            nowPriceLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            nowCountLabel.topAnchor.constraint(equalTo: nowPriceLabel.bottomAnchor),
            nowCountLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            nowSumLabel.topAnchor.constraint(equalTo: nowCountLabel.bottomAnchor),
            nowSumLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            inputLabel.topAnchor.constraint(equalTo: nowSumLabel.bottomAnchor, constant: 15),
            inputLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            inputPriceTextField.topAnchor.constraint(equalTo: inputLabel.bottomAnchor),
            inputPriceTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            inputCountTextField.topAnchor.constraint(equalTo: inputPriceTextField.bottomAnchor),
            inputCountTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            inputSumLabel.topAnchor.constraint(equalTo: inputCountTextField.bottomAnchor),
            inputSumLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
}

extension CalculatorViewController {
    func setBind() {
        inputPriceTextField.rx.text.orEmpty
            .map {
                Double($0.replacingOccurrences(of: "원", with: "")) ?? 0.0
            }
            .bind(to: viewModel.input.inputPrice)
            .disposed(by: disposeBag)
    
        inputCountTextField.rx.text.orEmpty
            .map {
                Double($0.replacingOccurrences(of: "개", with: "")) ?? 0.0
            }
            .bind(to: viewModel.input.inputCount)
            .disposed(by: disposeBag)
        
        inputPriceTextField.rx.controlEvent([.editingDidBegin])
            .asObservable()
            .withUnretained(self)
            .bind { owner, _ in
                owner.inputPriceTextField.text = ""
            }
            .disposed(by: disposeBag)
        
        inputPriceTextField.rx.controlEvent([.editingDidEnd])
            .asObservable()
            .withUnretained(self)
            .bind { owner, _ in
                owner.inputPriceTextField.text = owner.viewModel.output.inputPriceText.value
            }
            .disposed(by: disposeBag)
        
        inputCountTextField.rx.controlEvent([.editingDidBegin])
            .asObservable()
            .withUnretained(self)
            .bind { owner, _ in
                owner.inputCountTextField.text = ""
            }
            .disposed(by: disposeBag)
        
        inputCountTextField.rx.controlEvent([.editingDidEnd])
            .asObservable()
            .withUnretained(self)
            .bind { owner, _ in
                owner.inputCountTextField.text = owner.viewModel.output.inputCountText.value
            }
            .disposed(by: disposeBag)
        
        viewModel.output.resultPriceText
            .withUnretained(self)
            .bind { owner, text in
                owner.resultPriceLabel.text = text
                
                let resultPrice = Double(text.replacingOccurrences(of: "원", with: "").replacingOccurrences(of: ",", with: "")) ?? 0.0
                let nowPrice = Double(owner.viewModel.output.nowPriceText.value.replacingOccurrences(of: "원", with: "").replacingOccurrences(of: ",", with: "")) ?? 0.0
                
                if resultPrice > nowPrice {
                    owner.resultPriceLabel.textColor = Const.Color.plus
                } else if resultPrice < nowPrice {
                    owner.resultPriceLabel.textColor = Const.Color.minus
                } else {
                    owner.resultPriceLabel.textColor = Const.Color.black
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.output.resultCountText
            .withUnretained(self)
            .bind { owner, text in
                owner.resultCountLabel.text = text
            }
            .disposed(by: disposeBag)
        
        viewModel.output.resultSumText
            .withUnretained(self)
            .bind { owner, text in
                owner.resultSumLabel.text = text
            }
            .disposed(by: disposeBag)
        
        viewModel.output.nowPriceText
            .withUnretained(self)
            .bind { owner, text in
                owner.nowPriceLabel.text = text
            }
            .disposed(by: disposeBag)
        
        viewModel.output.nowCountText
            .withUnretained(self)
            .bind { owner, text in
                owner.nowCountLabel.text = text
            }
            .disposed(by: disposeBag)
        
        viewModel.output.nowSumText
            .withUnretained(self)
            .bind { owner, text in
                owner.nowSumLabel.text = text
            }
            .disposed(by: disposeBag)
        
        viewModel.output.inputSumText
            .withUnretained(self)
            .bind { owner, text in
                owner.inputSumLabel.text = text
            }
            .disposed(by: disposeBag)
    }
}
