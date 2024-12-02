import 'package:cached_network_image/cached_network_image.dart';
import 'package:debugging_optimizing_ecommerce_challenge/debugging_optimizing/custom_animated_container.dart';
import 'package:flutter/material.dart';

class DebuggingTask extends StatelessWidget {
  const DebuggingTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Debugging Task')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 1000,
              itemBuilder: (context, index) => ListTile(
                leading: const CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                    'https://via.placeholder.com/50',
                  ),
                // ClipOval(
                //   //   width: 50.0, // Set the width
                //   //   height: 50.0,
                //   // decoration: const ShapeDecoration(shape: CircleBorder()),
                //   // clipBehavior: Clip.hardEdge,
                //   // backgroundImage:
                //   // NetworkImage('https://via.placeholder.com/50'),
                //   child: CachedNetworkImage(
                //     imageUrl: 'https://via.placeholder.com/50',
                //     fit: BoxFit.cover,
                //     placeholder: (context, url) => const CircularProgressIndicator(), // Optional placeholder
                //     errorWidget: (context, url, error) => const Icon(Icons.error),
                //   ),
                ),
                title: Text('Item $index'),
              ),
            ),
          ),
          const CustomAnimatedContainer()
        ],
      ),
    );
  }
}
