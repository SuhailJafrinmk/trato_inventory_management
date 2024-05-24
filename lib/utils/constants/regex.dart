class RegexUtils{
   static final ageRegex =RegExp(r'^(1[0-4]\d|150|[1-9][0-9]|10)$');
   static final phoneRegExp = RegExp(r'^[6-9]\d{9}$');
   static final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
   static final username = RegExp(r'^[a-zA-Z0-9_]+$');
   static final specialChar=RegExp(r'[!@#$%^&*(),.?":{}|<>]');
   static final atLeastANumber=RegExp(r'[0-9]');
   static final atLeastAnUppercase=RegExp(r'[A-Z]');

}