import 'package:flutter/material.dart';

const content_text =
    'Google officially announced its much-anticipated Pixel phones; the Pixel and Pixel XL, on October 4. We attended Google’s London UK event, mirroring the main one taking place in San Francisco, US, where the firm unwrapped the new Android 7.1 Nougat devices which will apparently usurp Google’s long-standing Nexus series.';
const content_specs_display =
    "5.0 inches\nFHD AMOLED at 441ppi\n2.5D Corning® Gorilla® Glass 4";
const content_specs_size =
    '5.6 x 2.7 x 0.2 ~ 0.3 inches 143.8 x 69.5 x 7.3 ~ 8.5 mm';
const content_specs_battery =
    "2,770 mAh battery\nStandby time (LTE): up to 19 days\nTalk time (3g/WCDMA): up to 26 hours\nInternet use time (Wi-Fi): up to 13 hours\nInternet use time (LTE): up to 13 hours\nVideo playback: up to 13 hours\nAudio playback (via headset): up to 110 hours\nFast charging: up to 7 hours of use from only 15 minutes of charging";
const image_phone =
    "https://raw.githubusercontent.com/dicodingacademy/a195-flutter-fundamental-labs/google-pixel/google_pixel/assets/pixel_google.jpg";
const image_avatar =
    "https://raw.githubusercontent.com/dicodingacademy/a195-flutter-fundamental-labs/google-pixel/google_pixel/assets/photo_2.jpg";

class SliverPage extends StatefulWidget {
  const SliverPage({Key? key}) : super(key: key);

  @override
  _SliverPageState createState() => _SliverPageState();
}

class _SliverPageState extends State<SliverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  image_phone,
                  fit: BoxFit.fitWidth,
                ),
                title: Text('Google Pixel'),
                // titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
              ),
            ),
          ];
        },
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        r'$735',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Container(
                        color: Colors.black26,
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.collections,
                              color: Colors.white,
                            ),
                            Text(
                              '6 photos',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Stock hanya 5 buah',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  SizedBox(height: 8),
                  Text(content_text),
                  SizedBox(height: 8),
                  Text(
                    'Spesifikasi',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(height: 8),
                  Table(
                    columnWidths: {0: FractionColumnWidth(0.3)},
                    children: [
                      TableRow(
                        children: [
                          Text('Display'),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Text(content_specs_display),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Text('Size'),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Text(content_specs_size),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Text('Battery'),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Text(content_specs_battery),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Dijual oleh',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(image_avatar),
                          radius: 24,
                        ),
                      ),
                      Text('Narenda Wicaksono'),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text('Beli'),
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        onPrimary: Colors.white,
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Added to Cart'),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
