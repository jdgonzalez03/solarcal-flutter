import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final String title;
  final String description;
  final String? additionalText;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? textColor;
  final IconData? icon;

  const CustomContainer({
    Key? key,
    required this.title,
    required this.description,
    this.additionalText,
    this.backgroundColor,
    this.titleColor,
    this.textColor,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final headingColor = titleColor ?? theme.colorScheme.primary;
    final contentColor = textColor ?? theme.colorScheme.onSurface;
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (icon != null) ...[
            Icon(
              icon,
              size: 48.0,
              color: headingColor,
            ),
            const SizedBox(height: 16),
          ],
          Text(
            title,
            style: theme.textTheme.headlineMedium?.copyWith(
              color: headingColor,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            description,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: contentColor,
            ),
            textAlign: TextAlign.center,
          ),
          if (additionalText != null) ...[
            const SizedBox(height: 20),
            Text(
              additionalText!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: contentColor.withOpacity(0.8),
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}