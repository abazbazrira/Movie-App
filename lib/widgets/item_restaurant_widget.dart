import 'package:dicoding_bfaf_submission/data/model/restaurant.dart';
import 'package:dicoding_bfaf_submission/ui/detail_restaurant_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ItemRestaurantWidget extends StatelessWidget {
  final Restaurant restaurant;

  const ItemRestaurantWidget({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      leading: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
              ),
            ),
          ),
        ),
      ),
      title: Text(
        restaurant.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
        ),
        child: RichText(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Icon(
                  defaultTargetPlatform == TargetPlatform.android
                      ? Icons.star
                      : CupertinoIcons.star_circle,
                  color: Colors.yellow,
                  size: 16,
                ),
              ),
              TextSpan(
                text: restaurant.rating.toString(),
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
              WidgetSpan(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6.0,
                  ),
                  child: Text(
                    '-',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
              TextSpan(
                text: restaurant.city,
                style: const TextStyle(
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, DetailRestaurantPage.routeName,
            arguments: restaurant);
      },
    );
  }
}
