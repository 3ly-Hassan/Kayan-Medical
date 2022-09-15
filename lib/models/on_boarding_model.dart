class OnBoardingModel {
  final String title, body, imgPath;

  OnBoardingModel(this.title, this.body, this.imgPath);
}

final onBoardingData = [
  OnBoardingModel(
    'ستجد كل ما تبحث عنه وتحتاجه\n هنا في مكان واحد',
    " هنا انت هتلاقي مجموعة كبيرة من المنتجات الطبية مصنفة تصنيف جيد يساعدك للوصول لما تحتاج بسهولة",
    'assets/images/sva1.svg',
  ),
  OnBoardingModel(
      'اسعار خاصة وتجارية',
      'اسعار خاصة للطاقم الطبي واسعار خاصة لاصحاب المحال التجارية وللكميات',
      'assets/images/payment.svg'),
  OnBoardingModel(
      'ادفع زي ما تحب',
      ' سهلنالك عملية الدفع بكذا طريقة وامكانية الدفع عند الاستلام ',
      'assets/images/paymentplus.svg'),
];
