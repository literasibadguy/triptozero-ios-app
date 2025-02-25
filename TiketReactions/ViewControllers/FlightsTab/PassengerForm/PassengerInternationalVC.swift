//
//  PassengerInternationalVC.swift
//  TiketComponents
//
//  Created by Firas Rafislam on 26/01/18.
//  Copyright © 2018 Firas Rafislam. All rights reserved.
//
import Prelude
import ReactiveSwift
import TiketKitModels
import UIKit

public enum PassengerInternationalType {
    case adult
    case childInfant
}

public protocol PassengerInternationalDelegate: class {
    func paramFormSubmitted(_ internationalVC: PassengerInternationalVC, format: FormatDataForm, passenger: AdultPassengerParam)
    func paramHaveCanceled()
}

public final class PassengerInternationalVC: UIViewController {
    
    fileprivate let viewModel: PassengerInternationalViewModelType = PassengerInternationalViewModel()

    @IBOutlet fileprivate weak var passengerScrollView: UIScrollView!
    @IBOutlet fileprivate weak var noticeView: UIView!
    @IBOutlet fileprivate weak var noticeLabel: UILabel!
    
    @IBOutlet fileprivate weak var internationalStackView: UIStackView!
    
    @IBOutlet fileprivate weak var passengerLabel: UILabel!
    
    // TITLE INPUT STACK VIEW
    @IBOutlet fileprivate weak var titleInputStackView: UIStackView!
    @IBOutlet fileprivate weak var titleInputTextLabel: UILabel!
    @IBOutlet fileprivate weak var titleContainerView: UIView!
    @IBOutlet fileprivate weak var titlePickButton: UIButton!
    @IBOutlet fileprivate weak var titleMenuStackView: UIStackView!
    @IBOutlet fileprivate weak var titleSeparatorView: UIView!
    @IBOutlet fileprivate weak var titlePickedLabel: UILabel!
    
    
    // FIRST NAME INPUT STACK VIEW
    @IBOutlet fileprivate weak var firstNameInputStackView: UIStackView!
    @IBOutlet fileprivate weak var firstNameSeparatorView: UIView!
    @IBOutlet fileprivate weak var firstNameInputLabel: UILabel!
    @IBOutlet fileprivate weak var firstNameTextField: UITextField!
    
    // LAST NAME INPUT STACK VIEW
    @IBOutlet fileprivate weak var lastNameInputStackView: UIStackView!
    @IBOutlet fileprivate weak var lastNameInputLabel: UILabel!
    @IBOutlet fileprivate weak var lastNameSeparatorView: UIView!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    // DATE BORN INPUT STACK VIEW
    @IBOutlet fileprivate weak var dateBornInputStackView: UIStackView!
    @IBOutlet fileprivate weak var dateBornInputTextLabel: UILabel!
    @IBOutlet fileprivate weak var dateBornContainerView: UIView!
    @IBOutlet fileprivate weak var dateBornPickButton: UIButton!
    @IBOutlet fileprivate weak var dateBornSeparatorView: UIView!
    @IBOutlet fileprivate weak var dateBornMenuStackView: UIStackView!
    @IBOutlet fileprivate weak var dateBornPickedLabel: UILabel!
    
    // CITIZENSHIP INPUT STACK VIEW
    @IBOutlet fileprivate weak var citizenshipInputStackView: UIStackView!
    @IBOutlet fileprivate weak var citizenshipInputTextLabel: UILabel!
    @IBOutlet fileprivate weak var citizenshipContainerView: UIView!
    @IBOutlet fileprivate weak var citizenshipPickButton: UIButton!
    @IBOutlet fileprivate weak var citizenshipMenuStackView: UIStackView!
    @IBOutlet fileprivate weak var citizenshipSeparatorView: UIView!
    @IBOutlet fileprivate weak var citizenshipPickedLabel: UILabel!
    
    // PASPORT NO INPUT STACK VIEW
    @IBOutlet fileprivate weak var pasportNoInputStackView: UIStackView!
    @IBOutlet fileprivate weak var pasportNoInputLabel: UILabel!
    @IBOutlet fileprivate weak var pasportNoTextField: UITextField!
    @IBOutlet fileprivate weak var pasportNoSeparatorView: UIView!
    
    // PASPORT EXPIRED STACK VIEW
    @IBOutlet fileprivate weak var pasportExpiredInputStackView: UIStackView!
    @IBOutlet fileprivate weak var pasportExpiredInputTextLabel: UILabel!
    @IBOutlet fileprivate weak var pasportExpiredContainerView: UIView!
    @IBOutlet fileprivate weak var pasportExpiredPickButton: UIButton!
    @IBOutlet fileprivate weak var pasportExporedMenuStackView: UIStackView!
    @IBOutlet fileprivate weak var pasportExpiredSeparatorView: UIView!
    @IBOutlet fileprivate weak var passportExpiredPickedLabel: UILabel!
    
    // PASPORT ISSUES STACK VIEW
    @IBOutlet fileprivate weak var pasportIssuesStackView: UIStackView!
    @IBOutlet fileprivate weak var pasportIssuesInputLabel: UILabel!
    @IBOutlet fileprivate weak var pasportIssuesContainerView: UIView!
    @IBOutlet fileprivate weak var pasportIssuesPickButton: UIButton!
    @IBOutlet fileprivate weak var pasportIssuesMenuStackView: UIStackView!
    @IBOutlet fileprivate weak var pasportIssuesSeparatorView: UIView!
    @IBOutlet fileprivate weak var passportIssuesPickedLabel: UILabel!
    
    // ISSUE DATE STACK VIEW
    //
    @IBOutlet fileprivate weak var passportIssueDateInputStackView: UIStackView!
    @IBOutlet fileprivate weak var issueDateInputLabel: UILabel!
    @IBOutlet fileprivate weak var issueDateContainerView: UIView!
    @IBOutlet fileprivate weak var issueDatePickButton: UIButton!
    @IBOutlet fileprivate weak var issueDateMenuStackView: UIStackView!
    @IBOutlet fileprivate weak var issueDatePickedLabel: UILabel!
    @IBOutlet fileprivate weak var issueDateSeparatorView: UIView!
    
    // DEPART BAGGAGE INPUT STACK VIEW
    @IBOutlet fileprivate weak var departBaggageInputStackView: UIStackView!
    @IBOutlet fileprivate weak var departBaggageInputLabel: UILabel!
    @IBOutlet fileprivate weak var departBaggageContainerView: UIView!
    @IBOutlet fileprivate weak var departBaggagePickButton: UIButton!
    @IBOutlet fileprivate weak var departBaggageMenuStackView: UIStackView!
    @IBOutlet fileprivate weak var departBaggagePickedLabel: UILabel!
    @IBOutlet fileprivate weak var departBaggageSeparatorView: UIView!
    
    // RETURN BAGGAGE INPUT STACK VIEW
    @IBOutlet fileprivate weak var returnBaggageInputStackView: UIStackView!
    @IBOutlet fileprivate weak var returnBaggageInputLabel: UILabel!
    @IBOutlet fileprivate weak var returnBaggageContainerView: UIView!
    @IBOutlet fileprivate weak var returnBaggagePickButton: UIButton!
    @IBOutlet fileprivate weak var returnBaggageMenuStackView: UIStackView!
    @IBOutlet fileprivate weak var returnBaggagePickedLabel: UILabel!
    @IBOutlet fileprivate weak var returnBaggageSeparatorView: UIView!
    
    
    @IBOutlet fileprivate weak var collectInternationalButton: UIButton!
    
    internal weak var delegate: PassengerInternationalDelegate?
    
    public static func instantiate() -> PassengerInternationalVC {
        let vc = Storyboard.PassengerForm.instantiate(PassengerInternationalVC.self)
        return vc
    }
    
    public static func configureWith(separator: FormatDataForm, status: PassengerStatus, baggage: FormatDataForm? = nil) -> PassengerInternationalVC {
        let vc = Storyboard.PassengerForm.instantiate(PassengerInternationalVC.self)
        vc.viewModel.inputs.configureWith(separator, status: status, baggages: baggage)
        return vc
    }
    
    public static func configureDataWith(_ passenger: PassengersData) -> PassengerInternationalVC {
        let vc = Storyboard.PassengerForm.instantiate(PassengerInternationalVC.self)
        vc.viewModel.inputs.configureWith(data: passenger)
        return vc
    }
    
    public static func configureExtendedWith(_ params: AdultPassengerParam) -> PassengerInternationalVC {
        let vc = Storyboard.PassengerForm.instantiate(PassengerInternationalVC.self)
        vc.viewModel.inputs.configCurrentPassenger(pass: params)
        return vc
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        let cancelBarButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        self.navigationItem.setLeftBarButton(cancelBarButton, animated: true)
        self.navigationController?.navigationBar.isTranslucent = false
        
        /*
        let doneToolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30))
        //create left side empty space so that done button set on right side
        let flexSpace = UIBarButtonItem(barButtonSystemItem:    .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: Localizations.DonebuttonTitle, style: .done, target: self, action: #selector(noPassportTextFieldDoneEditing(_:)))
        doneBtn.tintColor = .tk_official_green
        doneToolbar.setItems([flexSpace, doneBtn], animated: false)
        doneToolbar.sizeToFit()
        */
        
        self.titlePickButton.addTarget(self, action: #selector(titleSalutationButtonTapped), for: .touchUpInside)
        self.dateBornPickButton.addTarget(self, action: #selector(dateBornButtonTapped), for: .touchUpInside)
        self.citizenshipPickButton.addTarget(self, action: #selector(citizenshipButtonTapped), for: .touchUpInside)
        self.pasportExpiredPickButton.addTarget(self, action: #selector(pasportExpiredButtonTapped), for: .touchUpInside)
        self.pasportIssuesPickButton.addTarget(self, action: #selector(pasportIssuesButtonTapped), for: .touchUpInside)
        self.issueDatePickButton.addTarget(self, action: #selector(passportIssueDateButtonTapped), for: .touchUpInside)
        self.departBaggagePickButton.addTarget(self, action: #selector(departBaggageButtonTapped), for: .touchUpInside)
        self.returnBaggagePickButton.addTarget(self, action: #selector(returnBaggageButtonTapped), for: .touchUpInside)
        
        self.firstNameTextField.addTarget(self, action: #selector(firstNameTextFieldChanged(_:)), for: [.editingDidEndOnExit, .editingChanged])
        self.firstNameTextField.addTarget(self, action: #selector(firstNameTextFieldDoneEditing), for: .editingDidEndOnExit)
        
        self.lastNameTextField.addTarget(self, action: #selector(lastNameTextFieldChanged(_:)), for: [.editingDidEndOnExit, .editingChanged])
        self.lastNameTextField.addTarget(self, action: #selector(lastNameTextFieldDoneEditing), for: .editingDidEndOnExit)
        
        self.pasportNoTextField.addTarget(self, action: #selector(noPassportTextFieldChanged(_:)), for: [.editingDidEndOnExit, .editingChanged])
        self.pasportNoTextField.addTarget(self, action: #selector(noPassportTextFieldDoneEditing), for: .editingDidEndOnExit)
//        self.pasportNoTextField.inputAccessoryView = doneToolbar
        
        self.collectInternationalButton.addTarget(self , action: #selector(submitPassengerFormTapped), for: .touchUpInside)
        
        self.viewModel.inputs.viewDidLoad()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.viewModel.inputs.viewDidAppear()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        startListeningToNotifications()
    }

    public override func bindStyles() {
        super.bindStyles()
        
        _ = self.noticeView
            |> UIView.lens.backgroundColor .~ .tk_fade_green_grey
        
        _ = self.noticeLabel
            |> UILabel.lens.textColor .~ .tk_typo_green_grey_600
        
        _ = self.internationalStackView
            |> UIStackView.lens.layoutMargins %~~ { _, stackView in
                stackView.traitCollection.isRegularRegular
                    ? .init(topBottom: Styles.grid(6), leftRight: Styles.grid(16))
                    : .init(top: Styles.grid(2), left: Styles.grid(4), bottom: Styles.grid(3), right: Styles.grid(4))
            }
            |> UIStackView.lens.isLayoutMarginsRelativeArrangement .~ true
            |> UIStackView.lens.spacing .~ Styles.grid(1)
        
        _ = self.titlePickedLabel
            |> UILabel.lens.textColor .~ .darkGray
        _ = self.citizenshipPickedLabel
            |> UILabel.lens.textColor .~ .darkGray
        _ = self.dateBornPickedLabel
            |> UILabel.lens.textColor .~ .darkGray
        _ = self.passportIssuesPickedLabel
            |> UILabel.lens.textColor .~ .darkGray
        _ = self.passportExpiredPickedLabel
            |> UILabel.lens.textColor .~ .darkGray
        _ = self.issueDatePickedLabel
            |> UILabel.lens.textColor .~ .darkGray
        
        _ = self.titleInputStackView
            |> UIStackView.lens.spacing .~ Styles.grid(1)
        
        _ = self.lastNameInputStackView
            |> UIStackView.lens.spacing .~ Styles.grid(1)
        
        _ = self.firstNameInputStackView
            |> UIStackView.lens.spacing .~ Styles.grid(1)
        
        _ = self.citizenshipInputStackView
            |> UIStackView.lens.spacing .~ Styles.grid(1)
//            |> UIStackView.lens.isHidden .~ true
        
        _ = self.dateBornInputStackView
            |> UIStackView.lens.spacing .~ Styles.grid(1)
//            |> UIStackView.lens.isHidden .~ true
        
        _ = self.pasportNoInputStackView
            |> UIStackView.lens.spacing .~ Styles.grid(1)
//            |> UIStackView.lens.isHidden .~ true
        
        _ = self.pasportExpiredInputStackView
            |> UIStackView.lens.spacing .~ Styles.grid(1)
//            |> UIStackView.lens.isHidden .~ true
        
        _ = self.pasportIssuesStackView
            |> UIStackView.lens.spacing .~ Styles.grid(1)
//            |> UIStackView.lens.isHidden .~ true
        
        _ = self.passportIssueDateInputStackView
            |> UIStackView.lens.spacing .~ Styles.grid(1)
        
        _ = self.departBaggageInputStackView
            |> UIStackView.lens.spacing .~ Styles.grid(1)
//            |> UIStackView.lens.isHidden .~ true
        
        _ = self.returnBaggageInputStackView
            |> UIStackView.lens.spacing .~ Styles.grid(1)
//            |> UIStackView.lens.isHidden .~ true
        
        _ = self.titleMenuStackView
            |> UIStackView.lens.spacing .~ Styles.grid(1)
            |> UIStackView.lens.alignment .~ .center
            |> UIStackView.lens.isUserInteractionEnabled .~ false
        _ = self.citizenshipMenuStackView
            |> UIStackView.lens.spacing .~ Styles.grid(1)
            |> UIStackView.lens.alignment .~ .center
            |> UIStackView.lens.isUserInteractionEnabled .~ false
        _ = self.dateBornMenuStackView
            |> UIStackView.lens.spacing .~ Styles.grid(1)
            |> UIStackView.lens.alignment .~ .center
            |> UIStackView.lens.isUserInteractionEnabled .~ false
        _ = self.pasportIssuesMenuStackView
            |> UIStackView.lens.spacing .~ Styles.grid(1)
            |> UIStackView.lens.alignment .~ .center
            |> UIStackView.lens.isUserInteractionEnabled .~ false
        
        _ = self.issueDateMenuStackView
            |> UIStackView.lens.spacing .~ Styles.grid(1)
            |> UIStackView.lens.alignment .~ .center
            |> UIStackView.lens.isUserInteractionEnabled .~ false
        
        _ = self.pasportExporedMenuStackView
            |> UIStackView.lens.spacing .~ Styles.grid(1)
            |> UIStackView.lens.alignment .~ .center
            |> UIStackView.lens.isUserInteractionEnabled .~ false
        
        
        _ = self.departBaggageMenuStackView
            |> UIStackView.lens.spacing .~ Styles.grid(1)
            |> UIStackView.lens.alignment .~ .center
            |> UIStackView.lens.isUserInteractionEnabled .~ false
        
        _ = self.returnBaggageMenuStackView
            |> UIStackView.lens.spacing .~ Styles.grid(1)
            |> UIStackView.lens.alignment .~ .center
            |> UIStackView.lens.isUserInteractionEnabled .~ false
        
        _ = self.titleContainerView
            |> UIView.lens.layoutMargins .~ .init(top: Styles.grid(2), left: Styles.grid(2), bottom: Styles.grid(2), right: Styles.grid(4))
            |> UIView.lens.backgroundColor .~ .white
        _ = self.citizenshipContainerView
            |> UIView.lens.layoutMargins .~ .init(top: Styles.grid(2), left: Styles.grid(2), bottom: Styles.grid(2), right: Styles.grid(4))
            |> UIView.lens.backgroundColor .~ .white
        _ = self.dateBornContainerView
            |> UIView.lens.layoutMargins .~ .init(top: Styles.grid(2), left: Styles.grid(2), bottom: Styles.grid(2), right: Styles.grid(4))
            |> UIView.lens.backgroundColor .~ .white
        _ = self.pasportIssuesContainerView
            |> UIView.lens.layoutMargins .~ .init(top: Styles.grid(2), left: Styles.grid(2), bottom: Styles.grid(2), right: Styles.grid(4))
            |> UIView.lens.backgroundColor .~ .white
        _ = self.pasportExpiredContainerView
            |> UIView.lens.layoutMargins .~ .init(top: Styles.grid(2), left: Styles.grid(2), bottom: Styles.grid(2), right: Styles.grid(4))
            |> UIView.lens.backgroundColor .~ .white
        _ = self.issueDateContainerView
            |> UIView.lens.layoutMargins .~ .init(top: Styles.grid(2), left: Styles.grid(2), bottom: Styles.grid(2), right: Styles.grid(4))
            |> UIView.lens.backgroundColor .~ .white
        _ = self.departBaggageContainerView
            |> UIView.lens.layoutMargins .~ .init(top: Styles.grid(2), left: Styles.grid(2), bottom: Styles.grid(2), right: Styles.grid(4))
            |> UIView.lens.backgroundColor .~ .white
        
        _ = self.returnBaggageContainerView
            |> UIView.lens.layoutMargins .~ .init(top: Styles.grid(2), left: Styles.grid(2), bottom: Styles.grid(2), right: Styles.grid(4))
            |> UIView.lens.backgroundColor .~ .white
        
        _ = self.noticeLabel
            |> UILabel.lens.text .~ Localizations.NoticeIdentityPassengerForm
        
        _ = self.firstNameInputLabel
            |> UILabel.lens.text .~ Localizations.FirstnameFormData
        
        _ = self.lastNameInputLabel
            |> UILabel.lens.text .~ Localizations.LastnameFormData
        
        _ = self.pasportNoInputLabel
            |> UILabel.lens.text .~ Localizations.PassportnoTitlePassengerForm
        
        _ = self.pasportIssuesInputLabel
            |> UILabel.lens.text .~ Localizations.IssuedpassportPassengerForm
        
        _ = self.citizenshipInputTextLabel
            |> UILabel.lens.text .~ Localizations.CitizenTitlePassengerForm
        
        _ = self.pasportExpiredInputTextLabel
            |> UILabel.lens.text .~ Localizations.ExpiredTitlePassengerForm
        
        _ = self.dateBornInputTextLabel
            |> UILabel.lens.text .~ Localizations.BirthdateTitlePassengerForm
        
        _ = self.issueDateInputLabel
            |> UILabel.lens.text .~ Localizations.IssuedatepassportPassengerForm
        
        _ = self.departBaggageInputLabel
            |> UILabel.lens.text .~ Localizations.DepartbaggagePassengerForm
        
        _ = self.returnBaggageInputLabel
            |> UILabel.lens.text .~ Localizations.ReturnbaggagePassengerForm
        
        _ = self.firstNameTextField
            |> UITextField.lens.returnKeyType .~ .next
            |> UITextField.lens.tintColor .~ .tk_official_green
            |> UITextField.lens.borderStyle .~ .none
            |> UITextField.lens.keyboardType .~ .default
        
        _ = self.lastNameTextField
            |> UITextField.lens.returnKeyType .~ .done
            |> UITextField.lens.tintColor .~ .tk_official_green
            |> UITextField.lens.borderStyle .~ .none
            |> UITextField.lens.keyboardType .~ .default
        
        _ = self.pasportNoTextField
            |> UITextField.lens.returnKeyType .~ .done
            |> UITextField.lens.tintColor .~ .tk_official_green
            |> UITextField.lens.borderStyle .~ .none
            |> UITextField.lens.keyboardType .~ .default
            |> UITextField.lens.autocapitalizationType .~ .allCharacters
        
        _ = self.titleSeparatorView
            |> UIView.lens.backgroundColor .~ .tk_official_green
        _ = self.firstNameSeparatorView
            |> UIView.lens.backgroundColor .~ .tk_official_green
        _ = self.lastNameSeparatorView
            |> UIView.lens.backgroundColor .~ .tk_official_green
        
        _ = self.dateBornSeparatorView
            |> UIView.lens.backgroundColor .~ .tk_official_green
//            |> UIView.lens.isHidden .~ true
        
        _ = self.citizenshipSeparatorView
            |> UIView.lens.backgroundColor .~ .tk_official_green
//            |> UIView.lens.isHidden .~ true
        
        _ = self.pasportNoSeparatorView
            |> UIView.lens.backgroundColor .~ .tk_official_green
//            |> UIView.lens.isHidden .~ true
        
        _ = self.pasportExpiredSeparatorView
            |> UIView.lens.backgroundColor .~ .tk_official_green
//            |> UIView.lens.isHidden .~ true
        
        _ = self.pasportIssuesSeparatorView
            |> UIView.lens.backgroundColor .~ .tk_official_green
//            |> UIView.lens.isHidden .~ true
        
        _ = self.issueDateSeparatorView
            |> UIView.lens.backgroundColor .~ .tk_official_green
        
        _ = self.departBaggageSeparatorView
            |> UIView.lens.backgroundColor .~ .tk_official_green
//            |> UIView.lens.isHidden .~ true
        
        _ = self.returnBaggageSeparatorView
            |> UIView.lens.backgroundColor .~ .tk_official_green
//            |> UIView.lens.isHidden .~ true
        
        _ = self.collectInternationalButton
            |> UIButton.lens.backgroundColor(forState: .normal) .~ .tk_official_green
            |> UIButton.lens.backgroundColor(forState: .disabled) .~ .tk_typo_green_grey_600
            |> UIButton.lens.titleColor(forState: .normal) .~ .white
            |> UIButton.lens.title(forState: .normal) .~ Localizations.SavePassengerInputForm
    }
    
    public override func bindViewModel() {
        super.bindViewModel()
        
        self.titleInputTextLabel.rac.text = self.viewModel.outputs.titleInputLabelText
        
        self.firstNameTextField.rac.becomeFirstResponder = self.viewModel.outputs.firstNameFirstResponder
        self.lastNameTextField.rac.becomeFirstResponder = self.viewModel.outputs.lastNameFirstResponder
        self.pasportNoTextField.rac.becomeFirstResponder = self.viewModel.outputs.noPassportFirstResponder
        
        self.passengerLabel.rac.text = self.viewModel.outputs.passengerStatusText
        self.titlePickedLabel.rac.text = self.viewModel.outputs.titleLabelText
        self.firstNameTextField.rac.text = self.viewModel.outputs.firstNameTextFieldText
        self.lastNameTextField.rac.text = self.viewModel.outputs.lastNameTextFieldText
        self.dateBornPickedLabel.rac.text = self.viewModel.outputs.birthDateLabelText
        self.citizenshipPickedLabel.rac.text = self.viewModel.outputs.citizenshipLabelText
        self.pasportNoTextField.rac.text = self.viewModel.outputs.noPassportTextFieldText
        self.passportExpiredPickedLabel.rac.text = self.viewModel.outputs.expiredPassportLabelText
        self.passportIssuesPickedLabel.rac.text = self.viewModel.outputs.issuedPassportLabelText
        self.issueDatePickedLabel.rac.text = self.viewModel.outputs.issueDatePassportLabelText
        self.departBaggagePickedLabel.rac.text = self.viewModel.outputs.departBaggageText
        self.returnBaggagePickedLabel.rac.text = self.viewModel.outputs.returnBaggageText
        
        self.pasportNoInputStackView.rac.hidden = self.viewModel.outputs.isInternational
        self.pasportExpiredInputStackView.rac.hidden = self.viewModel.outputs.isInternational
        self.pasportIssuesStackView.rac.hidden = self.viewModel.outputs.isInternational
        self.departBaggageInputStackView.rac.hidden = self.viewModel.outputs.isAvailableBaggage
        self.returnBaggageInputStackView.rac.hidden = self.viewModel.outputs.isReturnBaggage
        self.passportIssueDateInputStackView.rac.hidden = self.viewModel.outputs.isScootFlight
        
        self.pasportNoSeparatorView.rac.hidden = self.viewModel.outputs.isInternational
        self.pasportExpiredSeparatorView.rac.hidden = self.viewModel.outputs.isInternational
        self.pasportIssuesSeparatorView.rac.hidden = self.viewModel.outputs.isInternational
        self.departBaggageSeparatorView.rac.hidden = self.viewModel.outputs.isAvailableBaggage
        self.returnBaggageSeparatorView.rac.hidden = self.viewModel.outputs.isReturnBaggage
        self.issueDateSeparatorView.rac.hidden = self.viewModel.outputs.isScootFlight
        
    //    self.collectInternationalButton.rac.isEnabled = self.viewModel.outputs.isPassengerFormValid
        
        self.viewModel.outputs.goToInputsPicker
            .observe(on: QueueScheduler.main)
            .observeValues { [weak self] steps in
                switch steps {
//                case .goToTitleSalutationPicker:
//                    self?.goToTitlePickerController()
                case .goToCitizenshipPicker:
                    self?.goToCitizenshipPickerController()
                case .goToExpiredPassportPicker:
                    self?.goToExpiredPickerController()
                case .goToIssuedPassportPicker:
                    self?.goToIssuedPickerController()
                case .goToIssueDatePassportPicker:
                    self?.goToIssueDatePickerController()
                default: return
                }
        }
        
        self.viewModel.outputs.goToTitlePicker
            .observe(on: QueueScheduler.main)
            .observeValues { [weak self] field in
                self?.goToTitlePickerController(field: field)
        }
        
        self.viewModel.outputs.goToBaggagePicker
            .observe(on: QueueScheduler.main)
            .observeValues { [weak self] resBaggage in
                guard let _self = self else { return }
                let pickBaggageVC = PassengerBaggagePickerVC.configureWith(resBaggage)
                pickBaggageVC.departDelegate = _self
                pickBaggageVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                pickBaggageVC.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
                _self.present(pickBaggageVC, animated: true, completion: nil)
        }
        
        self.viewModel.outputs.goReturnBaggagePicker
            .observe(on: QueueScheduler.main)
            .observeValues { [weak self] resBaggage in
                guard let _self = self else { return }
                let pickBaggageVC = PassengerBaggagePickerVC.configureWith(resBaggage)
                pickBaggageVC.returnDelegate = _self
                pickBaggageVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                pickBaggageVC.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
                _self.present(pickBaggageVC, animated: true, completion: nil)
        }
        
        self.viewModel.outputs.goToBirthdatePicker
            .observe(on: QueueScheduler.main)
            .observeValues { [weak self] format in
                print("Res Baggage: \(format)")
                self?.goToBirthDatePickerController(field: format)
        }
        
        self.viewModel.outputs.dismissInputsPicker
            .observe(on: QueueScheduler.main)
            .observeValues { [weak self] steps in
                switch steps {
                default:
                    self?.dismiss(animated: true, completion: nil)
                }
        }
        
        self.viewModel.outputs.genericErrorNotValid
            .observe(on: QueueScheduler.main)
            .observeValues { [weak self] in
                self?.present(UIAlertController.genericError(message: "Data hasn't been valid", cancel:nil), animated: true, completion: nil)
        }
        
        self.viewModel.outputs.submitInternationalPassenger
            .observe(on: QueueScheduler.main)
            .observeValues { [weak self] format, adultParam in
                guard let _self = self else { return }
                _self.delegate?.paramFormSubmitted(_self, format: format, passenger: adultParam)
                _self.navigationController?.popViewController(animated: true)
        }
    }
    
    fileprivate func goToTitlePickerController(field: String) {
        var titles: [String]
        if field.contains("Anak") {
            titles = [Localizations.MstrFormData, Localizations.MissFormData]
        } else if field.contains("Bayi") {
            titles = [Localizations.MstrFormData, Localizations.MissFormData]
        } else {
            titles = [Localizations.MrFormData, Localizations.MrsFormData, Localizations.MsFormData]
        }
        let titlePickerVC = PassengerTitlePickerVC.instantiate(titles: titles, selectedTitle: "", delegate: self)
        titlePickerVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        titlePickerVC.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(titlePickerVC, animated: true, completion: nil)
        print("Passenger Title Picker VC Delegate")
    }
    
    fileprivate func goToBirthDatePickerController(field: String) {
        let birthPickerVC: PassengerBirthdatePickerVC
        switch field {
        case "Penumpang Anak 1":
            birthPickerVC = PassengerBirthdatePickerVC.configureBirthdate(self, state: .childPassenger)
        case "Penumpang Anak 2":
            birthPickerVC = PassengerBirthdatePickerVC.configureBirthdate(self, state: .childPassenger)
        case "Penumpang Anak 3":
            birthPickerVC = PassengerBirthdatePickerVC.configureBirthdate(self, state: .childPassenger)
        case "Penumpang Anak 4":
            birthPickerVC = PassengerBirthdatePickerVC.configureBirthdate(self, state: .childPassenger)
        case "Penumpang Anak 5":
            birthPickerVC = PassengerBirthdatePickerVC.configureBirthdate(self, state: .childPassenger)
        case "Penumpang Anak 6":
            birthPickerVC = PassengerBirthdatePickerVC.configureBirthdate(self, state: .childPassenger)
        case "Penumpang Bayi 1":
            birthPickerVC = PassengerBirthdatePickerVC.configureBirthdate(self, state: .infantPassenger)
        case "Penumpang Bayi 2":
            birthPickerVC = PassengerBirthdatePickerVC.configureBirthdate(self, state: .infantPassenger)
        case "Penumpang Bayi 3":
            birthPickerVC = PassengerBirthdatePickerVC.configureBirthdate(self, state: .infantPassenger)
        case "Penumpang Bayi 4":
            birthPickerVC = PassengerBirthdatePickerVC.configureBirthdate(self, state: .infantPassenger)
        case "Penumpang Bayi 5":
            birthPickerVC = PassengerBirthdatePickerVC.configureBirthdate(self, state: .infantPassenger)
        case "Penumpang Bayi 6":
            birthPickerVC = PassengerBirthdatePickerVC.configureBirthdate(self, state: .infantPassenger)
        default:
            birthPickerVC = PassengerBirthdatePickerVC.configureBirthdate(self, state: .adultPassenger)
        }
        birthPickerVC.modalTransitionStyle = .crossDissolve
        birthPickerVC.modalPresentationStyle = .overFullScreen
        self.present(birthPickerVC, animated: true, completion: nil)
    }
    
    fileprivate func goToCitizenshipPickerController() {
        let nationalPickerVC = NationalityPickVC.configureWith()
        nationalPickerVC.delegate = self
        self.present(nationalPickerVC, animated: true, completion: nil)
    }
    
    fileprivate func goToExpiredPickerController() {
        let birthdatePickerVC = PassengerBirthdatePickerVC.instantiate(expiredDelegate: self, state: .expiredPassport)
        birthdatePickerVC.modalTransitionStyle = .crossDissolve
        birthdatePickerVC.modalPresentationStyle = .overFullScreen
        self.present(birthdatePickerVC, animated: true, completion: nil)
    }
    
    fileprivate func goToIssueDatePickerController() {
        let birthdatePickerVC = PassengerBirthdatePickerVC.instantiate(issueDelegate: self, state: .issueDatePassport)
        birthdatePickerVC.modalTransitionStyle = .crossDissolve
        birthdatePickerVC.modalPresentationStyle = .overFullScreen
        self.present(birthdatePickerVC, animated: true, completion: nil)
    }
    
    fileprivate func goToIssuedPickerController() {
        let nationalPickerVC = NationalityPickVC.configureWith()
        nationalPickerVC.issueCountryDelegate = self
        self.present(nationalPickerVC, animated: true, completion: nil)
    }
    
    // I required a data from take baggage, How to make sure there is one?
    fileprivate func goTakeBaggage(res: [ResourceBaggage]) {
        
    }
    
    fileprivate func startListeningToNotifications() {
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc fileprivate func keyboardWillShow(_ notification: Foundation.Notification) {
        guard
            let userInfo = notification.userInfo as? [String: AnyObject],
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            else {
                return
        }
        
        refreshInsets(forKeyboardFrame: keyboardFrame)
    }
    
    @objc fileprivate func keyboardWillHide(_ notification: Foundation.Notification) {
        guard
            let userInfo = notification.userInfo as? [String: AnyObject],
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            else {
                return
        }
        
        refreshInsets(forKeyboardFrame: keyboardFrame)
        //        dismissOptionsViewControllerIfNecessary()
    }
    
    fileprivate func refreshInsets(forKeyboardFrame keyboardFrame: CGRect) {
        let referenceView: UIScrollView = self.passengerScrollView
        
        let scrollInsets = UIEdgeInsets(top: referenceView.scrollIndicatorInsets.top, left: 0, bottom: view.frame.maxY - keyboardFrame.minY, right: 0)
        let contentInsets  = UIEdgeInsets(top: referenceView.contentInset.top, left: 0, bottom: view.frame.maxY - keyboardFrame.minY, right: 0)
        
        self.passengerScrollView.scrollIndicatorInsets = scrollInsets
        self.passengerScrollView.contentInset = contentInsets
        
        //        htmlTextView.scrollIndicatorInsets = scrollInsets
        //        htmlTextView.contentInset = contentInsets
        
        //        richTextView.scrollIndicatorInsets = scrollInsets
        //        richTextView.contentInset = contentInsets
    }
    
    @objc fileprivate func cancelButtonTapped() {
        self.navigationController?.popViewController(animated: true)
        self.delegate?.paramHaveCanceled()
    }
    
    @objc fileprivate func titleSalutationButtonTapped() {
        self.viewModel.inputs.titleSalutationButtonTapped()
    }
    
    @objc fileprivate func dateBornButtonTapped() {
        self.viewModel.inputs.birthDateButtonTapped()
    }
    
    @objc fileprivate func citizenshipButtonTapped() {
        self.viewModel.inputs.citizenshipButtonTapped()
    }
    
    @objc fileprivate func pasportExpiredButtonTapped() {
        self.viewModel.inputs.expiredPassportButtonTapped()
    }
    
    @objc fileprivate func pasportIssuesButtonTapped() {
        self.viewModel.inputs.issuedPassportButtonTapped()
    }
    
    @objc fileprivate func passportIssueDateButtonTapped() {
        self.viewModel.inputs.issueDatePassportButtonTapped()
    }
    
    @objc fileprivate func firstNameTextFieldChanged(_ textField: UITextField) {
        self.viewModel.inputs.firstNameTextFieldChange(textField.text)
    }
    
    @objc fileprivate func firstNameTextFieldDoneEditing(_ textField: UITextField) {
        self.viewModel.inputs.firstNameTextFieldDidEndEditing()
    }
    
    @objc fileprivate func lastNameTextFieldChanged(_ textField: UITextField) {
        self.viewModel.inputs.lastNameTextFieldChange(textField.text)
    }
    
    @objc fileprivate func lastNameTextFieldDoneEditing(_ textField: UITextField) {
        self.viewModel.inputs.lastNameTextFieldDidEndEditing()
    }
    
    @objc fileprivate func noPassportTextFieldChanged(_ textField: UITextField) {
        self.viewModel.inputs.noPassportTextFieldChange(textField.text)
    }
    
    @objc fileprivate func noPassportTextFieldDoneEditing(_ textField: UITextField) {
        self.viewModel.inputs.noPassportTextFieldDidEndEditing()
        self.pasportNoTextField.resignFirstResponder()
    }
    
    @objc fileprivate func departBaggageButtonTapped() {
        self.viewModel.inputs.baggageDepartButtonTapped()
    }
    
    @objc fileprivate func returnBaggageButtonTapped() {
        self.viewModel.inputs.baggageReturnButtonTapped()
    }
    
    @objc fileprivate func submitPassengerFormTapped() {
        self.viewModel.inputs.submitButtonTapped()
    }
}

extension PassengerInternationalVC: PassengerTitlePickerVCDelegate {
    func passengerTitlePickerVC(_ controller: PassengerTitlePickerVC, choseTitle: String) {
        self.viewModel.inputs.titleSalutationChanged(choseTitle)
    }
    
    func passengerTitlePickerVCCancelled(_ controller: PassengerTitlePickerVC) {
        self.viewModel.inputs.titleSalutationCanceled()
    }
}

extension PassengerInternationalVC: PassengerBirthdatePickerDelegate {
    func dateHaveSelected(_ date: Date) {
        self.viewModel.inputs.birthDateChanged(date)
    }
}

extension PassengerInternationalVC: PassengerExpiredPassportPickerDelegate {
    func expiredDateHaveSelected(_ date: Date) {
        self.viewModel.inputs.expiredPassportChanged(date)
    }
}

extension PassengerInternationalVC: PassengerIssueDatePassportPickerDelegate {
    func issueDateHaveSelected(_ date: Date) {
        self.viewModel.inputs.issueDatePassportChanged(date)
    }
}

extension PassengerInternationalVC: NationalityPickDelegate {
    public func changedCountry(_ list: NationalityPickVC, country: CountryListEnvelope.ListCountry) {
        self.viewModel.inputs.citizenshipChanged(country)
    }
}

extension PassengerInternationalVC: PassportIssuePickDelegate {
    public func changedIssuing(_ list: NationalityPickVC, country: CountryListEnvelope.ListCountry) {
        self.viewModel.inputs.issuedPassportChanged(country)
    }
}

extension PassengerInternationalVC: PassengerDepartBaggagePickerDelegate {
    func passengerBaggagePicker(_ controller: PassengerBaggagePickerVC, choseBaggage: ResourceBaggage) {
        self.viewModel.inputs.baggageDepartChanged(choseBaggage)
    }
    
    func passengerBaggageCanceled(_ controller: PassengerBaggagePickerVC) {
        self.viewModel.inputs.baggageDepartCanceled()
    }
}

extension PassengerInternationalVC: PassengerReturnBaggagePickerDelegate {
    func passengerReturnBaggagePicker(_ controller: PassengerBaggagePickerVC, choseBaggage: ResourceBaggage) {
        self.viewModel.inputs.baggageReturnChanged(choseBaggage)
    }
    
    func passengerReturnBaggageCanceled(_ controller: PassengerBaggagePickerVC) {
        self.viewModel.inputs.baggageReturnCanceled()
    }
}
