import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:samera_app/core/styles/colors/colors.dart';
import 'package:samera_app/core/styles/typography/text_styles.dart';

import '../../bloc/account/account_bloc.dart';
import '../../bloc/account/account_state.dart';
import '../../widgets/account_trip_card.dart';

class SavedTripPlansScreen extends StatelessWidget {
  const SavedTripPlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Saved Trip Plans',
          style: tsTitleMediumSemiBold(ColorsResources.colorsBlack),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          if (state is AccountLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is AccountError) {
            return Center(child: Text(state.message));
          }
          if (state is AccountLoaded) {
            final plans = state.savedTripPlans;
            if (plans.isEmpty) {
              return const Center(child: Text('Belum ada trip plan'));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(24.0),
              itemCount: plans.length,
              itemBuilder: (context, index) {
                final plan = plans[index];
                final title = plan.items.isNotEmpty ? plan.items.first.destination.name : plan.city;
                final location = plan.items.isNotEmpty ? plan.items.first.destination.location : plan.city;
                final image = plan.items.isNotEmpty ? plan.items.first.destination.image : '';

                return AccountTripCard(
                  title: title,
                  date: '${plan.durationDays} Hari',
                  location: location,
                  imageUrl: image,
                  onTap: () {
                    context.push('/trip-plan', extra: plan);
                  },
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
