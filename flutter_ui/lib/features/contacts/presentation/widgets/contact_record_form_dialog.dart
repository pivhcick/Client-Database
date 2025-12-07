import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/contact_record.dart';
import '../providers/contact_record_provider.dart';

/// Contact record form dialog
///
/// Universal dialog for creating and editing contact records.
class ContactRecordFormDialog extends StatefulWidget {
  final String companyId;
  final String createdByUserId;
  final ContactRecord? contactRecord;

  const ContactRecordFormDialog({
    super.key,
    required this.companyId,
    required this.createdByUserId,
    this.contactRecord,
  });

  @override
  State<ContactRecordFormDialog> createState() =>
      _ContactRecordFormDialogState();
}

class _ContactRecordFormDialogState extends State<ContactRecordFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _contentController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();

    if (widget.contactRecord != null) {
      _contentController.text = widget.contactRecord!.content;
    }
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final contactRecordProvider =
          Provider.of<ContactRecordProvider>(context, listen: false);

      if (widget.contactRecord == null) {
        // Create
        await contactRecordProvider.createContactRecord(
          companyId: widget.companyId,
          content: _contentController.text.trim(),
          createdByUserId: widget.createdByUserId,
        );
      } else {
        // Update
        await contactRecordProvider.updateContactRecord(
          contactRecordId: widget.contactRecord!.id,
          content: _contentController.text.trim(),
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
    return AlertDialog(
      title: Text(
        widget.contactRecord == null
            ? 'Добавить запись о контакте'
            : 'Редактировать запись',
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
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: 'Заметка о контакте',
                  border: OutlineInputBorder(),
                  hintText: 'Описание взаимодействия с компанией...',
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Введите заметку';
                  }
                  return null;
                },
                enabled: !_isLoading,
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
              : Text(widget.contactRecord == null ? 'Добавить' : 'Сохранить'),
        ),
      ],
    );
  }
}
