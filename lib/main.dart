import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

StateProvider<int> pageIndexProvider = StateProvider<int>((ref) => 0);

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  static const Map<String, Widget> pages = {
    'ABOUT': About(),
    'PRIVACY-POLICY': PrivacyPolicy(),
    'ACCOUNT-DELETION': ContactUs(),
    'CSAE': CSAE(),
  };
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int index = ref.watch(pageIndexProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 800),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(width: 64, height: 64, 'assets/logo.webp'),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children:
                        pages.keys
                            .map(
                              (String text) => TextButton(
                                onPressed: () {
                                  ref.read(pageIndexProvider.notifier).state =
                                      pages.keys.toList().indexOf(text);
                                },
                                child: Text(text.toString()),
                              ),
                            )
                            .toList(),
                  ),
                  pages.values.toList()[index],
                  Text('Copyright © 2025 Polipulse - All Rights Reserved.'),
                  Column(children: [Text('Powered by')]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CSAE extends StatelessWidget {
  const CSAE({super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    var headStyle = Theme.of(
      context,
    ).textTheme.titleMedium?.copyWith(color: colorScheme.outline);

    var titleStyle = Theme.of(context).textTheme.titleLarge;

    var regularStyle = Theme.of(context).textTheme.titleSmall;
    var regularStyleWeight = regularStyle?.copyWith(
      fontWeight: FontWeight.w600,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(style: titleStyle, 'Child Safety Standards'),
                    Padding(
                      padding: const EdgeInsets.only(left: 4, top: 4),
                      child: Text(
                        'At POLIPULSE, the safety of children is our utmost priority. We have a zero-tolerance policy regarding child sexual abuse and exploitation (CSAE). We are committed to creating a safe environment for all users and take all necessary measures to prevent and address any instances of CSAE. ',
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(style: titleStyle, 'Our Commitment'),
                    Padding(
                      padding: const EdgeInsets.only(left: 4, top: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            style: regularStyle,
                            TextSpan(
                              children: [
                                TextSpan(
                                  style: regularStyleWeight,
                                  text: '• Prohibition of CSAE/CSAM:',
                                ),
                                TextSpan(
                                  text:
                                      ' We strictly prohibit the creation, distribution, or possession of child sexual abuse material (CSAM) within our app/platform.',
                                ),
                              ],
                            ),
                          ),
                          Text.rich(
                            style: regularStyle,
                            TextSpan(
                              children: [
                                TextSpan(
                                  style: regularStyleWeight,
                                  text: '• Reporting Mechanisms:',
                                ),
                                TextSpan(
                                  text:
                                      ' We provide clear and accessible mechanisms for users to report any suspected instances of CSAE. Users can report concerns by emailing us at: ',
                                ),
                                TextSpan(
                                  style: regularStyle?.copyWith(
                                    decoration: TextDecoration.underline,
                                  ),
                                  text: 'dev@polipulse.in',
                                ),
                              ],
                            ),
                          ),
                          Text.rich(
                            style: regularStyle,
                            TextSpan(
                              children: [
                                TextSpan(
                                  style: regularStyleWeight,
                                  text: '• Action Taken on Reports:',
                                ),
                                TextSpan(
                                  text:
                                      ' Upon receiving a report of suspected CSAE, we will immediately investigate the matter. We will take swift action, including removing offending content and blocking offending users. We will also cooperate fully with law enforcement agencies and report any suspected illegal activity.',
                                ),
                              ],
                            ),
                          ),
                          Text.rich(
                            style: regularStyle,
                            TextSpan(
                              children: [
                                TextSpan(
                                  style: regularStyleWeight,
                                  text: '• Compliance with Laws:',
                                ),
                                TextSpan(
                                  text:
                                      ' We are committed to complying with all applicable child protection laws and regulations, including [Mention specific laws relevant to your region, e.g., COPPA in the US, GDPR in Europe].',
                                ),
                              ],
                            ),
                          ),
                          Text.rich(
                            style: regularStyle,
                            TextSpan(
                              children: [
                                TextSpan(
                                  style: regularStyleWeight,
                                  text: '• Point of Contact:',
                                ),
                                TextSpan(
                                  text:
                                      ' For any questions or concerns regarding child safety, please contact our dedicated safety team at: ',
                                ),
                                TextSpan(
                                  style: regularStyle?.copyWith(
                                    decoration: TextDecoration.underline,
                                  ),
                                  text: 'dev@polipulse.in',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(style: titleStyle, 'Reporting Procedures '),
                    Padding(
                      padding: const EdgeInsets.only(left: 4, top: 4),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  'If you encounter any content or behavior that you believe may indicate CSAE, please report it immediately by sending an email to ',
                            ),
                            TextSpan(
                              style: regularStyle?.copyWith(
                                decoration: TextDecoration.underline,
                              ),
                              text: 'dev@polipulse.in',
                            ),
                            TextSpan(
                              text:
                                  '. Please provide as much detail as possible, including: ',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(style: regularStyleWeight, text: '  • '),
                          TextSpan(
                            text:
                                'The username of the offending user (if applicable).',
                          ),
                        ],
                      ),
                    ),

                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(style: regularStyleWeight, text: '  • '),
                          TextSpan(
                            text: 'A description of the content or behavior.',
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(style: regularStyleWeight, text: '  • '),
                          TextSpan(text: 'Any relevant screenshots or links.'),
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(style: regularStyleWeight, text: '  • '),
                          TextSpan(text: 'The date and time of the incident.'),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(style: titleStyle, 'Our Ongoing Efforts'),
                    Padding(
                      padding: const EdgeInsets.only(left: 4, top: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'We are continuously working to improve our safety measures and stay up-to-date with the latest best practices in child protection. We regularly review and update our policies and procedures to ensure the safety of our users.',
                          ),
                          Text(
                            'Thank you for helping us create a safe online environment.',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ]
              .map(
                (Widget widget) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: widget,
                ),
              )
              .toList(),
    );
  }
}

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    var headStyle = Theme.of(
      context,
    ).textTheme.titleMedium?.copyWith(color: colorScheme.outline);

    var titleStyle = Theme.of(context).textTheme.titleLarge;

    var regularStyle = Theme.of(context).textTheme.titleSmall;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          [
                Text("Privacy Policy", style: headStyle),
                Text.rich(
                  TextSpan(
                    style: regularStyle,
                    children: [
                      TextSpan(
                        text:
                            ' We don\'t directly collect any information from you other than your login info from google which is used to administer protected access to some of our content. This app does include google analytics which records anonymized browsing behaviour and used to improve the app design.',
                      ),
                      TextSpan(
                        style: regularStyle?.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                        text:
                            'How does this application access, use, store, or share Google user data?',
                      ),
                      TextSpan(
                        text:
                            'The only user data received is: name, email and profile picture. These are accessed via OAuth2 login. These are stored in an encrypted database. These are used only: to be re-displayed to the user, to reply to messages sent by the user, and as identification for granting access to additional content to the user.',
                      ),
                    ],
                  ),
                ),
                Text(
                  'The app does use third party services that may collect information used to identify the user. We collect information from your device in some cases. The information will be utilized for the provision of better service and to prevent fraudulent acts. Additionally, such information will not include that which will identify the individual user.',
                ),
                Text(
                  'By continuing to use this app, you accept this privacy policy in full. If you disagree with this policy, you must not use this login method.',
                ),
              ]
              .map(
                (Widget widget) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: widget,
                ),
              )
              .toList(),
    );
  }
}

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    var headStyle = Theme.of(
      context,
    ).textTheme.titleMedium?.copyWith(color: colorScheme.outline);

    var titleStyle = Theme.of(context).textTheme.titleLarge;

    var regularStyle = Theme.of(context).textTheme.titleSmall;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        var value = [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                [
                      Text(style: headStyle, 'CONTACT US'),
                      Text(style: titleStyle, 'Get in Touch!'),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Name'),
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Email'),
                        ),
                      ),
                      TextField(
                        maxLines: 3,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Message'),
                        ),
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                            ),
                          ),

                          onPressed: () {},
                          child: Text('SEND'),
                        ),
                      ),
                      Text(
                        'This site is protected by reCAPTCHA and the Google Privacy Policy and Terms of Service apply.',
                      ),
                    ]
                    .map(
                      (Widget widget) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: widget,
                      ),
                    )
                    .toList(),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(style: titleStyle, 'Questions or Comments'),
                          Text(
                            style: regularStyle,
                            'Send me a message or ask me a question using this form. I will do my best to get back to you soon!',
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(style: titleStyle, 'Polipulse'),
                          Text(
                            style: regularStyle,
                            'Gurugram, Haryana, India ',
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(style: titleStyle, 'Hours'),
                          Text(style: regularStyle, 'Mon–Fri: 9 AM – 6 PM'),
                        ],
                      ),
                    ]
                    .map(
                      (Widget widget) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: widget,
                      ),
                    )
                    .toList(),
          ),
        ];
        if (constraints.maxWidth <= 600) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children:
                value
                    .map(
                      (Widget widget) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        child: widget,
                      ),
                    )
                    .toList(),
          );
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:
              value
                  .map(
                    (Widget widget) => SizedBox(
                      width: (constraints.maxWidth / 2) - 16,
                      child: widget,
                    ),
                  )
                  .toList(),
        );
      },
    );
  }
}

class About extends ConsumerWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var colorScheme = Theme.of(context).colorScheme;
    var headStyle = Theme.of(
      context,
    ).textTheme.titleMedium?.copyWith(color: colorScheme.outline);
    var titleStyle = Theme.of(context).textTheme.titleLarge;
    var regularStyle = Theme.of(
      context,
    ).textTheme.titleMedium?.copyWith(color: colorScheme.outline);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    textAlign: TextAlign.justify,
                    style: headStyle,
                    'ABOUT POLIPULSE',
                  ),
                ),
                Center(
                  child: Text(style: titleStyle, 'Google OAuth2 Homepage'),
                ),
                Text.rich(
                  textAlign: TextAlign.justify,
                  style: regularStyle,

                  TextSpan(
                    children: [
                      TextSpan(
                        text: ' Accurately represents your app\'s identity',
                        style: regularStyle?.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(text: ': '),
                      TextSpan(
                        text:
                            'The PoliPulse App lets users search about leaders, give opinions on their work/performance, see current news. Users can also add performance metrics for leaders, compare different leaders data, etc.',
                      ),
                    ],
                  ),
                ),
                Text.rich(
                  textAlign: TextAlign.justify,
                  style: regularStyle,
                  TextSpan(
                    children: [
                      TextSpan(
                        text:
                            ' What will this app do with user data? The only user data received is',
                        style: regularStyle?.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(text: ': '),
                      TextSpan(
                        text:
                            'name, email and profile picture. These will be saved and re-displayed to the user. The email will be used to reply to messages sent by the user or to inform users about app enhancements, or ask them about the feedback. The email will be used to identify the user. Some users will be granted access to additional content.',
                      ),
                    ],
                  ),
                ),
                Text.rich(
                  textAlign: TextAlign.justify,
                  style: regularStyle,
                  TextSpan(
                    children: [
                      TextSpan(
                        text: ' How does this app enhance user functionality',
                        style: regularStyle?.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(text: '?'),
                      TextSpan(
                        text:
                            ' This app let users measure the perfomance of the elected leaders and give their opinions about the same.',
                      ),
                    ],
                  ),
                ),
                Text.rich(
                  textAlign: TextAlign.justify,
                  style: regularStyle,
                  TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Describe the content, context, or connection to the app',
                        style: regularStyle?.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(text: ': '),
                      TextSpan(
                        text:
                            'The PoliPulse app is mobile application on android, which empowers people to give their opinions about the elected leaders.',
                      ),
                    ],
                  ),
                ),
                Text.rich(
                  textAlign: TextAlign.justify,
                  TextSpan(
                    children: [
                      TextSpan(
                        style: regularStyle,
                        text: 'Link to Privacy Policy: ',
                      ),
                      TextSpan(
                        style: regularStyle?.copyWith(
                          decoration: TextDecoration.underline,
                        ),

                        text: 'Click here',
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                ref.read(pageIndexProvider.notifier).state = 1;
                              },
                      ),
                    ],
                  ),
                ),
                Text.rich(
                  textAlign: TextAlign.justify,
                  TextSpan(
                    children: [
                      TextSpan(style: regularStyle, text: 'Terms of Service: '),
                      TextSpan(
                        style: regularStyle?.copyWith(
                          decoration: TextDecoration.underline,
                        ),

                        text: 'Click here',
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Text(
                    style: titleStyle,
                    'Google OAuth2 Limited Use Disclosure',
                  ),
                ),
                Text(
                  textAlign: TextAlign.justify,
                  style: regularStyle,
                  'This app doesn\'t request restricted scopes, but if it did, the PoliPulse App\'s use of information received from Google APIs will adhere to the Google API Services User Data Policy , including the Limited Use requirements.',
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    textAlign: TextAlign.justify,
                    style: headStyle,
                    'PRIVACY POLICY',
                  ),
                ),
                Text.rich(
                  textAlign: TextAlign.justify,
                  style: regularStyle,
                  TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'We don\'t directly collect any information from you other than your login info from google which is used to administer protected access to some of our content. This app does include google analytics which records anonymized browsing behaviour and used to improve the app design. ',
                      ),
                      TextSpan(
                        style: regularStyle?.copyWith(
                          decoration: TextDecoration.underline,
                        ),

                        text:
                            'How does this application access, use, store, or share Google user data? ',
                      ),
                      TextSpan(
                        text:
                            ' The only user data received is: name, email and profile picture. These are accessed via OAuth2 login. These are stored in an encrypted database. These are used only: to be re-displayed to the user, to reply to messages sent by the user, and as identification for granting access to additional content to the user.',
                      ),
                    ],
                  ),
                ),
                Text(
                  textAlign: TextAlign.justify,
                  style: regularStyle,
                  ' The app does use third party services that may collect information used to identify the user. We collect information from your device in some cases. The information will be utilized for the provision of better service and to prevent fraudulent acts. Additionally, such information will not include that which will identify the individual user. By continuing to use this app, you accept this privacy policy in full. If you disagree with this policy, you must not use this login method. ',
                ),
                SizedBox(height: 8),
                Container(
                  color: colorScheme.surfaceContainerHighest,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 800),

                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 40,
                              child: Center(
                                child: Text(
                                  style: titleStyle,
                                  'Terms of Service',
                                ),
                              ),
                            ),
                            Text(
                              textAlign: TextAlign.justify,
                              style: regularStyle?.copyWith(
                                color: colorScheme.onSurface,
                              ),
                              'This app is designed to educate and socialize. It\'s provided "as is", without any warranty or condition, express or implied or statutory. This app specifically disclaims any implied warranties of merchantability or fitness for a particular purpose. ',
                            ),
                            Text(
                              textAlign: TextAlign.justify,
                              style: regularStyle?.copyWith(
                                color: colorScheme.onSurface,
                              ),
                              'By continuing to use this app, you accept these terms of service in full. If you disagree with these terms, you must not use this app. ',
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                ContactUs(),
              ]
              .map(
                (Widget widget) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: widget,
                ),
              )
              .toList(),
    );
  }
}
