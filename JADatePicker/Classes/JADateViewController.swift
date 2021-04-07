
//自定义时间选择器
import UIKit
import SnapKit
public struct DateFormat {
    /// 默认格式:yyyy-MM-dd HH:mm:ss
    public static let `default` = DateFormat(value: "yyyy-MM-dd HH:mm:ss")
    /// yyyy-MM-dd HH:mm
    public static let standard = DateFormat(value: "yyyy-MM-dd HH:mm")
    /// yyyy-MM-dd
    public static let days = DateFormat(value: "yyyy-MM-dd")
    /// yyyy-MM
    public static let months = DateFormat(value: "yyyy-MM")
    /// MM-dd
    public static let monthDay = DateFormat(value: "MM-dd")
    /// HH:mm
    public static let hourMinute = DateFormat(value: "HH:mm")
    
    public let value: String
    
    public init(value: String) {
        self.value = value
    }
}
class JADateViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //代理
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch self.format {
        case DateFormat.standard.value:do{
            addLabel(nameArr: ["年","月","日","时","分"])
           return 5
        }
        case DateFormat.days.value:do{
            addLabel(nameArr: ["年","月","日"])
            return 3
        }
        case DateFormat.months.value:do{
            addLabel(nameArr: ["年","月"])
            return 2
        }
        case DateFormat.monthDay.value:do{
            addLabel(nameArr: ["月","日"])
            return 2
        }
        case DateFormat.hourMinute.value:do{
            addLabel(nameArr: ["时","分"])
            return 2
        }
        default: do {
        }
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let arr = numberOfRowsInComponent()
        return arr[component] as! Int
    }
    private func numberOfRowsInComponent() -> NSArray{
        let yearNum = NSNumber(value: self.yearArray.count)
        let monthNum =  NSNumber(value: self.monthArray.count)
        let days = self.days(year_num: self.yearArray[yearIndex], month_num: self.monthArray[monthIndex])
        let dayNum = NSNumber(value: days)
        let hourNum = NSNumber(value:self.hourArray.count)
        let minuteNum = NSNumber(value: self.minuteArray.count)
        
        switch self.format {
        case DateFormat.standard.value:do{
            return [yearNum,monthNum,dayNum,hourNum,minuteNum]
        }
        case DateFormat.days.value:do{
            return [yearNum,monthNum,dayNum]
        }
        case DateFormat.months.value:do{
            return [yearNum,monthNum]
        }
        case DateFormat.monthDay.value:do{
            return [monthNum,dayNum]
        }
        case DateFormat.hourMinute.value:do{
            return [hourNum,minuteNum]
        }
        default: do {
        }
        }
        return []
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat{
        return 40
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var title = ""
        switch self.format {
        case DateFormat.standard.value:do{
            if 0 == component{
                title = self.yearArray[row] as! String
            }else if 1 == component {
                title = self.monthArray[row] as! String
            }else if 2 == component {
                title = self.dayArray[row] as! String
            }else if 3 == component {
                title = self.hourArray[row] as! String
            }else if 4 == component {
                title = self.minuteArray[row] as! String
            }
        }
        case DateFormat.days.value:do{
            if 0 == component{
                title = self.yearArray[row] as! String
            }else if 1 == component {
                title = self.monthArray[row] as! String
            }else if 2 == component {
                title = self.dayArray[row] as! String
            }
        }
        case DateFormat.months.value:do{
            if 0 == component{
                title = self.yearArray[row] as! String
            }else if 1 == component {
                title = self.monthArray[row] as! String
            }
        }
        case DateFormat.monthDay.value:do{
            if 0 == component {
                title = self.monthArray[row] as! String
            }else if 1 == component {
                title = self.dayArray[row] as! String
            }
        }
        case DateFormat.hourMinute.value:do{
           
            if 0 == component {
                title = self.hourArray[row] as! String
            }else if 1 == component {
                title = self.minuteArray[row] as! String
            }
        }
        default: do {
        }
        }
        let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        label.text = title
        return label
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        switch self.format {
        case DateFormat.standard.value:do{
            if 0 == component{
                yearIndex = row
                self.contentLabel.text = (self.yearArray[row] as! String)
            }else if 1 == component {
                monthIndex = row
            }else if 2 == component {
                dayIndex = row
            }else if 3 == component {
                hourIndex = row
            }else if 4 == component {
                minuteIndex = row
            }
        }
        case DateFormat.days.value:do{
            if 0 == component{
                yearIndex = row
                self.contentLabel.text = (self.yearArray[row] as! String)
            }else if 1 == component {
                monthIndex = row
            }else if 2 == component {
                dayIndex = row
            }
        }
        case DateFormat.months.value:do{
            if 0 == component{
                yearIndex = row
                self.contentLabel.text = (self.yearArray[row] as! String)
            }else if 1 == component {
                monthIndex = row
            }
        }
        case DateFormat.monthDay.value:do{
            
            if 0 == component {
                monthIndex = row
            }else if 1 == component {
                dayIndex = row
            }
        }
        case DateFormat.hourMinute.value:do{
            
            if 0 == component {
                hourIndex = row
            }else if 1 == component {
                minuteIndex = row
            }
        }
        default: do {
        }
        }
    }
    //定义
    typealias block = (String,Date)->Void
    //声明
    var callBackBlock:block?

    //固定常量
    private let left:CGFloat = 15.0
    //当前时间
    private var currentDate = Date()
    //时间字符串
    var current_time:String = ""
    
    //年
    private lazy var yearArray:NSMutableArray = {
        return serial(from: 1970, to: 2100, polish:true)
    }()
    //月
    private lazy var monthArray:NSMutableArray = {
        return serial(from: 1, to: 13, polish:false)
    }()
    //日
    private var dayArray:NSMutableArray  = []
    //时
    private lazy var hourArray:NSMutableArray = {
        return serial(from: 0, to: 24, polish:true)
    }()
    //分
    private lazy var minuteArray:NSMutableArray = {
        return serial(from: 0, to: 60, polish:true)
    }()
    //创造连续整数
    private func serial(from:NSInteger,to:NSInteger,polish:Bool)->NSMutableArray {
        if from > to {
            return NSMutableArray()
        }
        let arr:NSMutableArray = NSMutableArray()
        for i in (from..<to){
            var str = String(i)
            if str.count == 1 && polish {
                str = "0"+str
            }
            arr.add(str)
        }
        return arr
    }
    //记录年份选择角标
    @objc dynamic private var yearIndex:NSInteger = 0
    //记录月份选择角标
    @objc dynamic private var monthIndex:NSInteger = 0
    //记录天选择角标
    private var dayIndex:NSInteger = 0
    //记录小时选择角标
    private var hourIndex:NSInteger = 0
    //记录分钟选择角标
    private var minuteIndex:NSInteger = 0
    
    //时间格式
    var format: String = DateFormat.default.value

    //分析时间格式
    private func analyseFormat(format:String){
        let timeFormat = format.uppercased()
        //YYYY-MM-DD HH:MM:SS
        var hasYear:Bool = false
        var hasMonth:Bool = false
        var hasDay:Bool = false
        var hasHour:Bool = false
        var hasMinute:Bool = false
        //格式包含年份
        if timeFormat.contains("YYYY") {
            hasYear = true
        }
        //格式包含月份
        if timeFormat.contains("MM") {
            if timeFormat.contains(".MM") || timeFormat.contains("MM.") || timeFormat.contains("-MM") || timeFormat.contains("MM-"){
                hasMonth = true
            }
        }
        //格式包含天
        if timeFormat.contains("DD") {
            hasDay = true
        }
        //格式包含时
        if timeFormat.contains("HH") {
            hasHour = true
        }
        //格式包含分钟
        if timeFormat.contains("MM") {
            if timeFormat.contains(":MM") || timeFormat.contains("MM:"){
                //包含分钟的情况
                hasMinute = true
            }
        }
        if hasYear && hasMonth && hasDay && hasHour && hasMinute{
            self.format = DateFormat.standard.value
        }
        if hasYear && hasMonth && hasDay && !hasHour && !hasMinute{
            self.format = DateFormat.days.value
        }
        if hasYear && hasMonth && !hasDay && !hasHour && !hasMinute{
            self.format = DateFormat.months.value
        }
        if !hasYear && hasMonth && hasDay && !hasHour && !hasMinute{
            self.format = DateFormat.monthDay.value
        }
        if !hasYear && !hasMonth && !hasDay && hasHour && hasMinute{
            self.format = DateFormat.hourMinute.value
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        addKVC()
        analyseFormat(format: self.format)
        createSubView()
        configDefault()
    }

    open func showDatePicker(viewController:UIViewController){
        viewController.definesPresentationContext = true
        self.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        viewController.present(self, animated: false, completion: nil)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: false, completion: nil)
    }
    private func createSubView(){
        self.view.addSubview(self.backView);
        self.backView.snp.makeConstraints { (make) in
            make.left.equalTo(self.left);
            make.centerX.equalTo(self.view);
            make.bottom.equalTo(-20);
            make.height.equalTo(240);
        }
    }
    ///  *** 懒加载视图 ***
    public lazy var backView:UIView = {

        let view = UIView();
        view.backgroundColor = UIColor.white
        view.layer.masksToBounds = true
        view.layer.cornerRadius  = 10
        //时间选择器标题
        let titleLabel = UILabel();
        view.addSubview(titleLabel);

        titleLabel.text = self.title ?? "时间选择"
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(0);
            make.height.equalTo(40);
            make.centerX.equalTo(view);
        }
        //横线
        let line = UILabel();
        view.addSubview(line);
        line.backgroundColor = UIColor(red:235.0/255, green:235.0/255, blue: 235.0/255, alpha: 1.0)
        line.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom);
            make.left.right.equalTo(0);
            make.height.equalTo(1);
        }
        
        let sureBtn = UIButton(type: UIButton.ButtonType.custom)
        view.addSubview(sureBtn)
        sureBtn.setTitle("确定", for: UIControl.State.normal)
        sureBtn.titleLabel?.font = titleLabel.font
        sureBtn.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        sureBtn.addTarget(self,action:#selector(clickSureBtn),for:.touchUpInside)
        sureBtn.snp.makeConstraints { (make) in
            make.width.equalTo(70)
            make.top.right.equalTo(0)
            make.bottom.equalTo(line.snp.top)
        }
        
        self.contentLabel.textColor = line.backgroundColor
        view.addSubview(self.contentLabel)
        self.contentLabel.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(line.snp.bottom)
        }
        self.contentLabel.addSubview(self.datePicker)
        self.datePicker.snp.makeConstraints {(make) in
            make.top.bottom.left.right.equalTo(0)
        }
        return view
    }()
    /*按钮点击实现方法*/
    @objc  private func clickSureBtn(button:UIButton){
        
        var time = ""
        
        switch self.format {
        case DateFormat.standard.value:do{
            time = String(format: "%@-%@-%@ %@:%@", self.yearArray[yearIndex] as! CVarArg,self.monthArray[monthIndex] as! CVarArg,self.dayArray[dayIndex] as! CVarArg,self.hourArray[hourIndex] as! CVarArg,self.minuteArray[minuteIndex] as! CVarArg)
        }
        case DateFormat.days.value:do{
            time = String(format: "%@-%@-%@", self.yearArray[yearIndex] as! CVarArg,self.monthArray[monthIndex] as! CVarArg,self.dayArray[dayIndex] as! CVarArg)
        }
        case DateFormat.months.value:do{
            time = String(format: "%@-%@", self.yearArray[yearIndex] as! CVarArg,self.monthArray[monthIndex] as! CVarArg)
        }
        case DateFormat.monthDay.value:do{
            time = String(format: "%@-%@",self.monthArray[monthIndex] as! CVarArg,self.dayArray[dayIndex] as! CVarArg)
        }
        case DateFormat.hourMinute.value:do{
            time = String(format: "%@:%@", self.hourArray[hourIndex] as! CVarArg,self.minuteArray[minuteIndex] as! CVarArg)
        }
        default: do {
        }
        }
        if (self.callBackBlock != nil && time.count > 0) {
            self.callBackBlock!(time,string2date(time, format: self.format))
        }
        self.dismiss(animated: false, completion: nil)
    }
    //选择视图背景视图
    private lazy var contentLabel:UILabel = {
        let label = UILabel()
        label.text = date2String(Date(), format: "yyyy")
        label.isUserInteractionEnabled = true
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 110, weight: UIFont.Weight.bold)
        return label
    }()
    //懒加载时间选择器
    private lazy var datePicker:UIPickerView = {
        let datePicker = UIPickerView();
        datePicker.showsSelectionIndicator = true;
        datePicker.delegate = self;
        datePicker.dataSource = self;
        return datePicker
    }()
    
    //类型转换成数字
    private func changeValue(value:Any)->Int {
        var temp = 0
        if value is NSNumber {
            temp = Int(truncating: value as! NSNumber)
        }else if value is String {
            temp = Int(value as! String)!
        }else if value is NSString {
            temp = Int((value as! NSString) as String)!
        }
        return temp
    }
    //根据年份确定每个月份有多少天
    private func days(year_num:Any,month_num:Any)->Int {
        
        let year = changeValue(value: year_num)
        let month = changeValue(value: month_num)
    
        var days:Int = 0
        
        switch month {
        case 1,3,5,7,8,10,12:do{
            days = 31
        }
        case 4,6,9,11:do{
            days = 30
        }
        case 2:do{
            //能被4整除但是不能被100整除为普通闰年，能被400整除的为世纪闰年（例如：1900不为如年）
            let leapyear:Bool = (year % 4 == 0) ? ((year % 100 == 0) ? ((year % 400 == 0) ?true:false):true):false
            //闰年
            if leapyear {
                days = 29
            }else{
                days = 28
            }
        }
        default:
            break
        }
        return days
    }
    //添加年月日时分展示文本
    private func addLabel(nameArr:NSArray)->Void{
        for subView in self.contentLabel.subviews {
            if subView is UILabel {
                subView.removeFromSuperview()
            }
        }
        if nameArr.count == 0 {return}
        let width = (self.view.frame.size.width - self.left * 2)/CGFloat(nameArr.count)
        
        for(index, item) in nameArr.enumerated(){
            let label = UILabel()
            self.contentLabel.addSubview(label)
            label.text = (item as! String)
            label.isUserInteractionEnabled = true
            label.textAlignment = NSTextAlignment.center
            label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
            
            var space:CGFloat = 12.0
            if item as! String == "年" {
                space = 22.0
            }
            let x = width * CGFloat(index) + width / 2 + space
            label.snp.makeConstraints { (make) in
                make.centerY.equalTo(self.contentLabel)
                make.left.equalTo(x)
            }
        }
    }
    
    //默认配置
    private func configDefault()->Void{
        if self.current_time.count == self.format.count{
            self.currentDate = string2date(self.current_time, format: self.format)
        }
        
        //读取当前时间
        let dict = timeInfo(date: self.currentDate)
        
        //各时间位置
        yearIndex = self.containValue(value: dict["year"]!, array: yearArray)
        monthIndex = self.containValue(value: dict["month"]!, array: monthArray)
        dayIndex = self.containValue(value: dict["day"]!, array: dayArray)
        hourIndex = self.containValue(value: dict["hour"]!, array: hourArray)
        minuteIndex = self.containValue(value: dict["minute"]!, array: minuteArray)
        
        if self.format == DateFormat.monthDay.value{
            let year = date2String(Date(), format: "yyyy")
            if yearArray .contains(year) {
                yearIndex = yearArray.index(of: year);
            }
            self.contentLabel.text = year
        }
        //刷新视图
        self.reload()
    }
    //查找数组中元素的位置
    private func containValue(value:Any,array:NSArray) -> Int {
        if array .contains(value) {
           return array.index(of: value)
        }
        return 0
    }
    //时间信息，包含年、月、日、时、分、周信息
    func timeInfo(date:Date) -> Dictionary<String, String> {
        
        let calendar: Calendar = Calendar(identifier: .gregorian)
        var comps: DateComponents = DateComponents()
        comps = calendar.dateComponents([.year,.month,.day, .weekday, .hour, .minute,.second], from: date)
        // 获取各时间字段的数值
        var hour = String(comps.hour!)
        if hour.count == 1 {
            hour = "0"+hour
        }
        var minute = String(comps.minute!)
        if minute.count == 1 {
            minute = "0"+minute
        }
        
        return ["year":String(comps.year!),"month":String(comps.month!),"day":String(comps.day!),"hour":hour,"minute":minute,"weekday":String(comps.weekday! - 1)]
    }
    //刷新视图
    private func reload()->Void{
        switch self.format {
        case DateFormat.standard.value:do{
            self.datePicker.selectRow(yearIndex, inComponent: 0, animated: true)
            self.datePicker.selectRow(monthIndex, inComponent: 1, animated: true)
            self.datePicker.selectRow(dayIndex, inComponent: 2, animated: true)
            self.datePicker.selectRow(hourIndex, inComponent: 3, animated: true)
            self.datePicker.selectRow(minuteIndex, inComponent: 4, animated: true)
        }
        case DateFormat.days.value:do{
            self.datePicker.selectRow(yearIndex, inComponent: 0, animated: true)
            self.datePicker.selectRow(monthIndex, inComponent: 1, animated: true)
            self.datePicker.selectRow(dayIndex, inComponent: 2, animated: true)
        }
        case DateFormat.months.value:do{
            self.datePicker.selectRow(yearIndex, inComponent: 0, animated: true)
            self.datePicker.selectRow(monthIndex, inComponent: 1, animated: true)
            
        }
        case DateFormat.monthDay.value:do{
            self.datePicker.selectRow(monthIndex, inComponent: 0, animated: true)
            self.datePicker.selectRow(dayIndex, inComponent: 1, animated: true)
        }
        case DateFormat.hourMinute.value:do{
            self.datePicker.selectRow(hourIndex, inComponent: 0, animated: true)
            self.datePicker.selectRow(minuteIndex, inComponent: 1, animated: true)
        }
        default: do {
        }
        }
    }
    //日期 -> 字符串
    private func date2String(_ date:Date, format:String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        var dateFormat = "yyyy-MM-dd HH:mm:ss"
        if format.count != 0 {
            dateFormat = format
        }
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date
    }
    //字符串 -> 日期
    private func string2date(_ time:String, format:String) -> Date {
        
        let formatter:DateFormatter = DateFormatter()
        // 设置时区，不设置时默认的时区是系统时区（GMT+8）
        formatter.locale = Locale.init(identifier: "zh_CN")
        var dateFormat = "yyyy-MM-dd HH:mm:ss"
        if format.count != 0 {
            dateFormat = format
        }
        formatter.dateFormat = dateFormat
        //String 转 NSDate
        let date:Date = formatter.date(from: time)! as Date
        return date
    }
    //添加监听
    private func addKVC() -> Void{
        self.addObserver(self, forKeyPath: "yearIndex", options: [.old,.new], context: nil)
        self.addObserver(self, forKeyPath: "monthIndex", options: [.old,.new], context: nil)
    }
    //监听变化
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "yearIndex" || keyPath == "monthIndex"{
            
            let days = self.days(year_num: self.yearArray[yearIndex], month_num: self.monthArray[monthIndex])
            if days > 0 {
                self.dayArray = serial(from: 1, to: days+1, polish: false)
            }
            self.datePicker.reloadAllComponents()
        }
    }
    //移除监听
    private func removeKVC() -> Void{
        self.removeObserver(self, forKeyPath: "yearIndex")
        self.removeObserver(self, forKeyPath: "monthIndex")
    }
    //控制器销毁
    deinit {
        self.removeKVC()
    }
}
