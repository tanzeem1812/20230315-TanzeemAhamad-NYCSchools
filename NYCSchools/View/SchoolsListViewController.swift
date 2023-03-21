//
//  ViewController.swift
//  NYCSchools
//
//  Created by Tanzeem Ahamad on 3/15/23.
//

import UIKit

//  This ViewController  is using MVVM pattern and hence asking ViewModel for the data

class SchoolsListViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    var schoolListTableView = UITableView()
    var viewModel:SchoolsDataViewModel?
    let cellId = "schoolCell"
  
    init(schoolsDataViewModel:SchoolsDataViewModel?){
        self.viewModel = schoolsDataViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder:NSCoder){
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigation()
        setUpSchoolsListTableView()
        setUpLayOut()
        fetchSchoolsData()
    }
  
    
    //Set up Table view to listen
    func setUpSchoolsListTableView(){
        schoolListTableView.translatesAutoresizingMaskIntoConstraints = false
        schoolListTableView.rowHeight = 70;
        view.addSubview(schoolListTableView)
        schoolListTableView.register(SchoolTableViewCell.self, forCellReuseIdentifier: cellId)
        
        // assign self to tableview's datasource and delegate to call the delegates of this class
        schoolListTableView.dataSource = self
        schoolListTableView.delegate = self
    }
    
    //Set up the navigation color and title of the Table View
    func setUpNavigation() {
        let schoolStr = NSLocalizedString("SCHOOLS", comment: "")
        navigationItem.title = schoolStr // Dont use hard coded strings, apply localization and Use localized string using NSLocalizedString function
        
        self.navigationController?.navigationBar.barTintColor = .lightGray
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red: 1, green: 1, blue: 1, alpha: 1)]
    }
    
    // Setup Autolayout Contraints
    func setUpLayOut(){
        schoolListTableView.translatesAutoresizingMaskIntoConstraints = false
        schoolListTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        schoolListTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        schoolListTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        schoolListTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    // Retrieve the  data from the viewModel and handle the error properly
    func fetchSchoolsData(){
        viewModel?.fetchSchoolsData(){ result in
                switch result{
                case .success(_): // Data successfully received
                    //self.dataForTableView = data
                    DispatchQueue.main.async {
                        self.schoolListTableView.reloadData()
                    }
                case .failure(let error): // Show error to the user
                    self.handleError(error: error)
            }
        }
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


// Data and UI Events handling for the ViewTable
extension SchoolsListViewController{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.dataManager.getSchoolsData().count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SchoolTableViewCell
        let schoolData = viewModel?.dataManager.getSchoolsData()
        let data = schoolData![indexPath.row]
        cell.dbnLabel.text = "DBN:"
        cell.schoolLabel.text = NSLocalizedString("SCHOOL", comment: "") + ":"
        cell.dbnNameLabel.text =  data.dbn ?? "N/A"// It will return DBN Value
        cell.schoolNameLabel.text = data.school_name ?? "N/A" // It will return ScboolName Value
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = viewModel?.dataManager.getSchoolDataForIndex(index: indexPath.row)
        let schoolDetailViewController = SchoolDetailViewController(dbn: data?.dbn)
        schoolDetailViewController.viewModel = self.viewModel
        self.navigationController?.pushViewController(schoolDetailViewController, animated: true)
    }
}
