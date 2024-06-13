import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'zh_Hans'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? zh_HansText = '',
  }) =>
      [enText, zh_HansText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final language = locale.toString();
    return FFLocalizations.languages().contains(
      language.endsWith('_')
          ? language.substring(0, language.length - 1)
          : language,
    );
  }

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // login
  {
    't9iesyjp': {
      'en': 'Better Face ',
      'zh_Hans': '',
    },
    '2x5zrqyf': {
      'en': 'Welcome Back',
      'zh_Hans': '',
    },
    '63a40y0z': {
      'en': 'Let\'s get started by filling out the form below.',
      'zh_Hans': '',
    },
    'jxdev8q2': {
      'en': 'Email',
      'zh_Hans': '',
    },
    'z495ti27': {
      'en': 'Password',
      'zh_Hans': '',
    },
    '27q9vkoh': {
      'en': 'Sign In',
      'zh_Hans': '',
    },
    '7eerhnfc': {
      'en': 'Forgot password',
      'zh_Hans': '',
    },
    'md78rohg': {
      'en': 'Don\'t have an account? ',
      'zh_Hans': '',
    },
    'c9vu28vq': {
      'en': ' Sign Up here',
      'zh_Hans': '',
    },
    '0af89p4b': {
      'en': 'Home',
      'zh_Hans': '',
    },
  },
  // Dashboard
  {
    'jsjqivto': {
      'en': 'Dashboard',
      'zh_Hans': '',
    },
    'uo7wat8i': {
      'en': 'Better Face ',
      'zh_Hans': '',
    },
    'pbva7no2': {
      'en': 'Facial Emotion Recognition',
      'zh_Hans': '',
    },
    '06bhlwsa': {
      'en': 'Facial Muscle Movement Training ',
      'zh_Hans': '',
    },
    'oc63rl5q': {
      'en': 'Facial Emotion Recovery Training',
      'zh_Hans': '',
    },
    'nudr36g5': {
      'en': 'To-Do Task',
      'zh_Hans': '',
    },
    'wdfcukqo': {
      'en': 'Completed Task',
      'zh_Hans': '',
    },
    '4fbgw6xy': {
      'en': 'Setting',
      'zh_Hans': '',
    },
    'w0526wb3': {
      'en': 'Log Out',
      'zh_Hans': '',
    },
    'nbq42qhp': {
      'en': 'Home',
      'zh_Hans': '',
    },
  },
  // Signup
  {
    'qf1r0a40': {
      'en': 'Better Face ',
      'zh_Hans': '',
    },
    'xmekojbs': {
      'en': 'Create an account',
      'zh_Hans': '',
    },
    'csu8a0aq': {
      'en': 'Let\'s get started by filling out the form below.',
      'zh_Hans': '',
    },
    'vfullzal': {
      'en': 'Username',
      'zh_Hans': '',
    },
    'g18d4wxu': {
      'en': 'Email',
      'zh_Hans': '',
    },
    '2ijf5txo': {
      'en': 'Phone Number',
      'zh_Hans': '',
    },
    'qstn3fhq': {
      'en': 'Password',
      'zh_Hans': '',
    },
    'f0fl4660': {
      'en': 'Confirm Password',
      'zh_Hans': '',
    },
    '1igg9iki': {
      'en': 'I agree to the terms of service \nand privacy policy.',
      'zh_Hans': '',
    },
    'hb8zq4vo': {
      'en': 'Create Account',
      'zh_Hans': '',
    },
    'sp5i8xsm': {
      'en': 'Already have an account? ',
      'zh_Hans': '',
    },
    '9y36w755': {
      'en': 'Sign In',
      'zh_Hans': '',
    },
    '3ez6wczi': {
      'en': 'Already have an account? ',
      'zh_Hans': '',
    },
  },
  // ForgetPassword
  {
    'rg0nks2l': {
      'en': 'Better Face ',
      'zh_Hans': '',
    },
    'zp2w17st': {
      'en': 'Back',
      'zh_Hans': '',
    },
    's4f4wtti': {
      'en':
          'We will send you an email with a link to reset your password, please enter the email associated with your account below.',
      'zh_Hans': '',
    },
    '6nqsf40f': {
      'en': 'Your email address...',
      'zh_Hans': '',
    },
    '9vzs67tl': {
      'en': 'Enter your email...',
      'zh_Hans': '',
    },
    'jeewx8a3': {
      'en': 'Send Link',
      'zh_Hans': '',
    },
    'uuthn8dx': {
      'en': 'Forgot Password',
      'zh_Hans': '',
    },
    'rpa2q2e7': {
      'en': 'Home',
      'zh_Hans': '',
    },
  },
  // CheckEmail
  {
    'dkbv2b86': {
      'en': 'Check your email',
      'zh_Hans': '',
    },
    '0br0lego': {
      'en':
          'The instruction for password reset is sent to your email. Please have a look.',
      'zh_Hans': '',
    },
    'dv43i894': {
      'en': 'Go to Login',
      'zh_Hans': '',
    },
  },
  // Relaxing1
  {
    'f9pkrifw': {
      'en': 'Facial Muscle \nMovement Training',
      'zh_Hans': '',
    },
    '0x2e8g92': {
      'en': 'Better Face ',
      'zh_Hans': '',
    },
    'x3nhr3pt': {
      'en':
          'Take some time to relax your facial muscle, \nyou will feel  comfortable.',
      'zh_Hans': '',
    },
    'sgvzosec': {
      'en': 'Method 1: Happy Face',
      'zh_Hans': '',
    },
    '9wdxh0l3': {
      'en':
          '1. Smile as wide as you can.\n2. Hold for 5 seconds and then relax. \n3. Do 10 repetitions per set.',
      'zh_Hans': '',
    },
    'ks5b0ojq': {
      'en': 'Method 2: Slack Jaw',
      'zh_Hans': '',
    },
    'b0d75255': {
      'en':
          '1. Let your jaw fully relax and your mouth hang open. \n2. Bring the tip of your tongue to the highest point of the roof of your mouth. \n3. Hold this position for 5 seconds and then ease your jaw back into a resting closed mouth position. \n4. Do 10 repititions per set.',
      'zh_Hans': '',
    },
    'g8x4ifk4': {
      'en': 'Next',
      'zh_Hans': '',
    },
    '5un412fp': {
      'en': 'Home',
      'zh_Hans': '',
    },
  },
  // Relaxing2
  {
    'eeybftxi': {
      'en': 'Facial Muscle \nMovement Training',
      'zh_Hans': '',
    },
    'zaqwxzaa': {
      'en': 'Better Face ',
      'zh_Hans': '',
    },
    'a1ts5xxb': {
      'en':
          'Take some time to relax your facial muscle, \nyou will feel  comfortable.',
      'zh_Hans': '',
    },
    'pfn0uhe1': {
      'en': 'Method 3: Brow Furrow',
      'zh_Hans': '',
    },
    'wcan8og0': {
      'en':
          '1. Wrinkle your forehead by arching your eyebrows as high as possible. \n2. Hold this position for a 15 seconds, and then relax. \n3. Do 3 repititions per set.',
      'zh_Hans': '',
    },
    'pr4nef1t': {
      'en': 'Method 4: Eye Squeeze',
      'zh_Hans': '',
    },
    'zp00y0mj': {
      'en':
          '1. Close your eyes tightly.\n2. Hold this position for 20 seconds. \n3. Then, make your eyes go blank.\n4. Completely relax all the little muscles around your eyes.\n5. Stare expressionless for 15 seconds. \n6. Do 3 repititions per set.',
      'zh_Hans': '',
    },
    '576x5gmc': {
      'en': 'Previous',
      'zh_Hans': '',
    },
    '8oj8kxq6': {
      'en': 'Next',
      'zh_Hans': '',
    },
    '89052y5l': {
      'en': 'Home',
      'zh_Hans': '',
    },
  },
  // Relaxing3
  {
    'r6i95r8s': {
      'en': 'Facial Muscle \nMovement Training',
      'zh_Hans': '',
    },
    '29fgvjr3': {
      'en': 'Better Face ',
      'zh_Hans': '',
    },
    'q4roexbx': {
      'en':
          'Take some time to relax your facial muscle, \nyou will feel  comfortable.\nThis section requires your hand\nfor facial massage.',
      'zh_Hans': '',
    },
    'ir1cyhjb': {
      'en': 'Method 1: ',
      'zh_Hans': '',
    },
    'iv65klqe': {
      'en':
          '1. Using your hand, gently massage the muscle around the forehead.\n2. Do it for 30 seconds.',
      'zh_Hans': '',
    },
    '6jhvvw0x': {
      'en': 'Method 2:',
      'zh_Hans': '',
    },
    'iz5hv1yh': {
      'en':
          '1. Using your index finger, gently massage along the line of your jaw to the chin.\n2. Then up the opposite side along the jaw line. \n3. You can gently rub your fingers over any areas which feel tight or lumpy. \n4. Use a circular motion with your fingers.\n5. Do it for 45 seconds.',
      'zh_Hans': '',
    },
    'v8ibk1tp': {
      'en': 'Previous',
      'zh_Hans': '',
    },
    'bndyw77c': {
      'en': 'Back',
      'zh_Hans': '',
    },
    'rk4fcbxf': {
      'en': 'Home',
      'zh_Hans': '',
    },
  },
  // EmotionTraining
  {
    '6cp6v9qn': {
      'en': 'Facial Emotion \nRecovery Training',
      'zh_Hans': '',
    },
    'qxomzvi4': {
      'en': 'Better Face ',
      'zh_Hans': '',
    },
    'hbnv62xv': {
      'en': 'Welcome to Facial Emotion Training!\nEnjoy & Have FUN!',
      'zh_Hans': '',
    },
    '3r6fg7cj': {
      'en':
          '---------------------------------------------------------------------------------\nGentle Reminder: \nRelax your facial muscle before emotion training.\n---------------------------------------------------------------------------------',
      'zh_Hans': '',
    },
    'q0q01a70': {
      'en': 'Click the Relax button for exercise',
      'zh_Hans': '',
    },
    'e9ipupt8': {
      'en': 'Relax',
      'zh_Hans': '',
    },
    '0o5ixzhq': {
      'en': 'There are SIX types of facial emotions:',
      'zh_Hans': '',
    },
    'dz0306kz': {
      'en': 'HAPPY',
      'zh_Hans': '',
    },
    's86ovo5u': {
      'en': 'SAD',
      'zh_Hans': '',
    },
    'st1pwiq0': {
      'en': 'SURPRISE',
      'zh_Hans': '',
    },
    'j5znlnif': {
      'en': 'ANGRY',
      'zh_Hans': '',
    },
    's1bsaekk': {
      'en': 'FEAR',
      'zh_Hans': '',
    },
    'zrz2yidv': {
      'en': 'DISGUST',
      'zh_Hans': '',
    },
    '2rodc9qf': {
      'en': 'Home',
      'zh_Hans': '',
    },
  },
  // HappyT
  {
    'kuzo36ub': {
      'en': 'Happy',
      'zh_Hans': '',
    },
    '6ywd6bee': {
      'en': 'Better Face ',
      'zh_Hans': '',
    },
    'it0uay2u': {
      'en':
          'Happy is the facial emotion that shows \nyou are feeling pleasant and contentment.',
      'zh_Hans': '',
    },
    '8vb7g7pz': {
      'en':
          'Hints:\n1. Tightened muscles around the eyes. \n2. “Crow’s feet” wrinkles around the eyes.\n3. Raised cheeks.\n4. Raised lip corner diagonally.\n5. Either show your teeth or not.',
      'zh_Hans': '',
    },
    'xa0y7yzj': {
      'en':
          '*************************************************\nYou are doing great. \nLet\'s evaluate your emotion now.\n*************************************************',
      'zh_Hans': '',
    },
    'tgrg6grf': {
      'en': 'Test',
      'zh_Hans': '',
    },
    'xp9fvpyc': {
      'en': 'Home',
      'zh_Hans': '',
    },
  },
  // SadT
  {
    '5x7wtxw7': {
      'en': 'Sad',
      'zh_Hans': '',
    },
    'ab0ot9pa': {
      'en': 'Better Face ',
      'zh_Hans': '',
    },
    'mposinai': {
      'en':
          'Sad is the facial emotion that shows \nyou are feeling unhappiness and low mood.',
      'zh_Hans': '',
    },
    'eyanvobp': {
      'en':
          'Hints:\n1. Raised inner corners of the eyes.\n2. Loose eyelids.\n3. Pulled down lip corners.',
      'zh_Hans': '',
    },
    'pzsfozkn': {
      'en':
          '*************************************************\nYou are doing great. \nLet\'s evaluate your emotion now.\n*************************************************',
      'zh_Hans': '',
    },
    'uxi7ohjv': {
      'en': 'Test',
      'zh_Hans': '',
    },
    'wma7sh7t': {
      'en': 'Home',
      'zh_Hans': '',
    },
  },
  // SurpriseT
  {
    'lq1cksmd': {
      'en': 'Surprise',
      'zh_Hans': '',
    },
    'lavfrqv7': {
      'en': 'Better Face ',
      'zh_Hans': '',
    },
    'z166fbgz': {
      'en':
          'Surprise is the facial emotion when you \nencounter unexpected sounds or movement.\nThis emotion can last at most a few seconds.',
      'zh_Hans': '',
    },
    'czva68rr': {
      'en':
          'Hints:\n1. Dilated pupils.\n2. Open mouth.\n3. Lifted eyelids and eyebrows. ',
      'zh_Hans': '',
    },
    'vzkz8zn7': {
      'en':
          '*************************************************\nYou are doing great. \nLet\'s evaluate your emotion now.\n*************************************************',
      'zh_Hans': '',
    },
    '8ddo4ke2': {
      'en': 'Test',
      'zh_Hans': '',
    },
    '9i7x5gnw': {
      'en': 'Home',
      'zh_Hans': '',
    },
  },
  // AngryT
  {
    'zfpej5y7': {
      'en': 'Angry',
      'zh_Hans': '',
    },
    'kc7ysymo': {
      'en': 'Better Face ',
      'zh_Hans': '',
    },
    '9cdbpgjp': {
      'en':
          'Angry  is the facial emotion when you \nfeel antagonistic toward someone or \nsomething that you believe is intentionally hurting you.',
      'zh_Hans': '',
    },
    'aj3esswz': {
      'en':
          'Hints:\n1. Tightened lip.\n2. Rolled in lips margins.\n3. Pulled down eyebrows.\n4. Pulled up eyelids. ',
      'zh_Hans': '',
    },
    'ubmlhwik': {
      'en':
          '*************************************************\nYou are doing great. \nLet\'s evaluate your emotion now.\n*************************************************',
      'zh_Hans': '',
    },
    'iwq38byw': {
      'en': 'Test',
      'zh_Hans': '',
    },
    '285hrw7l': {
      'en': 'Home',
      'zh_Hans': '',
    },
  },
  // FearT
  {
    '3t7d2byn': {
      'en': 'Fear',
      'zh_Hans': '',
    },
    '2k1uwze4': {
      'en': 'Better Face ',
      'zh_Hans': '',
    },
    '0rei95ox': {
      'en': 'Fear is the facial emotion when you \nfeel danger or unsafe. ',
      'zh_Hans': '',
    },
    'j1zltglm': {
      'en':
          'Hints:\n1. Stretched mouth.\n2. Lifted eyelids\n3. Lifted eyebrows.',
      'zh_Hans': '',
    },
    'ixge6i7a': {
      'en':
          '*************************************************\nYou are doing great. \nLet\'s evaluate your emotion now.\n*************************************************',
      'zh_Hans': '',
    },
    'q4h2obut': {
      'en': 'Test',
      'zh_Hans': '',
    },
    'sc4ixdte': {
      'en': 'Home',
      'zh_Hans': '',
    },
  },
  // DisgustT
  {
    '8nwr9fkl': {
      'en': 'Disgust',
      'zh_Hans': '',
    },
    '6raq1xos': {
      'en': 'Better Face ',
      'zh_Hans': '',
    },
    'g17zlj9e': {
      'en':
          'Disgust is the facial emotion when you \nfeel revulsion or the response of aversion  \nto something unpleasant or offensive.',
      'zh_Hans': '',
    },
    'g09u54re': {
      'en':
          'Hints:\n1. Wrinkled nose.\n2. Pulled down yebrows \n3. Loose lips\n4. Pulled up upper lip',
      'zh_Hans': '',
    },
    '8d3hvs58': {
      'en':
          '*************************************************\nYou are doing great. \nLet\'s evaluate your emotion now.\n*************************************************',
      'zh_Hans': '',
    },
    '2mceaqi9': {
      'en': 'Test',
      'zh_Hans': '',
    },
    'jxooc9da': {
      'en': 'Home',
      'zh_Hans': '',
    },
  },
  // ToDoTask
  {
    'lmu9ng2d': {
      'en': 'To-Do Task',
      'zh_Hans': '',
    },
    '1qllr1rs': {
      'en': 'Better Face ',
      'zh_Hans': '',
    },
  },
  // CompletedTask
  {
    'ho9bvk8b': {
      'en': 'Completed Task',
      'zh_Hans': '',
    },
    '9xlknrx3': {
      'en': 'Better Face ',
      'zh_Hans': '',
    },
  },
  // EmotionDetection
  {
    'dl7m2bo5': {
      'en': 'Facial Emotion Detection',
      'zh_Hans': '',
    },
    '14rrose8': {
      'en': 'Camera / Gallery',
      'zh_Hans': '',
    },
    'tzu4xco1': {
      'en': 'Home',
      'zh_Hans': '',
    },
  },
  // CreateTask
  {
    '6z7wwlnq': {
      'en': 'Create Task',
      'zh_Hans': '',
    },
    'eg4f3tck': {
      'en': 'Title...',
      'zh_Hans': '',
    },
    '7tm4nrp5': {
      'en': 'Details...',
      'zh_Hans': '',
    },
    '5wo9gm5j': {
      'en': 'Create Task',
      'zh_Hans': '',
    },
  },
  // Miscellaneous
  {
    '6vj5fftf': {
      'en': '',
      'zh_Hans': '',
    },
    'ahnym5gy': {
      'en': '',
      'zh_Hans': '',
    },
    '63tn1iu0': {
      'en':
          'To take your photo, this app requires the permission to access your camera',
      'zh_Hans': '',
    },
    '4981uo75': {
      'en':
          'To upload the media, this app requires the permission to access your photo library',
      'zh_Hans': '',
    },
    '3qjbllyg': {
      'en': '',
      'zh_Hans': '',
    },
    'c4d167mq': {
      'en': '',
      'zh_Hans': '',
    },
    'f74682km': {
      'en': '',
      'zh_Hans': '',
    },
    '92iwcpz7': {
      'en': '',
      'zh_Hans': '',
    },
    'jn5ldx7c': {
      'en': '',
      'zh_Hans': '',
    },
    'cnxbqgzy': {
      'en': '',
      'zh_Hans': '',
    },
    'hni9iica': {
      'en': '',
      'zh_Hans': '',
    },
    'mdfb015p': {
      'en': '',
      'zh_Hans': '',
    },
    'ynj5q6by': {
      'en': '',
      'zh_Hans': '',
    },
    'r7mylzr0': {
      'en': '',
      'zh_Hans': '',
    },
    'op2wpsy1': {
      'en': '',
      'zh_Hans': '',
    },
    'svqi5o9z': {
      'en': '',
      'zh_Hans': '',
    },
    '6gzy6ge4': {
      'en': '',
      'zh_Hans': '',
    },
    'uicw0joh': {
      'en': '',
      'zh_Hans': '',
    },
    'm6vs1kyn': {
      'en': '',
      'zh_Hans': '',
    },
    'pmkqbjz1': {
      'en': '',
      'zh_Hans': '',
    },
    'jp54io73': {
      'en': '',
      'zh_Hans': '',
    },
    'y1fyjcec': {
      'en': '',
      'zh_Hans': '',
    },
    '0rjuye81': {
      'en': '',
      'zh_Hans': '',
    },
    '55r1xl0f': {
      'en': '',
      'zh_Hans': '',
    },
    'bumgjruo': {
      'en': '',
      'zh_Hans': '',
    },
    'cs888pod': {
      'en': '',
      'zh_Hans': '',
    },
    'en6zsamm': {
      'en': '',
      'zh_Hans': '',
    },
    '7dem2ms1': {
      'en': '',
      'zh_Hans': '',
    },
    'lpmqsf4z': {
      'en': '',
      'zh_Hans': '',
    },
  },
].reduce((a, b) => a..addAll(b));
