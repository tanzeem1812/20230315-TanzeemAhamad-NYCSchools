//
//  SchoolDetailViewController.swift
//  NYCSchools
//
//  Created by Tanzeem Ahamad on 3/15/23.
//

import UIKit

//  This ViewController is using MVVM pattern and hence asking ViewModel for the data

class SchoolDetailViewController: UIViewController {
    
    var dbn:String?
    var viewModel:SchoolsDataViewModel?
    
    let dbnLabel = UILabel()
    let schoolNameLabel = UILabel()
    let locationLabel = UILabel()
    let totalStudentsLabel = UILabel()
    let testTakersLabel = UILabel()
    let critReadingAvgScoreLabel =  UILabel()
    let mathAvgScoreLabel =  UILabel()
    let writingAvgScoreLabel = UILabel()
    
    convenience init( dbn:String?){
        self.init()
        self.dbn = dbn
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        //Add Views
        addViews()
        
         if dbn != nil {
            // Set up the layout of the views
            setUpDBNView()
             
             let schoolData = viewModel?.dataManager.getSchoolDataFor(dbn: dbn!)
            
            if schoolData != nil{
                setUpSchoolNameView(str:schoolData!.school_name ?? "N/A")
                setUpLocationLabelView(str:schoolData!.location ?? "N/A")
                setUpTotalStudentsLabelView(str:schoolData!.total_students ?? "N/A")
            }
             else{
                 setUpSchoolNameView(str:"N/A")
                 setUpLocationLabelView(str:"N/A")
                 setUpTotalStudentsLabelView(str:"N/A")
             }
            
             viewModel?.fetchSchoolsExtraData(dbnStr:dbn!, completion: {[weak self] result in
                switch result{
                case .success(_):
                    // Show data in main thread as this closure will be called by background thread
                    DispatchQueue.main.async {
                        //Set up the layout of Extra Data views
                        self?.setUpExtraDataViews()
                    }
                case .failure(let error):
                    self?.handleError(error: error)
                }
            })
        }
    }
    
    func addViews(){
        view.addSubview(dbnLabel)
        view.addSubview(schoolNameLabel)
        view.addSubview(locationLabel)
        view.addSubview(totalStudentsLabel)
        view.addSubview(testTakersLabel)
        view.addSubview(critReadingAvgScoreLabel)
        view.addSubview(mathAvgScoreLabel)
        view.addSubview(writingAvgScoreLabel)
    }
    
  
    func setUpDBNView(){
        dbnLabel.textColor = .black
        dbnLabel.translatesAutoresizingMaskIntoConstraints = false

        // Dont use hard coded  string if you are using multiple  languages, apply localization and Use localized string using NSLocalizedString function
        dbnLabel.text = "DBN : " + "\(dbn!)"
        dbnLabel.topAnchor.constraint(equalTo: view.topAnchor,constant: 50).isActive = true
        dbnLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 40).isActive = true
    }
    
    func setUpSchoolNameView(str:String){
            schoolNameLabel.numberOfLines = 0
            setColorAndAutosizeMaskConstraint(view: schoolNameLabel)
            
            let localizedStr = NSLocalizedString("SCHOOL", comment: "") + " " + NSLocalizedString("NAME", comment: "") + ":"
        schoolNameLabel.text = localizedStr + "\(str )"
            setUpAnchorContraints(lastView: dbnLabel, currentView: schoolNameLabel)
            schoolNameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    func setUpLocationLabelView(str:String){
            locationLabel.numberOfLines = 0
            setColorAndAutosizeMaskConstraint(view: locationLabel)
            
            let localizedStr = NSLocalizedString("LOCATION", comment: "") + ": "
        locationLabel.text = localizedStr + "\(str )"
            
            setUpAnchorContraints(lastView: schoolNameLabel, currentView: locationLabel)
            locationLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setUpTotalStudentsLabelView(str:String){
            setColorAndAutosizeMaskConstraint(view: totalStudentsLabel)
    
            // Dont use hard coded  string if you are using multiple  languages, apply localization and Use localized string using NSLocalizedString function as used in above functions
        totalStudentsLabel.text = "Number of students : " + "\(str )"
            setUpAnchorContraints(lastView: locationLabel, currentView: totalStudentsLabel)
    }
    
    //Set up the layout of Extra Data views
    func setUpExtraDataViews(){
        if dbn != nil {
            if let extraData = viewModel?.dataManager.getExtraSchoolDataFor(dbn: dbn!){
                setUpTestTakerLabelView(extraData.num_of_sat_test_takers ?? "N/A")
                setUpCritReadingAvgScoreLabelView(extraData.sat_critical_reading_avg_score ?? "N/A")
                setUpMathAvgScoreLableView(extraData.sat_math_avg_score ?? "N/A")
                setUpWritingAvgScoreLabelView(extraData.sat_writing_avg_score ?? "N/A")
            }
        }
    }
    
    func setUpTestTakerLabelView(_ str:String){
        setColorAndAutosizeMaskConstraint(view: testTakersLabel)
 
        // Dont use hard coded  string if you are using multiple  languages, apply localization and Use localized string using NSLocalizedString function as used in above functions
        testTakersLabel.text = "Test Takers : " + str
        setUpAnchorContraints(lastView: totalStudentsLabel, currentView: testTakersLabel)
    }
    
    func setUpCritReadingAvgScoreLabelView(_ str:String){
        setColorAndAutosizeMaskConstraint(view: critReadingAvgScoreLabel)
 
        // Dont use hard coded  string if you are using multiple  languages, apply localization and Use localized string using NSLocalizedString function as used in above functions

        critReadingAvgScoreLabel.text = "Reading Average Score : " + str
        setUpAnchorContraints(lastView: testTakersLabel, currentView: critReadingAvgScoreLabel)
    }
    
    func setUpMathAvgScoreLableView(_ str:String){
        setColorAndAutosizeMaskConstraint(view: mathAvgScoreLabel)
 
        // Dont use hard coded  string if you are using multiple  languages, apply localization and Use localized string using NSLocalizedString function as used in above functions

        mathAvgScoreLabel.text = "Math Average Score : " + str
        setUpAnchorContraints(lastView: critReadingAvgScoreLabel, currentView: mathAvgScoreLabel)
    }
    
    func setUpWritingAvgScoreLabelView(_ str:String){
        setColorAndAutosizeMaskConstraint(view: writingAvgScoreLabel)
        // Dont use hard coded  string if you are using multiple  languages, apply localization and Use localized string using NSLocalizedString function as used in above functions

        writingAvgScoreLabel.text = "Writing Average Score : " + str
        setUpAnchorContraints(lastView: mathAvgScoreLabel, currentView: writingAvgScoreLabel)
    }
    
    func setUpAnchorContraints(lastView:UILabel, currentView:UILabel){
        currentView.topAnchor.constraint(equalTo: lastView.bottomAnchor,constant: 2).isActive = true
        currentView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 40).isActive = true
        currentView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    func setColorAndAutosizeMaskConstraint(view:UILabel){
        view.textColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        
    }
    // Handle Error to show proper error Message to the user
    func handleError(error:ErrorCodes){
        let localizedTitleStr = NSLocalizedString("Error", comment: "")
        showAlert( title: localizedTitleStr,message: error.errorDescription!)
    }
    
    // Alert should be displayed in main thread in case its called from the background thread
    func showAlert(title:String,message:String){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message:message,preferredStyle: .alert)
            let nsLocalizedOKStr = NSLocalizedString("Ok", comment: "")
            alert.addAction(UIAlertAction(title: nsLocalizedOKStr, style: .default, handler: nil))
            self.present(alert,animated:true,completion: nil)
        }
    }
}

