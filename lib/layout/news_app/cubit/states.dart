abstract class NewsState{}
class NewsIntial extends NewsState{}
class NewsChangeBottomNav extends NewsState{}

class getBusinessApiDataLoading extends NewsState{}
class getBusinessApiDataSuccess extends NewsState{}
class getBusinessApiDataError extends NewsState{
  final String error;
  getBusinessApiDataError(this.error);
}
class getBusinessApiDataMoreLoading extends NewsState{}
class getBusinessApiDataMoreSuccess extends NewsState{}
class getBusinessApiDataMoreError extends NewsState{
  final String error;
  getBusinessApiDataMoreError(this.error);
}

class getSportsApiDataLoading extends NewsState{}
class getSportsApiDataSuccess extends NewsState{}
class getSportsApiDataError extends NewsState{
  final String error;
  getSportsApiDataError(this.error);
}
class getSportsApiDataMoreLoading extends NewsState{}
class getSportsApiDataMoreSuccess extends NewsState{}
class getSportsApiDataMoreError extends NewsState{
  final String error;
  getSportsApiDataMoreError(this.error);
}
class getScienceApiDataMoreLoading extends NewsState{}
class getScienceApiDataMoreSuccess extends NewsState{}
class getScienceApiDataMoreError extends NewsState{
  final String error;
  getScienceApiDataMoreError(this.error);
}

class getScienceApiDataLoading extends NewsState{}
class getScienceApiDataSuccess extends NewsState{}
class getScienceApiDataError extends NewsState{
  final String error;
  getScienceApiDataError(this.error);
}

class getSearchApiDataLoading extends NewsState{}
class getSearchApiDataSuccess extends NewsState{}
class getSearchApiDataError extends NewsState{
  final String error;
  getSearchApiDataError(this.error);
}
class ChangeMode extends NewsState{}
