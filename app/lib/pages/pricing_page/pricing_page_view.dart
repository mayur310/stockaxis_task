import 'package:app/components/shared/loading_view.dart';
import 'package:app/pages/pricing_page/pricing_desktop_view.dart';
import 'package:app/pages/pricing_page/pricing_mobile_view.dart';
import 'package:app/pages/pricing_page/pricing_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PricingPageView extends ConsumerWidget {
  const PricingPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<PricingViewModel>(
        future: PricingViewModel.initalizePricingDataAPIs(ref: ref),
        initialData: null,
        builder:
            (BuildContext context, AsyncSnapshot<PricingViewModel> snapshot) {
          if (snapshot.connectionState != ConnectionState.done ||
              !snapshot.hasData ||
              snapshot.hasError) {
            return const LoadingView();
          }
          PricingViewModel pricingViewModel = snapshot.data!;
          if (MediaQuery.of(context).size.width >
              MediaQuery.of(context).size.height) {
            return const PricingDesktopView();
          } else {
            return PricingMobileView(
              pricingViewModel: pricingViewModel,
            );
          }
        });
  }
}
