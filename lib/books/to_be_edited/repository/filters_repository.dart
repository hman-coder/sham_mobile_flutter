import 'package:sham_mobile/models/age_group.dart';
import 'package:sham_mobile/models/author.dart';
import 'package:sham_mobile/models/category.dart';

class FiltersRepository {
  List<Category> get categories => [
    Category(name: 'رعب'),
    Category(name: 'روايات'),
    Category(name: 'أدب روسي'),
    Category(name: 'تنمية بشرية'),
    Category(name: 'تطوير ذاتي')
  ];

  List<AgeGroup> get ageGroups => [
    AgeGroup.adolescents(),
    AgeGroup.adults(),
    AgeGroup.aged(),
    AgeGroup.teens(),
    AgeGroup.kids(),
    AgeGroup.midLife(),
  ];

  List<Category> get specialCategories => [
    Category(name: 'يغير نظرتك للناس على الفور'),
    Category(name: 'ستصبح ثرياً بعد قراءته'),
    Category(name: 'ستقرؤه أكثر من مرة'),
    Category(name: 'سيغير منظورك للحياة'),
  ];

  List<Author> get authors => [
    Author(name: 'فيدور دوستويفسكي'),
    Author(name: 'آلان وباربارا بييز'),
    Author(name: 'توماس هارف إيكر'),
    Author(name: 'أوسكار وايلد'),
    Author(name: 'مارك مانسون'),
    Author(name: 'جوردان ب. بيترسون'),

  ];


}