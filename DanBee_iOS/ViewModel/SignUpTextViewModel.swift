//
//  SignUpTextField.swift
//  DanBee_iOS
//
//  Created by 남수김 on 16/08/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class TextViewModel {
    let disposeBag = DisposeBag()
    let idObservable: BehaviorRelay<String> = BehaviorRelay(value: "")
    let pwObservable: BehaviorRelay<String> = BehaviorRelay(value: "")
    let pwCheckObservable: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    let idVaildObservable: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    let pwVaildObservable: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    let pwCheckVaildObservable: BehaviorSubject<Bool> = BehaviorSubject(value: false)

    var gender = -1
    
    let phoneNumberObservable: BehaviorRelay<String> = BehaviorRelay(value: "")
    let birthObservable: BehaviorRelay<String> = BehaviorRelay(value: "")
    let nameObservable: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    let buttonEnable: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    
    init() {
        setting()
    }
    
    
    func setting(){
        //아이디변경시 무조건 false
        idObservable.map({ _ in
            return false
        })
        .bind(to: idVaildObservable)
        .disposed(by: disposeBag)
        
        //비번형식체크
        pwObservable.map(pwCheck)
        .bind(to: pwVaildObservable)
        .disposed(by: disposeBag)
     
        //비번재확인
        pwCheckObservable.map(samePwCheck2)
        .bind(to: pwCheckVaildObservable)
        .disposed(by: disposeBag)
        
        //비밀번호바뀔시 다시 확인
        pwObservable.map(samePwCheck1)
        .bind(to: pwCheckVaildObservable)
        .disposed(by: disposeBag)
        
        Observable.combineLatest(idVaildObservable, pwVaildObservable, pwCheckVaildObservable, resultSelector: {$0 && $1 && $2 && true})
            .distinctUntilChanged()
        .bind(to: buttonEnable)
        .disposed(by: disposeBag)
        
    }
    
    func pwCheck(_ s: String) -> Bool {
        if s.count > 2 {
            return true
        }else{
            return false
        }
    }
    
    func samePwCheck1 (_ s: String) -> Bool {
        if s != pwCheckObservable.value || pwCheckObservable.value.isEmpty {
            return false
        }else {
            return true
        }
    }
    
    func samePwCheck2 (_ s: String) -> Bool {
        if s != pwObservable.value || pwObservable.value.isEmpty {
            return false
        }else {
            return true
        }
    }
    
}
