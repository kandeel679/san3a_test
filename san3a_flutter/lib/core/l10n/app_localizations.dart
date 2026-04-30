import 'package:flutter/material.dart';

/// Centralized localization for San3a — supports English and Arabic.
///
/// Usage:
///   final t = AppLocalizations.of(context);
///   Text(t.translate('welcome'))
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('ar'),
  ];

  // ─── String Maps ────────────────────────────────────────────────────

  static const Map<String, Map<String, String>> _localizedValues = {
    'en': _en,
    'ar': _ar,
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }

  // Convenience getters for very common strings
  String get appName => translate('appName');

  // ─── English ────────────────────────────────────────────────────────

  static const Map<String, String> _en = {
    // General
    'appName': 'San3a',
    'next': 'Next',
    'skip': 'Skip',
    'verify': 'Verify',
    'cancel': 'Cancel',
    'save': 'Save',
    'done': 'Done',
    'ok': 'OK',
    'error': 'Error',
    'success': 'Success',
    'loading': 'Loading...',
    'noResults': 'No results found',
    'all': 'All',
    'offers': 'offers',

    // Splash
    'san3aArabic': 'صنعة',

    // Onboarding
    'onboardingTitle1': 'Find the Right Service',
    'onboardingDesc1':
        'Browse services from verified craftsmen in your area. From plumbing to painting, we\'ve got you covered.',
    'onboardingTitle2': 'Get Competitive Offers',
    'onboardingDesc2':
        'Receive multiple offers from skilled professionals. Compare prices and choose the best one for you.',
    'onboardingTitle3': 'Quality Guaranteed',
    'onboardingDesc3':
        'Rate your experience and help build a trusted community of service providers.',
    'getStarted': 'Get Started',

    // Login / Register
    'welcomeToSan3a': 'Welcome to San3a',
    'enterPhoneToStart': 'Enter your phone number to get started',
    'phoneNumber': 'Phone Number',
    'phoneHint': '+20 1XX XXX XXXX',
    'sendOtp': 'Send OTP',
    'phoneRequired': 'Phone number is required',
    'invalidPhone': 'Invalid phone number',
    'termsNotice': 'By continuing, you agree to our Terms of Service',

    // OTP
    'verification': 'Verification',
    'enterOtpCode': 'Enter the 4-digit code sent to',
    'resendCode': 'Resend Code',

    // Account Setup
    'accountType': 'Account Type',
    'selectServices': 'Select Services',
    'yourLocation': 'Your Location',
    'personalInfo': 'Personal Info',
    'showcaseWork': 'Showcase Your Work',
    'uploadNationalId': 'Upload National ID',
    'allDone': 'All Done!',
    'whatAccountType': 'What type of account?',
    'chooseHowToUse': 'Choose how you want to use San3a',
    'customer': 'Customer',
    'customerDesc': 'I need to hire service providers',
    'craftsman': 'Craftsman',
    'craftsmanDesc': 'I provide services and want to get jobs',
    'whatServicesOffer': 'What services do you offer?',
    'whatServicesLooking': 'What services are you looking for?',
    'whereLocated': 'Where are you located?',
    'governorate': 'Governorate',
    'city': 'City',
    'addressDetails': 'Address Details',
    'addressHint': 'Building, street, etc.',
    'personalInformation': 'Personal Information',
    'fullName': 'Full Name',
    'showcaseYourWork': 'Showcase Your Work',
    'addPhotosDesc': 'Add photos and describe your expertise (optional)',
    'addPhotos': 'Add Photos',
    'workDescription': 'Work Description',
    'workDescHint': 'Describe your experience and skills',
    'verifyIdentity': 'Verify Your Identity',
    'uploadIdDesc': 'Upload your national ID for verification (optional)',
    'nationalIdFront': 'National ID Front',
    'nationalIdBack': 'National ID Back',
    'youreAllSet': 'You\'re All Set!',
    'accountCreated':
        'Your account has been created successfully. Start exploring San3a!',
    'startUsingSan3a': 'Start Using San3a',

    // Services
    'plumbing': 'Plumbing',
    'electrical': 'Electrical',
    'painting': 'Painting',
    'tiling': 'Tiling',
    'locksmith': 'Locksmith',
    'applianceRepair': 'Appliance Repair',

    // Governorates & cities
    'cairo': 'Cairo',
    'giza': 'Giza',
    'alexandria': 'Alexandria',
    'qalyubia': 'Qalyubia',

    // Customer Home
    'goodMorning': 'Good Morning',
    'goodAfternoon': 'Good Afternoon',
    'goodEvening': 'Good Evening',
    'searchService': 'Search for a service...',
    'mostRequested': 'Most Requested',
    'findWhatYouNeed': 'Find What You Need',
    'results': 'Results',
    'whatNeedHelp': 'What do you need help with?',
    'describeProblem': 'Describe the problem',
    'whereAreYou': 'Where are you?',
    'address': 'Address',
    'addPhotosOptional': 'Add photos (optional)',
    'tapToAddPhotos': 'Tap to add photos',
    'createRequest': 'Create Request',
    'requestCreated': 'Request created!',
    'becomeACraftsman': 'Become a Craftsman',
    'adTitle': 'Got a Skill? Start Earning!',
    'adCaption': 'Create your craftsman account and get job requests',
    'describe': 'Describe...',

    // Provider Home
    'yourStats': 'Your Stats',
    'recentJobs': 'Recent Plumbing Jobs',
    'availableJobs': 'Available Jobs',
    'noJobsCategory': 'No jobs for this category',

    // Request List
    'availableRequests': 'Available Requests',
    'plumbingIssue': 'Plumbing Issue',
    'downtownCairo': 'Downtown Cairo - Needs fixing ASAP',
    'sendOffer': 'Send Offer',

    // My Requests
    'myRequests': 'My Requests',
    'noRequestsYet': 'No requests yet',

    // Messages
    'messages': 'Messages',
    'noMessagesYet': 'No messages yet',

    // Notifications
    'notifications': 'Notifications',
    'markAllRead': 'Mark all read',

    // Chat
    'chat': 'Chat',
    'typeMessage': 'Type a message',
    'typeMessageDots': 'Type a message...',

    // AI Chatbot
    'aiAssistant': 'AI Assistant',
    'aiGreeting':
        'Hello! I am the San3a AI assistant. How can I help you find the right service today?',

    // Service Request
    'describeYourProblem': 'Describe your problem:',
    'description': 'Description',
    'locationDetails': 'Location Details:',
    'location': 'Location',
    'aiPriceRecommendation': 'AI Price Recommendation',
    'getAiPriceEstimate': 'Get AI Price Estimate',
    'submitRequest': 'Submit Request',
    'serviceRequestSubmitted': 'Service Request Submitted!',

    // Negotiation
    'aiNegotiation': 'AI Negotiation',
    'currentProviderOffer': 'Current Provider Offer:',
    'enterTargetPrice': 'Enter your target price:',
    'targetPrice': 'Target Price (EGP)',
    'aiCounterOffer': 'AI Counter Offer:',
    'acceptOffer': 'Accept Offer',
    'offerAccepted': 'Offer Accepted!',
    'letAiNegotiate': 'Let AI Negotiate',

    // Admin
    'adminOverview': 'Admin Overview',
    'platformStats': 'Platform Statistics and Overview',

    // More / Settings
    'account': 'Account',
    'profileSettings': 'Profile Settings',
    'myServices': 'My Services',
    'myLocation': 'My Location',
    'preferences': 'Preferences',
    'language': 'Language',
    'english': 'English',
    'arabic': 'العربية',
    'darkMode': 'Dark Mode',
    'support': 'Support',
    'helpCenter': 'Help Center',
    'aboutSan3a': 'About San3a',
    'logOut': 'Log Out',

    // Bottom Navigation
    'home': 'Home',
    'jobs': 'Jobs',
    'requests': 'Requests',
    'more': 'More',

    // Status labels
    'ongoing': 'ONGOING',
    'completed': 'COMPLETED',
    'cancelled': 'CANCELLED',
  };

  // ─── Arabic ─────────────────────────────────────────────────────────

  static const Map<String, String> _ar = {
    // General
    'appName': 'صنعة',
    'next': 'التالي',
    'skip': 'تخطي',
    'verify': 'تحقق',
    'cancel': 'إلغاء',
    'save': 'حفظ',
    'done': 'تم',
    'ok': 'حسناً',
    'error': 'خطأ',
    'success': 'نجاح',
    'loading': 'جاري التحميل...',
    'noResults': 'لا توجد نتائج',
    'all': 'الكل',
    'offers': 'عروض',

    // Splash
    'san3aArabic': 'صنعة',

    // Onboarding
    'onboardingTitle1': 'اعثر على الخدمة المناسبة',
    'onboardingDesc1':
        'تصفح الخدمات من حرفيين موثوقين في منطقتك. من السباكة إلى الدهان، نحن نغطي كل شيء.',
    'onboardingTitle2': 'احصل على عروض تنافسية',
    'onboardingDesc2':
        'استلم عروض متعددة من محترفين ماهرين. قارن الأسعار واختر الأفضل لك.',
    'onboardingTitle3': 'جودة مضمونة',
    'onboardingDesc3':
        'قيّم تجربتك وساعد في بناء مجتمع موثوق من مقدمي الخدمات.',
    'getStarted': 'ابدأ الآن',

    // Login / Register
    'welcomeToSan3a': 'أهلاً بك في صنعة',
    'enterPhoneToStart': 'أدخل رقم هاتفك للبدء',
    'phoneNumber': 'رقم الهاتف',
    'phoneHint': '+20 1XX XXX XXXX',
    'sendOtp': 'إرسال رمز التحقق',
    'phoneRequired': 'رقم الهاتف مطلوب',
    'invalidPhone': 'رقم هاتف غير صالح',
    'termsNotice': 'بالمتابعة، أنت توافق على شروط الخدمة الخاصة بنا',

    // OTP
    'verification': 'التحقق',
    'enterOtpCode': 'أدخل الرمز المكون من 4 أرقام المرسل إلى',
    'resendCode': 'إعادة إرسال الرمز',

    // Account Setup
    'accountType': 'نوع الحساب',
    'selectServices': 'اختر الخدمات',
    'yourLocation': 'موقعك',
    'personalInfo': 'المعلومات الشخصية',
    'showcaseWork': 'اعرض أعمالك',
    'uploadNationalId': 'رفع بطاقة الهوية',
    'allDone': 'تم بنجاح!',
    'whatAccountType': 'ما نوع الحساب؟',
    'chooseHowToUse': 'اختر كيف تريد استخدام صنعة',
    'customer': 'عميل',
    'customerDesc': 'أحتاج لتوظيف مقدمي خدمات',
    'craftsman': 'حرفي',
    'craftsmanDesc': 'أقدم خدمات وأريد الحصول على طلبات عمل',
    'whatServicesOffer': 'ما الخدمات التي تقدمها؟',
    'whatServicesLooking': 'ما الخدمات التي تبحث عنها؟',
    'whereLocated': 'أين موقعك؟',
    'governorate': 'المحافظة',
    'city': 'المدينة',
    'addressDetails': 'تفاصيل العنوان',
    'addressHint': 'المبنى، الشارع، إلخ.',
    'personalInformation': 'المعلومات الشخصية',
    'fullName': 'الاسم الكامل',
    'showcaseYourWork': 'اعرض أعمالك',
    'addPhotosDesc': 'أضف صور ووصف لخبرتك (اختياري)',
    'addPhotos': 'إضافة صور',
    'workDescription': 'وصف العمل',
    'workDescHint': 'صف خبرتك ومهاراتك',
    'verifyIdentity': 'تحقق من هويتك',
    'uploadIdDesc': 'ارفع بطاقة الهوية للتحقق (اختياري)',
    'nationalIdFront': 'الوجه الأمامي للبطاقة',
    'nationalIdBack': 'الوجه الخلفي للبطاقة',
    'youreAllSet': 'أنت جاهز!',
    'accountCreated': 'تم إنشاء حسابك بنجاح. ابدأ باستكشاف صنعة!',
    'startUsingSan3a': 'ابدأ استخدام صنعة',

    // Services
    'plumbing': 'سباكة',
    'electrical': 'كهرباء',
    'painting': 'دهان',
    'tiling': 'بلاط',
    'locksmith': 'نجارة أقفال',
    'applianceRepair': 'إصلاح أجهزة',

    // Governorates & cities
    'cairo': 'القاهرة',
    'giza': 'الجيزة',
    'alexandria': 'الإسكندرية',
    'qalyubia': 'القليوبية',

    // Customer Home
    'goodMorning': 'صباح الخير',
    'goodAfternoon': 'مساء الخير',
    'goodEvening': 'مساء الخير',
    'searchService': 'ابحث عن خدمة...',
    'mostRequested': 'الأكثر طلباً',
    'findWhatYouNeed': 'اعثر على ما تحتاجه',
    'results': 'النتائج',
    'whatNeedHelp': 'بماذا تحتاج مساعدة؟',
    'describeProblem': 'صف المشكلة',
    'whereAreYou': 'أين أنت؟',
    'address': 'العنوان',
    'addPhotosOptional': 'أضف صور (اختياري)',
    'tapToAddPhotos': 'اضغط لإضافة صور',
    'createRequest': 'إنشاء طلب',
    'requestCreated': 'تم إنشاء الطلب!',
    'becomeACraftsman': 'كن حرفياً',
    'adTitle': 'عندك مهارة؟ ابدأ الكسب!',
    'adCaption': 'أنشئ حساب حرفي واحصل على طلبات عمل',
    'describe': 'وصف...',

    // Provider Home
    'yourStats': 'إحصائياتك',
    'recentJobs': 'أعمال السباكة الأخيرة',
    'availableJobs': 'الأعمال المتاحة',
    'noJobsCategory': 'لا توجد أعمال لهذه الفئة',

    // Request List
    'availableRequests': 'الطلبات المتاحة',
    'plumbingIssue': 'مشكلة سباكة',
    'downtownCairo': 'وسط القاهرة - يحتاج إصلاح فوري',
    'sendOffer': 'إرسال عرض',

    // My Requests
    'myRequests': 'طلباتي',
    'noRequestsYet': 'لا توجد طلبات بعد',

    // Messages
    'messages': 'الرسائل',
    'noMessagesYet': 'لا توجد رسائل بعد',

    // Notifications
    'notifications': 'الإشعارات',
    'markAllRead': 'تحديد الكل كمقروء',

    // Chat
    'chat': 'المحادثة',
    'typeMessage': 'اكتب رسالة',
    'typeMessageDots': 'اكتب رسالة...',

    // AI Chatbot
    'aiAssistant': 'المساعد الذكي',
    'aiGreeting':
        'مرحباً! أنا مساعد صنعة الذكي. كيف يمكنني مساعدتك في إيجاد الخدمة المناسبة اليوم؟',

    // Service Request
    'describeYourProblem': 'صف مشكلتك:',
    'description': 'الوصف',
    'locationDetails': 'تفاصيل الموقع:',
    'location': 'الموقع',
    'aiPriceRecommendation': 'توصية السعر بالذكاء الاصطناعي',
    'getAiPriceEstimate': 'احصل على تقدير سعر ذكي',
    'submitRequest': 'إرسال الطلب',
    'serviceRequestSubmitted': 'تم إرسال طلب الخدمة!',

    // Negotiation
    'aiNegotiation': 'التفاوض الذكي',
    'currentProviderOffer': 'عرض مقدم الخدمة الحالي:',
    'enterTargetPrice': 'أدخل السعر المطلوب:',
    'targetPrice': 'السعر المطلوب (ج.م)',
    'aiCounterOffer': 'العرض المضاد الذكي:',
    'acceptOffer': 'قبول العرض',
    'offerAccepted': 'تم قبول العرض!',
    'letAiNegotiate': 'دع الذكاء الاصطناعي يتفاوض',

    // Admin
    'adminOverview': 'نظرة عامة للمدير',
    'platformStats': 'إحصائيات ونظرة عامة على المنصة',

    // More / Settings
    'account': 'الحساب',
    'profileSettings': 'إعدادات الملف الشخصي',
    'myServices': 'خدماتي',
    'myLocation': 'موقعي',
    'preferences': 'التفضيلات',
    'language': 'اللغة',
    'english': 'English',
    'arabic': 'العربية',
    'darkMode': 'الوضع الداكن',
    'support': 'الدعم',
    'helpCenter': 'مركز المساعدة',
    'aboutSan3a': 'عن صنعة',
    'logOut': 'تسجيل الخروج',

    // Bottom Navigation
    'home': 'الرئيسية',
    'jobs': 'الأعمال',
    'requests': 'الطلبات',
    'more': 'المزيد',

    // Status labels
    'ongoing': 'جارٍ',
    'completed': 'مكتمل',
    'cancelled': 'ملغي',
  };
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
