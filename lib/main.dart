import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff3989f4)),
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

  Widget itemBuilder(BuildContext context, int index) =>
      Text(pages.keys.toList()[index]);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextStyle? headStyle = Theme.of(
      context,
    ).textTheme.titleMedium?.copyWith(color: colorScheme.outline);

    final int index = ref.watch(pageIndexProvider);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      endDrawer:
          (width > 600)
              ? null
              : //
              Drawer(
                child: ListView.builder(
                  itemCount: pages.length,
                  itemBuilder:
                      (BuildContext context, int index) => InkWell(
                        onTap: () {
                          ref.read(pageIndexProvider.notifier).state = index;
                          Scaffold.of(context).closeEndDrawer();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(pages.keys.toList()[index]),
                        ),
                      ),
                ),
              ),
      appBar: AppBar(
        title: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double maxWidth = constraints.maxWidth;
            if (constraints.maxWidth >= 800) maxWidth = 800;
            return SizedBox(
              width: maxWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox.square(
                    dimension: 56,
                    child: Image.asset('assets/logo.webp'),
                  ),
                  if (maxWidth > 600)
                    SizedBox(
                      height: 56,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children:
                            pages.keys
                                .map(
                                  (String text) => Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          ref
                                              .read(pageIndexProvider.notifier)
                                              .state = pages.keys
                                              .toList()
                                              .indexOf(text);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(),
                                            ),
                                          ),
                                          child: Text(text),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                  if (maxWidth > 600) SizedBox.square(dimension: 56),
                ],
              ),
            );
          },
        ),
      ),
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
                  pages.values.toList()[index],

                  LayoutBuilder(
                    builder: (
                      BuildContext context,
                      BoxConstraints constraints,
                    ) {
                      final List<Widget> children = [
                        Text(
                          'Copyright © 2025 Polipulse - All Rights Reserved.',
                          style: headStyle,
                        ),
                        Column(
                          children: [
                            Text('Powered by', style: headStyle),
                            godaddySVG,
                          ],
                        ),
                      ];

                      if (constraints.maxWidth > 600) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: children,
                        );
                      }
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: children,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget godaddySVG = SvgPicture.string(
  '<svg viewBox="0 0 131 20" fill="currentColor" width="131" height="20" data-ux="IconAiro" class="x-el x-el-svg c1-1 c1-2 c1-4s c1-1i c1-2b c1-b c1-c c1-d c1-e c1-f c1-g"><g><path d="M19.3748 0.914408C17.0406 -0.544155 13.967 -0.197654 11.2308 1.52588C8.49389 -0.197654 5.42186 -0.544155 3.08767 0.914408C-0.599906 3.21843 -1.04832 9.15459 2.08731 14.1719C4.39948 17.8717 8.01369 20.0388 11.2308 19.9988C14.448 20.0388 18.063 17.8717 20.3744 14.1719C23.51 9.15459 23.0624 3.21925 19.3748 0.914408ZM3.7823 13.1129C3.12273 12.057 2.636 10.9425 2.33516 9.79949C2.05225 8.72249 1.94626 7.67157 2.02208 6.6761C2.16231 4.82212 2.91646 3.37823 4.14674 2.60941C5.37702 1.84058 7.00598 1.79574 8.73359 2.48222C8.99367 2.58576 9.2513 2.70561 9.50567 2.8385C8.58521 3.67255 7.73893 4.67536 7.01984 5.82656C5.1145 8.87576 4.53482 12.2633 5.19929 14.9693C4.67831 14.4075 4.20381 13.7863 3.78312 13.112L3.7823 13.1129ZM20.1265 9.79949C19.8257 10.9425 19.3389 12.057 18.6794 13.1129C18.2579 13.7871 17.7842 14.4075 17.2632 14.9693C17.8576 12.5462 17.4556 9.57855 15.9971 6.79513C15.8943 6.59946 15.6579 6.53424 15.4704 6.65164L10.9292 9.48886C10.7555 9.5973 10.7025 9.8264 10.811 10.0001L11.4771 11.0656C11.5855 11.2393 11.8146 11.2923 11.9882 11.1839L14.9315 9.34456C15.0301 9.62747 15.1182 9.912 15.194 10.1982C15.4769 11.2752 15.5829 12.3261 15.5071 13.3216C15.3668 15.1755 14.6127 16.6194 13.3824 17.3883C12.7677 17.7723 12.0543 17.9753 11.2781 17.9973C11.261 17.9973 11.2439 17.9973 11.2276 17.9973C11.2129 17.9973 11.1982 17.9973 11.1844 17.9973C10.4082 17.9753 9.69401 17.7723 9.07928 17.3883C7.849 16.6194 7.09403 15.1747 6.95462 13.3216C6.87961 12.3261 6.98478 11.2752 7.26769 10.1982C7.56853 9.05513 8.05526 7.94062 8.71484 6.88481C9.37441 5.82901 10.1628 4.90283 11.0588 4.13156C11.9026 3.40513 12.8011 2.84992 13.7289 2.48059C15.4565 1.79411 17.0855 1.83895 18.3158 2.60778C19.546 3.3766 20.301 4.8213 20.4404 6.67447C20.5154 7.66994 20.4102 8.72086 20.1273 9.79786L20.1265 9.79949Z" fill="black"></path><path d="M43.5589 7.57455C45.9624 7.57455 47.8922 9.43832 47.8922 11.81C47.8922 14.1817 45.9624 15.9957 43.5589 15.9957C41.1554 15.9957 39.2419 14.1646 39.2419 11.81C39.2419 9.45544 41.1717 7.57455 43.5589 7.57455ZM43.5589 13.7838C44.6759 13.7838 45.5132 12.8935 45.5132 11.7929C45.5132 10.6922 44.6759 9.78645 43.5589 9.78645C42.442 9.78645 41.621 10.6931 41.621 11.7929C41.621 12.8927 42.4583 13.7838 43.5589 13.7838ZM59.2338 10.027C59.2338 13.4284 56.7912 15.7666 53.2756 15.7666H48.8828C48.67 15.7666 48.5232 15.6028 48.5232 15.3908V4.68025C48.5232 4.48377 48.67 4.32071 48.8828 4.32071H53.2756C56.7912 4.32071 59.2338 6.60924 59.2338 10.027ZM56.6664 10.0278C56.6664 8.03275 55.3253 6.57745 53.38 6.57745H50.9765V13.5107H53.38C55.3261 13.5107 56.6664 11.9902 56.6664 10.0278ZM63.6951 7.57537C64.7582 7.57537 65.6086 8.03356 65.9844 8.65482V8.16401C65.9844 7.96752 66.1646 7.80447 66.3277 7.80447H67.9794C68.1759 7.80447 68.3227 7.96834 68.3227 8.16401V15.4242C68.3227 15.6207 68.1759 15.7675 67.9794 15.7675H66.3277C66.1475 15.7675 65.9844 15.6207 65.9844 15.4242V14.9171C65.6086 15.5384 64.7419 15.9965 63.6788 15.9965C61.6185 15.9965 59.705 14.3448 59.705 11.7774C59.705 9.21003 61.6348 7.57537 63.6951 7.57537ZM64.137 13.801C65.2319 13.801 66.0521 12.9604 66.0521 11.7945C66.0521 10.6286 65.2311 9.78808 64.137 9.78808C63.0428 9.78808 62.2218 10.6286 62.2218 11.7945C62.2218 12.9604 63.0428 13.801 64.137 13.801ZM72.9177 7.57537C73.9971 7.57537 74.8638 8.03356 75.2396 8.62221V4.66313C75.2396 4.46665 75.4035 4.31989 75.5992 4.31989H77.251C77.4475 4.31989 77.5942 4.46665 77.5942 4.66313V15.4234C77.5942 15.6199 77.4475 15.7666 77.251 15.7666H75.5992C75.4198 15.7666 75.256 15.6199 75.256 15.4234V14.9163C74.8141 15.5375 74.0135 15.9957 72.9503 15.9957C70.8901 15.9957 68.9766 14.3439 68.9766 11.7766C68.9766 9.20922 70.8737 7.57374 72.9177 7.57374M73.4085 13.8205C74.4977 13.8205 75.3155 12.9718 75.3155 11.7929C75.3155 10.614 74.4986 9.76525 73.4085 9.76525C72.3185 9.76525 71.5015 10.614 71.5015 11.7929C71.5015 12.9718 72.3185 13.8205 73.4085 13.8205ZM82.1884 7.57374C83.2679 7.57374 84.1345 8.03193 84.5104 8.62057V4.66313C84.5104 4.46665 84.6742 4.31989 84.8699 4.31989H86.5217C86.7182 4.31989 86.8649 4.46665 86.8649 4.66313V15.4234C86.8649 15.6199 86.7174 15.7666 86.5217 15.7666H84.8699C84.6897 15.7666 84.5267 15.6199 84.5267 15.4234V14.9163C84.0848 15.5375 83.2842 15.9957 82.221 15.9957C80.1608 15.9957 78.2473 14.3439 78.2473 11.7766C78.2473 9.20922 80.1445 7.57374 82.1884 7.57374ZM82.6792 13.8205C83.7685 13.8205 84.5862 12.9718 84.5862 11.7929C84.5862 10.614 83.7693 9.76525 82.6792 9.76525C81.5892 9.76525 80.7722 10.614 80.7722 11.7929C80.7722 12.9718 81.5892 13.8205 82.6792 13.8205ZM95.2511 7.80283H93.6034C93.3416 7.80283 93.2112 7.98301 93.1623 8.17869L91.6409 13.8662L90.012 8.17869C89.9182 7.8754 89.7698 7.80283 89.5579 7.80283H87.8205C87.412 7.80283 87.3362 8.08085 87.4185 8.35887L89.6231 15.4226C89.6883 15.6191 89.8196 15.7658 90.065 15.7658H91.0629L90.8509 16.467C90.6422 17.0727 90.2533 17.2358 89.7454 17.2358C89.31 17.2358 89.0247 17.0638 88.7165 16.8648C88.5983 16.7882 88.5061 16.7523 88.3912 16.7523C88.2428 16.7523 88.1409 16.8192 88.0031 17.023L87.5139 17.756C87.4185 17.9076 87.3672 17.9916 87.3672 18.1538C87.3672 18.4139 87.6272 18.577 87.9387 18.7547C88.4752 19.0612 89.1584 19.2145 89.9093 19.2145C91.5611 19.2145 92.6234 18.3152 93.0979 16.811L95.5625 8.35887C95.6767 8.03193 95.578 7.80283 95.2511 7.80283ZM36.5099 14.2045C35.644 15.2978 34.1398 15.9859 32.4375 15.9859C29.2415 15.9859 26.7426 13.5816 26.7426 10.1582C26.7426 6.7348 29.4396 4.14787 32.8468 4.14787C35.3619 4.14787 37.3733 5.22976 38.2652 7.40497C38.2929 7.4759 38.3068 7.53297 38.3068 7.58597C38.3068 7.68951 38.2391 7.76696 38.0222 7.84278L36.43 8.45589C36.3077 8.49747 36.2033 8.49502 36.1283 8.45996C36.0468 8.42246 35.9971 8.34745 35.9384 8.24228C35.3717 7.15631 34.351 6.41765 32.7864 6.41765C30.7563 6.41765 29.3027 8.0034 29.3027 10.0588C29.3027 12.1141 30.5419 13.6893 32.8435 13.6893C34.055 13.6893 35.022 13.1161 35.472 12.4908H34.0346C33.8235 12.4908 33.6612 12.3285 33.6612 12.1174V10.8904C33.6612 10.6792 33.8235 10.517 34.0346 10.517H38.2465C38.4576 10.517 38.6199 10.6629 38.6199 10.8741V15.3892C38.6199 15.6003 38.4576 15.7626 38.2465 15.7626H36.8833C36.6721 15.7626 36.5099 15.6003 36.5099 15.3892V14.2045Z" fill="black"></path><path d="M129.305 7.81017C129.3 7.80528 129.294 7.80283 129.286 7.80283H129.084C129.074 7.80283 129.066 7.80446 129.061 7.80854C129.054 7.81262 129.049 7.81914 129.046 7.82648L128.858 8.25125L128.671 7.82648C128.668 7.81833 128.663 7.81262 128.656 7.80854C128.65 7.80446 128.642 7.80283 128.633 7.80283H128.426C128.419 7.80283 128.412 7.80528 128.407 7.81017C128.402 7.81506 128.399 7.82159 128.399 7.82892V8.62547C128.399 8.63362 128.402 8.63933 128.407 8.64503C128.412 8.64993 128.417 8.65237 128.425 8.65237H128.546C128.553 8.65237 128.559 8.64993 128.564 8.64503C128.569 8.64014 128.571 8.63362 128.571 8.62628V8.02459L128.768 8.46159C128.772 8.47138 128.778 8.4779 128.783 8.48198C128.788 8.48605 128.796 8.48768 128.807 8.48768H128.904C128.915 8.48768 128.924 8.48605 128.929 8.48198C128.935 8.4779 128.94 8.47138 128.944 8.46159L129.14 8.02459V8.62628C129.14 8.63443 129.143 8.64014 129.148 8.64585C129.153 8.65074 129.159 8.65319 129.167 8.65319H129.287C129.295 8.65319 129.301 8.65074 129.305 8.64585C129.31 8.64096 129.312 8.63443 129.312 8.62628V7.82974C129.312 7.8224 129.31 7.81506 129.305 7.81017ZM128.214 7.81017C128.209 7.80528 128.203 7.80283 128.195 7.80283H127.524C127.516 7.80283 127.509 7.80528 127.504 7.81017C127.499 7.81588 127.497 7.8224 127.497 7.83055V7.93573C127.497 7.94388 127.499 7.9504 127.504 7.9553C127.509 7.96019 127.516 7.96263 127.524 7.96263H127.769V8.62384C127.769 8.63199 127.772 8.6377 127.776 8.6434C127.782 8.6483 127.788 8.65156 127.795 8.65156H127.922C127.929 8.65156 127.935 8.64911 127.941 8.6434C127.947 8.6377 127.949 8.63199 127.949 8.62384V7.96263H128.195C128.203 7.96263 128.209 7.96019 128.214 7.9553C128.219 7.9504 128.222 7.94388 128.222 7.93573V7.83055C128.222 7.8224 128.219 7.81588 128.214 7.81017ZM113.465 4.81315C113.002 4.56856 112.622 4.18863 112.377 3.72554C112.349 3.67337 112.309 3.63097 112.261 3.60162C112.212 3.57227 112.156 3.55596 112.098 3.55596C111.98 3.55596 111.872 3.622 111.818 3.72554C111.573 4.18863 111.193 4.56856 110.729 4.81315C110.626 4.86777 110.56 4.97539 110.56 5.09279C110.56 5.2102 110.626 5.31782 110.729 5.37244C111.193 5.61703 111.573 5.99696 111.818 6.46004C111.846 6.51222 111.886 6.55462 111.934 6.58397C111.983 6.61332 112.039 6.62962 112.098 6.62962C112.215 6.62962 112.323 6.56359 112.377 6.46004C112.622 5.99696 113.002 5.61703 113.465 5.37244C113.569 5.31782 113.634 5.2102 113.634 5.09279C113.634 4.97539 113.568 4.86777 113.465 4.81315ZM127.11 9.69677C126.772 9.07062 126.297 8.57084 125.684 8.19825C125.07 7.82729 124.354 7.64141 123.537 7.64141C122.72 7.64141 122.003 7.82729 121.389 8.19825C120.776 8.57084 120.301 9.07062 119.963 9.69677C119.626 10.3237 119.457 11.02 119.457 11.7847C119.457 12.5495 119.626 13.2449 119.963 13.8719C120.301 14.4989 120.776 14.9978 121.389 15.3696C122.003 15.7414 122.719 15.9272 123.537 15.9272C124.355 15.9272 125.07 15.7414 125.684 15.3696C126.298 14.9978 126.772 14.4989 127.11 13.8719C127.447 13.2449 127.616 12.5495 127.616 11.7847C127.616 11.02 127.447 10.3237 127.11 9.69677ZM125.34 12.9897C125.205 13.3591 124.99 13.655 124.695 13.8776C124.399 14.0994 124.013 14.2102 123.537 14.2102C123.061 14.2102 122.674 14.0994 122.378 13.8776C122.083 13.655 121.868 13.3591 121.733 12.9897C121.599 12.6204 121.532 12.2185 121.532 11.7847C121.532 11.351 121.599 10.9499 121.733 10.5789C121.868 10.2096 122.083 9.91363 122.378 9.69187C122.674 9.4693 123.06 9.35923 123.537 9.35923C124.014 9.35923 124.399 9.4693 124.695 9.69187C124.99 9.91363 125.205 10.2096 125.34 10.5789C125.474 10.9499 125.541 11.3518 125.541 11.7847C125.541 12.2177 125.474 12.6196 125.34 12.9897ZM119.036 7.67728C118.891 7.65364 118.707 7.64304 118.493 7.64304C117.99 7.64304 117.54 7.8012 117.141 8.12406C116.797 8.39963 116.525 8.77793 116.323 9.25406V7.80283H114.397V15.765H116.308V12.481C116.308 11.9201 116.4 11.4203 116.582 10.9833C116.765 10.5463 117.024 10.1998 117.36 9.94869C117.694 9.69513 118.088 9.56795 118.541 9.56795C118.752 9.56795 118.922 9.58099 119.054 9.61279C119.186 9.64214 119.3 9.67638 119.39 9.71307V7.75473C119.301 7.72538 119.181 7.70255 119.036 7.67565V7.67728ZM111.082 7.80365L107.533 10.181L105.089 4.04188H103.572L99.0838 15.3321C98.7544 16.1629 99.3659 17.0646 100.259 17.0646C100.385 17.0646 100.509 17.0458 100.628 17.01C100.747 16.9741 100.86 16.9203 100.965 16.8502L106.532 13.1153L107.494 15.7658H109.758L108.245 11.9657L111.082 10.0628V15.7658H113.057V7.80365H111.082ZM101.737 14.0659L104.31 6.99732L105.87 11.2956L101.737 14.0659Z" fill="black"></path></g></svg>',
);

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
