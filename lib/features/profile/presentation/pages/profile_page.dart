import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/theme_selector_widget.dart';
import '../../../../core/theme/theme_extension.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _switchValue = false;
  double _sliderValue = 50;
  String _dropdownValue = 'Option 1';
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile & Theme Testing'),
        backgroundColor: context.colorScheme.primaryContainer,
        foregroundColor: context.colorScheme.onPrimaryContainer,
      ),
      body: SingleChildScrollView(
        padding: context.largePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ThemeSelectorWidget(
              showDescription: true,
              showPreview: false,
            ),
            SizedBox(height: context.customSpacing('xl')),
            Text(
              'UI Elements Testing',
              style: context.textTheme.headlineMedium?.copyWith(
                color: context.colorScheme.primary,
              ),
            ),
            SizedBox(height: context.customSpacing('lg')),
            _buildButtonsSection(context),
            SizedBox(height: context.customSpacing('lg')),
            _buildInputSection(context),
            SizedBox(height: context.customSpacing('lg')),
            _buildControlsSection(context),
            SizedBox(height: context.customSpacing('lg')),
            _buildCardsSection(context),
            SizedBox(height: context.customSpacing('lg')),
            _buildChipsSection(context),
            SizedBox(height: context.customSpacing('lg')),
            _buildProgressSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonsSection(BuildContext context) {
    return Container(
      padding: context.defaultPadding,
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: context.defaultBorderRadius,
        border: Border.all(color: context.colorScheme.outline.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Buttons',
            style: context.textTheme.titleLarge,
          ),
          SizedBox(height: context.customSpacing('md')),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _showSnackBar(context, 'Elevated Button'),
                  child: const Text('Elevated'),
                ),
              ),
              SizedBox(width: context.customSpacing('sm')),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _showSnackBar(context, 'Icon Button'),
                  icon: const Icon(Icons.star),
                  label: const Text('Icon'),
                ),
              ),
            ],
          ),
          SizedBox(height: context.customSpacing('sm')),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _showSnackBar(context, 'Outlined Button'),
                  child: const Text('Outlined'),
                ),
              ),
              SizedBox(width: context.customSpacing('sm')),
              Expanded(
                child: TextButton(
                  onPressed: () => _showSnackBar(context, 'Text Button'),
                  child: const Text('Text'),
                ),
              ),
            ],
          ),
          SizedBox(height: context.customSpacing('sm')),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => _showSnackBar(context, 'Filled Button'),
              child: const Text('Filled Button'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputSection(BuildContext context) {
    return Container(
      padding: context.defaultPadding,
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: context.defaultBorderRadius,
        border: Border.all(color: context.colorScheme.outline.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Input Fields',
            style: context.textTheme.titleLarge,
          ),
          SizedBox(height: context.customSpacing('md')),
          TextField(
            controller: _textController,
            decoration: const InputDecoration(
              labelText: 'Standard TextField',
              hintText: 'Enter some text...',
              prefixIcon: Icon(Icons.person),
            ),
          ),
          SizedBox(height: context.customSpacing('md')),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Outlined TextField',
              hintText: 'Enter some text...',
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: context.customSpacing('md')),
          TextField(
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password Field',
              hintText: 'Enter password...',
              prefixIcon: Icon(Icons.lock),
              suffixIcon: Icon(Icons.visibility),
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlsSection(BuildContext context) {
    return Container(
      padding: context.defaultPadding,
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: context.defaultBorderRadius,
        border: Border.all(color: context.colorScheme.outline.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Controls',
            style: context.textTheme.titleLarge,
          ),
          SizedBox(height: context.customSpacing('md')),
          SwitchListTile(
            title: const Text('Enable notifications'),
            subtitle: const Text('Receive app notifications'),
            value: _switchValue,
            onChanged: (value) => setState(() => _switchValue = value),
          ),
          SizedBox(height: context.customSpacing('md')),
          Text('Slider Value: ${_sliderValue.round()}'),
          Slider(
            value: _sliderValue,
            min: 0,
            max: 100,
            divisions: 20,
            label: _sliderValue.round().toString(),
            onChanged: (value) => setState(() => _sliderValue = value),
          ),
          SizedBox(height: context.customSpacing('md')),
          DropdownButtonFormField<String>(
            value: _dropdownValue,
            decoration: const InputDecoration(
              labelText: 'Choose Option',
              border: OutlineInputBorder(),
            ),
            items: ['Option 1', 'Option 2', 'Option 3']
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    ))
                .toList(),
            onChanged: (value) => setState(() => _dropdownValue = value!),
          ),
        ],
      ),
    );
  }

  Widget _buildCardsSection(BuildContext context) {
    return Container(
      padding: context.defaultPadding,
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: context.defaultBorderRadius,
        border: Border.all(color: context.colorScheme.outline.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cards & Lists',
            style: context.textTheme.titleLarge,
          ),
          SizedBox(height: context.customSpacing('md')),
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: context.colorScheme.primary,
                child: const Icon(Icons.person, color: Colors.white),
              ),
              title: const Text('Sample User'),
              subtitle: const Text('user@example.com'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => _showSnackBar(context, 'Card tapped'),
            ),
          ),
          SizedBox(height: context.customSpacing('sm')),
          Card(
            child: Padding(
              padding: context.defaultPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: context.colorScheme.primary,
                      ),
                      SizedBox(width: context.customSpacing('sm')),
                      Text(
                        'Featured Content',
                        style: context.textTheme.titleMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: context.customSpacing('sm')),
                  Text(
                    'This is a sample card with custom content to test theme colors and typography.',
                    style: context.textTheme.bodyMedium,
                  ),
                  SizedBox(height: context.customSpacing('md')),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => _showSnackBar(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      SizedBox(width: context.customSpacing('sm')),
                      ElevatedButton(
                        onPressed: () => _showSnackBar(context, 'Save'),
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChipsSection(BuildContext context) {
    return Container(
      padding: context.defaultPadding,
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: context.defaultBorderRadius,
        border: Border.all(color: context.colorScheme.outline.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Chips & Tags',
            style: context.textTheme.titleLarge,
          ),
          SizedBox(height: context.customSpacing('md')),
          Wrap(
            spacing: context.customSpacing('sm'),
            children: [
              Chip(
                label: const Text('Default'),
                onDeleted: () {},
              ),
              Chip(
                label: const Text('Category'),
                avatar: const Icon(Icons.category, size: 18),
              ),
              ChoiceChip(
                label: const Text('Choice'),
                selected: true,
                onSelected: (selected) {},
              ),
              FilterChip(
                label: const Text('Filter'),
                selected: false,
                onSelected: (selected) {},
              ),
              ActionChip(
                label: const Text('Action'),
                onPressed: () => _showSnackBar(context, 'Action chip'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSection(BuildContext context) {
    return Container(
      padding: context.defaultPadding,
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: context.defaultBorderRadius,
        border: Border.all(color: context.colorScheme.outline.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Progress Indicators',
            style: context.textTheme.titleLarge,
          ),
          SizedBox(height: context.customSpacing('md')),
          const Text('Linear Progress'),
          SizedBox(height: context.customSpacing('sm')),
          const LinearProgressIndicator(value: 0.7),
          SizedBox(height: context.customSpacing('md')),
          const Text('Circular Progress'),
          SizedBox(height: context.customSpacing('sm')),
          Row(
            children: [
              const CircularProgressIndicator(value: 0.7),
              SizedBox(width: context.customSpacing('lg')),
              const CircularProgressIndicator(),
            ],
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: context.defaultBorderRadius,
        ),
      ),
    );
  }
}
