import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../theme/theme_extension.dart';
import '../theme/base_theme.dart';
import '../../shared/blocs/theme_bloc/theme_bloc.dart';

class ThemeSelectorWidget extends StatelessWidget {
  final bool showDescription;
  final bool showPreview;

  const ThemeSelectorWidget({
    super.key,
    this.showDescription = true,
    this.showPreview = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        if (state is ThemeLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ThemeError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error_outline,
                  color: context.colorScheme.error,
                  size: 48,
                ),
                SizedBox(height: context.customSpacing('md')),
                Text(
                  'Theme Error',
                  style: context.textTheme.headlineSmall,
                ),
                SizedBox(height: context.customSpacing('sm')),
                Text(
                  state.message,
                  style: context.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: context.customSpacing('lg')),
                ElevatedButton(
                  onPressed: () => context.resetTheme(),
                  child: const Text('Reset to Default'),
                ),
              ],
            ),
          );
        }

        if (state is! ThemeLoaded) return const SizedBox();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: context.defaultPadding,
              decoration: BoxDecoration(
                gradient: context.primaryGradient,
                borderRadius: context.defaultBorderRadius,
                boxShadow: context.defaultShadow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.palette,
                        color: context.customTheme.colorScheme.onPrimary,
                        size: 24,
                      ),
                      SizedBox(width: context.customSpacing('sm')),
                      Text(
                        'Theme Selector',
                        style: context.customTextStyle('button').copyWith(
                              fontSize: 18,
                              color: context.customTheme.colorScheme.onPrimary,
                            ),
                      ),
                    ],
                  ),
                  if (showDescription) ...[
                    SizedBox(height: context.customSpacing('sm')),
                    Text(
                      'Current: ${state.currentTheme.themeName}',
                      style: TextStyle(
                        color: context.customTheme.colorScheme.onPrimary
                            .withOpacity(0.9),
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      state.currentTheme.themeDescription,
                      style: TextStyle(
                        color: context.customTheme.colorScheme.onPrimary
                            .withOpacity(0.8),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(height: context.customSpacing('lg')),
            Wrap(
              spacing: context.customSpacing('md'),
              runSpacing: context.customSpacing('md'),
              children: state.availableThemes
                  .map((theme) => _buildThemeCard(
                        context,
                        theme,
                        theme.themeKey == state.currentTheme.themeKey,
                      ))
                  .toList(),
            ),
            if (showPreview) ...[
              SizedBox(height: context.customSpacing('lg')),
              _buildThemePreview(context, state.currentTheme),
            ],
          ],
        );
      },
    );
  }

  Widget _buildThemeCard(
      BuildContext context, BaseTheme theme, bool isSelected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: InkWell(
        onTap: () => context.changeTheme(theme.themeKey),
        borderRadius: context.defaultBorderRadius,
        child: Container(
          width: 160,
          padding: context.defaultPadding,
          decoration: BoxDecoration(
            borderRadius: context.defaultBorderRadius,
            border: Border.all(
              color: isSelected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.outline,
              width: isSelected ? 3 : 1,
            ),
            color: theme.colorScheme.surface,
            boxShadow: isSelected ? theme.largeShadow : theme.smallShadow,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  SizedBox(width: context.customSpacing('sm')),
                  Expanded(
                    child: Text(
                      theme.themeName,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  if (isSelected)
                    Icon(
                      Icons.check_circle,
                      color: theme.colorScheme.primary,
                      size: 20,
                    ),
                ],
              ),
              SizedBox(height: context.customSpacing('sm')),
              Container(
                height: 4,
                decoration: BoxDecoration(
                  gradient: theme.primaryGradient,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: context.customSpacing('sm')),
              Text(
                theme.themeDescription,
                style: TextStyle(
                  fontSize: 12,
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: context.customSpacing('sm')),
              Row(
                children: theme.customColors.values
                    .take(4)
                    .map(
                      (color) => Container(
                        width: 16,
                        height: 16,
                        margin:
                            EdgeInsets.only(right: context.customSpacing('xs')),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: theme.colorScheme.outline.withOpacity(0.3),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThemePreview(BuildContext context, BaseTheme theme) {
    return Container(
      padding: context.largePadding,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: context.largeBorderRadius,
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Theme Preview',
            style: theme.textTheme.headlineSmall,
          ),
          SizedBox(height: context.customSpacing('lg')),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: theme.elevatedButtonTheme.style,
                  onPressed: () {},
                  child: const Text('Primary Button'),
                ),
              ),
              SizedBox(width: context.customSpacing('md')),
              Expanded(
                child: OutlinedButton(
                  style: theme.outlinedButtonTheme.style,
                  onPressed: () {},
                  child: const Text('Outlined'),
                ),
              ),
            ],
          ),
          SizedBox(height: context.customSpacing('md')),
          TextField(
            decoration: InputDecoration(
              labelText: 'Sample Input',
              hintText: 'Type something...',
              filled: theme.inputDecorationTheme.filled,
              fillColor: theme.inputDecorationTheme.fillColor,
              border: theme.inputDecorationTheme.border,
              enabledBorder: theme.inputDecorationTheme.enabledBorder,
              focusedBorder: theme.inputDecorationTheme.focusedBorder,
              contentPadding: theme.inputDecorationTheme.contentPadding,
            ),
          ),
          SizedBox(height: context.customSpacing('lg')),
          Container(
            width: double.infinity,
            padding: context.defaultPadding,
            decoration: BoxDecoration(
              gradient: theme.backgroundGradient,
              borderRadius: context.defaultBorderRadius,
            ),
            child: Column(
              children: [
                Text(
                  'Custom Colors',
                  style: theme.textTheme.titleMedium,
                ),
                SizedBox(height: context.customSpacing('md')),
                Wrap(
                  spacing: context.customSpacing('sm'),
                  runSpacing: context.customSpacing('sm'),
                  children: theme.customColors.entries
                      .map(
                        (entry) => Chip(
                          label: Text(
                            entry.key,
                            style: TextStyle(
                              color: entry.value.computeLuminance() > 0.5
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                          backgroundColor: entry.value,
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
