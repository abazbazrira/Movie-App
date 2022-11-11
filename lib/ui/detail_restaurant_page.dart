import 'package:dicoding_bfaf_submission/data/api/api_service.dart';
import 'package:dicoding_bfaf_submission/data/db/database_helper.dart';
import 'package:dicoding_bfaf_submission/data/model/restaurant.dart';
import 'package:dicoding_bfaf_submission/provider/database_provider.dart';
import 'package:dicoding_bfaf_submission/provider/detail_restaurant_provider.dart';
import 'package:dicoding_bfaf_submission/utils/result_state.dart';
import 'package:dicoding_bfaf_submission/widgets/error_state_widget.dart';
import 'package:dicoding_bfaf_submission/widgets/item_review_widget.dart';
import 'package:dicoding_bfaf_submission/widgets/loading_state_widget.dart';
import 'package:dicoding_bfaf_submission/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailRestaurantPage extends StatelessWidget {
  static const routeName = '/detail_restaurant';
  final String title = 'Restaurant Detail';
  final Restaurant restaurant;

  const DetailRestaurantPage({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DatabaseProvider>(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
        ChangeNotifierProvider<DetailRestaurantProvider>(
          create: (_) => DetailRestaurantProvider(
            apiService: ApiService(),
            restaurantId: restaurant.id,
          ),
        ),
      ],
      child: PlatformWidget(
        androidBuilder: _androidBuilder(context),
        iosBuilder: _iosBuilder(context),
      ),
    );
  }

  Widget _buildDetail(BuildContext context) {
    return Consumer<DetailRestaurantProvider>(
      builder: (context, value, child) {
        if (value.state == ResultState.hasData) {
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Image.network(
                  'https://restaurant-api.dicoding.dev/images/medium/${value.result.pictureId}',
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        value.result.name,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 16.0,
                        ),
                        child: RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyText1,
                            children: [
                              WidgetSpan(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Icon(
                                    defaultTargetPlatform ==
                                            TargetPlatform.android
                                        ? Icons.star
                                        : CupertinoIcons.star_circle,
                                    color: Colors.yellow,
                                    size: 20,
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: value.result.rating.toString(),
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              WidgetSpan(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6.0,
                                  ),
                                  child: Text(
                                    '-',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: value.result.city,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 16.0,
                        ),
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        value.result.description,
                        style: Theme.of(context).textTheme.bodyText2,
                        textAlign: TextAlign.justify,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 16.0,
                        ),
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 8.0,
                          ),
                          child: Text(
                            'Foods',
                            style: Theme.of(context).textTheme.headline6,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      _buildMenu(context, value.result.menu!.foods),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 26.0,
                            bottom: 8.0,
                          ),
                          child: Text(
                            'Drinks',
                            style: Theme.of(context).textTheme.headline6,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      _buildMenu(context, value.result.menu!.drinks),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 16.0,
                        ),
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 8.0,
                          ),
                          child: Text(
                            'Reviews',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            value.result.customerReviews!.map((customerReview) {
                          return ItemReviewWidget(
                            customerReview: customerReview,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (value.state == ResultState.noData) {
          return ErrorStateWidget(message: value.message);
        } else if (value.state == ResultState.loading) {
          return LoadingStateWidget(message: value.message);
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

  Widget _buildMenu(BuildContext context, List<dynamic> menus) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: menus.map((menu) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 4.0, top: 4.0, left: 16.0),
          child: Text(
            menu.name,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        );
      }).toList(),
    );
  }

  Widget _androidBuilder(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, value, child) {
        return FutureBuilder<bool>(
          future: value.isBookmarked(restaurant.id),
          builder: (context, snapshot) {
            final isFavorite = snapshot.data ?? false;
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  title,
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      if (isFavorite) {
                        value.removeBookmark(restaurant.id);
                      } else {
                        value.addBookmark(restaurant);
                      }
                    },
                    icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border),
                  )
                ],
              ),
              body: _buildDetail(context),
            );
          },
        );
      },
    );
  }

  Widget _iosBuilder(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, value, child) {
        return FutureBuilder<bool>(
          future: value.isBookmarked(restaurant.id),
          builder: (context, snapshot) {
            final isFavorite = snapshot.data ?? false;
            return CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                middle: Text(
                  title,
                ),
                trailing: IconButton(
                  onPressed: () {
                    if (isFavorite) {
                      value.removeBookmark(restaurant.id);
                    } else {
                      value.addBookmark(restaurant);
                    }
                  },
                  icon: Icon(isFavorite
                      ? CupertinoIcons.suit_heart_fill
                      : CupertinoIcons.suit_heart),
                ),
              ),
              child: _buildDetail(context),
            );
          },
        );
      },
    );
  }
}
