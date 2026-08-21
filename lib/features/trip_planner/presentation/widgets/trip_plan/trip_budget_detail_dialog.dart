import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:samera_app/core/styles/typography/text_styles.dart';
import 'package:samera_app/core/styles/colors/colors.dart';
import 'package:samera_app/features/trip_planner/domain/entities/trip_plan_entity.dart';
import 'package:samera_app/core/utils/format_utils.dart';

class TripBudgetDetailDialog extends StatelessWidget {
  final TripPlanEntity plan;

  const TripBudgetDetailDialog({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text('Rincian Estimasi Biaya', style: tsTitleMediumSemiBold(ColorsResources.colorsPrimary)),
              const SizedBox(height: 4),
              Text('Estimasi untuk ${plan.numberOfPeople} orang', style: tsBodyMediumMedium(Colors.grey[600]!)),
              const SizedBox(height: 24),

              // Transportasi Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Transportasi', style: tsBodyMediumSemiBold(Colors.black87)),
                    const SizedBox(height: 4),
                    Text(
                      '${FormatUtils.formatTransportationLabel(plan.transportation)} • ${plan.durationDays} Hari',
                      style: tsBodySmallMedium(Colors.grey[700]!),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      formatCurrency.format(plan.transportCost),
                      style: tsBodyLargeSemiBold(ColorsResources.colorsPrimary),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Tiket Destinasi
              Text('Tiket Destinasi', style: tsBodyMediumSemiBold(Colors.black87)),
              const SizedBox(height: 16),
              ...plan.items.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.destination.name, style: tsBodyMediumSemiBold(Colors.black87)),
                      const SizedBox(height: 4),
                      Text(
                        '${formatCurrency.format(item.destination.ticketPrice)} / orang',
                        style: tsBodySmallMedium(Colors.grey[600]!),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${plan.numberOfPeople} × ${formatCurrency.format(item.destination.ticketPrice)}',
                            style: tsBodySmallMedium(Colors.grey[700]!),
                          ),
                          Text(
                            formatCurrency.format(item.estimatedCost),
                            style: tsBodyMediumSemiBold(Colors.black87),
                          ),
                        ],
                      ),
                      if (item != plan.items.last) const _HorizontalDashedDivider(),
                    ],
                  ),
                );
              }),

              if (plan.items.isNotEmpty) const _HorizontalDashedDivider(),

              // Summary
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Tiket Destinasi', style: tsBodyMediumMedium(Colors.black87)),
                  Text(formatCurrency.format(plan.destinationCost), style: tsBodyMediumSemiBold(Colors.black87)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Transportasi', style: tsBodyMediumMedium(Colors.black87)),
                  Text(formatCurrency.format(plan.transportCost), style: tsBodyMediumSemiBold(Colors.black87)),
                ],
              ),

              const _HorizontalDashedDivider(),

              // Grand Total
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Estimasi Trip', style: tsBodyMediumSemiBold(Colors.black87)),
                  Text(formatCurrency.format(plan.estimatedBudget), style: tsBodyLargeSemiBold(const Color(0xFFFE813C))),
                ],
              ),
              const SizedBox(height: 24),

              // Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFE813C),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text('Tutup', style: tsBodyMediumSemiBold(Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HorizontalDashedDivider extends StatelessWidget {
  const _HorizontalDashedDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final boxWidth = constraints.constrainWidth();
          const dashWidth = 5.0;
          const dashHeight = 1.5;
          final dashCount = (boxWidth / (2 * dashWidth)).floor();
          return Flex(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.horizontal,
            children: List.generate(dashCount, (_) {
              return const SizedBox(
                width: dashWidth,
                height: dashHeight,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Color(0xFFE0E0E0)),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
