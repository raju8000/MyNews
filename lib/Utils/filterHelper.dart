import 'package:my_news_task/model/ModelFilterValues.dart';

class FilterHelper{

  static List<ModelFilterValues> getCategory(){
    List<ModelFilterValues> list = <ModelFilterValues>[];
    list.add(new ModelFilterValues("Business","business"));
    list.add(new ModelFilterValues("Entertainment","entertainment"));
    list.add(new ModelFilterValues("General","general"));
    list.add(new ModelFilterValues("Health","health"));
    list.add(new ModelFilterValues("Science","science"));
    list.add(new ModelFilterValues("Sports","sports"));
    list.add(new ModelFilterValues("Technology","technology"));
    return list;
  }

  static List<ModelFilterValues> getCountryList(){
    List<ModelFilterValues> list = <ModelFilterValues>[];
    list.add(new ModelFilterValues("India","in"));
    list.add(new ModelFilterValues("United States","us"));
    list.add(new ModelFilterValues("United Arab Emirates","ae"));
    list.add(new ModelFilterValues("Argentina","ar"));
    list.add(new ModelFilterValues("Austria","at"));
    list.add(new ModelFilterValues("Australia","au"));
    list.add(new ModelFilterValues("Belgium","be"));
    list.add(new ModelFilterValues("Bulgaria","bg"));
    list.add(new ModelFilterValues("Brazil","br"));
    list.add(new ModelFilterValues("Morocco","ma"));

    return list;
  }
  static List<ModelFilterValues> getShortByItem(){
    List<ModelFilterValues> list = <ModelFilterValues>[];
    list.add(new ModelFilterValues("Recent First","publishedAt"));
    list.add(new ModelFilterValues("Popular","popularity"));
    list.add(new ModelFilterValues("Relevant","relevancy"));

    return list;
  }
}