import 'package:dicoding_mfde_submission/data/api/api_service.dart';
import 'package:dicoding_mfde_submission/provider/search_restaurant_provider.dart';
import 'package:dicoding_mfde_submission/utils/result_state.dart';
import 'package:dicoding_mfde_submission/widgets/error_state_widget.dart';
import 'package:dicoding_mfde_submission/widgets/item_restaurant_widget.dart';
import 'package:dicoding_mfde_submission/widgets/loading_state_widget.dart';
import 'package:dicoding_mfde_submission/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchRestaurant extends StatefulWidget {
  static const routeName = '/search_restaurant';

  const SearchRestaurant({Key? key}) : super(key: key);

  @override
  _SearchRestaurantState createState() => _SearchRestaurantState();
}

class _SearchRestaurantState extends State<SearchRestaurant> {
  final String title = 'Restaurant';
  String query = '';
  final TextEditingController _controller = TextEditingController();
  static const _labelText = 'Find the restaurant by name, category or menu';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchRestaurantProvider(
        apiService: ApiService(),
      ),
      child: PlatformWidget(
        androidBuilder: _androidBuilder(context),
        iosBuilder: _iosBuilder(context),
      ),
    );
  }

  Widget _buildSearch(BuildContext context) {
    return Consumer<SearchRestaurantProvider>(
      builder: (context, value, _) {
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 24,
              ),
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: _labelText,
                ),
                onChanged: (String s) {
                  setState(() {
                    query = s;
                    value.fetchRestaurants(query);
                  });
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: _buildList(context),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<SearchRestaurantProvider>(
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
              message: 'Something proble. Try again later.');
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
      ),
      body: _buildSearch(context),
    );
  }

  Widget _iosBuilder(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          title,
        ),
      ),
      child: _buildSearch(context),
    );
  }
}
