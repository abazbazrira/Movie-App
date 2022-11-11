import 'package:dicoding_bfaf_submission/data/api/api_service.dart';
import 'package:dicoding_bfaf_submission/provider/list_restaurant_provider.dart';
import 'package:dicoding_bfaf_submission/ui/detail_restaurant_page.dart';
import 'package:dicoding_bfaf_submission/ui/favorite_restaurant_page.dart';
import 'package:dicoding_bfaf_submission/ui/search_restaurant_page.dart';
import 'package:dicoding_bfaf_submission/ui/settings_page.dart';
import 'package:dicoding_bfaf_submission/utils/notification_helper.dart';
import 'package:dicoding_bfaf_submission/utils/result_state.dart';
import 'package:dicoding_bfaf_submission/widgets/error_state_widget.dart';
import 'package:dicoding_bfaf_submission/widgets/item_restaurant_widget.dart';
import 'package:dicoding_bfaf_submission/widgets/loading_state_widget.dart';
import 'package:dicoding_bfaf_submission/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListRestaurantPage extends StatefulWidget {
  static const routeName = '/list_restaurant';

  const ListRestaurantPage({Key? key}) : super(key: key);

  @override
  _ListRestaurantPageState createState() => _ListRestaurantPageState();
}

class _ListRestaurantPageState extends State<ListRestaurantPage> {
  final String title = 'Restaurant';

  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(DetailRestaurantPage.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ListRestaurantProvider>(
      create: (_) => ListRestaurantProvider(
        apiService: ApiService(),
      ),
      child: PlatformWidget(
        androidBuilder: _androidBuilder(context),
        iosBuilder: _iosBuilder(context),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<ListRestaurantProvider>(
      builder: (context, value, _) {
        if (value.state == ResultState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: value.result.length,
            itemBuilder: (context, index) {
              var restaurant = value.result[index];
              return ItemRestaurantWidget(restaurant: restaurant);
            },
          );
        } else if (value.state == ResultState.loading) {
          return LoadingStateWidget(message: value.message);
        } else if (value.state == ResultState.noData) {
          return ErrorStateWidget(message: value.message);
        } else if (value.state == ResultState.error) {
          return ErrorStateWidget(message: value.message);
        } else {
          return const ErrorStateWidget(
            message: 'Something problem. Try again later.',
          );
        }
      },
    );
  }

  Widget _androidBuilder(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchRestaurant.routeName);
            },
            icon: const Icon(Icons.search),
          ),
          PopupMenuButton<int>(
            onSelected: (item) => onSelected(context, item),
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                child: Row(
                  children: const [
                    Icon(Icons.favorite_border),
                    SizedBox(width: 8.0),
                    Text('Favorites'),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Row(
                  children: const [
                    Icon(Icons.settings),
                    SizedBox(width: 8.0),
                    Text('Settings'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: _buildList(context),
    );
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        Navigator.pushNamed(context, FavoriteRestaurantPage.routeName);
        break;
      case 1:
        Navigator.pushNamed(context, SettingsPage.routeName);
        break;
    }
  }

  Widget _iosBuilder(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          title,
        ),
        trailing: CupertinoButton(
          onPressed: () {
            Navigator.pushNamed(context, SearchRestaurant.routeName);
          },
          child: const Icon(CupertinoIcons.search),
        ),
      ),
      child: _buildList(context),
    );
  }
}
