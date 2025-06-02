import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:switch_config/features/scan_boitier/domain/entities/boitier.dart';
import 'package:switch_config/features/scan_boitier/presentation/pages/passeport_produit.dart';
import 'package:switch_config/shared/widgets/custom-button.dart';
import 'package:switch_config/shared/widgets/uderlined-title.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/utils/functions.dart';
import '../controllers/scan_boitier_controller.dart';
import '../widgets/schema_port.dart';

class PasseportProduitBody extends StatelessWidget {
  final Boitier? produit;

  const PasseportProduitBody({
    Key? key,
    required this.produit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final infoItems = <Map<String, String?>>[
      {
        'label': 'passeport_produit.labels.serialnumber'.tr(),
        'value': produit?.serialNumber
      },
      {
        'label': 'passeport_produit.labels.manufacturerid'.tr(),
        'value': produit?.manufacturer
      },
      {
        'label': 'passeport_produit.labels.model'.tr(),
        'value': produit?.name
      },
      {
        'label':
        'passeport_produit.labels.distribution_cable_diam_max'.tr(),
        'value': produit?.cableDiameter?.toString() ?? '-'
      },
      {
        'label': 'passeport_produit.labels.theorical_losses'.tr(),
        'value': produit?.theoricalLosses.toString()
      },
      {
        'label': 'passeport_produit.labels.connectorization'.tr(),
        'value': produit?.connectorization
      },
      {
        'label': 'passeport_produit.labels.connectorization_body'.tr(),
        'value': produit?.connectorizationBody
      },
      {
        'label': 'passeport_produit.labels.production_date'.tr(),
        'value': formatDate(produit?.productionDate)
      },
      {
        'label': 'passeport_produit.labels.production_batch'.tr(),
        'value': produit?.productionBatch
      },
      {
        'label': 'passeport_produit.labels.origin'.tr(),
        'value': produit?.origin
      },
      {
        'label': 'passeport_produit.labels.material'.tr(),
        'value': produit?.material
      },
      {
        'label': 'passeport_produit.labels.warranty_date'.tr(),
        'value': formatDate(produit?.warrantyDate)
      },
    ];
    if (produit?.cableDiameter != null) {
      infoItems.add({
        'label': 'passeport_produit.labels.cable_diameter'.tr(),
        'value': produit?.cableDiameter.toString()
      });
    }
    return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        if(produit != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: UnderlinedTitle(title: "passeport_produit.schema_global".tr()),
              ),
              SchemaPorts(produit: produit),

              SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: UnderlinedTitle(title: "passeport_produit.technical_desc".tr()),
              ),
              ...infoItems.map((item) => _InfoCard(
                title: item['label']??"",
                subtitle: item['value']??"",
              )),
            ],
          )
      ],

    ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title, subtitle;
  const _InfoCard({Key? key, required this.title, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: ListTile(
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        title: Text(title),
        subtitle: Text(
          subtitle,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: AppColors.primary, fontSize: 16),
        ),
      ),
    );
  }
}