//
//  WritingVC+Logic.swift
//  moeum
//
//  Created by 송영모 on 2022/04/07.
//

extension WritingViewController {
    
    func update(record: Record) {
        self.viewModel.record = record
        print(record.id)
        self.writingView.tagTextField.textField.text = record.tag
        self.writingView.itemTextField.textField.text = record.item
        self.writingView.typeSegment.selectedSegmentIndex = types.firstIndex(of: record.type) ?? 0
        self.writingView.datePicker.date = record.date
        self.writingView.priceTextField.textField.text = String(record.price)
        self.writingView.countTextField.textField.text = String(record.count)
        self.writingView.memoTextView.textView.text = record.memo
        
    }
    
    func goToBackVC() {
        self.dismiss(animated: true, completion: nil)
    }
}
