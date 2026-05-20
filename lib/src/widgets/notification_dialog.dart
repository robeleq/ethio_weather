import 'package:flutter/material.dart';

import '../locales/app_localizations.dart';

class NotificationDialog extends StatelessWidget {
	final String title;
	final String body;

	const NotificationDialog({super.key, required this.title, required this.body});
	
	@override
	Widget build(BuildContext context) {
		final ThemeData _theme = Theme.of(context);
		return Dialog(
			shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
			elevation: 0,
			backgroundColor: Colors.transparent,
			child: _dialogContent(context),
		);
	}
	
	_dialogContent(BuildContext context) {
		return Container(
			// height: MediaQuery.of(context).size.height * 0.75,
			padding: const EdgeInsets.only(
					top: 8, bottom: 8, left: 8, right: 8
			),
			// margin: const EdgeInsets.only(top: 8),
			decoration: BoxDecoration(
					color: Theme.of(context).scaffoldBackgroundColor,
					shape: BoxShape.rectangle,
					borderRadius: BorderRadius.circular(16),
					boxShadow: const [
						BoxShadow(
								color: Colors.black26,
								blurRadius: 8.0,
								offset: Offset(0.0, 10.0)
						)
					]
			),
			child: ListView(
					shrinkWrap: true,
					children: [
						/*
						Center(
							child: Image.asset(
								'assets/images/banks/${bankCurrencyForex.bankCode?.toString() ?? 'default_bank'}.png',
								height: 48,
								width: 48,
								fit: BoxFit.fitWidth,
								errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
									return Image.asset(
										'assets/images/banks/default_bank.png',
										height: 48,
										width: 48,
										fit: BoxFit.fitWidth,
									);
								},
							),
						),
						Center(
						  child: Text(
						  	AppLocalizations.of(context)!.translate("label_bank_name_${bankCurrencyForex.bankCode?.toString()}") ?? 'No Bank Name',
						  	style: Theme.of(context).textTheme.titleLarge?.copyWith(
						  		fontSize: 14,
									fontWeight: FontWeight.bold,
						  	),
						  ),
						),
						*/
						const SizedBox(height: 16.0,),
						Container(
							padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 8.0),
							child: Row(
								crossAxisAlignment: CrossAxisAlignment.start,
								children: [
									// 25% width for the currency emoji
									/*
									Row(
										children: [
											Text(
												CurrencyUtils.currencyToEmoji(bankCurrencyForex.currencyCode.toString()),
												style: const TextStyle(
													fontSize: 32,
												),
											),
											const SizedBox(width: 16.0),
										],
									),
									*/
									// 25% width for the currency code and name
									/*
									Expanded(
										flex: 1, // 25% width
										child: Column(
											crossAxisAlignment: CrossAxisAlignment.start,
											children: [
												Text(
													"${bankCurrencyForex.currencyCode}",
													style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
												),
												const SizedBox(height: 12.0),
												Text(
													AppLocalizations.of(context)!.translate("label_currency_name_${bankCurrencyForex.currencyCode.toString()}")?.toTitleCase() ?? bankCurrencyForex.currencyName.toString().toTitleCase(),
													style: const TextStyle(fontSize: 10.0),
													overflow: TextOverflow.ellipsis,
													softWrap: true,
												),
											],
										),
									),
									*/
									const SizedBox(width: 16,),
									Flexible(
										child: Column(
											crossAxisAlignment: CrossAxisAlignment.start,
											children: [
												Row(
													mainAxisAlignment: MainAxisAlignment.start,
													children: [
														Text(
															"${AppLocalizations.of(context)!.translate("label_buying")}:" ?? 'Buying:',
															style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
														),
														const SizedBox(width: 8.0),
														/* Text(
															"${bankCurrencyForex.buying?.toPrecision(2)}",
															style: const TextStyle(fontSize: 12.0,),
														),
														*/
													],
												),
												const SizedBox(height: 10.0),
												Row(
													mainAxisAlignment: MainAxisAlignment.start,
													children: [
														Text(
															"${AppLocalizations.of(context)!.translate("label_selling")}:" ?? 'Selling:',
															style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
														),
														const SizedBox(width: 8.0),
														/*
														Text(
															"${bankCurrencyForex.selling?.toPrecision(2)}",
															style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
														),
														*/
													],
												),
											],
										),
									),
								],
							),
						),
						const SizedBox(height: 8.0,),
					]
			),
		);
	}
}
