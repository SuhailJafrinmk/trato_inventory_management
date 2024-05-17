class RegexUtils{
   final ageRegex =RegExp(r'^(1[0-4]\d|150|[1-9][0-9]|10)$');
   final phoneRegExp = RegExp(r'^[6-9]\d{9}$');
   final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
}