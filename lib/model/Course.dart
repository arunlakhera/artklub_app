class Course{

  late String _courseNum;
  late String _courseName;
  late String _courseDesc;
  late String _courseMedium;
  late String _courseDuration;
  late String _bgImage;
  late String _cNumImage;
  late var _bgColor;

  Course({courseNum, courseName, courseDesc, courseMedium, courseDuration, bgImage, cNumImage, bgColor}){
    this._courseNum = courseNum;
    this._courseName = courseName;
    this._courseDesc = courseDesc;
    this._courseMedium = courseMedium;
    this._courseDuration = courseDuration;
    this._bgImage = bgImage;
    this._cNumImage = cNumImage;
    this._bgColor = bgColor;
  }

  getCourseNum(){
    return _courseNum;
  }

  getCourseName(){
    return _courseName;
  }

  getCourseDesc(){
    return _courseDesc;
  }

  getCourseMedium(){
    return _courseMedium;
  }

  getCourseDuration(){
    return _courseDuration;
  }

  getbgImage(){
    return _bgImage;
  }

  getcNumImage(){
    return _cNumImage;
  }

  getbgColor(){
    return _bgColor;
  }


}