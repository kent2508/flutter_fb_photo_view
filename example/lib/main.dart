import 'package:flutter/material.dart';
import 'package:flutter_fb_photo_view/flutter_fb_photo_view.dart';

void main() {
  runApp(const MyApp());
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
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Demo Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final combineItems = [
    "assets/gallery1.jpg",
    "assets/gallery2.jpg",
    "assets/gallery3.jpg",
    "assets/large-image.jpg",
    "assets/small-image.jpg",
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
  ];

  final newTest = [
    "https://d3as25xk38qbzc.cloudfront.net/albums/122/20b7ca2b-c79b-4a40-83ee-c2527b025663.jpg",
    "https://d3as25xk38qbzc.cloudfront.net/albums/122/25b69d87-0aad-463a-8932-31f5e53b4e4b.jpg",
    "https://d3as25xk38qbzc.cloudfront.net/albums/122/876f789b-36d1-42dd-a3dd-df877473bc85.jpg",
    "https://d3as25xk38qbzc.cloudfront.net/albums/122/efc5fb88-b54d-4bdd-b128-d92609c77efb.jpg",
    "https://d3as25xk38qbzc.cloudfront.net/albums/122/59ae8169-1e36-4de7-ab92-ff70754d7c40.jpg",
  ];
  final newTestThumb = [
    "https://d3as25xk38qbzc.cloudfront.net/albums/122/thumb_20b7ca2b-c79b-4a40-83ee-c2527b025663.jpg",
    "https://d3as25xk38qbzc.cloudfront.net/albums/122/thumb_25b69d87-0aad-463a-8932-31f5e53b4e4b.jpg",
    "https://d3as25xk38qbzc.cloudfront.net/albums/122/thumb_876f789b-36d1-42dd-a3dd-df877473bc85.jpg",
    "https://d3as25xk38qbzc.cloudfront.net/albums/122/thumb_efc5fb88-b54d-4bdd-b128-d92609c77efb.jpg",
    "https://d3as25xk38qbzc.cloudfront.net/albums/122/thumb_59ae8169-1e36-4de7-ab92-ff70754d7c40.jpg",
  ];

  ScrollController scrollController = ScrollController();

  String _selectedItem = 'FBPhotoViewType.list'; // Default selected item

  final List<String> _items = [
    'FBPhotoViewType.list',
    'FBPhotoViewType.grid3',
    'FBPhotoViewType.grid4',
    'FBPhotoViewType.grid5',
    'Custom photo container',
  ];

  ValueNotifier<int> currentIndexNotifier = ValueNotifier(0);

  @override
  void dispose() {
    currentIndexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text('Change display type to see different layout'),
            DropdownButton<String>(
                value: _selectedItem,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.black, fontSize: 18),
                underline: const SizedBox.shrink(),
                onChanged: (String? newValue) {
                  _selectedItem = newValue ?? '';
                  setState(() {});
                },
                items: _items.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList()),
            const SizedBox(height: 10),
            imageContainer(),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget imageContainer() {
    switch (_selectedItem) {
      case 'FBPhotoViewType.list':
        return FBPhotoView(
          key: UniqueKey(),
          dataSource: combineItems,
          displayType: FBPhotoViewType.list,
          customSubChild: const [
            Positioned(
              left: 10,
              bottom: 20,
              child: Text(
                'Text something here',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ],
        );
      case 'FBPhotoViewType.grid3':
        return FBPhotoView(
          key: UniqueKey(),
          dataSource: newTest,
          thumbnailSource: newTestThumb,
          displayType: FBPhotoViewType.grid3,
          customSubChild: [
            Positioned(
              right: 20,
              bottom: 20,
              child: Container(
                width: 30,
                height: 30,
                color: Colors.red,
              ),
            ),
          ],
        );
      case 'FBPhotoViewType.grid4':
        return FBPhotoView(
          key: UniqueKey(),
          dataSource: combineItems,
          displayType: FBPhotoViewType.grid4,
        );
      case 'FBPhotoViewType.grid5':
        return FBPhotoView(
          key: UniqueKey(),
          dataSource: combineItems,
          displayType: FBPhotoViewType.grid5,
        );

      default:
        return SizedBox(
          height: 240,
          child: ListView.separated(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final source = combineItems[index];
              final isRemoteAsset = source.isNetworkSource;
              return GestureDetector(
                onTap: () {
                  // set the current index to the selected index
                  currentIndexNotifier.value = index;
                  FBPhotoView.displayImage(
                    context,
                    combineItems,
                    displayIndex: index,
                    onPageChanged: (nextIndex) {
                      currentIndexNotifier.value = nextIndex;
                      scrollController.animateTo(16 + nextIndex * 130.0, duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
                    },
                    customSubChild: [
                      Positioned(
                        left: 20,
                        bottom: 20,
                        child: ValueListenableBuilder(
                            valueListenable: currentIndexNotifier,
                            builder: (context, currentIndex, _) {
                              return Material(
                                color: Colors.transparent,
                                child: Text(
                                  'Page $currentIndex',
                                  style: const TextStyle(color: Colors.white, fontSize: 12),
                                ),
                              );
                            }),
                      ),
                    ],
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Hero(
                      tag: source,
                      child: isRemoteAsset
                          ? Image.network(
                              source,
                              width: 120,
                              height: 240,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              source,
                              width: 120,
                              height: 240,
                              fit: BoxFit.cover,
                            )),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemCount: combineItems.length,
          ),
        );
    }
  }
}
