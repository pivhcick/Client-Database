import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/company.dart';
import '../providers/company_provider.dart';
import '../../../contacts/domain/entities/contact_person.dart';
import '../../../contacts/presentation/providers/contact_person_provider.dart';
import '../../../contacts/presentation/widgets/contact_person_form_dialog.dart';
import '../../../contacts/domain/entities/contact_record.dart';
import '../../../contacts/presentation/providers/contact_record_provider.dart';
import '../../../contacts/presentation/widgets/contact_record_form_dialog.dart';
import '../../../reminders/domain/entities/reminder.dart';
import '../../../reminders/domain/entities/reminder_status.dart';
import '../../../reminders/presentation/providers/reminder_provider.dart';
import '../../../reminders/presentation/widgets/reminder_form_dialog.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import 'package:intl/intl.dart';
import '../../../../core/widgets/phone_number_link.dart';

/// Company detail page
///
/// Shows detailed information about a company including contact persons,
/// contact records, and reminders.
class CompanyDetailPage extends StatefulWidget {
  final String companyId;

  const CompanyDetailPage({
    super.key,
    required this.companyId,
  });

  @override
  State<CompanyDetailPage> createState() => _CompanyDetailPageState();
}

class _CompanyDetailPageState extends State<CompanyDetailPage> {
  Company? _company;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadCompany();
    _loadContactPersons();
    _loadContactRecords();
    _loadReminders();
  }

  Future<void> _loadContactPersons() async {
    final contactPersonProvider =
        Provider.of<ContactPersonProvider>(context, listen: false);
    await contactPersonProvider.loadContactPersons(widget.companyId);
  }

  Future<void> _loadContactRecords() async {
    final contactRecordProvider =
        Provider.of<ContactRecordProvider>(context, listen: false);
    await contactRecordProvider.loadContactRecords(widget.companyId);
  }

  Future<void> _loadReminders() async {
    final reminderProvider =
        Provider.of<ReminderProvider>(context, listen: false);
    await reminderProvider.loadRemindersByCompany(widget.companyId);
  }

  Future<void> _loadCompany() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final companyProvider = Provider.of<CompanyProvider>(context, listen: false);
      final company = await companyProvider.getCompanyById(widget.companyId);

      if (mounted) {
        setState(() {
          _company = company;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString().replaceAll('Exception: ', '');
          _isLoading = false;
        });
      }
    }
  }

  Color _getStatusColor(CompanyStatus status) {
    switch (status) {
      case CompanyStatus.real:
        return const Color(0xFF00C48C);
      case CompanyStatus.potential:
        return const Color(0xFF006FFD);
      case CompanyStatus.lost:
        return const Color(0xFFF53178);
    }
  }

  String _formatDate(DateTime date) {
    final dateFormat = DateFormat('dd.MM.yyyy HH:mm');
    return dateFormat.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/companies'),
        ),
        title: const Text('Информация о компании'),
        actions: _company != null
            ? [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    context.go('/companies/${widget.companyId}/edit');
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _handleDelete(),
                ),
              ]
            : null,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Color(0xFFF53178),
            ),
            const SizedBox(height: 16),
            Text(
              _errorMessage!,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF8F9098),
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: _loadCompany,
              child: const Text('Повторить'),
            ),
          ],
        ),
      );
    }

    if (_company == null) {
      return const Center(
        child: Text('Компания не найдена'),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCompanyInfoCard(),
          const SizedBox(height: 16),
          _buildContactPersonsSection(),
          const SizedBox(height: 16),
          _buildContactRecordsSection(),
          const SizedBox(height: 16),
          _buildRemindersSection(),
        ],
      ),
    );
  }

  Widget _buildCompanyInfoCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    _company!.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Sora',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(_company!.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _company!.status.displayName,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _getStatusColor(_company!.status),
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 32),
            _buildPhoneRow(Icons.phone, 'Телефон', _company!.phone),
            if (_company!.email != null) ...[
              const SizedBox(height: 12),
              _buildInfoRow(Icons.email, 'Email', _company!.email!),
            ],
            const SizedBox(height: 12),
            _buildInfoRow(Icons.location_on, 'Адрес', _company!.address),
            if (_company!.lastContactDate != null) ...[
              const SizedBox(height: 12),
              _buildInfoRow(
                Icons.access_time,
                'Последний контакт',
                _formatDate(_company!.lastContactDate!),
              ),
            ],
            if (_company!.content != null && _company!.content!.isNotEmpty) ...[
              const Divider(height: 32),
              const Text(
                'Заметка',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF8F9098),
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _company!.content!,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: const Color(0xFF8F9098),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF8F9098),
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneRow(IconData icon, String label, String phoneNumber) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: const Color(0xFF8F9098),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF8F9098),
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 2),
              PhoneNumberLink(
                phoneNumber: phoneNumber,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF006FFD),
                  decoration: TextDecoration.underline,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactPersonsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Контактные лица',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add, size: 20),
                  onPressed: () => _showContactPersonDialog(),
                  tooltip: 'Добавить контактное лицо',
                ),
              ],
            ),
            const SizedBox(height: 8),
            Consumer<ContactPersonProvider>(
              builder: (context, provider, _) {
                if (provider.isLoading) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (provider.contactPersons.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Контактных лиц пока нет',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF8F9098),
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: provider.contactPersons.length,
                  separatorBuilder: (context, index) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final contactPerson = provider.contactPersons[index];
                    return _buildContactPersonCard(contactPerson);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactPersonCard(ContactPerson contactPerson) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      leading: CircleAvatar(
        backgroundColor: const Color(0xFF006FFD).withOpacity(0.1),
        child: Text(
          contactPerson.lastName[0],
          style: const TextStyle(
            color: Color(0xFF006FFD),
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
        ),
      ),
      title: Text(
        contactPerson.fullName,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(
            contactPerson.position,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF8F9098),
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 2),
          Text(
            contactPerson.phone,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF8F9098),
              fontFamily: 'Inter',
            ),
          ),
          if (contactPerson.email != null) ...[
            const SizedBox(height: 2),
            Text(
              contactPerson.email!,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF8F9098),
                fontFamily: 'Inter',
              ),
            ),
          ],
        ],
      ),
      trailing: PopupMenuButton<String>(
        icon: const Icon(Icons.more_vert, size: 20),
        onSelected: (value) {
          if (value == 'edit') {
            _showContactPersonDialog(contactPerson: contactPerson);
          } else if (value == 'delete') {
            _handleDeleteContactPerson(contactPerson);
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'edit',
            child: Row(
              children: [
                Icon(Icons.edit, size: 18),
                SizedBox(width: 8),
                Text('Редактировать'),
              ],
            ),
          ),
          const PopupMenuItem(
            value: 'delete',
            child: Row(
              children: [
                Icon(Icons.delete, size: 18),
                SizedBox(width: 8),
                Text('Удалить'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showContactPersonDialog({ContactPerson? contactPerson}) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => ContactPersonFormDialog(
        companyId: widget.companyId,
        contactPerson: contactPerson,
      ),
    );

    if (result == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            contactPerson == null
                ? 'Контактное лицо добавлено'
                : 'Контактное лицо обновлено',
          ),
        ),
      );
    }
  }

  Future<void> _handleDeleteContactPerson(ContactPerson contactPerson) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить контактное лицо?'),
        content: Text(
          'Вы действительно хотите удалить контактное лицо "${contactPerson.fullName}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFFF53178),
            ),
            child: const Text('Удалить'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    try {
      final contactPersonProvider =
          Provider.of<ContactPersonProvider>(context, listen: false);
      await contactPersonProvider.deleteContactPerson(contactPerson.id);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Контактное лицо удалено')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: const Color(0xFFF53178),
          ),
        );
      }
    }
  }

  Widget _buildContactRecordsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'История контактов',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add, size: 20),
                  onPressed: () => _showContactRecordDialog(),
                  tooltip: 'Добавить запись',
                ),
              ],
            ),
            const SizedBox(height: 8),
            Consumer<ContactRecordProvider>(
              builder: (context, provider, _) {
                if (provider.isLoading) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (provider.contactRecords.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Записей о контактах пока нет',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF8F9098),
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: provider.contactRecords.length,
                  separatorBuilder: (context, index) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final contactRecord = provider.contactRecords[index];
                    return _buildContactRecordCard(contactRecord);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactRecordCard(ContactRecord contactRecord) {
    final dateFormat = DateFormat('dd.MM.yyyy HH:mm');

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      leading: CircleAvatar(
        backgroundColor: const Color(0xFF006FFD).withOpacity(0.1),
        child: const Icon(
          Icons.history,
          color: Color(0xFF006FFD),
          size: 20,
        ),
      ),
      title: Text(
        contactRecord.content,
        style: const TextStyle(
          fontSize: 14,
          fontFamily: 'Inter',
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(
            dateFormat.format(contactRecord.createdAt),
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF8F9098),
              fontFamily: 'Inter',
            ),
          ),
          if (contactRecord.createdByUserName != null) ...[
            const SizedBox(height: 2),
            Text(
              contactRecord.createdByUserName!,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF8F9098),
                fontFamily: 'Inter',
              ),
            ),
          ],
        ],
      ),
      trailing: PopupMenuButton<String>(
        icon: const Icon(Icons.more_vert, size: 20),
        onSelected: (value) {
          if (value == 'edit') {
            _showContactRecordDialog(contactRecord: contactRecord);
          } else if (value == 'delete') {
            _handleDeleteContactRecord(contactRecord);
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'edit',
            child: Row(
              children: [
                Icon(Icons.edit, size: 18),
                SizedBox(width: 8),
                Text('Редактировать'),
              ],
            ),
          ),
          const PopupMenuItem(
            value: 'delete',
            child: Row(
              children: [
                Icon(Icons.delete, size: 18),
                SizedBox(width: 8),
                Text('Удалить'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showContactRecordDialog({ContactRecord? contactRecord}) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final currentUser = authProvider.currentUser;

    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Не удалось определить текущего пользователя')),
      );
      return;
    }

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => ContactRecordFormDialog(
        companyId: widget.companyId,
        createdByUserId: currentUser.id,
        contactRecord: contactRecord,
      ),
    );

    if (result == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            contactRecord == null
                ? 'Запись о контакте добавлена'
                : 'Запись о контакте обновлена',
          ),
        ),
      );
    }
  }

  Future<void> _handleDeleteContactRecord(ContactRecord contactRecord) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить запись?'),
        content: Text(
          'Вы действительно хотите удалить запись о контакте от ${DateFormat('dd.MM.yyyy').format(contactRecord.createdAt)}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFFF53178),
            ),
            child: const Text('Удалить'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    try {
      final contactRecordProvider =
          Provider.of<ContactRecordProvider>(context, listen: false);
      await contactRecordProvider.deleteContactRecord(contactRecord.id);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Запись о контакте удалена')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: const Color(0xFFF53178),
          ),
        );
      }
    }
  }

  Widget _buildRemindersSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Напоминания',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add, size: 20),
                  onPressed: () => _showReminderDialog(),
                  tooltip: 'Добавить напоминание',
                ),
              ],
            ),
            const SizedBox(height: 8),
            Consumer<ReminderProvider>(
              builder: (context, provider, _) {
                if (provider.isLoading) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (provider.reminders.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Напоминаний пока нет',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF8F9098),
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: provider.reminders.length,
                  separatorBuilder: (context, index) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final reminder = provider.reminders[index];
                    return _buildReminderCard(reminder);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReminderCard(Reminder reminder) {
    final dateFormat = DateFormat('dd.MM.yyyy HH:mm');

    Color statusColor;
    switch (reminder.status) {
      case ReminderStatus.pending:
        statusColor = const Color(0xFF006FFD);
        break;
      case ReminderStatus.delivered:
        statusColor = const Color(0xFF00C48C);
        break;
      case ReminderStatus.cancelled:
        statusColor = const Color(0xFF8F9098);
        break;
    }

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      leading: CircleAvatar(
        backgroundColor: statusColor.withOpacity(0.1),
        child: Icon(
          Icons.notifications,
          color: statusColor,
          size: 20,
        ),
      ),
      title: Text(
        reminder.title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (reminder.description != null) ...[
            const SizedBox(height: 4),
            Text(
              reminder.description!,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF8F9098),
                fontFamily: 'Inter',
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.schedule, size: 12, color: statusColor),
              const SizedBox(width: 4),
              Text(
                dateFormat.format(reminder.scheduledFor),
                style: TextStyle(
                  fontSize: 12,
                  color: statusColor,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  reminder.status.displayName,
                  style: TextStyle(
                    fontSize: 10,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      trailing: reminder.status == ReminderStatus.pending
          ? PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert, size: 20),
              onSelected: (value) {
                if (value == 'edit') {
                  _showReminderDialog(reminder: reminder);
                } else if (value == 'cancel') {
                  _handleCancelReminder(reminder);
                } else if (value == 'delete') {
                  _handleDeleteReminder(reminder);
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit, size: 18),
                      SizedBox(width: 8),
                      Text('Редактировать'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'cancel',
                  child: Row(
                    children: [
                      Icon(Icons.cancel, size: 18),
                      SizedBox(width: 8),
                      Text('Отменить'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, size: 18),
                      SizedBox(width: 8),
                      Text('Удалить'),
                    ],
                  ),
                ),
              ],
            )
          : null,
    );
  }

  Future<void> _showReminderDialog({Reminder? reminder}) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final currentUser = authProvider.currentUser;

    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Не удалось определить текущего пользователя')),
      );
      return;
    }

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => ReminderFormDialog(
        companyId: widget.companyId,
        createdByUserId: currentUser.id,
        reminder: reminder,
      ),
    );

    if (result == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            reminder == null
                ? 'Напоминание добавлено'
                : 'Напоминание обновлено',
          ),
        ),
      );
    }
  }

  Future<void> _handleCancelReminder(Reminder reminder) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Отменить напоминание?'),
        content: Text(
          'Вы действительно хотите отменить напоминание "${reminder.title}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Нет'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Да'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    try {
      final reminderProvider =
          Provider.of<ReminderProvider>(context, listen: false);
      await reminderProvider.cancelReminder(reminder.id);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Напоминание отменено')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: const Color(0xFFF53178),
          ),
        );
      }
    }
  }

  Future<void> _handleDeleteReminder(Reminder reminder) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить напоминание?'),
        content: Text(
          'Вы действительно хотите удалить напоминание "${reminder.title}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFFF53178),
            ),
            child: const Text('Удалить'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    try {
      final reminderProvider =
          Provider.of<ReminderProvider>(context, listen: false);
      await reminderProvider.deleteReminder(reminder.id);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Напоминание удалено')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: const Color(0xFFF53178),
          ),
        );
      }
    }
  }

  Future<void> _handleDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить компанию?'),
        content: Text(
          'Вы действительно хотите удалить компанию "${_company!.name}"? '
          'Это также удалит все связанные контактные лица, записи о контактах и напоминания.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFFF53178),
            ),
            child: const Text('Удалить'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    try {
      final companyProvider = Provider.of<CompanyProvider>(context, listen: false);
      await companyProvider.deleteCompany(widget.companyId);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Компания удалена')),
        );
        context.go('/');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: const Color(0xFFF53178),
          ),
        );
      }
    }
  }
}
