import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/reminder.dart';
import '../providers/reminder_provider.dart';

/// Reminder form dialog
///
/// Universal dialog for creating and editing reminders.
class ReminderFormDialog extends StatefulWidget {
  final String companyId;
  final String createdByUserId;
  final Reminder? reminder;

  const ReminderFormDialog({
    super.key,
    required this.companyId,
    required this.createdByUserId,
    this.reminder,
  });

  @override
  State<ReminderFormDialog> createState() => _ReminderFormDialogState();
}

class _ReminderFormDialogState extends State<ReminderFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  DateTime? _selectedDateTime;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();

    if (widget.reminder != null) {
      _titleController.text = widget.reminder!.title;
      _descriptionController.text = widget.reminder!.description ?? '';
      _selectedDateTime = widget.reminder!.scheduledFor;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDateTime() async {
    final now = DateTime.now();
    final initialDate = _selectedDateTime ?? now.add(const Duration(hours: 1));

    // Select date with manual input by default
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate.isAfter(now) ? initialDate : now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
      locale: const Locale('ru'),
      initialEntryMode: DatePickerEntryMode.input, // ✅ Ручной ввод по умолчанию
    );

    if (selectedDate == null || !mounted) return;

    // Select time with 24-hour format and manual input
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialDate),
      initialEntryMode: TimePickerEntryMode.input, // ✅ Ручной ввод времени по умолчанию
      builder: (context, child) {
        // ✅ Принудительно включаем 24-часовой формат
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (selectedTime == null || !mounted) return;

    // Construct the selected datetime
    final newDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    // Validate that selected datetime is not in the past
    if (newDateTime.isBefore(DateTime.now())) {
      if (!mounted) return;

      // Show error dialog
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Ошибка'),
          content: const Text(
            'Нельзя выбрать дату и время в прошлом. '
            'Пожалуйста, выберите дату и время в будущем.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );

      // Clear the error message and don't set the invalid datetime
      setState(() {
        _errorMessage = null;
      });

      return;
    }

    setState(() {
      _selectedDateTime = newDateTime;
      _errorMessage = null; // Clear any previous error
    });
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedDateTime == null) {
      setState(() {
        _errorMessage = 'Выберите дату и время';
      });
      return;
    }

    if (_selectedDateTime!.isBefore(DateTime.now())) {
      setState(() {
        _errorMessage = 'Дата и время должны быть в будущем';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final reminderProvider =
          Provider.of<ReminderProvider>(context, listen: false);

      if (widget.reminder == null) {
        // Create
        await reminderProvider.createReminder(
          companyId: widget.companyId,
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim().isEmpty
              ? null
              : _descriptionController.text.trim(),
          scheduledFor: _selectedDateTime!,
          createdByUserId: widget.createdByUserId,
        );
      } else {
        // Update
        await reminderProvider.updateReminder(
          reminderId: widget.reminder!.id,
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim().isEmpty
              ? null
              : _descriptionController.text.trim(),
          scheduledFor: _selectedDateTime,
        );
      }

      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceAll('Exception: ', '');
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd.MM.yyyy HH:mm');

    return AlertDialog(
      title: Text(
        widget.reminder == null
            ? 'Добавить напоминание'
            : 'Редактировать напоминание',
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_errorMessage != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF53178).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Color(0xFFF53178),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFFF53178),
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Заголовок',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Введите заголовок';
                  }
                  return null;
                },
                enabled: !_isLoading,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Описание (необязательно)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                enabled: !_isLoading,
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: _isLoading ? null : _selectDateTime,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Дата и время',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  child: Text(
                    _selectedDateTime != null
                        ? dateFormat.format(_selectedDateTime!)
                        : 'Выберите дату и время',
                    style: TextStyle(
                      fontSize: 16,
                      color: _selectedDateTime != null
                          ? Colors.black
                          : Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(false),
          child: const Text('Отмена'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _handleSubmit,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF006FFD),
            foregroundColor: Colors.white,
          ),
          child: _isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(widget.reminder == null ? 'Добавить' : 'Сохранить'),
        ),
      ],
    );
  }
}
