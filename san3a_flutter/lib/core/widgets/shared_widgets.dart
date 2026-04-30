import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// AppButton mirroring shared/components/AppButton.kt
enum AppButtonState { enable, loading, disable }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonState state;
  final bool isSecondary;
  final double? width;

  const AppButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.state = AppButtonState.enable,
    this.isSecondary = false,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = San3aTheme.of(context);
    final isDisabled = state == AppButtonState.disable;
    final isLoading = state == AppButtonState.loading;

    final bgColor = isDisabled
        ? theme.colors.button.disabled
        : isSecondary
            ? theme.colors.button.secondary
            : theme.colors.button.primary;

    final textColor = isDisabled
        ? theme.colors.button.onDisabled
        : isSecondary
            ? theme.colors.button.onSecondary
            : theme.colors.button.onPrimary;

    return SizedBox(
      width: width ?? double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: (isDisabled || isLoading) ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          disabledBackgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(theme.radius.large),
            side: isSecondary
                ? BorderSide(color: theme.colors.stroke.primary)
                : BorderSide.none,
          ),
          elevation: 0,
        ),
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: textColor,
                ),
              )
            : Text(
                text,
                style: theme.textStyle.bodyLargeMedium.copyWith(color: textColor),
              ),
      ),
    );
  }
}

/// AppTextField mirroring shared/components/AppTextField.kt
class AppTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  final Widget? prefix;
  final Widget? suffix;

  const AppTextField({
    Key? key,
    this.label,
    this.hint,
    this.controller,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.maxLines = 1,
    this.onChanged,
    this.prefix,
    this.suffix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = San3aTheme.of(context);
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      onChanged: onChanged,
      style: theme.textStyle.bodyMediumRegular.copyWith(
        color: theme.colors.shade.primary,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: prefix,
        suffixIcon: suffix,
        hintStyle: theme.textStyle.bodyMediumRegular.copyWith(
          color: theme.colors.shade.tertiary,
        ),
        filled: true,
        fillColor: theme.colors.background.bottomSheetCard,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(theme.radius.large),
          borderSide: BorderSide(color: theme.colors.stroke.primary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(theme.radius.large),
          borderSide: BorderSide(color: theme.colors.stroke.primary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(theme.radius.large),
          borderSide: BorderSide(color: theme.colors.brand.primary, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}

/// SearchBar mirroring shared/components/SearchBar.kt
class AppSearchBar extends StatelessWidget {
  final String value;
  final ValueChanged<String> onValueChange;
  final String hint;
  final VoidCallback? onMicClick;

  const AppSearchBar({
    Key? key,
    required this.value,
    required this.onValueChange,
    required this.hint,
    this.onMicClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = San3aTheme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: theme.colors.background.card,
        borderRadius: BorderRadius.circular(theme.radius.full),
        border: Border.all(color: theme.colors.stroke.primary),
      ),
      child: TextField(
        onChanged: onValueChange,
        style: theme.textStyle.bodyMediumRegular.copyWith(color: theme.colors.shade.primary),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: theme.textStyle.bodyMediumRegular.copyWith(color: theme.colors.shade.tertiary),
          prefixIcon: Icon(Icons.search, color: theme.colors.shade.tertiary),
          suffixIcon: onMicClick != null
              ? IconButton(
                  icon: Icon(Icons.mic, color: theme.colors.brand.primary),
                  onPressed: onMicClick,
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}

/// AppChip mirroring shared/components/AppChips.kt
class AppChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isSelected;
  final Color? selectedColor;
  final Color? textColor;
  final Color? borderColor;

  const AppChip({
    Key? key,
    required this.label,
    required this.onTap,
    this.isSelected = false,
    this.selectedColor,
    this.textColor,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = San3aTheme.of(context);
    final bg = isSelected
        ? (selectedColor ?? theme.colors.brand.tertiary)
        : theme.colors.background.card;
    final tc = textColor ?? (isSelected ? theme.colors.brand.primary : theme.colors.shade.secondary);
    final bc = borderColor ?? (isSelected ? theme.colors.brand.secondary : theme.colors.shade.quaternary);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(theme.radius.full),
          border: Border.all(color: bc),
        ),
        child: Text(label, style: theme.textStyle.bodySmallMedium.copyWith(color: tc)),
      ),
    );
  }
}

/// RequestCardForCraftsman mirroring shared/components/RequestCardForCraftsMan.kt
class RequestCard extends StatelessWidget {
  final String title;
  final String type;
  final int offers;
  final String description;
  final String location;
  final String? imageUri;
  final VoidCallback? onClick;
  final double? maxWidth;

  const RequestCard({
    Key? key,
    required this.title,
    required this.type,
    required this.offers,
    required this.description,
    required this.location,
    this.imageUri,
    this.onClick,
    this.maxWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = San3aTheme.of(context);
    return GestureDetector(
      onTap: onClick,
      child: Container(
        width: maxWidth,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colors.background.card,
          borderRadius: BorderRadius.circular(theme.radius.extraLarge),
          border: Border.all(color: theme.colors.stroke.primary),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUri != null && imageUri!.isNotEmpty) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(theme.radius.medium),
                child: Image.network(
                  imageUri!,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 120,
                    color: theme.colors.shade.quinary,
                    child: Icon(Icons.image, color: theme.colors.shade.tertiary),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
            Text(title, style: theme.textStyle.bodyLargeSemibold.copyWith(color: theme.colors.shade.primary)),
            const SizedBox(height: 4),
            Text(description, style: theme.textStyle.bodySmallRegular.copyWith(color: theme.colors.shade.secondary), maxLines: 2, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.location_on_outlined, size: 14, color: theme.colors.shade.tertiary),
                const SizedBox(width: 4),
                Expanded(child: Text(location, style: theme.textStyle.bodySmallRegular.copyWith(color: theme.colors.shade.tertiary), maxLines: 1, overflow: TextOverflow.ellipsis)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: theme.colors.brand.tertiary,
                    borderRadius: BorderRadius.circular(theme.radius.full),
                  ),
                  child: Text('$offers offers', style: theme.textStyle.labelMediumMedium.copyWith(color: theme.colors.brand.primary)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// CategoryItem mirroring shared/components/CategoryItem.kt
class CategoryItem extends StatelessWidget {
  final String title;
  final String description;
  final String serviceImageUrl;
  final VoidCallback onTap;

  const CategoryItem({
    Key? key,
    required this.title,
    required this.description,
    required this.serviceImageUrl,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = San3aTheme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colors.background.card,
          borderRadius: BorderRadius.circular(theme.radius.extraLarge),
          border: Border.all(color: theme.colors.stroke.primary),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(theme.radius.medium),
              child: Image.network(
                serviceImageUrl,
                width: 56,
                height: 56,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 56,
                  height: 56,
                  color: theme.colors.shade.quinary,
                  child: Icon(Icons.build, color: theme.colors.shade.tertiary),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: theme.textStyle.bodyLargeMedium.copyWith(color: theme.colors.shade.primary)),
                  const SizedBox(height: 4),
                  Text(description, style: theme.textStyle.bodySmallRegular.copyWith(color: theme.colors.shade.secondary), maxLines: 2, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: theme.colors.shade.tertiary),
          ],
        ),
      ),
    );
  }
}

/// StatsContainer mirroring craftsman/components/StatsContainer.kt
class StatsContainer extends StatelessWidget {
  final int jobsDone;
  final double earnings;
  final double rating;

  const StatsContainer({
    Key? key,
    required this.jobsDone,
    required this.earnings,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = San3aTheme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _StatCard(
            icon: Icons.work_outline,
            value: '$jobsDone',
            label: 'Jobs Done',
            color: theme.colors.additional.primary.blue,
            bgColor: theme.colors.additional.secondary.blue,
          ),
          const SizedBox(width: 12),
          _StatCard(
            icon: Icons.attach_money,
            value: '${earnings.toStringAsFixed(0)}',
            label: 'Earnings',
            color: theme.colors.additional.primary.green,
            bgColor: theme.colors.additional.secondary.green,
          ),
          const SizedBox(width: 12),
          _StatCard(
            icon: Icons.star_outline,
            value: rating.toStringAsFixed(1),
            label: 'Rating',
            color: theme.colors.additional.primary.yellow,
            bgColor: theme.colors.additional.secondary.yellow,
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;
  final Color bgColor;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = San3aTheme.of(context);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(theme.radius.extraLarge),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(value, style: theme.textStyle.titleMedium.copyWith(color: theme.colors.shade.primary)),
            const SizedBox(height: 4),
            Text(label, style: theme.textStyle.bodySmallRegular.copyWith(color: theme.colors.shade.secondary)),
          ],
        ),
      ),
    );
  }
}

/// AdCard mirroring shared/components/AdCard.kt
class AdCard extends StatelessWidget {
  final String title;
  final String caption;
  final String buttonTitle;
  final VoidCallback? onTap;

  const AdCard({
    Key? key,
    required this.title,
    required this.caption,
    required this.buttonTitle,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = San3aTheme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.colors.brand.primary, theme.colors.brand.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(theme.radius.extraLarge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textStyle.titleSmall.copyWith(color: Colors.white)),
          const SizedBox(height: 8),
          Text(caption, style: theme.textStyle.bodySmallRegular.copyWith(color: Colors.white.withOpacity(0.8))),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(theme.radius.full),
              ),
              child: Text(buttonTitle, style: theme.textStyle.bodySmallSemibold.copyWith(color: theme.colors.brand.primary)),
            ),
          ),
        ],
      ),
    );
  }
}
